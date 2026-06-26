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
#include <vector>

namespace pathfind
{

// Builds paths from a navmesh; holds a mesh reference, so construct it on demand.
class NavPathBuilder
{
public:
    explicit NavPathBuilder(NavMesh& navMesh);

    // Path from `start` to `end`, falling back to the nearest on-mesh point at either end, or nullopt when no path exists.
    auto findPath(const position_t& start, const position_t& end) const -> Maybe<PathResult>;

    // Pick 1..maxTurns roam destinations within `maxRadius`, or nullopt on hard navmesh failure.
    auto findRoamTurnPoints(const position_t& start, float maxRadius, uint8 maxTurns) const -> Maybe<std::vector<position_t>>;

private:
    NavMesh& navMesh_;
};

} // namespace pathfind
