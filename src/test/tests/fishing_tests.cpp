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

#include "map/utils/fishingutils.h"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Fishing legendary attack bonuses also increase wrong-arrow healing", "[fishing]")
{
    auto rod         = rod_t{};
    rod.fishAttack   = 100;
    rod.lgdBonusAtk  = 50;
    rod.fishRecovery = 50;

    CHECK(fishingutils::CalculateAttack(fishingutils::Legendary::No, 20, &rod) == 400);
    CHECK(fishingutils::CalculateAttack(fishingutils::Legendary::Yes, 20, &rod) == 600);
    CHECK(fishingutils::CalculateHeal(fishingutils::Legendary::No, 20, &rod) == 100);
    CHECK(fishingutils::CalculateHeal(fishingutils::Legendary::Yes, 20, &rod) == 150);
}

TEST_CASE("Fishing area segments intersect at crossings, endpoints and overlaps", "[fishing]")
{
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 10 }, { 0, 0, 10 }, { 10, 0, 0 }));
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 10, 0, 0 }, { 20, 0, 0 }));
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 5, 0, 0 }, { 15, 0, 0 }));
    CHECK_FALSE(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 11, 0, 0 }, { 20, 0, 0 }));
    CHECK_FALSE(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 0, 0, 1 }, { 10, 0, 1 }));
}

TEST_CASE("Fishing polygon boundaries include edges and enforce height", "[fishing]")
{
    areavector_t polygon[] = { { 0, 0, 0 }, { 10, 0, 0 }, { 10, 0, 10 }, { 0, 0, 10 } };

    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, 0, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 0, 0, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, 2, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, -2, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 11, 0, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 5, 3, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 5, -3, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 2, { 5, 0, 5 }, 0, 4));
}

TEST_CASE("Fishing cylinders include the radius and reject points beyond it", "[fishing]")
{
    const auto center = areavector_t{ 10, 20, 30 };

    CHECK(fishingutils::isInsideCylinder(center, { 10, 20, 30 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 13, 20, 34 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 7, 20, 26 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 10, 22, 30 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 10, 18, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 14, 20, 34 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 16, 20, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 20, 36 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 23, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 17, 30 }, 5, 4));
}
