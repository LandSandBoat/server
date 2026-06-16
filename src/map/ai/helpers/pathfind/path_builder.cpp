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

    // findPath uses a 2.5f XZ poly search radius per endpoint. Two fallbacks handle endpoints
    // outside that radius (> 2.5f XZ from any poly):
    //
    // End off-mesh (e.g. player on a rock/ledge): path to the nearest on-mesh point to the target,
    // found via the wide 30f radius.
    //
    // Start off-mesh (e.g. mob placed there by the stuck-repath teleport): build from the nearest
    // on-mesh point to the mob. The mob steps toward that first waypoint and slides back onto the
    // mesh within a tick or two - no hard snap, no position modification.
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

    // For complete (non-chunked) paths, close any gap between the last waypoint and the destination.
    // findClosestValidPoint's wider 30f XZ search may beat the endpoint findPath's 2.5f-radius result.
    if (!result->isPartial && !result->points.empty())
    {
        if (const auto closestEnd = navMesh_.findClosestValidPoint(end))
        {
            const float lastWaypointGap = distance(result->points.back().position, end);
            const float closestGap      = distance(*closestEnd, end);
            if (closestGap < lastWaypointGap - 0.1f)
            {
                result->points.emplace_back(pathpoint_t{ *closestEnd, 0s, false });
            }
        }
    }

    return result;
}

auto NavPathBuilder::findRoamTurnPoints(const position_t& start, float maxRadius, uint8 maxTurns) const -> Maybe<std::vector<position_t>>
{
    const auto desiredTurnCount = static_cast<uint8_t>(xirand::GetRandomNumber<uint32>(maxTurns) + 1);

    // Seemingly arbitrary divisor: most maxRadius inputs give similar results, likely because
    // navmesh polys are dense enough that the poly query saturates quickly anyway.
    const float maxRadiusForPolyQuery = maxRadius / 10.0f;

    std::vector<position_t> turnPoints;

    // Pick `desiredTurnCount` random navmesh destinations. Allow up to 2x attempts since
    // findRandomPosition may return a poly outside `maxRadius`.
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
