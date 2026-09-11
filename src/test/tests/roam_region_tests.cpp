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

#include "map/navmesh/navmesh.h"
#include "map/roam_region.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <cmath>
#include <vector>

namespace
{

// 100x100 square with a 20x20 hole punched in the middle.
auto squareWithHole() -> RoamRegion
{
    const RoamRegion::Ring outer{ { 0.0f, -10.0f, 0.0f }, { 100.0f, -10.0f, 0.0f }, { 100.0f, -10.0f, 100.0f }, { 0.0f, -10.0f, 100.0f } };
    const RoamRegion::Ring hole{ { 40.0f, -10.0f, 40.0f }, { 60.0f, -10.0f, 40.0f }, { 60.0f, -10.0f, 60.0f }, { 40.0f, -10.0f, 60.0f } };

    return RoamRegion(outer, { hole });
}

// surface walk that lands `drift` yalms off the requested point, like a mob sliding along geometry
class DriftingNavMesh final : public NavMesh
{
public:
    explicit DriftingNavMesh(float drift)
    : drift_(drift)
    {
    }

    auto moveAlongSurface(const position_t& start, const position_t& end, position_t& result) const -> bool override
    {
        result = end;
        result.x += drift_;
        return true;
    }

    auto findPath(const position_t&, const position_t&) -> Maybe<PathResult> override
    {
        return std::nullopt;
    }

    auto findRandomPosition(const position_t& start, float) const -> Maybe<position_t> override
    {
        return start;
    }

    auto validPosition(const position_t&) const -> bool override
    {
        return true;
    }

    auto findClosestValidPoint(const position_t& position) const -> Maybe<position_t> override
    {
        return position;
    }

    auto findFurthestValidPoint(const position_t&, const position_t& endPosition) const -> Maybe<position_t> override
    {
        return endPosition;
    }

    auto snapToValidPosition(position_t&) const -> void override
    {
    }

private:
    float drift_;
};

} // namespace

TEST_CASE("RoamRegion rejects a walk that slid outside the region", "[roam_region]")
{
    // the target was inside but the walk ends past the edge; only the arrival check catches it
    const auto            region = squareWithHole();
    const DriftingNavMesh strayed(500.0f);

    const position_t from{ 50.0f, -10.0f, 10.0f, 0, 0 };
    for (int i = 0; i < 500; ++i)
    {
        CHECK_FALSE(region.randomPointAt(from, 20.0f, &strayed).has_value());
    }
}

TEST_CASE("RoamRegion accepts a walk that stayed inside", "[roam_region]")
{
    const auto            region = squareWithHole();
    const DriftingNavMesh onTarget(0.0f);

    const position_t from{ 50.0f, -10.0f, 10.0f, 0, 0 };

    int hits = 0;
    for (int i = 0; i < 500; ++i)
    {
        if (const auto point = region.randomPointAt(from, 20.0f, &onTarget))
        {
            REQUIRE(region.contains(point->x, point->z));
            ++hits;
        }
    }

    CHECK(hits > 400);
}

TEST_CASE("RoamRegion contains respects holes and bounds", "[roam_region]")
{
    const auto region = squareWithHole();

    CHECK(region.contains(5.0f, 5.0f));
    CHECK(region.contains(99.0f, 99.0f));
    CHECK_FALSE(region.contains(50.0f, 50.0f));
    CHECK_FALSE(region.contains(-1.0f, 50.0f));
    CHECK_FALSE(region.contains(50.0f, 101.0f));
}

TEST_CASE("RoamRegion measures how far outside a position is", "[roam_region]")
{
    const auto region = squareWithHole();

    // inside: the position is its own closest point
    const position_t inside{ 10.0f, -10.0f, 10.0f, 0, 0 };
    CHECK(region.distanceOutside(inside) == 0.0f);
    CHECK(region.closestPoint(inside).x == inside.x);
    CHECK(region.closestPoint(inside).z == inside.z);

    // past the west wall: nearest point is on the wall, straight back in
    const position_t west{ -10.0f, -10.0f, 50.0f, 0, 0 };
    CHECK(std::abs(region.distanceOutside(west) - 10.0f) < 0.01f);
    CHECK(std::abs(region.closestPoint(west).x - 0.0f) < 0.01f);
    CHECK(std::abs(region.closestPoint(west).z - 50.0f) < 0.01f);

    // in the hole: the region is all around, nearest wall is 10 away
    const position_t inHole{ 50.0f, -10.0f, 50.0f, 0, 0 };
    CHECK(std::abs(region.distanceOutside(inHole) - 10.0f) < 0.01f);
    CHECK(region.contains(region.closestPoint(inHole).x, region.closestPoint(inHole).z));
}

TEST_CASE("RoamRegion samples land inside the region", "[roam_region]")
{
    const auto region = squareWithHole();

    for (int i = 0; i < 5000; ++i)
    {
        const auto point = region.randomPoint();

        REQUIRE(point.has_value());
        REQUIRE(region.contains(point->x, point->z));
    }
}

TEST_CASE("RoamRegion roam steps vary in length", "[roam_region]")
{
    // the requested distance is the median of a log-normal draw, not a radius
    const auto       region = squareWithHole();
    const position_t from{ 50.0f, -10.0f, 10.0f, 0, 0 };

    std::vector<float> distances;
    for (int i = 0; i < 5000; ++i)
    {
        if (const auto point = region.randomPointAt(from, 20.0f))
        {
            distances.push_back(std::hypot(point->x - from.x, point->z - from.z));
        }
    }

    REQUIRE(distances.size() > 100);

    const auto [shortest, longest] = std::ranges::minmax(distances);
    CHECK(longest - shortest > 1.0f);
    CHECK(shortest >= 0.5f);
}

TEST_CASE("RoamRegion roam steps never leave the region", "[roam_region]")
{
    const auto region = squareWithHole();

    // includes spots hard against the hole and the outer edge, where a step is most likely to land outside
    for (const auto& from : { position_t{ 50.0f, -10.0f, 10.0f, 0, 0 },
                              position_t{ 39.0f, -10.0f, 50.0f, 0, 0 },
                              position_t{ 1.0f, -10.0f, 1.0f, 0, 0 },
                              position_t{ 99.0f, -10.0f, 99.0f, 0, 0 } })
    {
        for (int i = 0; i < 2000; ++i)
        {
            if (const auto point = region.randomPointAt(from, 20.0f))
            {
                REQUIRE(region.contains(point->x, point->z));
            }
        }
    }
}

TEST_CASE("RoamRegion keeps roaming in a corridor narrower than its step", "[roam_region]")
{
    // 200x6: no 20 yalm step fits across it, so without a shorter retry the mob would stand still
    const RoamRegion::Ring corridor{ { 0.0f, -10.0f, 0.0f }, { 200.0f, -10.0f, 0.0f }, { 200.0f, -10.0f, 6.0f }, { 0.0f, -10.0f, 6.0f } };
    const RoamRegion       region(corridor, {});

    const position_t from{ 100.0f, -10.0f, 3.0f, 0, 0 };

    int hits = 0;
    for (int i = 0; i < 2000; ++i)
    {
        if (const auto point = region.randomPointAt(from, 20.0f))
        {
            REQUIRE(region.contains(point->x, point->z));
            ++hits;
        }
    }

    // along the corridor a long step fits, across it nothing does; most ticks must still move
    CHECK(hits > 1500);
}

TEST_CASE("RoamRegion with no geometry hands out nothing", "[roam_region]")
{
    const RoamRegion region({}, {});

    CHECK_FALSE(region.randomPoint().has_value());
    CHECK_FALSE(region.randomPointAt({}, 10.0f).has_value());
}

TEST_CASE("RoamRegion clamps a leg at the first boundary it would cross", "[roam_region]")
{
    const auto    region = squareWithHole();
    const Vector3 east{ .x = 1.0f, .y = 0.0f, .z = 0.0f };

    // clear row: stops just short of the outer edge at x = 100
    const position_t clearRow{ 10.0f, -10.0f, 20.0f, 0, 0 };
    CHECK(std::abs(region.clampToRegion(clearRow, east, 200.0f) - 89.95f) < 0.01f);

    // row through the hole: stops at the hole's near edge at x = 40
    const position_t holeRow{ 10.0f, -10.0f, 50.0f, 0, 0 };
    CHECK(std::abs(region.clampToRegion(holeRow, east, 200.0f) - 29.95f) < 0.01f);

    // short leg comes back whole
    CHECK(region.clampToRegion(holeRow, east, 20.0f) == 20.0f);

    // outside start gets nothing
    const position_t outside{ -5.0f, -10.0f, 50.0f, 0, 0 };
    CHECK(region.clampToRegion(outside, east, 20.0f) == 0.0f);
}
