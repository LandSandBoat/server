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

#pragma once

#include "navmesh_config.h"

#include "common/cbasetypes.h"
#include "common/scheduler.h"

#include <common/types/hash_map.h>

#include <limits>
#include <string>
#include <vector>

struct rcConfig;

class IXiMesh;
class dtNavMesh;

constexpr auto FloatMax    = std::numeric_limits<float>::max();
constexpr auto FloatLowest = std::numeric_limits<float>::lowest();

struct GatheredMesh
{
    std::vector<float>         verts;
    std::vector<int>           indices;
    std::vector<unsigned char> areas;
};

struct TileCoord
{
    int tx{};
    int ty{};
};

struct CellCoord
{
    int cx{};
    int cz{};
};

struct TileResult
{
    int            tx{};
    int            ty{};
    unsigned char* data{};
    int            dataSize{};
    int            offMeshCount{};
};

// Off-mesh links for one tile, in the SoA layout dtNavMeshCreateParams wants.
struct TileOffMeshConnections
{
    std::vector<float>          verts; // 6 floats per link: start xyz, end xyz (Detour space)
    std::vector<float>          rad;
    std::vector<unsigned short> flags;
    std::vector<unsigned char>  areas;
    std::vector<unsigned char>  dir;
    int                         count{};
};

struct OffMeshCandidate
{
    float start[3];
    float end[3];
};

class NavMeshBuilder
{
public:
    explicit NavMeshBuilder(const IXiMesh& xiMesh);

    void getWorldBounds(float* bmin, float* bmax) const;

    void getFilteredWorldBounds(const NavMeshConfig& config, float* bmin, float* bmax) const;

    void gatherTrianglesInAABB(const float* bmin, const float* bmax, GatheredMesh& out, const std::vector<float>& ySkipPlanes = {}, const std::vector<NavMeshSkipSphere>& skipSpheres = {}) const;

    auto buildAsync(Scheduler& scheduler, const std::string& zoneName, uint16 zoneID, const NavMeshConfig& config) -> Task<dtNavMesh*>;

private:
    auto buildTile(int tx, int ty, const rcConfig& cfg, const NavMeshConfig& config, float tileWorldSize) const -> TileResult;
    auto worldToCell(float x, float z) const -> CellCoord;

    static auto onYSkipPlane(float y0, float y1, float y2, const std::vector<float>& ySkipPlanes) -> bool;
    static auto insideSkipSphere(const float* v0, const float* v1, const float* v2, const std::vector<NavMeshSkipSphere>& skipSpheres) -> bool;

    struct PreTransformedBlock
    {
        std::vector<float> worldVerts;
        bool               flipWinding{};
    };

    const IXiMesh* xiMesh_{};
    uint16         gridWidth_{};
    uint16         gridHeight_{};
    float          worldBmin_[3]{ FloatMax, FloatMax, FloatMax };
    float          worldBmax_[3]{ FloatLowest, FloatLowest, FloatLowest };

    HashMap<uint32, PreTransformedBlock> preTransformed_;
};
