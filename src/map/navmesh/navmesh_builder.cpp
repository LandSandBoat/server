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

#include <map/ximesh/iximesh.h>

#include <DetourNavMesh.h>
#include <DetourNavMeshBuilder.h>
#include <Recast.h>

#include <algorithm>
#include <array>
#include <cmath>
#include <unordered_set>

namespace
{

// Recast/Detour constants (not tunable)
constexpr uint16 SAMPLE_POLYFLAGS_WALK  = 0x0001; // RecastDemo/Include/Sample.h
constexpr int    TILE_BORDER_PADDING    = 3;      // Extra cells beyond walkableRadius for tile stitching (Sample_TileMesh.cpp)
constexpr float  MIN_DETAIL_SAMPLE_DIST = 0.9f;   // Recast clamps non-zero detailSampleDist to >= 0.9
constexpr int    DT_MAX_TILE_BITS       = 14;     // dtNavMesh max bits for tile indexing
constexpr int    DT_TOTAL_REF_BITS      = 22;     // dtNavMesh total bits for tile + poly refs

// FFXI dat format constant (not tunable)
constexpr float XIMESH_CELL_SIZE = 4.0f; // Each ximesh grid cell covers 4x4 world units

constexpr std::size_t TILE_BATCH_SIZE = 32;

auto transform(const std::array<float, 9>& rot, const std::array<float, 3>& trans, const float* vertex) -> std::array<float, 3>
{
    return {
        rot[0] * vertex[0] + rot[3] * vertex[1] + rot[6] * vertex[2] + trans[0],
        rot[1] * vertex[0] + rot[4] * vertex[1] + rot[7] * vertex[2] + trans[1],
        rot[2] * vertex[0] + rot[5] * vertex[1] + rot[8] * vertex[2] + trans[2],
    };
}

} // namespace

NavMeshBuilder::NavMeshBuilder(const IXiMesh& xiMesh)
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

void NavMeshBuilder::gatherTrianglesInAABB(const float* bmin, const float* bmax, GatheredMesh& out) const
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
    gatherTrianglesInAABB(gatherBmin, gatherBmax, tileMesh);
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
        .offMeshConVerts  = nullptr,
        .offMeshConRad    = nullptr,
        .offMeshConFlags  = nullptr,
        .offMeshConAreas  = nullptr,
        .offMeshConDir    = nullptr,
        .offMeshConUserID = nullptr,
        .offMeshConCount  = 0,
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
        .tx       = tx,
        .ty       = ty,
        .data     = navData,
        .dataSize = navDataSize,
    };
}

auto NavMeshBuilder::buildAsync(Scheduler& scheduler, const std::string& zoneName, const uint16 zoneID, const NavMeshConfig& config) -> Task<dtNavMesh*>
{
    //
    // World bounds to Detour coordinate space (negate Y and Z, swap min/max)
    //

    float worldBmin[3];
    float worldBmax[3];
    getWorldBounds(worldBmin, worldBmax);

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

    auto tilesBuilt = 0;
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

    ShowInfoFmt("Built {} nav tiles in {}x{} grid for {} ({}) in {}ms", tilesBuilt, tw, th, zoneName, zoneID, durationMs);
    co_return navMesh;
}
