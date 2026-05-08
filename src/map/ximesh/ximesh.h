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

#include "map/ximesh/iximesh.h"
#include "map/ximesh/transformation_matrix.h"

#include <string>

class XiMesh final : public IXiMesh
{
public:
    explicit XiMesh(const std::string& filename);
    ~XiMesh() override = default;

    DISALLOW_COPY_AND_MOVE(XiMesh);

    auto query(float x, float y, float z) const -> std::optional<CellHit> override;
    auto getTerrainAt(float x, float y, float z) const -> TerrainType override;
    auto getFloorId(float x, float y, float z) const -> uint8 override;

    auto rayIntersect(const Vector3& start, const Vector3& end, IgnoreTransparentBarriers ignoreTransparentBarriers = IgnoreTransparentBarriers::Yes) const -> bool override;
    auto getPositionInfo(const Vector3& position, YOffsets yOffsets, IgnoreTransparentBarriers ignoreTransparentBarriers = IgnoreTransparentBarriers::Yes) const -> std::optional<RayHitInfo> override;

    auto blocks() const -> const std::vector<MeshBlock>& override;
    auto placements() const -> const std::vector<MeshPlacement>& override;
    auto entries() const -> const std::vector<CellEntry>& override;
    auto cells() const -> const std::vector<CellSpan>& override;
    auto gridWidth() const -> uint16 override;
    auto gridHeight() const -> uint16 override;

private:
    auto load(const std::string& filename) -> bool;

    auto worldToCell(float x, float z) const -> std::pair<int, int>;

    auto rayIntersectCell(const Vector3& start, const Vector3& end, YRange yRange, uint32 cellIdx, IgnoreTransparentBarriers ignoreTransparentBarriers) const -> bool;
    auto rayIntersectCellHitInfo(const Vector3& start, const Vector3& end, YRange yRange, uint32 cellIdx, IgnoreTransparentBarriers ignoreTransparentBarriers, std::optional<RayHitInfo>& closestHit) const -> void;

    XimeshHeader header_{};

    std::vector<MeshBlock>     blocks_;
    std::vector<MeshPlacement> placements_;
    std::vector<CellEntry>     entries_;
    std::vector<CellSpan>      cells_;

    std::vector<TransformationMatrix> w2os_;
    std::vector<bool>                 placementFlips_;
    std::vector<YRange>               cellRanges_;
};
