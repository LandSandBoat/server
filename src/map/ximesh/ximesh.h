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
#include "map/ximesh/ximesh_structs.h"

#include <common/types/maybe.h>
#include <vector>

using IgnoreTransparentBarriers = xi::Flag<struct IgnoreTransparentBarriersTag>;

class XiMesh
{
public:
    virtual ~XiMesh() = default;

    virtual auto query(float x, float y, float z) const -> Maybe<CellHit>                                                                                                                     = 0;
    virtual auto getTerrainAt(float x, float y, float z) const -> TerrainType                                                                                                                 = 0;
    virtual auto getFloorId(float x, float y, float z) const -> uint8                                                                                                                         = 0;
    virtual auto rayIntersect(const Vector3& start, const Vector3& end, IgnoreTransparentBarriers ignoreTransparentBarriers = IgnoreTransparentBarriers::Yes) const -> bool                   = 0;
    virtual auto getPositionInfo(const Vector3& position, YOffsets yOffsets, IgnoreTransparentBarriers ignoreTransparentBarriers = IgnoreTransparentBarriers::Yes) const -> Maybe<RayHitInfo> = 0;

    virtual auto blocks() const -> const std::vector<MeshBlock>&         = 0;
    virtual auto placements() const -> const std::vector<MeshPlacement>& = 0;
    virtual auto entries() const -> const std::vector<CellEntry>&        = 0;
    virtual auto cells() const -> const std::vector<CellSpan>&           = 0;
    virtual auto gridWidth() const -> uint16                             = 0;
    virtual auto gridHeight() const -> uint16                            = 0;
};
