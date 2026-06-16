/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "detour_navmesh.h"

#include <DetourNavMesh.h>
#include <DetourNavMeshQuery.h>

#include "common/utils.h"
#include "common/xirand.h"

#include <algorithm>
#include <fstream>
#include <common/types/maybe.h>
#include <vector>

namespace
{

constexpr int NAVMESHSET_MAGIC   = 'M' << 24 | 'S' << 16 | 'E' << 8 | 'T'; // 'MSET'
constexpr int NAVMESHSET_VERSION = 1;

// Mirrors SamplePolyFlags from RecastDemo's Sample.h.
enum SamplePolyFlags : uint16_t
{
    SAMPLE_POLYFLAGS_WALK     = 0x0001, // Walk (ground, grass, road)
    SAMPLE_POLYFLAGS_SWIM     = 0x0002, // Swim (water)
    SAMPLE_POLYFLAGS_DOOR     = 0x0004, // Move through doors
    SAMPLE_POLYFLAGS_JUMP     = 0x0008, // Jump
    SAMPLE_POLYFLAGS_DISABLED = 0x0010, // Disabled polygon
    SAMPLE_POLYFLAGS_ALL      = 0xFFFF, // All abilities
};

// Exclude wins over include, so include all and exclude the unwanted.
constexpr unsigned short INCLUDE_FLAGS = SamplePolyFlags::SAMPLE_POLYFLAGS_ALL;
constexpr unsigned short EXCLUDE_FLAGS = SamplePolyFlags::SAMPLE_POLYFLAGS_DISABLED;

// Detour result buffer sizes. Bigger buffers allow longer/higher-quality paths but
// cost more; since queries run blocking, keep these as small as quality allows.
constexpr size_t MAX_NAV_POLYS   = 1024; // buffer / node-pool / clamp ceiling
constexpr size_t PATH_POLY_LIMIT = 128;  // per-query corridor cap.
                                         // 128 routes identically to 512/1024 on the Bhaflau canary while
                                         // issuing smaller/faster queries; buffers <= 32 degrade to near-
                                         // straight (wall-clipping) paths, so 128 keeps a comfortable margin.
constexpr size_t MAX_QUERY_POLYS = 16;

// Detour search extents. Larger extents search more polys; keep small since queries
// run blocking. Used to snap a query point onto the nearest poly.
constexpr float smallPolyPickExt[3] = { 0.5f, 1.0f, 0.5f };
constexpr float polyPickExt[3]      = { 2.5f, 5.0f, 2.5f };
constexpr float largePolyPickExt[3] = { 30.0f, 60.0f, 30.0f };

struct NavMeshSetHeader
{
    int             magic;
    int             version;
    int             numTiles;
    dtNavMeshParams params;
};

struct NavMeshTileHeader
{
    dtTileRef tileRef;
    int       dataSize;
};

} // namespace

// Detour is right-handed Y-up, FFXI is left-handed Y-up: Y and Z are sign-flipped between them.
auto DetourNavMesh::toDetour(const position_t& p) -> std::array<float, 3>
{
    return { p.x, p.y * -1.0f, p.z * -1.0f };
}

auto DetourNavMesh::fromDetour(const float* p) -> position_t
{
    return { p[0], p[1] * -1.0f, p[2] * -1.0f, 0, 0 };
}

auto DetourNavMesh::makeFilter() const -> dtQueryFilter
{
    dtQueryFilter filter;
    filter.setIncludeFlags(INCLUDE_FLAGS);
    filter.setExcludeFlags(EXCLUDE_FLAGS);
    return filter;
}

auto DetourNavMesh::lookupPoly(const std::array<float, 3>& pos, const float* extents, const dtQueryFilter& filter) const -> Maybe<DetourNavMesh::PolyLookup>
{
    PolyLookup hit{};
    const auto status = navMeshQuery_.findNearestPoly(pos.data(), extents, &filter, &hit.ref, hit.nearest.data());
    if (dtStatusFailed(status))
    {
        ShowError("DetourNavMesh::lookupPoly findNearestPoly failed (%u): %s", zoneID_, detourStatusString(status));
        return std::nullopt;
    }
    if (!navMesh_->isValidPolyRef(hit.ref))
    {
        return std::nullopt;
    }
    return hit;
}

DetourNavMesh::DetourNavMesh(uint16 zoneID)
: zoneID_(zoneID)
, navMesh_(nullptr)
{
    navMeshQueryPolyData_.resize(MAX_NAV_POLYS);
    navMeshQueryStraightPathFloatData_.resize(MAX_NAV_POLYS * 3);
    navMeshQueryStraightPathFlagData_.resize(MAX_NAV_POLYS);
    navMeshQueryStraightPathPolyData_.resize(MAX_NAV_POLYS);
}

DetourNavMesh::~DetourNavMesh()
{
    if (navMesh_)
    {
        dtFreeNavMesh(navMesh_);
    }
}

auto DetourNavMesh::load(const std::string& filename) -> bool
{
    this->filename_ = filename;

    std::ifstream file(filename.c_str(), std::ios_base::in | std::ios_base::binary);

    if (!file.good())
    {
        return false;
    }

    // Read header
    NavMeshSetHeader header{};
    file.read(reinterpret_cast<char*>(&header), sizeof(header));
    if (header.magic != NAVMESHSET_MAGIC)
    {
        return false;
    }
    if (header.version != NAVMESHSET_VERSION)
    {
        return false;
    }

    navMesh_ = dtAllocNavMesh();
    if (!navMesh_)
    {
        return false;
    }

    dtStatus status = navMesh_->init(&header.params);
    if (dtStatusFailed(status))
    {
        ShowError("DetourNavMesh::load Could not initialize detour for (%s)", filename);
        ShowError(detourStatusString(status));
        return false;
    }

    // Read tiles
    for (int i = 0; i < header.numTiles; ++i)
    {
        NavMeshTileHeader tileHeader{};
        file.read(reinterpret_cast<char*>(&tileHeader), sizeof(tileHeader));
        if (!tileHeader.tileRef || !tileHeader.dataSize)
        {
            break;
        }

        unsigned char* data = (unsigned char*)dtAlloc(tileHeader.dataSize, DT_ALLOC_PERM);
        if (!data)
        {
            break;
        }
        std::memset(data, 0, tileHeader.dataSize);
        file.read(reinterpret_cast<char*>(data), tileHeader.dataSize);

        navMesh_->addTile(data, tileHeader.dataSize, DT_TILE_FREE_DATA, tileHeader.tileRef, nullptr);
    }

    // Init the path finder query
    status = navMeshQuery_.init(navMesh_, MAX_NAV_POLYS);

    if (dtStatusFailed(status))
    {
        ShowError("DetourNavMesh::load Error loading navMeshQuery_ (%s)", filename);
        ShowError(detourStatusString(status));
        return false;
    }

    return true;
}

auto DetourNavMesh::unload() -> void
{
    dtFreeNavMesh(navMesh_);
    navMesh_ = nullptr;
}

auto DetourNavMesh::installNavMesh(dtNavMesh* newNavMesh) -> bool
{
    if (!newNavMesh)
    {
        return false;
    }

    unload();

    navMesh_ = newNavMesh;

    const auto status = navMeshQuery_.init(navMesh_, MAX_NAV_POLYS);
    if (dtStatusFailed(status))
    {
        ShowErrorFmt("DetourNavMesh::installNavMesh: Could not init navMeshQuery ({})", zoneID_);
        unload();
        return false;
    }

    return true;
}

auto DetourNavMesh::save(const std::string& path) const -> bool
{
    if (!navMesh_ || path.empty())
    {
        return false;
    }

    std::ofstream file(path, std::ios::binary);
    if (!file.good())
    {
        ShowErrorFmt("DetourNavMesh::save: Could not open file for writing ({})", path);
        return false;
    }

    const auto* nav = navMesh_;

    auto header    = NavMeshSetHeader{};
    header.magic   = NAVMESHSET_MAGIC;
    header.version = NAVMESHSET_VERSION;
    header.params  = *nav->getParams();

    for (auto i = 0; i < nav->getMaxTiles(); ++i)
    {
        const auto* tile = nav->getTile(i);
        if (tile && tile->header && tile->dataSize > 0)
        {
            header.numTiles++;
        }
    }

    file.write(reinterpret_cast<const char*>(&header), sizeof(header));

    for (auto i = 0; i < nav->getMaxTiles(); ++i)
    {
        const auto* tile = nav->getTile(i);
        if (!tile || !tile->header || tile->dataSize <= 0)
        {
            continue;
        }

        const auto tileHeader = NavMeshTileHeader{
            .tileRef  = nav->getTileRef(tile),
            .dataSize = tile->dataSize,
        };

        file.write(reinterpret_cast<const char*>(&tileHeader), sizeof(tileHeader));
        file.write(reinterpret_cast<const char*>(tile->data), tile->dataSize);
    }

    return true;
}

auto DetourNavMesh::findPath(const position_t& start, const position_t& end) -> Maybe<PathResult>
{
    TracyZoneScoped;

    if (std::isnan(start.x) || std::isnan(start.y) || std::isnan(start.z) ||
        std::isnan(end.x) || std::isnan(end.y) || std::isnan(end.z))
    {
        ShowWarning("DetourNavMesh::findPath NaN position detected (%u)", zoneID_);
        return std::nullopt;
    }

    DebugNavmesh("DetourNavMesh::findPath (%f, %f, %f) -> (%f, %f, %f) (zone: %u) (MAX_NAV_POLYS: %u)",
                 start.x, start.y, start.z, end.x, end.y, end.z, zoneID_, MAX_NAV_POLYS);

    const auto filter    = makeFilter();
    const auto startPoly = lookupPoly(toDetour(start), polyPickExt, filter);
    if (!startPoly)
    {
        DebugNavmesh("DetourNavMesh::findPath start has no poly within extents: (%f, %f, %f) (%u)", start.x, start.y, start.z, zoneID_);
        return std::nullopt;
    }

    const auto endPoly = lookupPoly(toDetour(end), polyPickExt, filter);
    if (!endPoly)
    {
        DebugNavmesh("DetourNavMesh::findPath end has no poly within extents: (%f, %f, %f) (%u)", end.x, end.y, end.z, zoneID_);
        return std::nullopt;
    }

    // Build a poly corridor from start to end
    int32    pathPolyCount = 0;
    dtStatus status        = navMeshQuery_.findPath(
        startPoly->ref, endPoly->ref,
        startPoly->nearest.data(), endPoly->nearest.data(),
        &filter, navMeshQueryPolyData_.data(), &pathPolyCount, static_cast<int>(PATH_POLY_LIMIT));
    if (dtStatusFailed(status))
    {
        ShowError("DetourNavMesh::findPath findPath error (%u)", zoneID_);
        ShowError(detourStatusString(status));
        return std::nullopt;
    }

    if (pathPolyCount <= 0)
    {
        ShowError("DetourNavMesh::findPath Unable to generate polys for path (%f, %f, %f)->(%f, %f, %f) (%u)",
                  start.x, start.y, start.z, end.x, end.y, end.z, zoneID_);
        return std::nullopt;
    }

    // Straighten the corridor into a waypoint list.
    // DT_STRAIGHTPATH_ALL_CROSSINGS can worsen local-minima trapping; keep it off.
    int32 straightPathCount = 0;
    status = navMeshQuery_.findStraightPath(
        startPoly->nearest.data(), endPoly->nearest.data(),
        navMeshQueryPolyData_.data(), pathPolyCount,
        navMeshQueryStraightPathFloatData_.data(),
        navMeshQueryStraightPathFlagData_.data(),
        navMeshQueryStraightPathPolyData_.data(),
        &straightPathCount, static_cast<int>(PATH_POLY_LIMIT) /* , DT_STRAIGHTPATH_ALL_CROSSINGS */);
    if (dtStatusFailed(status))
    {
        ShowError("DetourNavMesh::findPath findStraightPath error (%u)", zoneID_);
        ShowError(detourStatusString(status));
        return std::nullopt;
    }

    // Partial path: if the poly buffer ran out before reaching `end`, Detour's best-guess
    // final waypoint lands far from the requested endpoint. Drop it to avoid trapping the
    // entity in a local minimum; the caller walks this chunk and re-requests from there.
    // Compared in Detour space - distance is invariant to the Y/Z sign flip.
    const float* pathEnd = &navMeshQueryStraightPathFloatData_[(straightPathCount - 1) * 3];
    const float* wantEnd = endPoly->nearest.data();
    const float  dx = pathEnd[0] - wantEnd[0];
    const float  dy = pathEnd[1] - wantEnd[1];
    const float  dz = pathEnd[2] - wantEnd[2];

    bool isPartial = false;
    if (straightPathCount > 2 && dx * dx + dy * dy + dz * dz > 5.0f * 5.0f)
    {
        DebugNavmesh("DetourNavMesh::findPath Partial path detected! (%u)", zoneID_);
        isPartial = true;
        straightPathCount -= 1;
    }

    // straightPathCount == 1: only the start position was produced - no usable path
    if (straightPathCount <= 1)
    {
        return std::nullopt;
    }

    // TODO: Detect local minima and re-try pathing with a larger buffer.

    // Skip index 0 (the start position - we're already there)
    std::vector<pathpoint_t> outPoints;
    outPoints.reserve(straightPathCount - 1);
    for (int i = 1; i < straightPathCount; ++i)
    {
        outPoints.emplace_back(pathpoint_t{
            fromDetour(&navMeshQueryStraightPathFloatData_[i * 3]),
            0s,
            false,
        });
    }

    return PathResult{ std::move(outPoints), isPartial };
}

auto DetourNavMesh::findRandomPosition(const position_t& start, float maxRadius) const -> Maybe<position_t>
{
    TracyZoneScoped;

    DebugNavmesh("DetourNavMesh::findRandomPosition (%f, %f, %f) (%u)", start.x, start.y, start.z, zoneID_);

    const auto filter    = makeFilter();
    const auto spos      = toDetour(start);
    const auto startPoly = lookupPoly(spos, polyPickExt, filter);
    if (!startPoly)
    {
        DebugNavmesh("DetourNavMesh::findRandomPosition start has no poly within extents: (%f, %f, %f) (%u)", start.x, start.y, start.z, zoneID_);
        return std::nullopt;
    }

    dtPolyRef randomRef = 0;
    float     randomPt[3];
    const auto status = navMeshQuery_.findRandomPointAroundCircle(
        startPoly->ref, spos.data(), maxRadius, &filter,
        []() -> float { return xirand::GetRandomNumber(1.0f); },
        &randomRef, randomPt);

    if (dtStatusFailed(status))
    {
        ShowError("DetourNavMesh::findRandomPosition error (%u): %s", zoneID_, detourStatusString(status));
        return std::nullopt;
    }

    return fromDetour(randomPt);
}

auto DetourNavMesh::validPosition(const position_t& position) const -> bool
{
    TracyZoneScoped;

    DebugNavmesh("DetourNavMesh::validPosition (%f, %f, %f) (%u)", position.x, position.y, position.z, zoneID_);
    return lookupPoly(toDetour(position), smallPolyPickExt, makeFilter()).has_value();
}

auto DetourNavMesh::findClosestValidPoint(const position_t& position) const -> Maybe<position_t>
{
    TracyZoneScoped;

    DebugNavmesh("DetourNavMesh::findClosestValidPoint (%f, %f, %f) (%u)", position.x, position.y, position.z, zoneID_);

    const auto hit = lookupPoly(toDetour(position), largePolyPickExt, makeFilter());
    if (!hit)
    {
        return std::nullopt;
    }

    return fromDetour(hit->nearest.data());
}

auto DetourNavMesh::findFurthestValidPoint(const position_t& startPosition, const position_t& endPosition) const -> Maybe<position_t>
{
    TracyZoneScoped;

    DebugNavmesh("DetourNavMesh::findFurthestValidPoint (%f, %f, %f) -> (%f, %f, %f) (%u)",
                 startPosition.x, startPosition.y, startPosition.z,
                 endPosition.x, endPosition.y, endPosition.z, zoneID_);

    const auto filter    = makeFilter();
    const auto startPoly = lookupPoly(toDetour(startPosition), largePolyPickExt, filter);
    if (!startPoly)
    {
        return std::nullopt;
    }

    const auto targetPos = toDetour(endPosition);
    dtPolyRef  visited[MAX_QUERY_POLYS];
    int        visitedCount = 0;
    float      result[3];

    const auto status = navMeshQuery_.moveAlongSurface(
        startPoly->ref, startPoly->nearest.data(), targetPos.data(),
        &filter, result, visited, &visitedCount, MAX_QUERY_POLYS);

    if (dtStatusFailed(status))
    {
        return std::nullopt;
    }

    return fromDetour(result);
}

auto DetourNavMesh::moveAlongSurface(const position_t& start, const position_t& end, position_t& result) const -> bool
{
    TracyZoneScoped;

    // Tight start extent: assumes the entity is already on the mesh. If `start` is genuinely
    // off-mesh (> polyPickExt from any poly - e.g. a zone-in slide or "underground" worm),
    // report failure so the caller free-moves until it slides back on.
    const auto filter    = makeFilter();
    const auto startPoly = lookupPoly(toDetour(start), polyPickExt, filter);
    if (!startPoly)
    {
        return false;
    }

    const auto targetPos = toDetour(end);
    dtPolyRef  visited[MAX_QUERY_POLYS];
    int        visitedCount = 0;
    float      out[3];

    const auto status = navMeshQuery_.moveAlongSurface(
        startPoly->ref, startPoly->nearest.data(), targetPos.data(),
        &filter, out, visited, &visitedCount, MAX_QUERY_POLYS);

    if (dtStatusFailed(status))
    {
        return false;
    }

    result = fromDetour(out);
    return true;
}

auto DetourNavMesh::snapToValidPosition(position_t& position) const -> void
{
    TracyZoneScoped;

    DebugNavmesh("DetourNavMesh::snapToValidPosition (%f, %f, %f) (%u)", position.x, position.y, position.z, zoneID_);

    const auto filter = makeFilter();
    const auto spos   = toDetour(position);

    // Cheap small radius first; fall back to 30f XZ for genuinely off-mesh positions
    // (e.g. after a stuck-repath teleport lands on a cliff ledge).
    auto poly = lookupPoly(spos, polyPickExt, filter);
    if (!poly)
    {
        poly = lookupPoly(spos, largePolyPickExt, filter);
    }
    if (!poly)
    {
        return;
    }

    const auto snapped = fromDetour(poly->nearest.data());
    position.x = snapped.x;
    position.y = snapped.y;
    position.z = snapped.z;
}

[[nodiscard]] auto DetourNavMesh::detourStatusString(const uint32 status) -> std::string
{
    std::string outStr;

    // High-level status
    if (status & DT_FAILURE)
    {
        outStr += "DT_FAILURE: Operation failed. ";
    }
    if (status & DT_SUCCESS)
    {
        outStr += "DT_SUCCESS: Operation succeeded. ";
    }
    if (status & DT_IN_PROGRESS)
    {
        outStr += "DT_IN_PROGRESS: Operation still in progress. ";
    }

    // Status detail bits
    if (status & DT_WRONG_MAGIC)
    {
        outStr += "DT_WRONG_MAGIC: Input data is not recognized. ";
    }
    if (status & DT_WRONG_VERSION)
    {
        outStr += "DT_WRONG_VERSION: Input data is in wrong version. ";
    }
    if (status & DT_OUT_OF_MEMORY)
    {
        outStr += "DT_OUT_OF_MEMORY: Operation ran out of memory. ";
    }
    if (status & DT_INVALID_PARAM)
    {
        outStr += "DT_INVALID_PARAM: An input parameter was invalid. ";
    }
    if (status & DT_BUFFER_TOO_SMALL)
    {
        outStr += "DT_BUFFER_TOO_SMALL: Result buffer for the query was too small to store all results. ";
    }
    if (status & DT_OUT_OF_NODES)
    {
        outStr += "DT_OUT_OF_NODES: Query ran out of nodes during search. ";
    }
    if (status & DT_PARTIAL_RESULT)
    {
        outStr += "DT_PARTIAL_RESULT: Query did not reach the end location, returning best guess. ";
    }
    if (status & DT_ALREADY_OCCUPIED)
    {
        outStr += "DT_ALREADY_OCCUPIED: A tile has already been assigned to the given x, y coordinate. ";
    }

    return outStr;
}

