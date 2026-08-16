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

#include "map/roam_region.h"

#include <catch2/catch_test_macros.hpp>

#include <cmath>

namespace
{

// 100x100 square with a 20x20 hole punched in the middle.
auto squareWithHole() -> RoamRegion
{
    const RoamRegion::Ring outer{ { 0.0f, -10.0f, 0.0f }, { 100.0f, -10.0f, 0.0f }, { 100.0f, -10.0f, 100.0f }, { 0.0f, -10.0f, 100.0f } };
    const RoamRegion::Ring hole{ { 40.0f, -10.0f, 40.0f }, { 60.0f, -10.0f, 40.0f }, { 60.0f, -10.0f, 60.0f }, { 40.0f, -10.0f, 60.0f } };

    return RoamRegion(outer, { hole });
}

} // namespace

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

TEST_CASE("RoamRegion ring queries hold their distance", "[roam_region]")
{
    const auto       region = squareWithHole();
    const position_t from{ 50.0f, -10.0f, 10.0f, 0, 0 };

    int hits = 0;
    for (int i = 0; i < 5000; ++i)
    {
        const auto point = region.randomPointAt(from, 20.0f);
        if (!point)
        {
            continue;
        }

        REQUIRE(std::abs(std::hypot(point->x - from.x, point->z - from.z) - 20.0f) < 0.01f);
        REQUIRE(region.contains(point->x, point->z));
        ++hits;
    }

    CHECK(hits > 0);
}

TEST_CASE("RoamRegion with no geometry hands out nothing", "[roam_region]")
{
    const RoamRegion region({}, {});

    CHECK_FALSE(region.randomPoint().has_value());
    CHECK_FALSE(region.randomPointAt({}, 10.0f).has_value());
}
