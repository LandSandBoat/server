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

// Invariants zoneutils relies on, checked against West Ronfaure.

#include "map/data/datasets/zones/regions/dataset.h"
#include "map/data/loader.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <ranges>
#include <stdexcept>

namespace
{

using RegionsDataset = xi::data::datasets::zones::regions::Dataset;

constexpr auto kMinimal = R"(
regions:
  rabbit_field:
    poly:
      - [-317.41, -52.49, 308.69]
      - [-290.11, -52.31, 283.01]
      - [-285.31, -51.88, 279.85]
    holes:
      - - [-300.00, -52.20, 290.00]
        - [-295.00, -52.14, 292.00]
        - [-297.00, -52.18, 288.00]
)";

} // namespace

TEST_CASE("regions: a region keeps its outer ring and holes", "[data][region]")
{
    const auto records = RegionsDataset::decode(kMinimal);

    REQUIRE(records.size() == 1);

    const auto& region = records.front();
    REQUIRE(region.Name == "rabbit_field");
    REQUIRE(region.Outer.size() == 3);
    REQUIRE(region.Outer.front()[0] == -317.41f);
    REQUIRE(region.Outer.front()[1] == -52.49f);
    REQUIRE(region.Holes.size() == 1);
    REQUIRE(region.Holes.front().size() == 3);
}

TEST_CASE("regions: a ring that encloses nothing is rejected", "[data][region]")
{
    constexpr auto twoCorners = R"(
regions:
  sliver:
    poly:
      - [0.0, 0.0, 0.0]
      - [1.0, 0.0, 1.0]
)";

    REQUIRE_THROWS_AS(RegionsDataset::decode(twoCorners), std::runtime_error);
}

TEST_CASE("regions: a corner that is not x, y, z is rejected", "[data][region]")
{
    constexpr auto flat = R"(
regions:
  sliver:
    poly:
      - [0.0, 0.0]
      - [1.0, 0.0]
      - [1.0, 1.0]
)";

    REQUIRE_THROWS_AS(RegionsDataset::decode(flat), std::runtime_error);
}

TEST_CASE("regions: West Ronfaure declares the region its spawns name", "[data][region]")
{
    const auto records = xi::data::loadZoneFile<RegionsDataset>(xi::ZoneId::WestRonfaure);
    REQUIRE(records.has_value());

    const auto found = std::ranges::find(*records, "e_46", &xi::data::RegionData::Name);
    REQUIRE(found != records->end());
    REQUIRE(found->Outer.size() == 52);
    REQUIRE(found->Holes.size() == 3);
}
