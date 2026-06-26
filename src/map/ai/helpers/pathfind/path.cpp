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

#include <map/ai/helpers/pathfind/path.h>

#include <common/utils.h>

#include <limits>

namespace pathfind
{

auto Path::clear() -> void
{
    points_.clear();
    currentPoint_ = 0;
    isPartial_    = false;
}

auto Path::empty() const -> bool
{
    return points_.empty();
}

auto Path::partial() const -> bool
{
    return isPartial_;
}

auto Path::setPartial(bool partial) -> void
{
    isPartial_ = partial;
}

auto Path::assign(std::vector<pathpoint_t> points, bool partial) -> void
{
    points_       = std::move(points);
    currentPoint_ = 0;
    isPartial_    = partial;
}

auto Path::points() const -> const std::vector<pathpoint_t>&
{
    return points_;
}

auto Path::append(const pathpoint_t& point) -> void
{
    points_.emplace_back(point);
}

auto Path::size() const -> int16
{
    return static_cast<int16>(points_.size());
}

auto Path::cursor() const -> int16
{
    return currentPoint_;
}

auto Path::advance() -> void
{
    ++currentPoint_;
}

auto Path::restart() -> void
{
    currentPoint_ = 0;
}

auto Path::consumed() const -> bool
{
    return currentPoint_ >= size();
}

auto Path::atLastIndex() const -> bool
{
    return currentPoint_ == size() - 1;
}

auto Path::atOrPastLastIndex() const -> bool
{
    return currentPoint_ >= size() - 1;
}

auto Path::current() const -> const pathpoint_t&
{
    return points_[currentPoint_];
}

auto Path::destination() const -> const position_t&
{
    return points_.back().position;
}

auto Path::pruneTailWithin(float within) -> void
{
    if (points_.empty())
    {
        return;
    }

    // Drop waypoints within `within` of the destination so the entity stops short of the destination tile.
    const position_t& destinationPos = points_.back().position;
    while (points_.size() > 1)
    {
        const position_t& penultimate = points_[points_.size() - 2].position;
        if (distance(destinationPos, penultimate) > within)
        {
            break;
        }
        points_.erase(points_.end() - 2);
    }
}

auto Path::isWithinRatio(const position_t& from, float ratio) const -> bool
{
    if (points_.empty() || currentPoint_ < 0 || currentPoint_ >= size())
    {
        return false;
    }

    const float directDistance = distance(from, points_.back().position);
    if (directDistance < 0.01f)
    {
        return true;
    }

    float pathLength = distance(from, points_[currentPoint_].position);
    for (size_t i = static_cast<size_t>(currentPoint_) + 1; i < points_.size(); ++i)
    {
        pathLength += distance(points_[i - 1].position, points_[i].position);
    }

    return pathLength <= directDistance * ratio;
}

auto Path::setCursorToNearest(const position_t& from) -> void
{
    float closestSq = std::numeric_limits<float>::max();
    for (size_t i = 0; i < points_.size(); ++i)
    {
        const float distanceSq = distanceSquared(from, points_[i].position);
        if (distanceSq < closestSq)
        {
            currentPoint_ = static_cast<int16>(i);
            closestSq     = distanceSq;
        }
    }
}

} // namespace pathfind
