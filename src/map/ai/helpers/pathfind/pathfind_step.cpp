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

#include <map/ai/helpers/pathfind/pathfind_step.h>

#include <common/mmo.h>
#include <common/utils.h>

#include <algorithm>
#include <cmath>

namespace pathfind
{

auto stepTowards(position_t& pos, const position_t& target, float stepDistance, float stopShort) -> float
{
    const float distanceTo = distance(pos, target);
    const float diffY      = target.y - pos.y;

    // Face the target, unless we are basically on top of it and the angle would be unpredictable.
    if (!isWithinDistance(pos, target, 0.1f, true))
    {
        pos.rotation = worldAngle(pos, target);
    }

    // FFXI's rotation byte is counter-clockwise; standard math convention is clockwise.
    const float radians = 2.0f * static_cast<float>(M_PI) - rotationToRadian(pos.rotation);

    // Step Y toward target.y along the slope, clamped so we never overshoot its height either way.
    const auto stepY = [&]() -> void
    {
        if (std::abs(diffY) <= 0.5f)
        {
            pos.y = target.y;
            return;
        }

        const float startY = pos.y;
        const float newY   = startY + stepDistance * (target.y - startY) / distance(pos, target, true);
        const float minY   = std::min(startY, target.y);
        const float maxY   = std::max(startY, target.y);
        pos.y              = std::clamp(newY, minY, maxY);
    };

    if (distanceTo <= stopShort + stepDistance)
    {
        // Close enough to settle this tick.
        const float advance = distanceTo - stopShort;

        if (stopShort == 0.0f)
        {
            pos.x = target.x;
            pos.y = target.y;
            pos.z = target.z;
        }
        else
        {
            pos.x += cosf(radians) * advance;
            pos.z += sinf(radians) * advance;
            stepY();
        }

        return advance;
    }

    // Take one full step along our current heading.
    pos.x += cosf(radians) * stepDistance;
    pos.z += sinf(radians) * stepDistance;
    stepY();

    return stepDistance;
}

} // namespace pathfind
