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

#include <vector>

namespace pathfind
{

// A waypoint sequence plus a cursor for progress, with pure geometry over them (tail pruning,
// directness). Owns no entity/navmesh state; CPathFind steps its owner toward current() until
// the cursor is consumed().
class Path
{
public:
    auto clear() -> void;
    auto empty() const -> bool;

    // Partial: stopped short (navmesh poly buffer ran out); chunked sequence requests the next leg.
    // Complete: reaches its destination.
    auto partial() const -> bool;
    auto setPartial(bool partial) -> void;

    // Replace waypoints and reset the cursor to the first point.
    auto assign(std::vector<pathpoint_t> points, bool partial = false) -> void;

    // Underlying waypoints (e.g. to snapshot a patrol route).
    auto points() const -> const std::vector<pathpoint_t>&;

    // Append one waypoint (e.g. end-gap top-up after a complete build).
    auto append(const pathpoint_t& point) -> void;

    //
    // Cursor
    //

    auto cursor() const -> int16;
    auto advance() -> void;
    auto restart() -> void; // reset cursor to first point (e.g. looping a patrol)
    auto consumed() const -> bool;          // cursor past the last point (whole path walked)
    auto atLastIndex() const -> bool;        // cursor exactly on the final point
    auto atOrPastLastIndex() const -> bool;  // cursor on or past the final point
    auto current() const -> const pathpoint_t&;
    auto destination() const -> const position_t&; // final waypoint's position

    //
    // Geometry
    //

    // Drop trailing waypoints within `within` of the destination so a stop-short entity halts before
    // the exact destination tile. Keeps at least one point.
    auto pruneTailWithin(float within) -> void;

    // True when the remaining path (from `from`, through points at/after the cursor) is no longer
    // than `ratio` x the straight-line distance from `from` to the final point. False if empty or
    // the cursor is out of range.
    auto isWithinRatio(const position_t& from, float ratio) const -> bool;

    // Set cursor to the waypoint physically closest to `from` (patrol resume).
    auto setCursorToNearest(const position_t& from) -> void;

private:
    auto size() const -> int16;

    std::vector<pathpoint_t> points_;
    int16                    currentPoint_{ 0 };
    bool                     isPartial_{ false };
};

} // namespace pathfind
