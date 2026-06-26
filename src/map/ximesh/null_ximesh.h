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

#include "map/ximesh/ximesh.h"

// Null-object XiMesh for zones with no ximesh loaded: queries return empty/none.
class NullXiMesh final : public XiMesh
{
public:
    auto query(float x, float y, float z) const -> Maybe<CellHit> override;
    auto getTerrainAt(float x, float y, float z) const -> TerrainType override;
    auto getFloorId(float x, float y, float z) const -> uint8 override;
    auto rayIntersect(const Vector3& start, const Vector3& end, IgnoreTransparentBarriers ignoreTransparentBarriers = IgnoreTransparentBarriers::Yes) const -> bool override;
    auto getPositionInfo(const Vector3& position, YOffsets yOffsets, IgnoreTransparentBarriers ignoreTransparentBarriers = IgnoreTransparentBarriers::Yes) const -> Maybe<RayHitInfo> override;

    auto blocks() const -> const std::vector<MeshBlock>& override;
    auto placements() const -> const std::vector<MeshPlacement>& override;
    auto entries() const -> const std::vector<CellEntry>& override;
    auto cells() const -> const std::vector<CellSpan>& override;
    auto gridWidth() const -> uint16 override;
    auto gridHeight() const -> uint16 override;
};
