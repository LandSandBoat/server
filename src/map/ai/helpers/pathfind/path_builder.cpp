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

#include <map/ai/helpers/pathfind/path_builder.h>

#include <common/utils.h>
#include <common/xirand.h>

namespace pathfind
{

NavPathBuilder::NavPathBuilder(NavMesh& navMesh)
: navMesh_(navMesh)
{
}

auto NavPathBuilder::findPath(const position_t& start, const position_t& end) const -> Maybe<PathResult>
{
    auto result = navMesh_.findPath(start, end);

    // findPath searches 2.5f XZ per endpoint, so two fallbacks handle endpoints outside that radius.
    // An off-mesh end paths to the nearest on-mesh point via the wider 30f radius.
    // An off-mesh start builds from the nearest on-mesh point, and the mob slides back on within a tick or two.
    if (!result)
    {
        if (const auto closestEnd = navMesh_.findClosestValidPoint(end))
        {
            if (!isNear(start, *closestEnd))
            {
                result = navMesh_.findPath(start, *closestEnd);
            }
        }
    }

    if (!result)
    {
        if (const auto closestStart = navMesh_.findClosestValidPoint(start))
        {
            if (!isNear(*closestStart, end))
            {
                result = navMesh_.findPath(*closestStart, end);
            }
        }
    }

    if (!result)
    {
        return std::nullopt;
    }

    // Close any end-gap on complete paths, since the wider 30f search may beat findPath's 2.5f result.
    if (!result->isPartial && !result->points.empty())
    {
        // A gap this small can never be beaten, and the 30f search costs 13x a normal lookup.
        const float lastWaypointGap = distance(result->points.back().position, end);
        if (lastWaypointGap > 0.1f)
        {
            if (const auto closestEnd = navMesh_.findClosestValidPoint(end))
            {
                const float closestGap = distance(*closestEnd, end);
                if (closestGap < lastWaypointGap - 0.1f)
                {
                    result->points.emplace_back(pathpoint_t{ *closestEnd, 0s, false });
                }
            }
        }
    }

    return result;
}

auto NavPathBuilder::findRoamTurnPoints(const position_t& start, float maxRadius, uint8 maxTurns) const -> Maybe<std::vector<position_t>>
{
    const auto desiredTurnCount = static_cast<uint8_t>(xirand::GetRandomNumber<uint32>(maxTurns) + 1);

    // Seemingly arbitrary divisor: navmesh polys are dense enough that the query saturates regardless.
    const float maxRadiusForPolyQuery = maxRadius / 10.0f;

    std::vector<position_t> turnPoints;

    // Allow up to 2x attempts, since findRandomPosition may return a poly outside `maxRadius`.
    const int maxAttempts = desiredTurnCount * 2;
    for (int i = 0; i < maxAttempts; ++i)
    {
        const auto candidate = navMesh_.findRandomPosition(start, maxRadiusForPolyQuery);
        if (!candidate)
        {
            // Hard navmesh failure - bail rather than return a partial turn list.
            return std::nullopt;
        }

        if (isWithinDistance(start, *candidate, maxRadius, true))
        {
            turnPoints.emplace_back(*candidate);
        }

        if (turnPoints.size() >= desiredTurnCount)
        {
            break;
        }
    }

    return turnPoints;
}

} // namespace pathfind
