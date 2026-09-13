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

#include <common/cbasetypes.h>
#include <common/mmo.h>

#include <map/navmesh/navmesh.h>

#include <common/types/maybe.h>

class RoamRegion;

namespace pathfind
{

// Picks the legs of a wanderer: a mob that walks on from where it stands, roughly the way it faces, along its region's lanes.
class WanderPathBuilder
{
public:
    explicit WanderPathBuilder(NavMesh& navMesh);

    // A spot within `radius` of `from`, roughly ahead, reached by a walk that stays inside the region.
    auto findLeg(const position_t& from, float radius, const RoamRegion& region) const -> Maybe<position_t>;

private:
    NavMesh& navMesh_;
};

} // namespace pathfind
