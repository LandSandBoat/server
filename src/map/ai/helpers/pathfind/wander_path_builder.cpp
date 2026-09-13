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

#include <map/ai/helpers/pathfind/wander_path_builder.h>

#include <map/roam_region.h>

#include <common/utils.h>
#include <common/xirand.h>

namespace
{

constexpr double kTurnSpread    = 0.6;   // radians, about 34 degrees; how far off its current heading the next leg may point
constexpr int    kTries         = 24;    // draws before the mob gives up on this walk; the first half stay in the cone, the rest go any direction
constexpr float  kSnapTolerance = 3.0f;  // yalms; a drawn spot the mesh has to move further than this was not on walkable ground
constexpr float  kShortStep     = 20.0f; // yalms; when nothing long is open ahead, a short step any way, as retail does round bends and at lane ends
constexpr float  kMaxDetour     = 2.0f;  // path over straight-line ratio: the walk may follow the lanes round a bend, as retail's two-leg walks do

auto pathLength(const position_t& from, const std::vector<pathpoint_t>& points) -> float
{
    float length = 0.0f;
    auto  last   = from;
    for (const auto& point : points)
    {
        length += distance(last, point.position, true);
        last = point.position;
    }

    return length;
}

// every yalm of the walk lies in the region
auto pathInsideRegion(const RoamRegion& region, const position_t& from, const std::vector<pathpoint_t>& points) -> bool
{
    auto last = from;
    for (const auto& point : points)
    {
        const auto& to     = point.position;
        const float length = std::max(distance(last, to, true), 0.01f);
        for (float along = 0.0f; along <= length + 1.0f; along += 1.0f)
        {
            const float t = std::min(along / length, 1.0f);
            if (!region.contains(last.x + (to.x - last.x) * t, last.z + (to.z - last.z) * t))
            {
                return false;
            }
        }

        last = to;
    }

    return true;
}

} // namespace

namespace pathfind
{

WanderPathBuilder::WanderPathBuilder(NavMesh& navMesh)
: navMesh_(navMesh)
{
}

auto WanderPathBuilder::findLeg(const position_t& from, const float radius, const RoamRegion& region) const -> Maybe<position_t>
{
    for (int attempt = 0; attempt < kTries; ++attempt)
    {
        // once half the tries found nothing ahead, take a short step any way
        const bool ahead = attempt < kTries / 2;
        double     turn  = xirand::GetRandomNumber(-M_PI, M_PI);
        float      reach = xirand::GetRandomNumber(kSnapTolerance, kShortStep);
        if (ahead)
        {
            turn = xirand::GetNormalNumber(0.0, kTurnSpread);
            // as likely near as far per square yalm
            reach = radius * std::sqrt(xirand::GetRandomNumber(0.0f, 1.0f));
        }

        const auto drawn  = nearPosition(from, reach, static_cast<float>(turn));
        const auto target = navMesh_.findClosestValidPoint(drawn);
        if (!target)
        {
            continue;
        }

        if (distance(drawn, *target, true) > kSnapTolerance)
        {
            continue;
        }

        const auto path = navMesh_.findPath(from, *target);
        if (!path || path->isPartial)
        {
            continue;
        }

        const bool alongLanes = pathLength(from, path->points) <= distance(from, *target, true) * kMaxDetour;
        const bool inside     = pathInsideRegion(region, from, path->points);
        if (alongLanes && inside)
        {
            return target;
        }
    }

    return std::nullopt;
}

} // namespace pathfind
