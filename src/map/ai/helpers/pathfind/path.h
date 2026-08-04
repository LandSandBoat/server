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

// A waypoint sequence plus a cursor, with pure geometry over them and no entity or navmesh state.
class Path
{
public:
    auto clear() -> void;
    auto empty() const -> bool;

    // Partial means the poly buffer ran out and the next leg must be requested; complete means it reaches the destination.
    auto partial() const -> bool;
    auto setPartial(bool partial) -> void;

    // Replace waypoints and reset the cursor to the first point.
    auto assign(std::vector<pathpoint_t> points, bool partial = false) -> void;

    // Underlying waypoints, e.g. to snapshot a patrol route.
    auto points() const -> const std::vector<pathpoint_t>&;

    // Append one waypoint, e.g. an end-gap top-up.
    auto append(const pathpoint_t& point) -> void;

    // Cursor

    auto cursor() const -> int16;
    auto advance() -> void;
    auto restart() -> void;                 // reset cursor to first point (e.g. looping a patrol)
    auto consumed() const -> bool;          // cursor past the last point (whole path walked)
    auto atLastIndex() const -> bool;       // cursor exactly on the final point
    auto atOrPastLastIndex() const -> bool; // cursor on or past the final point
    auto current() const -> const pathpoint_t&;
    auto destination() const -> const position_t&; // final waypoint's position

    // Geometry

    // Drop trailing waypoints within `within` of the destination, always keeping at least one.
    auto pruneTailWithin(float within) -> void;

    // True when the remaining path is no longer than `ratio` x the straight-line distance to the final point.
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
