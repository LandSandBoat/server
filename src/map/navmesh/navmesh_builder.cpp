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

#include "navmesh_builder.h"

#include "common/logging.h"
#include "common/timer.h"

#include <map/ximesh/ximesh.h>

#include <DetourCommon.h>
#include <DetourNavMesh.h>
#include <DetourNavMeshBuilder.h>
#include <Recast.h>

#include <algorithm>
#include <array>
#include <cmath>
#include <map>
#include <unordered_set>

namespace
{

// Recast/Detour constants (not tunable)
constexpr uint16 SAMPLE_POLYFLAGS_WALK  = 0x0001; // RecastDemo/Include/Sample.h
constexpr int    TILE_BORDER_PADDING    = 8;      // Extra cells beyond walkableRadius for tile stitching; <8 leaves eroded seam gaps on continuous terrain
constexpr float  MIN_DETAIL_SAMPLE_DIST = 0.9f;   // Recast clamps non-zero detailSampleDist to >= 0.9
constexpr int    DT_MAX_TILE_BITS       = 14;     // dtNavMesh max bits for tile indexing
constexpr int    DT_TOTAL_REF_BITS      = 22;     // dtNavMesh total bits for tile + poly refs

// FFXI dat format constant (not tunable)
constexpr float XIMESH_CELL_SIZE = 4.0f; // Each ximesh grid cell covers 4x4 world units

// A triangle counts as lying on a ySkipPlanes plane when all three vertex Ys are
// within this distance of it. Phantom planes sit at exact values post-transform,
// so this only needs to absorb float noise.
constexpr float Y_SKIP_PLANE_TOLERANCE = 0.01f;

constexpr std::size_t TILE_BATCH_SIZE = 32;

// Off-mesh link generation limits
constexpr int   OFFMESH_MAX_PER_TILE = 256;  // hard cap; excess dropped with a warning
constexpr float OFFMESH_DEDUP_DIST   = 1.0f; // links whose start AND end are within this are dupes

auto transform(const std::array<float, 9>& rot, const std::array<float, 3>& trans, const float* vertex) -> std::array<float, 3>
{
    return {
        rot[0] * vertex[0] + rot[3] * vertex[1] + rot[6] * vertex[2] + trans[0],
        rot[1] * vertex[0] + rot[4] * vertex[1] + rot[7] * vertex[2] + trans[1],
        rot[2] * vertex[0] + rot[5] * vertex[1] + rot[8] * vertex[2] + trans[2],
    };
}

// Scan each walkable poly's ledge (border) edges.
// Where a walkable surface sits below within the drop window, link the ledge down to it.
// Landings come only from this tile's own detail mesh, so both endpoints are real polys.
// Detour space, Y up.
auto buildOffMeshConnections(const rcPolyMesh& pmesh, const rcPolyMeshDetail& dmesh, const NavMeshConfig& config, const int tileX, const int tileY, const std::vector<std::array<float, 9>>& barriers) -> TileOffMeshConnections
{
    TileOffMeshConnections out;

    const int    vertsPerPoly = pmesh.nvp;
    const float  cellSize     = pmesh.cs;
    const float  cellHeight   = pmesh.ch;
    const float* boundsMin    = pmesh.bmin;
    const float  minDrop      = config.agentMaxClimb; // below this Recast already connects in-mesh
    const float  maxDrop      = config.offMeshMaxDrop;
    const float  maxReach     = std::max(config.offMeshHorizReach, config.agentRadius);
    const float  linkRadius   = std::max(config.agentRadius, cellSize);

    const auto polyVertToWorld = [&](const int vertIndex, float* outXyz)
    {
        outXyz[0] = boundsMin[0] + pmesh.verts[vertIndex * 3 + 0] * cellSize;
        outXyz[1] = boundsMin[1] + pmesh.verts[vertIndex * 3 + 1] * cellHeight;
        outXyz[2] = boundsMin[2] + pmesh.verts[vertIndex * 3 + 2] * cellSize;
    };

    // Union-find of walk-connected polys; skip a link whose landing shares the source poly's component.
    std::vector<int> parent(pmesh.npolys);
    for (int p = 0; p < pmesh.npolys; ++p)
    {
        parent[p] = p;
    }

    const auto findRoot = [&](int x) -> int
    {
        while (parent[x] != x)
        {
            parent[x] = parent[parent[x]];
            x         = parent[x];
        }
        return x;
    };

    for (int p = 0; p < pmesh.npolys; ++p)
    {
        const unsigned short* poly = &pmesh.polys[p * 2 * vertsPerPoly];
        for (int j = 0; j < vertsPerPoly; ++j)
        {
            if (poly[j] == RC_MESH_NULL_IDX)
            {
                break;
            }

            const unsigned short neighborPoly = poly[vertsPerPoly + j];
            if (neighborPoly == RC_MESH_NULL_IDX || (neighborPoly & 0x8000)) // border or tile portal, not internal
            {
                continue;
            }

            const int rootA = findRoot(p);
            const int rootB = findRoot(neighborPoly);
            if (rootA != rootB)
            {
                parent[rootA] = rootB;
            }
        }
    }

    // Per-poly xz-AABB of the detail surface, to cull the height search.
    struct PolyAABB
    {
        float xmin, xmax, zmin, zmax;
    };

    std::vector<PolyAABB> aabb(pmesh.npolys);
    for (int p = 0; p < pmesh.npolys; ++p)
    {
        const int detailBase      = dmesh.meshes[p * 4 + 0];
        const int detailVertCount = dmesh.meshes[p * 4 + 1];
        auto      box             = PolyAABB{ FloatMax, FloatLowest, FloatMax, FloatLowest };
        for (int i = 0; i < detailVertCount; ++i)
        {
            const float* vert = &dmesh.verts[(detailBase + i) * 3];
            box.xmin          = std::min(box.xmin, vert[0]);
            box.xmax          = std::max(box.xmax, vert[0]);
            box.zmin          = std::min(box.zmin, vert[2]);
            box.zmax          = std::max(box.zmax, vert[2]);
        }
        aabb[p] = box;
    }

    // Highest walkable detail-surface Y at (x, z) within [loY, hiY], excluding srcPoly, plus the poly it lands on (used by the same-component skip below).
    const auto sampleBelow = [&](const float x, const float z, const float loY, const float hiY, const int srcPoly, float& outY, int& outPoly) -> bool
    {
        bool  found = false;
        float best  = FloatLowest;
        for (int p = 0; p < pmesh.npolys; ++p)
        {
            if (p == srcPoly || pmesh.areas[p] != RC_WALKABLE_AREA)
            {
                continue;
            }

            const auto& box = aabb[p];
            if (x < box.xmin - 0.01f || x > box.xmax + 0.01f || z < box.zmin - 0.01f || z > box.zmax + 0.01f)
            {
                continue;
            }

            const int detailBase = dmesh.meshes[p * 4 + 0];
            const int triBase    = dmesh.meshes[p * 4 + 2];
            const int triCount   = dmesh.meshes[p * 4 + 3];
            for (int t = 0; t < triCount; ++t)
            {
                const unsigned char* tri = &dmesh.tris[(triBase + t) * 4];
                const float*         va  = &dmesh.verts[(detailBase + tri[0]) * 3];
                const float*         vb  = &dmesh.verts[(detailBase + tri[1]) * 3];
                const float*         vc  = &dmesh.verts[(detailBase + tri[2]) * 3];

                const float probe[3] = { x, 0.0f, z };
                float       y        = 0.0f;
                if (dtClosestHeightPointTriangle(probe, va, vb, vc, y) && y >= loY && y <= hiY && y > best)
                {
                    best    = y;
                    found   = true;
                    outPoly = p;
                }
            }
        }

        if (found)
        {
            outY = best;
        }

        return found;
    };

    // barrier triangles reduced to xz segments + a Y span, to veto links that clip through walls
    struct BarrierWall
    {
        float x1, z1, x2, z2, yMin, yMax;
    };

    std::vector<BarrierWall> walls;
    walls.reserve(barriers.size());
    for (const auto& b : barriers)
    {
        const float* v[3] = { &b[0], &b[3], &b[6] };

        int   bi = 0;
        int   bj = 1;
        float bd = -1.0f;
        for (int i = 0; i < 3; ++i)
        {
            for (int j = i + 1; j < 3; ++j)
            {
                const float dx = v[i][0] - v[j][0];
                const float dz = v[i][2] - v[j][2];
                const float dd = dx * dx + dz * dz;
                if (dd > bd)
                {
                    bd = dd;
                    bi = i;
                    bj = j;
                }
            }
        }

        walls.push_back(BarrierWall{ v[bi][0], v[bi][2], v[bj][0], v[bj][2], std::min({ v[0][1], v[1][1], v[2][1] }), std::max({ v[0][1], v[1][1], v[2][1] }) });
    }

    // segment (a -> b) crosses segment (c -> d) in the xz-plane
    const auto segmentsCrossXZ = [](const float* a, const float* b, float cx, float cz, float dx, float dz) -> bool
    {
        const auto side = [](float px, float pz, float qx, float qz, float rx, float rz)
        {
            return (rz - pz) * (qx - px) - (rx - px) * (qz - pz);
        };

        const float d1 = side(cx, cz, dx, dz, a[0], a[2]);
        const float d2 = side(cx, cz, dx, dz, b[0], b[2]);
        const float d3 = side(a[0], a[2], b[0], b[2], cx, cz);
        const float d4 = side(a[0], a[2], b[0], b[2], dx, dz);
        return (d1 > 0.0f) != (d2 > 0.0f) && (d3 > 0.0f) != (d4 > 0.0f);
    };

    // only a wall rising more than a climb-height above the ledge blocks the drop; one sitting at
    // the ledge is its own drop-face, which must not veto the link. detour Y is up-positive
    const auto crossesBarrier = [&](const float* start, const float* end) -> bool
    {
        const float ledgeY = std::max(start[1], end[1]);
        for (const auto& w : walls)
        {
            if (w.yMax <= ledgeY + config.agentMaxClimb)
            {
                continue;
            }

            if (segmentsCrossXZ(start, end, w.x1, w.z1, w.x2, w.z2))
            {
                return true;
            }
        }

        return false;
    };

    std::vector<OffMeshCandidate> candidates;
    for (int p = 0; p < pmesh.npolys; ++p)
    {
        if (pmesh.areas[p] != RC_WALKABLE_AREA)
        {
            continue;
        }

        const unsigned short* poly = &pmesh.polys[p * 2 * vertsPerPoly];

        int   vertCount   = 0;
        float centroid[3] = { 0.0f, 0.0f, 0.0f };
        for (int j = 0; j < vertsPerPoly; ++j)
        {
            if (poly[j] == RC_MESH_NULL_IDX)
            {
                break;
            }

            float worldVert[3];
            polyVertToWorld(poly[j], worldVert);
            centroid[0] += worldVert[0];
            centroid[1] += worldVert[1];
            centroid[2] += worldVert[2];
            vertCount++;
        }

        if (vertCount < 3)
        {
            continue;
        }

        centroid[0] /= static_cast<float>(vertCount);
        centroid[1] /= static_cast<float>(vertCount);
        centroid[2] /= static_cast<float>(vertCount);

        for (int j = 0; j < vertCount; ++j)
        {
            // Only ledge edges: RC_MESH_NULL_IDX is a solid border; internal neighbours and tile-portal edges (0x8000) are skipped.
            if (poly[vertsPerPoly + j] != RC_MESH_NULL_IDX)
            {
                continue;
            }

            float edgeA[3];
            float edgeB[3];
            polyVertToWorld(poly[j], edgeA);
            polyVertToWorld(poly[(j + 1) % vertCount], edgeB);
            float edgeMid[3];
            dtVlerp(edgeMid, edgeA, edgeB, 0.5f);

            // Outward direction (away from the poly centroid), in the xz-plane.
            float       outwardX   = edgeMid[0] - centroid[0];
            float       outwardZ   = edgeMid[2] - centroid[2];
            const float outwardLen = std::sqrt(outwardX * outwardX + outwardZ * outwardZ);
            if (outwardLen < 1e-4f)
            {
                continue;
            }

            outwardX /= outwardLen;
            outwardZ /= outwardLen;

            const float ledgeY       = edgeMid[1];
            float       landingX     = 0.0f;
            float       landingY     = 0.0f;
            float       landingZ     = 0.0f;
            int         landingPoly  = -1;
            bool        foundLanding = false;
            for (float reach = linkRadius; reach <= maxReach + 1e-3f; reach += 0.5f)
            {
                const float probeX = edgeMid[0] + outwardX * reach;
                const float probeZ = edgeMid[2] + outwardZ * reach;

                if (sampleBelow(probeX, probeZ, ledgeY - maxDrop, ledgeY - minDrop, p, landingY, landingPoly))
                {
                    landingX     = probeX;
                    landingZ     = probeZ;
                    foundLanding = true;
                    break; // nearest landing wins
                }
            }

            if (!foundLanding)
            {
                continue;
            }

            // Skip when the landing is already walk-reachable within this tile.
            if (findRoot(landingPoly) == findRoot(p))
            {
                continue;
            }

            const float start[3] = { edgeMid[0] - outwardX * linkRadius, ledgeY, edgeMid[2] - outwardZ * linkRadius }; // pulled just inside the source poly
            const float end[3]   = { landingX, landingY, landingZ };

            // drop through a wall/rail, not an open ledge
            if (crossesBarrier(start, end))
            {
                continue;
            }

            candidates.push_back(OffMeshCandidate{
                .start = { start[0], start[1], start[2] },
                .end   = { end[0], end[1], end[2] },
            });
        }
    }

    // Drop near-duplicate links (a long ledge spans many edges -> parallel dupes).
    const auto closeBy = [](const float* a, const float* b) -> bool
    {
        return dtVdistSqr(a, b) < OFFMESH_DEDUP_DIST * OFFMESH_DEDUP_DIST;
    };

    std::vector<OffMeshCandidate> unique;
    for (const auto& c : candidates)
    {
        const bool dupe = std::any_of(unique.begin(), unique.end(), [&](const OffMeshCandidate& u)
                                      {
                                          return closeBy(c.start, u.start) && closeBy(c.end, u.end);
                                      });
        if (!dupe)
        {
            unique.push_back(c);
        }
    }

    // Cap per tile, logging what was dropped rather than truncating silently.
    if (static_cast<int>(unique.size()) > OFFMESH_MAX_PER_TILE)
    {
        ShowWarningFmt("NavMeshBuilder: tile ({}, {}) generated {} off-mesh links, capping at {}",
                       tileX,
                       tileY,
                       unique.size(),
                       OFFMESH_MAX_PER_TILE);
        unique.resize(OFFMESH_MAX_PER_TILE);
    }

    out.count = static_cast<int>(unique.size());
    out.verts.reserve(static_cast<std::size_t>(out.count) * 6);
    for (const auto& c : unique)
    {
        out.verts.insert(out.verts.end(), { c.start[0], c.start[1], c.start[2], c.end[0], c.end[1], c.end[2] });
    }

    // All links are walkable and two-way (mirroring retail mob pathing).
    out.rad.assign(out.count, linkRadius);
    out.flags.assign(out.count, SAMPLE_POLYFLAGS_WALK);
    out.areas.assign(out.count, RC_WALKABLE_AREA);
    out.dir.assign(out.count, DT_OFFMESH_CON_BIDIR);

    return out;
}

} // namespace

NavMeshBuilder::NavMeshBuilder(const XiMesh& xiMesh)
: xiMesh_(&xiMesh)
, gridWidth_(xiMesh.gridWidth())
, gridHeight_(xiMesh.gridHeight())
{
    const auto& blocks     = xiMesh.blocks();
    const auto& placements = xiMesh.placements();
    const auto& entries    = xiMesh.entries();
    const auto& cells      = xiMesh.cells();
    const auto  cellCount  = static_cast<uint32>(gridWidth_) * gridHeight_;

    for (uint32 cellIndex = 0; cellIndex < cellCount; ++cellIndex)
    {
        const auto& cell = cells[cellIndex];
        for (uint16 ref = 0; ref < cell.count; ++ref)
        {
            const auto& [blockIdx, placementIdx] = entries[cell.offset + ref];
            const auto& block                    = blocks[blockIdx];
            const auto& place                    = placements[placementIdx];

            const auto key = (static_cast<uint32>(blockIdx) << 16) | placementIdx;
            if (preTransformed_.contains(key))
            {
                continue;
            }

            const auto& rot = place.rotation;
            const auto  det = rot[0] * (rot[4] * rot[8] - rot[5] * rot[7]) -
                              rot[3] * (rot[1] * rot[8] - rot[2] * rot[7]) +
                              rot[6] * (rot[1] * rot[5] - rot[2] * rot[4]);

            auto ptb = PreTransformedBlock{
                .worldVerts  = std::vector<float>(block.vertices.size()),
                .flipWinding = det > 0.0f,
            };

            for (std::size_t v = 0; v < block.vertices.size(); v += 3)
            {
                const auto world = transform(place.rotation, place.translation, &block.vertices[v]);

                ptb.worldVerts[v]     = world[0];
                ptb.worldVerts[v + 1] = world[1];
                ptb.worldVerts[v + 2] = world[2];

                for (int axis = 0; axis < 3; ++axis)
                {
                    worldBmin_[axis] = std::min(worldBmin_[axis], world[axis]);
                    worldBmax_[axis] = std::max(worldBmax_[axis], world[axis]);
                }
            }

            preTransformed_.emplace(key, std::move(ptb));
        }
    }
}

auto NavMeshBuilder::worldToCell(const float x, const float z) const -> CellCoord
{
    return {
        .cx = static_cast<int>(std::floor(x / XIMESH_CELL_SIZE)) + gridWidth_ / 2,
        .cz = static_cast<int>(std::floor(z / XIMESH_CELL_SIZE)) + gridHeight_ / 2,
    };
}

void NavMeshBuilder::getWorldBounds(float* bmin, float* bmax) const
{
    bmin[0] = worldBmin_[0];
    bmin[1] = worldBmin_[1];
    bmin[2] = worldBmin_[2];
    bmax[0] = worldBmax_[0];
    bmax[1] = worldBmax_[1];
    bmax[2] = worldBmax_[2];
}

// A triangle sits on a skip plane when all three vertices are within tolerance of it.
// Requiring all three leaves sloped geometry that merely crosses the plane alone.
auto NavMeshBuilder::onYSkipPlane(const float y0, const float y1, const float y2, const std::vector<float>& ySkipPlanes) -> bool
{
    return std::any_of(
        ySkipPlanes.begin(),
        ySkipPlanes.end(),
        [&](const float plane)
        {
            return std::abs(y0 - plane) <= Y_SKIP_PLANE_TOLERANCE &&
                   std::abs(y1 - plane) <= Y_SKIP_PLANE_TOLERANCE &&
                   std::abs(y2 - plane) <= Y_SKIP_PLANE_TOLERANCE;
        });
}

// A triangle is carved out when all three vertices fall inside a skip sphere.
// Requiring all three leaves geometry that merely clips the sphere alone.
auto NavMeshBuilder::insideSkipSphere(const float* v0, const float* v1, const float* v2, const std::vector<NavMeshSkipSphere>& skipSpheres) -> bool
{
    const auto contains = [](const NavMeshSkipSphere& sphere, const float* vertex)
    {
        const auto dx = vertex[0] - sphere.center[0];
        const auto dy = vertex[1] - sphere.center[1];
        const auto dz = vertex[2] - sphere.center[2];

        const auto dx2 = dx * dx;
        const auto dy2 = dy * dy;
        const auto dz2 = dz * dz;

        return (dx2 + dy2 + dz2) <= (sphere.radius * sphere.radius);
    };

    return std::any_of(
        skipSpheres.begin(),
        skipSpheres.end(),
        [&](const NavMeshSkipSphere& sphere)
        {
            return contains(sphere, v0) && contains(sphere, v1) && contains(sphere, v2);
        });
}

void NavMeshBuilder::getFilteredWorldBounds(const NavMeshConfig& config, float* bmin, float* bmax) const
{
    if (config.ySkipPlanes.empty() && config.skipSpheres.empty())
    {
        getWorldBounds(bmin, bmax);
        return;
    }

    for (int axis = 0; axis < 3; ++axis)
    {
        bmin[axis] = FloatMax;
        bmax[axis] = FloatLowest;
    }

    const auto& blocks = xiMesh_->blocks();

    for (const auto& [key, ptb] : preTransformed_)
    {
        const auto& block = blocks[key >> 16];

        for (std::size_t tri = 0; tri < block.metas.size(); ++tri)
        {
            const auto* v0 = &ptb.worldVerts[static_cast<std::size_t>(block.indices[tri * 3 + 0]) * 3];
            const auto* v1 = &ptb.worldVerts[static_cast<std::size_t>(block.indices[tri * 3 + 1]) * 3];
            const auto* v2 = &ptb.worldVerts[static_cast<std::size_t>(block.indices[tri * 3 + 2]) * 3];

            if (onYSkipPlane(v0[1], v1[1], v2[1], config.ySkipPlanes) ||
                insideSkipSphere(v0, v1, v2, config.skipSpheres))
            {
                continue;
            }

            for (int axis = 0; axis < 3; ++axis)
            {
                bmin[axis] = std::min({ bmin[axis], v0[axis], v1[axis], v2[axis] });
                bmax[axis] = std::max({ bmax[axis], v0[axis], v1[axis], v2[axis] });
            }
        }
    }
}

void NavMeshBuilder::gatherTrianglesInAABB(const float* bmin, const float* bmax, GatheredMesh& out, const std::vector<float>& ySkipPlanes, const std::vector<NavMeshSkipSphere>& skipSpheres) const
{
    out.verts.clear();
    out.indices.clear();
    out.areas.clear();

    const auto& blocks  = xiMesh_->blocks();
    const auto& entries = xiMesh_->entries();
    const auto& cells   = xiMesh_->cells();

    const auto [cxMin, czMin] = worldToCell(bmin[0], bmin[2]);
    const auto [cxMax, czMax] = worldToCell(bmax[0], bmax[2]);

    const auto xStart = std::max(0, cxMin);
    const auto xEnd   = std::min(static_cast<int>(gridWidth_) - 1, cxMax);
    const auto zStart = std::max(0, czMin);
    const auto zEnd   = std::min(static_cast<int>(gridHeight_) - 1, czMax);

    std::unordered_set<uint32> visited;

    for (int cz = zStart; cz <= zEnd; ++cz)
    {
        for (int cx = xStart; cx <= xEnd; ++cx)
        {
            const auto& cell = cells[static_cast<uint32>(cz) * gridWidth_ + cx];
            for (uint16 ref = 0; ref < cell.count; ++ref)
            {
                const auto& entry = entries[cell.offset + ref];
                const auto  key   = (static_cast<uint32>(entry.blockIdx) << 16) | entry.placementIdx;

                if (!visited.emplace(key).second)
                {
                    continue;
                }

                const auto it = preTransformed_.find(key);
                if (it == preTransformed_.end())
                {
                    continue;
                }

                const auto& ptb   = it->second;
                const auto& block = blocks[entry.blockIdx];

                const auto vertexBase = static_cast<int>(out.verts.size() / 3);

                out.verts.insert(out.verts.end(), ptb.worldVerts.begin(), ptb.worldVerts.end());

                for (std::size_t tri = 0; tri < block.metas.size(); ++tri)
                {
                    if (!ySkipPlanes.empty() || !skipSpheres.empty())
                    {
                        const auto* v0 = &ptb.worldVerts[static_cast<std::size_t>(block.indices[tri * 3 + 0]) * 3];
                        const auto* v1 = &ptb.worldVerts[static_cast<std::size_t>(block.indices[tri * 3 + 1]) * 3];
                        const auto* v2 = &ptb.worldVerts[static_cast<std::size_t>(block.indices[tri * 3 + 2]) * 3];

                        if (onYSkipPlane(v0[1], v1[1], v2[1], ySkipPlanes) ||
                            insideSkipSphere(v0, v1, v2, skipSpheres))
                        {
                            continue;
                        }
                    }

                    const auto i0 = vertexBase + block.indices[tri * 3 + 0];
                    const auto i1 = vertexBase + block.indices[tri * 3 + 1];
                    const auto i2 = vertexBase + block.indices[tri * 3 + 2];

                    if (ptb.flipWinding)
                    {
                        out.indices.push_back(i2);
                        out.indices.push_back(i1);
                        out.indices.push_back(i0);
                    }
                    else
                    {
                        out.indices.push_back(i0);
                        out.indices.push_back(i1);
                        out.indices.push_back(i2);
                    }

                    out.areas.push_back(block.metas[tri].barrier ? RC_NULL_AREA : RC_WALKABLE_AREA);
                }
            }
        }
    }
}

// Full Recast tile pipeline: RecastDemo/Source/Sample_TileMesh.cpp:794-830.
auto NavMeshBuilder::buildTile(const int tx, const int ty, const rcConfig& cfg, const NavMeshConfig& config, const float tileWorldSize) const -> TileResult
{
    //
    // Tile AABB in Detour space
    //

    const float tileBmin[3] = { cfg.bmin[0] + tx * tileWorldSize, cfg.bmin[1], cfg.bmin[2] + ty * tileWorldSize };
    const float tileBmax[3] = { cfg.bmin[0] + (tx + 1) * tileWorldSize, cfg.bmax[1], cfg.bmin[2] + (ty + 1) * tileWorldSize };

    //
    // Expand for border overlap so adjacent tiles connect
    //

    const float expandedBmin[3] = { tileBmin[0] - cfg.borderSize * cfg.cs, tileBmin[1], tileBmin[2] - cfg.borderSize * cfg.cs };
    const float expandedBmax[3] = { tileBmax[0] + cfg.borderSize * cfg.cs, tileBmax[1], tileBmax[2] + cfg.borderSize * cfg.cs };

    //
    // Gather geometry (reverse Y/Z negation back to world space for the gather)
    //

    const float gatherBmin[3] = { expandedBmin[0], -expandedBmax[1], -expandedBmax[2] };
    const float gatherBmax[3] = { expandedBmax[0], -expandedBmin[1], -expandedBmin[2] };

    GatheredMesh tileMesh;
    gatherTrianglesInAABB(gatherBmin, gatherBmax, tileMesh, config.ySkipPlanes, config.skipSpheres);
    if (tileMesh.verts.empty())
    {
        return {};
    }

    //
    // Transform gathered verts to Detour coordinate space (negate Y and Z)
    //

    for (std::size_t i = 0; i < tileMesh.verts.size(); i += 3)
    {
        tileMesh.verts[i + 1] = -tileMesh.verts[i + 1];
        tileMesh.verts[i + 2] = -tileMesh.verts[i + 2];
    }

    const auto numVerts = static_cast<int>(tileMesh.verts.size() / 3);
    const auto numTris  = static_cast<int>(tileMesh.indices.size() / 3);

    //
    // Per-tile rcConfig with expanded bounds
    //

    rcConfig tileCfg = cfg;
    tileCfg.width    = tileCfg.tileSize + tileCfg.borderSize * 2;
    tileCfg.height   = tileCfg.tileSize + tileCfg.borderSize * 2;
    rcVcopy(tileCfg.bmin, expandedBmin);
    rcVcopy(tileCfg.bmax, expandedBmax);

    //
    // Heightfield
    //

    rcContext ctx(false);

    rcHeightfield* solid = rcAllocHeightfield();
    if (!solid || !rcCreateHeightfield(&ctx, *solid, tileCfg.width, tileCfg.height, tileCfg.bmin, tileCfg.bmax, tileCfg.cs, tileCfg.ch))
    {
        rcFreeHeightField(solid);
        return {};
    }

    //
    // Walkable triangles + rasterize
    //

    std::vector<unsigned char> triAreas(numTris, 0);
    rcMarkWalkableTriangles(&ctx, tileCfg.walkableSlopeAngle, tileMesh.verts.data(), numVerts, tileMesh.indices.data(), numTris, triAreas.data());

    for (int i = 0; i < numTris; ++i)
    {
        if (tileMesh.areas[i] == RC_NULL_AREA)
        {
            triAreas[i] = RC_NULL_AREA;
        }
    }

    if (!rcRasterizeTriangles(&ctx, tileMesh.verts.data(), numVerts, tileMesh.indices.data(), triAreas.data(), numTris, *solid, tileCfg.walkableClimb))
    {
        rcFreeHeightField(solid);
        return {};
    }

    //
    // Filters
    //

    if (config.filterLowHangingObstacles)
    {
        rcFilterLowHangingWalkableObstacles(&ctx, tileCfg.walkableClimb, *solid);
    }

    if (config.filterLedgeSpans)
    {
        rcFilterLedgeSpans(&ctx, tileCfg.walkableHeight, tileCfg.walkableClimb, *solid);
    }

    if (config.filterWalkableLowHeightSpans)
    {
        rcFilterWalkableLowHeightSpans(&ctx, tileCfg.walkableHeight, *solid);
    }

    //
    // Compact heightfield + erosion
    //

    rcCompactHeightfield* chf = rcAllocCompactHeightfield();
    if (!chf || !rcBuildCompactHeightfield(&ctx, tileCfg.walkableHeight, tileCfg.walkableClimb, *solid, *chf))
    {
        rcFreeHeightField(solid);
        rcFreeCompactHeightfield(chf);
        return {};
    }
    rcFreeHeightField(solid);

    if (!rcErodeWalkableArea(&ctx, tileCfg.walkableRadius, *chf))
    {
        rcFreeCompactHeightfield(chf);
        return {};
    }

    //
    // Regions
    //

    if (!rcBuildDistanceField(&ctx, *chf) ||
        !rcBuildRegions(&ctx, *chf, tileCfg.borderSize, tileCfg.minRegionArea, tileCfg.mergeRegionArea))
    {
        rcFreeCompactHeightfield(chf);
        return {};
    }

    //
    // Contours
    //

    rcContourSet* cset = rcAllocContourSet();
    if (!cset || !rcBuildContours(&ctx, *chf, tileCfg.maxSimplificationError, tileCfg.maxEdgeLen, *cset))
    {
        rcFreeCompactHeightfield(chf);
        rcFreeContourSet(cset);
        return {};
    }

    if (cset->nconts == 0)
    {
        rcFreeCompactHeightfield(chf);
        rcFreeContourSet(cset);
        return {};
    }

    //
    // Poly mesh
    //

    rcPolyMesh* pmesh = rcAllocPolyMesh();
    if (!pmesh || !rcBuildPolyMesh(&ctx, *cset, tileCfg.maxVertsPerPoly, *pmesh))
    {
        rcFreeCompactHeightfield(chf);
        rcFreeContourSet(cset);
        rcFreePolyMesh(pmesh);
        return {};
    }

    //
    // Detail mesh
    //

    rcPolyMeshDetail* dmesh = rcAllocPolyMeshDetail();
    if (!dmesh || !rcBuildPolyMeshDetail(&ctx, *pmesh, *chf, tileCfg.detailSampleDist, tileCfg.detailSampleMaxError, *dmesh))
    {
        rcFreeCompactHeightfield(chf);
        rcFreeContourSet(cset);
        rcFreePolyMesh(pmesh);
        rcFreePolyMeshDetail(dmesh);
        return {};
    }

    rcFreeCompactHeightfield(chf);
    rcFreeContourSet(cset);

    //
    // Poly flags
    //

    for (int i = 0; i < pmesh->npolys; ++i)
    {
        if (pmesh->areas[i] == RC_WALKABLE_AREA)
        {
            pmesh->flags[i] = SAMPLE_POLYFLAGS_WALK;
        }
    }

    //
    // Auto-generated off-mesh connections (drop / step links across ledges)
    //

    TileOffMeshConnections offMesh;
    if (config.generateOffMeshLinks)
    {
        // barrier triangles (detour space) so off-mesh links can't route through walls/rails
        std::vector<std::array<float, 9>> barriers;
        for (int i = 0; i < numTris; ++i)
        {
            if (tileMesh.areas[i] != RC_NULL_AREA)
            {
                continue;
            }

            const int i0 = tileMesh.indices[i * 3 + 0];
            const int i1 = tileMesh.indices[i * 3 + 1];
            const int i2 = tileMesh.indices[i * 3 + 2];
            barriers.push_back({ tileMesh.verts[i0 * 3 + 0], tileMesh.verts[i0 * 3 + 1], tileMesh.verts[i0 * 3 + 2], tileMesh.verts[i1 * 3 + 0], tileMesh.verts[i1 * 3 + 1], tileMesh.verts[i1 * 3 + 2], tileMesh.verts[i2 * 3 + 0], tileMesh.verts[i2 * 3 + 1], tileMesh.verts[i2 * 3 + 2] });
        }

        offMesh = buildOffMeshConnections(*pmesh, *dmesh, config, tx, ty, barriers);
    }

    //
    // Build Detour tile data
    //

    auto params = dtNavMeshCreateParams{
        .verts            = pmesh->verts,
        .vertCount        = pmesh->nverts,
        .polys            = pmesh->polys,
        .polyFlags        = pmesh->flags,
        .polyAreas        = pmesh->areas,
        .polyCount        = pmesh->npolys,
        .nvp              = pmesh->nvp,
        .detailMeshes     = dmesh->meshes,
        .detailVerts      = dmesh->verts,
        .detailVertsCount = dmesh->nverts,
        .detailTris       = dmesh->tris,
        .detailTriCount   = dmesh->ntris,
        .offMeshConVerts  = offMesh.verts.data(),
        .offMeshConRad    = offMesh.rad.data(),
        .offMeshConFlags  = offMesh.flags.data(),
        .offMeshConAreas  = offMesh.areas.data(),
        .offMeshConDir    = offMesh.dir.data(),
        .offMeshConUserID = nullptr, // unused; Detour defaults ids when null
        .offMeshConCount  = offMesh.count,
        .userId           = 0,
        .tileX            = tx,
        .tileY            = ty,
        .tileLayer        = 0,
        .bmin             = {}, // set via rcVcopy below
        .bmax             = {}, // set via rcVcopy below
        .walkableHeight   = config.agentHeight,
        .walkableRadius   = config.agentRadius,
        .walkableClimb    = config.agentMaxClimb,
        .cs               = tileCfg.cs,
        .ch               = tileCfg.ch,
        .buildBvTree      = true,
    };
    rcVcopy(params.bmin, pmesh->bmin);
    rcVcopy(params.bmax, pmesh->bmax);

    unsigned char* navData     = nullptr;
    int            navDataSize = 0;
    if (!dtCreateNavMeshData(&params, &navData, &navDataSize))
    {
        rcFreePolyMesh(pmesh);
        rcFreePolyMeshDetail(dmesh);
        return {};
    }

    rcFreePolyMesh(pmesh);
    rcFreePolyMeshDetail(dmesh);

    return {
        .tx           = tx,
        .ty           = ty,
        .data         = navData,
        .dataSize     = navDataSize,
        .offMeshCount = offMesh.count,
    };
}

auto NavMeshBuilder::buildAsync(Scheduler& scheduler, const std::string& zoneName, const uint16 zoneID, const NavMeshConfig& config) -> Task<dtNavMesh*>
{
    //
    // World bounds to Detour coordinate space (negate Y and Z, swap min/max)
    //

    float worldBmin[3];
    float worldBmax[3];
    getFilteredWorldBounds(config, worldBmin, worldBmax);

    // No geometry was gathered (empty or null ximesh) - nothing to build.
    if (worldBmin[0] > worldBmax[0])
    {
        co_return nullptr;
    }

    const float detourBmin[3] = { worldBmin[0], -worldBmax[1], -worldBmax[2] };
    const float detourBmax[3] = { worldBmax[0], -worldBmin[1], -worldBmin[2] };

    const auto startTime = timer::now();

    //
    // rcConfig
    // Standard Recast boilerplate. See: RecastDemo/Source/Sample_TileMesh.cpp
    //

    const auto cs             = config.cellSize;
    const auto ch             = config.cellHeight;
    const auto walkableHeight = static_cast<int>(std::ceil(config.agentHeight / ch));
    const auto walkableClimb  = static_cast<int>(std::floor(config.agentMaxClimb / ch));
    const auto walkableRadius = static_cast<int>(std::ceil(config.agentRadius / cs));

    const auto cfg = rcConfig{
        .width                  = 0,
        .height                 = 0,
        .tileSize               = config.tileSize,
        .borderSize             = walkableRadius + TILE_BORDER_PADDING,
        .cs                     = cs,
        .ch                     = ch,
        .bmin                   = { detourBmin[0], detourBmin[1], detourBmin[2] },
        .bmax                   = { detourBmax[0], detourBmax[1], detourBmax[2] },
        .walkableSlopeAngle     = config.walkableSlopeAngle,
        .walkableHeight         = walkableHeight,
        .walkableClimb          = walkableClimb,
        .walkableRadius         = walkableRadius,
        .maxEdgeLen             = config.maxEdgeLen > 0.0f ? static_cast<int>(config.maxEdgeLen / cs) : 0,
        .maxSimplificationError = config.maxSimplificationError,
        .minRegionArea          = config.minRegionArea,
        .mergeRegionArea        = config.mergeRegionArea,
        .maxVertsPerPoly        = config.maxVertsPerPoly,
        .detailSampleDist       = config.detailSampleDist < MIN_DETAIL_SAMPLE_DIST ? 0.0f : cs * config.detailSampleDist,
        .detailSampleMaxError   = ch * config.detailSampleMaxError,
    };

    //
    // Tile grid
    //

    int gridW = 0;
    int gridH = 0;
    rcCalcGridSize(cfg.bmin, cfg.bmax, cfg.cs, &gridW, &gridH);

    const auto tileWorldSize = cfg.tileSize * cfg.cs;
    const auto tw            = (gridW + cfg.tileSize - 1) / cfg.tileSize;
    const auto th            = (gridH + cfg.tileSize - 1) / cfg.tileSize;

    //
    // Tile coordinates
    //

    std::vector<TileCoord> tileCoords;
    tileCoords.reserve(static_cast<std::size_t>(tw) * th);
    for (int ty = 0; ty < th; ++ty)
    {
        for (int tx = 0; tx < tw; ++tx)
        {
            tileCoords.push_back({ .tx = tx, .ty = ty });
        }
    }

    //
    // Init dtNavMesh
    //

    auto tileBits = 0;
    for (auto v = tw * th; v > 0; v >>= 1)
    {
        tileBits++;
    }
    tileBits = std::min(tileBits, DT_MAX_TILE_BITS);

    const auto polyBits = DT_TOTAL_REF_BITS - tileBits;

    auto navParams = dtNavMeshParams{
        .orig       = {},
        .tileWidth  = tileWorldSize,
        .tileHeight = tileWorldSize,
        .maxTiles   = 1 << tileBits,
        .maxPolys   = 1 << polyBits,
    };
    rcVcopy(navParams.orig, cfg.bmin);

    auto* navMesh = dtAllocNavMesh();
    if (!navMesh)
    {
        ShowErrorFmt("NavMeshBuilder::build: Could not allocate dtNavMesh ({})", zoneID);
        co_return nullptr;
    }

    auto status = navMesh->init(&navParams);
    if (dtStatusFailed(status))
    {
        ShowErrorFmt("NavMeshBuilder::build: Could not init dtNavMesh ({})", zoneID);
        dtFreeNavMesh(navMesh);
        co_return nullptr;
    }

    //
    // Parallel tile builds in batches
    //

    std::vector<TileResult> results(tileCoords.size());
    for (std::size_t batch = 0; batch < tileCoords.size(); batch += TILE_BATCH_SIZE)
    {
        const auto batchEnd = std::min(batch + TILE_BATCH_SIZE, tileCoords.size());

        co_await Scheduler::TaskGroup(
            batchEnd - batch,
            [&, batch, batchEnd](auto& add)
            {
                for (std::size_t i = batch; i < batchEnd; ++i)
                {
                    const auto& tile = tileCoords[i];
                    add(scheduler.spawnOnWorkerThread(
                        [this, i, tile, &cfg, &config, tileWorldSize, &results]()
                        {
                            results[i] = buildTile(tile.tx, tile.ty, cfg, config, tileWorldSize);
                        }));
                }
            });
    }

    //
    // Add tiles to navmesh (addTile is not thread-safe)
    //

    auto tilesBuilt  = 0;
    auto offMeshCons = 0;
    for (const auto& result : results)
    {
        if (result.data)
        {
            status = navMesh->addTile(result.data, result.dataSize, DT_TILE_FREE_DATA, 0, nullptr);
            if (dtStatusFailed(status))
            {
                dtFree(result.data);
                continue;
            }
            tilesBuilt++;
            offMeshCons += result.offMeshCount;
        }
    }

    if (tilesBuilt == 0)
    {
        ShowErrorFmt("NavMeshBuilder::build: No tiles built ({})", zoneID);
        dtFreeNavMesh(navMesh);
        co_return nullptr;
    }

    const auto endTime    = timer::now();
    const auto durationMs = timer::count_milliseconds(endTime - startTime);

    ShowInfoFmt("Built {} nav tiles ({} off-mesh links) in {}x{} grid for {} ({}) in {}ms", tilesBuilt, offMeshCons, tw, th, zoneName, zoneID, durationMs);
    co_return navMesh;
}
