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

struct position_t;

namespace pathfind
{

// Advance `pos` one tick toward `target`.
//
// - stepDistance: max travel this tick (speed / 50.0 running, speed / 40.0 walking).
// - stopShort:    settle this many yalms short of `target` along the heading; 0 lands exactly on it.
//                 Per-call: callers pass the path's stop-short ONLY for the final waypoint and 0 for
//                 intermediate corners, so the entity rounds corners instead of cutting across them.
//
// Returns the distance advanced this tick (for LimitDistance bookkeeping). Also sets `pos.rotation`
// to face `target`, matching CPathFind::LookAt.
auto stepTowards(position_t& pos, const position_t& target, float stepDistance, float stopShort) -> float;

} // namespace pathfind
