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

// Builds paths from a navmesh; owns none of CPathFind's state. Holds a mesh reference, so construct
// on demand (the owner's zone navmesh can change).
class NavPathBuilder
{
public:
    explicit NavPathBuilder(NavMesh& navMesh);

    // Path from `start` to `end`. Direct query first, then falls back to the nearest on-mesh point
    // to the end (target off-mesh) and to the start (mob off-mesh), then closes any remaining end-gap
    // for complete paths. std::nullopt when no path can be built.
    auto findPath(const position_t& start, const position_t& end) const -> Maybe<PathResult>;

    // Pick a random number (1..maxTurns) of roam destinations within `maxRadius` of `start`.
    // std::nullopt on hard navmesh failure (caller bails rather than roam a partial set); otherwise
    // the chosen turn points (possibly fewer than requested).
    auto findRoamTurnPoints(const position_t& start, float maxRadius, uint8 maxTurns) const -> Maybe<std::vector<position_t>>;

private:
    NavMesh& navMesh_;
};

} // namespace pathfind
