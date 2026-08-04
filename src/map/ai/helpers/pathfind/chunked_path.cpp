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

#include <map/ai/helpers/pathfind/chunked_path.h>

#include <algorithm>

namespace pathfind
{

auto ChunkedPath::clear() -> void
{
    active_       = false;
    target_       = {};
    range_        = 0.0f;
    lastDistance_ = 0.0f;
    stallCount_   = 0;
}

auto ChunkedPath::begin(const position_t& target, float range) -> void
{
    active_       = true;
    target_       = target;
    range_        = range;
    lastDistance_ = 0.0f;
    stallCount_   = 0;
}

auto ChunkedPath::setRange(float range) -> void
{
    range_ = range;
}

auto ChunkedPath::active() const -> bool
{
    return active_;
}

auto ChunkedPath::range() const -> float
{
    return range_;
}

auto ChunkedPath::target() const -> const position_t&
{
    return target_;
}

auto ChunkedPath::evaluate(float distanceToTarget) -> Step
{
    if (!active_)
    {
        return Step::Inactive;
    }

    // Effectively arrived; plain PathTo has no stop-short range, so a small slack covers landing near the end.
    const float arrivalDistance = std::max(0.5f, range_);
    if (distanceToTarget <= arrivalDistance)
    {
        return Step::Arrived;
    }

    // Bail after a few chunks that make no progress, since the navmesh is circling an obstacle we cannot clear.
    if (lastDistance_ > 0.0f && distanceToTarget >= lastDistance_ - 0.5f)
    {
        ++stallCount_;
        if (stallCount_ >= kMaxStalls)
        {
            return Step::Stalled;
        }
    }
    else
    {
        stallCount_ = 0;
    }
    lastDistance_ = distanceToTarget;

    return Step::Continue;
}

} // namespace pathfind
