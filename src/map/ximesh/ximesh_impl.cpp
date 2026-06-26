/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "ximesh_impl.h"

#include <common/logging.h>
#include <common/tracy.h>
#include <common/utils.h>

#include <common/types/hash_map.h>

#include <array>
#include <cmath>
#include <fstream>
#include <span>

#include <DetourCommon.h>
#include <zlib.h>

namespace
{

//
// File-format layout
//

constexpr uint32 kBytesPerVertex   = 3 * sizeof(float);                                                    // x, y, z per vertex
constexpr uint32 kBytesPerTriangle = 3 * sizeof(uint16);                                                   // 3 indices per triangle
constexpr size_t kTransformBytes   = sizeof(MeshPlacement::rotation) + sizeof(MeshPlacement::translation); // 3x3 rotation + vec3 translation

//
// Grid
//

constexpr float  kCellSize         = 4.0f; // world units per grid cell
constexpr uint32 kCullMinTriangles = 1;    // AABB broad-phase threshold

//
// zlib decompression
//

constexpr size_t kZlibChunkSize       = 32 * 1024;        // inflate buffer (32 KB)
constexpr size_t kMaxDecompressedSize = 64 * 1024 * 1024; // hard cap (64 MB)

//
// Ray-cast tolerances
//

constexpr float kRayTriEpsilon   = 0.0000001f; // Moller-Trumbore parallel/degenerate cull
constexpr float kParallelEpsilon = 1e-6f;      // ray has ~no horizontal component (grid DDA)
constexpr float kZeroDirEpsilon  = 1e-8f;      // direction component ~0 (reciprocal clamp)
constexpr float kLargeReciprocal = 1e30f;      // finite stand-in for 1/0 (large, but won't overflow when scaled)
constexpr float kFloorEpsilon    = 0.01f;      // floor-height tolerance in query()
constexpr float kAabbPad         = 0.1f;       // block-AABB padding for the broad-phase cull (yalms)

template <typename T>
auto readAt(const std::span<const uint8> buf, const uint32 offset) -> T
{
    if (offset + sizeof(T) > buf.size())
    {
        return T{};
    }

    T val{};
    std::memcpy(&val, buf.data() + offset, sizeof(T));
    return val;
}

auto zlibDecompress(const std::vector<uint8>& rawData) -> std::vector<uint8>
{
    z_stream stream{};
    if (inflateInit(&stream) != Z_OK)
    {
        return {};
    }

    stream.next_in  = (Bytef*)rawData.data();
    stream.avail_in = static_cast<uInt>(rawData.size());

    std::vector<uint8> result;
    result.reserve(rawData.size() * 4);
    std::array<uint8, kZlibChunkSize> chunk{};

    int rc = Z_OK;
    while (rc != Z_STREAM_END)
    {
        stream.next_out  = chunk.data();
        stream.avail_out = static_cast<uInt>(chunk.size());

        rc = inflate(&stream, Z_NO_FLUSH);
        if (rc != Z_OK && rc != Z_STREAM_END)
        {
            inflateEnd(&stream);
            return {};
        }

        const size_t bytesWritten = chunk.size() - stream.avail_out;
        result.insert(result.end(), chunk.data(), chunk.data() + bytesWritten);

        if (result.size() > kMaxDecompressedSize)
        {
            inflateEnd(&stream);
            return {};
        }
    }

    inflateEnd(&stream);
    return result;
}

// Local to world space.
auto transform(const std::array<float, 9>& rot, const std::array<float, 3>& trans, const float* vertex) -> std::array<float, 3>
{
    return {
        rot[0] * vertex[0] + rot[3] * vertex[1] + rot[6] * vertex[2] + trans[0],
        rot[1] * vertex[0] + rot[4] * vertex[1] + rot[7] * vertex[2] + trans[1],
        rot[2] * vertex[0] + rot[5] * vertex[1] + rot[8] * vertex[2] + trans[2],
    };
}

auto buildO2W(const MeshPlacement& p) -> TransformationMatrix
{
    TransformationMatrix m{};
    m.elements[0][0] = p.rotation[0];
    m.elements[0][1] = p.rotation[1];
    m.elements[0][2] = p.rotation[2];
    m.elements[1][0] = p.rotation[3];
    m.elements[1][1] = p.rotation[4];
    m.elements[1][2] = p.rotation[5];
    m.elements[2][0] = p.rotation[6];
    m.elements[2][1] = p.rotation[7];
    m.elements[2][2] = p.rotation[8];
    m.elements[3][0] = p.translation[0];
    m.elements[3][1] = p.translation[1];
    m.elements[3][2] = p.translation[2];
    return m;
}

auto vertexAt(const MeshBlock& block, const uint16 vertexIdx) -> Vector3
{
    const float* v = &block.vertices[vertexIdx * 3];
    return Vector3{ v[0], v[1], v[2] };
}

// Broad-phase slab test: does the object-space ray SEGMENT (origin o, direction reciprocal invD,
// parameter t in [0, 1]) overlap the AABB [bmin, bmax]? `invD` is the componentwise reciprocal of the
// segment vector, with near-zero axes clamped to a large finite value (avoids inf*0 = NaN). Used to
// skip a whole block's triangles when the ray misses its bounds; never culls a real hit, since the
// AABB encloses every triangle in the block.
auto segmentHitsAABB(const Vector3& o, const Vector3& invD, const Vector3& bmin, const Vector3& bmax) -> bool
{
    const float tx1  = (bmin.x - o.x) * invD.x;
    const float tx2  = (bmax.x - o.x) * invD.x;
    float       tmin = std::min(tx1, tx2);
    float       tmax = std::max(tx1, tx2);

    const float ty1 = (bmin.y - o.y) * invD.y;
    const float ty2 = (bmax.y - o.y) * invD.y;
    tmin            = std::max(tmin, std::min(ty1, ty2));
    tmax            = std::min(tmax, std::max(ty1, ty2));

    const float tz1 = (bmin.z - o.z) * invD.z;
    const float tz2 = (bmax.z - o.z) * invD.z;
    tmin            = std::max(tmin, std::min(tz1, tz2));
    tmax            = std::min(tmax, std::max(tz1, tz2));

    return tmax >= std::max(tmin, 0.0f) && tmin <= 1.0f;
}

// Componentwise reciprocal of a segment vector for segmentHitsAABB; near-zero axes are clamped to a
// large finite magnitude so the slab test stays NaN-free for axis-aligned rays.
auto reciprocalDir(const Vector3& d) -> Vector3
{
    return Vector3{
        std::abs(d.x) > kZeroDirEpsilon ? 1.0f / d.x : kLargeReciprocal,
        std::abs(d.y) > kZeroDirEpsilon ? 1.0f / d.y : kLargeReciprocal,
        std::abs(d.z) > kZeroDirEpsilon ? 1.0f / d.z : kLargeReciprocal,
    };
}

// Moller-Trumbore ray/triangle intersection.
auto rayIntersectTriangle(const Vector3& v1, const Vector3& v2, const Vector3& v3, const Vector3& rayOrigin, const Vector3& rayVector) -> Maybe<Vector3>
{
    const auto edge1 = v2 - v1;
    const auto edge2 = v3 - v1;
    const auto h     = rayVector.crossProduct(edge2);
    const auto a     = edge1.dotProduct(h);

    if (a > -kRayTriEpsilon && a < kRayTriEpsilon)
    {
        return std::nullopt;
    }

    const auto f = 1.0f / a;
    const auto s = rayOrigin - v1;
    const auto u = f * s.dotProduct(h);

    if (u < 0.0f || u > 1.0f)
    {
        return std::nullopt;
    }

    const auto q = s.crossProduct(edge1);
    const auto v = f * rayVector.dotProduct(q);

    if (v < 0.0f || u + v > 1.0f)
    {
        return std::nullopt;
    }

    const auto t = f * edge2.dotProduct(q);

    if (t > kRayTriEpsilon && t <= 1.0f)
    {
        return Vector3(rayOrigin + rayVector * t);
    }

    return std::nullopt;
}

} // namespace

XiMeshImpl::XiMeshImpl(const std::string& filename)
{
    if (!load(filename))
    {
        throw std::runtime_error(fmt::format("Failed to load {}", filename));
    }
}

auto XiMeshImpl::load(const std::string& filename) -> bool
{
    TracyZoneScoped;

    // Step 1. Read the file
    std::ifstream file(filename, std::ios::binary | std::ios::ate);
    if (!file.good())
    {
        return false;
    }

    const auto fileSize = static_cast<size_t>(file.tellg());
    file.seekg(0, std::ios::beg);

    std::vector<uint8> rawData(fileSize);
    file.read(reinterpret_cast<char*>(rawData.data()), fileSize);
    if (file.fail())
    {
        ShowErrorFmt("XiMeshImpl::load: Failed to read file ({})", filename);
        return false;
    }

    // Step 2. Decompress ximesh zlib
    const auto decompressed = zlibDecompress(rawData);
    if (decompressed.empty())
    {
        ShowErrorFmt("XiMeshImpl::load: zlib decompression failed ({})", filename);
        return false;
    }

    const std::span buf = decompressed;

    // Step 3. Load in the header containing the size of the grid and prepare final vector
    if (buf.size() < sizeof(XimeshHeader))
    {
        ShowErrorFmt("XiMeshImpl::load: File too small ({})", filename);
        return false;
    }

    std::memcpy(&header_, buf.data(), sizeof(XimeshHeader));
    if (header_.gridWidth == 0 || header_.gridHeight == 0)
    {
        ShowErrorFmt("XiMeshImpl::load: Invalid grid {}x{} ({})", header_.gridWidth, header_.gridHeight, filename);
        return false;
    }

    const uint32 cellCount = static_cast<uint32>(header_.gridWidth) * header_.gridHeight;
    cells_.resize(cellCount);
    blocks_.reserve(header_.blockCount);
    placements_.reserve(header_.placementCount);

    uint32 totalEntries = 0;
    for (uint32 cellIndex = 0; cellIndex < cellCount; ++cellIndex)
    {
        const uint32 cellDataOffset = readAt<uint32>(buf, sizeof(XimeshHeader) + cellIndex * 4);
        if (cellDataOffset != 0 && cellDataOffset + sizeof(XimeshCellHeader) <= buf.size())
        {
            totalEntries += readAt<XimeshCellHeader>(buf, cellDataOffset).entryCount;
        }
    }
    entries_.reserve(totalEntries);

    // Step 3a. Define block and placement parsers (deduplicated by file offset)
    HashMap<uint32, uint16> blockCache;
    HashMap<uint32, uint16> placeCache;

    auto getOrParseBlock = [&](const uint32 fileOffset) -> Maybe<uint16>
    {
        auto [it, inserted] = blockCache.try_emplace(fileOffset, static_cast<uint16>(blocks_.size()));
        if (!inserted)
        {
            return it->second;
        }

        MeshBlock block;

        const auto vertexCount   = readAt<uint16>(buf, fileOffset);
        const auto triangleCount = readAt<uint16>(buf, fileOffset + 2);
        const auto barrierFlag   = readAt<uint16>(buf, fileOffset + 4);
        block.hasBarriers        = barrierFlag > 0;

        const uint32 vertexBytes = vertexCount * kBytesPerVertex;
        const uint32 indexBytes  = triangleCount * kBytesPerTriangle;
        const uint32 metaBytes   = triangleCount; // 1 byte per triangle

        const uint32 vertexOffset = fileOffset + 8;
        const uint32 indexOffset  = roundUpToNearestFour(vertexOffset + vertexBytes);
        const uint32 metaOffset   = roundUpToNearestFour(indexOffset + indexBytes);

        if (vertexOffset + vertexBytes > buf.size() ||
            indexOffset + indexBytes > buf.size() ||
            metaOffset + metaBytes > buf.size())
        {
            ShowErrorFmt("XiMeshImpl: Block OOB at offset 0x{:X} (bufSize={})", fileOffset, buf.size());
            return std::nullopt;
        }

        block.vertices.resize(vertexCount * 3);
        std::memcpy(block.vertices.data(), buf.data() + vertexOffset, vertexBytes);

        // Local-space AABB for the ray broad-phase cull in rayIntersectCell.
        if (vertexCount > 0)
        {
            Vector3 mn{ block.vertices[0], block.vertices[1], block.vertices[2] };
            Vector3 mx = mn;
            for (uint16 vi = 1; vi < vertexCount; ++vi)
            {
                const float* v = &block.vertices[vi * 3];
                mn.x           = std::min(mn.x, v[0]);
                mn.y           = std::min(mn.y, v[1]);
                mn.z           = std::min(mn.z, v[2]);
                mx.x           = std::max(mx.x, v[0]);
                mx.y           = std::max(mx.y, v[1]);
                mx.z           = std::max(mx.z, v[2]);
            }

            // Pad the bounds so the slab broad-phase never rejects a hit lying exactly on a face due to
            // float rounding (a corner-grazing ray).
            block.aabbMin = Vector3{ mn.x - kAabbPad, mn.y - kAabbPad, mn.z - kAabbPad };
            block.aabbMax = Vector3{ mx.x + kAabbPad, mx.y + kAabbPad, mx.z + kAabbPad };
        }

        block.indices.resize(triangleCount * 3);
        std::memcpy(block.indices.data(), buf.data() + indexOffset, indexBytes);

        block.metas.resize(metaBytes);
        std::memcpy(block.metas.data(), buf.data() + metaOffset, metaBytes);

        blocks_.emplace_back(std::move(block));
        return it->second;
    };

    auto getOrParsePlacement = [&](const uint32 fileOffset) -> Maybe<uint16>
    {
        auto [it, inserted] = placeCache.try_emplace(fileOffset, static_cast<uint16>(placements_.size()));
        if (!inserted)
        {
            return it->second;
        }

        const auto    flags = readAt<PlacementFlags>(buf, fileOffset);
        MeshPlacement placement{
            .mapId  = static_cast<uint8>(flags.mapIdHigh << 3 | flags.mapIdLow),
            .roofed = flags.roofed != 0,
        };

        if (fileOffset + 4 + kTransformBytes > buf.size())
        {
            ShowErrorFmt("XiMeshImpl: Placement OOB at offset 0x{:X} (bufSize={})", fileOffset, buf.size());
            return std::nullopt;
        }

        std::memcpy(placement.rotation.data(), buf.data() + fileOffset + 4, kTransformBytes);

        placements_.emplace_back(placement);
        return it->second;
    };

    // Step 3b. Parse cells
    for (uint32 cellIndex = 0; cellIndex < cellCount; ++cellIndex)
    {
        const uint32 cellDataOffset = readAt<uint32>(buf, sizeof(XimeshHeader) + cellIndex * 4);
        if (cellDataOffset == 0 || cellDataOffset + sizeof(XimeshCellHeader) > buf.size())
        {
            continue;
        }

        const auto cellHeader = readAt<XimeshCellHeader>(buf, cellDataOffset);
        auto&      cell       = cells_[cellIndex];
        cell.offset           = static_cast<uint32>(entries_.size());
        cell.count            = 0;

        for (uint16 entryIndex = 0; entryIndex < cellHeader.entryCount; ++entryIndex)
        {
            const uint32 entryOffset = cellDataOffset + sizeof(XimeshCellHeader) + entryIndex * sizeof(XimeshCellEntry);
            if (entryOffset + sizeof(XimeshCellEntry) > buf.size())
            {
                break;
            }

            const auto rawEntry     = readAt<XimeshCellEntry>(buf, entryOffset);
            const auto blockIdx     = getOrParseBlock(rawEntry.blockOffset);
            const auto placementIdx = getOrParsePlacement(rawEntry.placementOffset);
            if (!blockIdx || !placementIdx)
            {
                ShowErrorFmt("XiMeshImpl::load: Corrupt block/placement data ({})", filename);
                return false;
            }

            entries_.push_back({ *blockIdx, *placementIdx });
            cell.count++;
        }
    }

    // Step 4. Pre-compute Y bounds per placement (used by query culling).
    for (uint32 cellIndex = 0; cellIndex < cellCount; ++cellIndex)
    {
        const auto& cell = cells_[cellIndex];
        for (uint16 ref = 0; ref < cell.count; ++ref)
        {
            const auto& [blockIdx, placementIdx] = entries_[cell.offset + ref];
            const auto& block                    = blocks_[blockIdx];
            auto&       place                    = placements_[placementIdx];

            for (size_t v = 0; v < block.vertices.size(); v += 3)
            {
                const auto world = transform(place.rotation, place.translation, &block.vertices[v]);

                place.yMin = std::min(place.yMin, world[1]);
                place.yMax = std::max(place.yMax, world[1]);
            }
        }
    }

    // Step 5. Pre-compute world->object matrices, winding flips, and per-cell Y ranges (used by ray queries).
    w2os_.resize(placements_.size());
    placementFlips_.resize(placements_.size());
    for (size_t i = 0; i < placements_.size(); ++i)
    {
        const auto o2w     = buildO2W(placements_[i]);
        w2os_[i]           = o2w.getInverted();
        placementFlips_[i] = o2w.determinant() > 0.0f;
    }

    cellRanges_.assign(cellCount, YRange{});
    for (uint32 cellIndex = 0; cellIndex < cellCount; ++cellIndex)
    {
        auto&       range = cellRanges_[cellIndex];
        const auto& cell  = cells_[cellIndex];

        for (uint16 ref = 0; ref < cell.count; ++ref)
        {
            const auto& [blockIdx, placementIdx] = entries_[cell.offset + ref];
            const auto& place                    = placements_[placementIdx];
            range.min                            = std::min(range.min, place.yMin);
            range.max                            = std::max(range.max, place.yMax);
        }
    }

    return true;
}

// World position to cell grid index. Each cell covers 4x4 world units.
auto XiMeshImpl::worldToCell(const float x, const float z) const -> std::pair<int, int>
{
    return {
        static_cast<int>(std::floor(x / kCellSize)) + header_.gridWidth / 2,
        static_cast<int>(std::floor(z / kCellSize)) + header_.gridHeight / 2,
    };
}

// Returns the triangle under (x, z) closest above y.
auto XiMeshImpl::query(const float x, const float y, const float z) const -> Maybe<CellHit>
{
    TracyZoneScoped;

    const auto [cx, cz]    = worldToCell(x, z);
    const std::array point = { x, 0.0f, z };

    auto searchCell = [&](const int cellX, const int cellZ) -> Maybe<CellHit>
    {
        if (cellX < 0 || cellX >= header_.gridWidth || cellZ < 0 || cellZ >= header_.gridHeight)
        {
            return std::nullopt;
        }

        const auto& cell = cells_[static_cast<uint32>(cellZ) * header_.gridWidth + cellX];
        if (cell.count == 0)
        {
            return std::nullopt;
        }

        Maybe<CellHit> best;
        for (uint16 ref = 0; ref < cell.count; ++ref)
        {
            const auto& [blockIdx, placementIdx] = entries_[cell.offset + ref];
            const auto& block                    = blocks_[blockIdx];
            const auto& place                    = placements_[placementIdx];

            // Skip placements entirely above query point
            if (place.yMax < y - kFloorEpsilon)
            {
                continue;
            }

            for (size_t triIdx = 0; triIdx < block.metas.size(); ++triIdx)
            {
                const uint16 i0 = block.indices[triIdx * 3 + 0];
                const uint16 i1 = block.indices[triIdx * 3 + 1];
                const uint16 i2 = block.indices[triIdx * 3 + 2];

                const auto world0 = transform(place.rotation, place.translation, &block.vertices[i0 * 3]);
                const auto world1 = transform(place.rotation, place.translation, &block.vertices[i1 * 3]);
                const auto world2 = transform(place.rotation, place.translation, &block.vertices[i2 * 3]);

                float triY = 0.0f;
                if (!dtClosestHeightPointTriangle(point.data(), world0.data(), world1.data(), world2.data(), triY))
                {
                    continue;
                }

                // Pick the closest triangle above the query point (Y is negative-up).
                if (triY >= y - kFloorEpsilon && (!best || triY < best->y))
                {
                    const auto& meta = block.metas[triIdx];
                    best             = CellHit{
                        .type    = static_cast<TerrainType>(meta.material),
                        .mapId   = place.mapId,
                        .roofed  = place.roofed,
                        .barrier = meta.barrier != 0,
                        .y       = triY,
                    };
                }
            }
        }

        return best;
    };

    // Check target cell first
    if (const auto best = searchCell(cx, cz))
    {
        return best;
    }

    // Miss, check neighbors
    Maybe<CellHit> best;
    for (int dz = -1; dz <= 1; ++dz)
    {
        for (int dx = -1; dx <= 1; ++dx)
        {
            if (dx == 0 && dz == 0)
            {
                continue;
            }

            if (const auto hit = searchCell(cx + dx, cz + dz))
            {
                if (!best || hit->y < best->y)
                {
                    best = hit;
                }
            }
        }
    }

    return best;
}

auto XiMeshImpl::getTerrainAt(const float x, const float y, const float z) const -> TerrainType
{
    TracyZoneScoped;

    if (const auto hit = query(x, y, z))
    {
        return hit->type;
    }

    return TerrainType::None;
}

auto XiMeshImpl::getFloorId(const float x, const float y, const float z) const -> uint8
{
    TracyZoneScoped;

    if (const auto hit = query(x, y, z))
    {
        return hit->mapId;
    }

    return 0;
}

auto XiMeshImpl::blocks() const -> const std::vector<MeshBlock>&
{
    return blocks_;
}

auto XiMeshImpl::placements() const -> const std::vector<MeshPlacement>&
{
    return placements_;
}

auto XiMeshImpl::entries() const -> const std::vector<CellEntry>&
{
    return entries_;
}

auto XiMeshImpl::cells() const -> const std::vector<CellSpan>&
{
    return cells_;
}

auto XiMeshImpl::gridWidth() const -> uint16
{
    return header_.gridWidth;
}

auto XiMeshImpl::gridHeight() const -> uint16
{
    return header_.gridHeight;
}

auto XiMeshImpl::rayIntersect(const Vector3& start, const Vector3& end, const IgnoreTransparentBarriers ignoreTransparentBarriers) const -> bool
{
    TracyZoneScoped;

    const auto cellSearchDiff = header_.wideSearch > 0 ? 2 : 1;

    auto [col, row] = worldToCell(start.x, start.z);

    const auto yRange = YRange{ std::min(start.y, end.y), std::max(start.y, end.y) };

    auto row1 = std::max<int32>(0, row - cellSearchDiff);
    auto row2 = std::min<int32>(header_.gridHeight - 1, row + cellSearchDiff);
    auto col1 = std::max<int32>(0, col - cellSearchDiff);
    auto col2 = std::min<int32>(header_.gridWidth - 1, col + cellSearchDiff);

    for (int32 r = row1; r <= row2; ++r)
    {
        const auto rGrid = static_cast<uint32>(r) * header_.gridWidth;
        for (int32 c = col1; c <= col2; ++c)
        {
            const auto cellIdx = rGrid + static_cast<uint32>(c);

            if (rayIntersectCell(start, end, yRange, cellIdx, ignoreTransparentBarriers))
            {
                return true;
            }
        }
    }

    auto [endCol, endRow] = worldToCell(end.x, end.z);

    const auto dx = end.x - start.x;
    const auto dz = end.z - start.z;

    if (std::abs(dx) < kParallelEpsilon && std::abs(dz) < kParallelEpsilon)
    {
        return false;
    }

    const auto stepCol = dx > 0 ? 1 : -1;
    const auto stepRow = dz > 0 ? 1 : -1;
    const auto deltaX  = std::abs(dx) < kParallelEpsilon ? std::numeric_limits<float>::infinity() : std::abs(kCellSize / dx);
    const auto deltaZ  = std::abs(dz) < kParallelEpsilon ? std::numeric_limits<float>::infinity() : std::abs(kCellSize / dz);

    float nextX{};
    float nextZ{};

    if (dx > 0)
    {
        const auto rightEdge = (col + 1) * kCellSize - header_.gridWidth * (kCellSize / 2.0f);
        nextX                = (rightEdge - start.x) / dx;
    }
    else if (dx < 0)
    {
        const auto leftEdge = col * kCellSize - header_.gridWidth * (kCellSize / 2.0f);
        nextX               = (leftEdge - start.x) / dx;
    }
    else
    {
        nextX = std::numeric_limits<float>::infinity();
    }

    if (dz > 0)
    {
        const auto bottomEdge = (row + 1) * kCellSize - header_.gridHeight * (kCellSize / 2.0f);
        nextZ                 = (bottomEdge - start.z) / dz;
    }
    else if (dz < 0)
    {
        const auto topEdge = row * kCellSize - header_.gridHeight * (kCellSize / 2.0f);
        nextZ              = (topEdge - start.z) / dz;
    }
    else
    {
        nextZ = std::numeric_limits<float>::infinity();
    }

    float       currentDistance = 0.0f;
    const int32 maxSteps        = static_cast<int32>(header_.gridWidth) + static_cast<int32>(header_.gridHeight) + 2;
    int32       steps           = 0;

    while ((col != endCol || row != endRow) && currentDistance < 1.0f)
    {
        if (++steps > maxSteps)
        {
            break;
        }

        // Move to whichever grid line is closer.
        if (nextX < nextZ)
        {
            currentDistance = nextX;
            nextX += deltaX;
            col += stepCol;

            row1 = std::max<int32>(0, row - cellSearchDiff);
            row2 = std::min<int32>(header_.gridHeight - 1, row + cellSearchDiff);

            col1 = std::clamp<int32>(col + stepCol, 0, header_.gridWidth - 1);
            col2 = col1;
        }
        else
        {
            currentDistance = nextZ;
            nextZ += deltaZ;
            row += stepRow;

            row1 = std::clamp<int32>(row + stepRow, 0, header_.gridHeight - 1);
            row2 = row1;

            col1 = std::max<int32>(0, col - cellSearchDiff);
            col2 = std::min<int32>(header_.gridWidth - 1, col + cellSearchDiff);
        }

        if (currentDistance <= 1.0f)
        {
            for (int32 r = row1; r <= row2; ++r)
            {
                const auto rGrid = static_cast<uint32>(r) * header_.gridWidth;
                for (int32 c = col1; c <= col2; ++c)
                {
                    if (rayIntersectCell(start, end, yRange, rGrid + static_cast<uint32>(c), ignoreTransparentBarriers))
                    {
                        return true;
                    }
                }
            }
        }
    }

    return false;
}

auto XiMeshImpl::getPositionInfo(const Vector3& position, const YOffsets yOffsets, const IgnoreTransparentBarriers ignoreTransparentBarriers) const -> Maybe<RayHitInfo>
{
    TracyZoneScoped;

    const auto cellSearchDiff = header_.wideSearch > 0 ? 2 : 1;

    const auto start = Vector3{ position.x, position.y + yOffsets.start, position.z };
    const auto end   = Vector3{ position.x, position.y + yOffsets.start + yOffsets.end, position.z };

    auto [col, row] = worldToCell(start.x, start.z);

    const auto yRange = YRange{ std::min(start.y, end.y), std::max(start.y, end.y) };

    const auto row1 = std::max<int32>(0, row - cellSearchDiff);
    const auto row2 = std::min<int32>(header_.gridHeight - 1, row + cellSearchDiff);
    const auto col1 = std::max<int32>(0, col - cellSearchDiff);
    const auto col2 = std::min<int32>(header_.gridWidth - 1, col + cellSearchDiff);

    Maybe<RayHitInfo> closestHit;

    for (int32 r = row1; r <= row2; ++r)
    {
        const auto rGrid = static_cast<uint32>(r) * header_.gridWidth;
        for (int32 c = col1; c <= col2; ++c)
        {
            rayIntersectCellHitInfo(start, end, yRange, rGrid + static_cast<uint32>(c), ignoreTransparentBarriers, closestHit);
        }
    }

    return closestHit;
}

auto XiMeshImpl::rayIntersectCell(const Vector3& start, const Vector3& end, const YRange yRange, const uint32 cellIdx, const IgnoreTransparentBarriers ignoreTransparentBarriers) const -> bool
{
    if (cellIdx >= cells_.size())
    {
        return false;
    }

    const auto& cell = cells_[cellIdx];
    if (cell.count == 0)
    {
        return false;
    }

    const auto& cRange = cellRanges_[cellIdx];
    if (yRange.min > cRange.max || yRange.max < cRange.min)
    {
        return false;
    }

    const auto worldDiff = end - start;

    uint16  lastPlacementIdx = UINT16_MAX;
    Vector3 oStart{};
    Vector3 oDiff{};
    Vector3 oInvDiff{};
    uint32  v1Off = 0;
    uint32  v3Off = 2;

    for (uint16 ref = 0; ref < cell.count; ++ref)
    {
        const auto& [blockIdx, placementIdx] = entries_[cell.offset + ref];
        const auto& block                    = blocks_[blockIdx];

        if (block.hasBarriers && ignoreTransparentBarriers)
        {
            continue;
        }

        const auto& place = placements_[placementIdx];
        if (yRange.min > place.yMax || yRange.max < place.yMin)
        {
            continue;
        }

        if (placementIdx != lastPlacementIdx)
        {
            lastPlacementIdx = placementIdx;
            const auto& w2o  = w2os_[placementIdx];
            oStart           = w2o.applyToCopy(start);
            const auto& el   = w2o.elements;
            oDiff            = Vector3{
                el[0][0] * worldDiff.x + el[1][0] * worldDiff.y + el[2][0] * worldDiff.z,
                el[0][1] * worldDiff.x + el[1][1] * worldDiff.y + el[2][1] * worldDiff.z,
                el[0][2] * worldDiff.x + el[1][2] * worldDiff.y + el[2][2] * worldDiff.z,
            };
            oInvDiff        = reciprocalDir(oDiff);
            const auto flip = placementFlips_[placementIdx];
            v1Off           = flip ? 2u : 0u;
            v3Off           = flip ? 0u : 2u;
        }

        const auto triCount = block.metas.size();

        // Broad-phase: skip the whole block when the object-space ray segment misses its bounds.
        // Only worth the slab test for blocks with several triangles (cheap vs the narrow-phase, but
        // not free for a 1-2 triangle block that the ray passes through anyway).
        if (triCount > kCullMinTriangles && !segmentHitsAABB(oStart, oInvDiff, block.aabbMin, block.aabbMax))
        {
            continue;
        }

        for (size_t triIdx = 0; triIdx < triCount; ++triIdx)
        {
            const auto base = triIdx * 3;
            const auto va   = vertexAt(block, block.indices[base + v1Off]);
            const auto vb   = vertexAt(block, block.indices[base + 1]);
            const auto vc   = vertexAt(block, block.indices[base + v3Off]);

            if (rayIntersectTriangle(va, vb, vc, oStart, oDiff))
            {
                return true;
            }
        }
    }

    return false;
}

auto XiMeshImpl::rayIntersectCellHitInfo(const Vector3& start, const Vector3& end, const YRange yRange, const uint32 cellIdx, const IgnoreTransparentBarriers ignoreTransparentBarriers, Maybe<RayHitInfo>& closestHit) const -> void
{
    if (cellIdx >= cells_.size())
    {
        return;
    }

    const auto& cell = cells_[cellIdx];
    if (cell.count == 0)
    {
        return;
    }

    const auto& cRange = cellRanges_[cellIdx];
    if (yRange.min > cRange.max || yRange.max < cRange.min)
    {
        return;
    }

    const auto worldDiff = end - start;

    uint16  lastPlacementIdx = UINT16_MAX;
    Vector3 oStart{};
    Vector3 oDiff{};
    Vector3 oInvDiff{};
    uint32  v1Off = 0;
    uint32  v3Off = 2;

    for (uint16 ref = 0; ref < cell.count; ++ref)
    {
        const auto& [blockIdx, placementIdx] = entries_[cell.offset + ref];
        const auto& block                    = blocks_[blockIdx];

        if (block.hasBarriers && ignoreTransparentBarriers)
        {
            continue;
        }

        const auto& place = placements_[placementIdx];
        if (yRange.min > place.yMax || yRange.max < place.yMin)
        {
            continue;
        }

        if (placementIdx != lastPlacementIdx)
        {
            lastPlacementIdx = placementIdx;
            const auto& w2o  = w2os_[placementIdx];
            oStart           = w2o.applyToCopy(start);
            const auto& el   = w2o.elements;
            oDiff            = Vector3{
                el[0][0] * worldDiff.x + el[1][0] * worldDiff.y + el[2][0] * worldDiff.z,
                el[0][1] * worldDiff.x + el[1][1] * worldDiff.y + el[2][1] * worldDiff.z,
                el[0][2] * worldDiff.x + el[1][2] * worldDiff.y + el[2][2] * worldDiff.z,
            };
            oInvDiff        = reciprocalDir(oDiff);
            const auto flip = placementFlips_[placementIdx];
            v1Off           = flip ? 2u : 0u;
            v3Off           = flip ? 0u : 2u;
        }

        const auto triCount = block.metas.size();

        // Broad-phase: skip the whole block when the object-space ray segment misses its bounds.
        // Only worth the slab test for blocks with several triangles (cheap vs the narrow-phase, but
        // not free for a 1-2 triangle block that the ray passes through anyway).
        if (triCount > kCullMinTriangles && !segmentHitsAABB(oStart, oInvDiff, block.aabbMin, block.aabbMax))
        {
            continue;
        }

        for (size_t triIdx = 0; triIdx < triCount; ++triIdx)
        {
            const auto base = triIdx * 3;
            const auto va   = vertexAt(block, block.indices[base + v1Off]);
            const auto vb   = vertexAt(block, block.indices[base + 1]);
            const auto vc   = vertexAt(block, block.indices[base + v3Off]);

            const auto hitOpt = rayIntersectTriangle(va, vb, vc, oStart, oDiff);
            if (hitOpt.has_value())
            {
                const auto intersection = hitOpt.value();
                const auto distanceSq   = (oStart - intersection).magnitudeSquared();
                if (!closestHit.has_value() || closestHit->distanceSq > distanceSq)
                {
                    const auto& meta = block.metas[triIdx];
                    closestHit       = RayHitInfo{
                        .intersection = intersection,
                        .distanceSq   = distanceSq,
                        .placement    = &place,
                        .type         = static_cast<TerrainType>(meta.material),
                        .barrier      = meta.barrier != 0,
                    };
                }
            }
        }
    }
}
