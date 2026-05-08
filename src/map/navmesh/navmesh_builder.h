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

#include "common/cbasetypes.h"
#include "common/scheduler.h"
#include "navmesh_config.h"

#include <limits>
#include <string>
#include <unordered_map>
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
};

class NavMeshBuilder
{
public:
    explicit NavMeshBuilder(const IXiMesh& xiMesh);

    void getWorldBounds(float* bmin, float* bmax) const;
    void gatherTrianglesInAABB(const float* bmin, const float* bmax, GatheredMesh& out) const;
    auto buildAsync(Scheduler& scheduler, const std::string& zoneName, uint16 zoneID, const NavMeshConfig& config) -> Task<dtNavMesh*>;

private:
    auto buildTile(int tx, int ty, const rcConfig& cfg, const NavMeshConfig& config, float tileWorldSize) const -> TileResult;
    auto worldToCell(float x, float z) const -> CellCoord;

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

    std::unordered_map<uint32, PreTransformedBlock> preTransformed_;
};
