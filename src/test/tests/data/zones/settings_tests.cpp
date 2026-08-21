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

// Invariants CZone and zoneutils rely on, checked against West Ronfaure.

#include "map/data/datasets/zones/settings/dataset.h"
#include "map/data/loader.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <ranges>
#include <stdexcept>

namespace
{

using ZoneSettingsDataset = xi::data::datasets::zones::settings::Dataset;

constexpr auto kMinimal = R"(
type:
  - outdoors
zonelines:
  z2s0:
    from:  [ -119.065, -65.707, 280.921 ]
    to:    southern_san_doria
    at:    [ -110.465, -2.083, -54.469, 5.497787 ]
    scale: [ 1.0, 5.0 ]
)";

} // namespace

TEST_CASE("zone settings: omitted fields fall back to their defaults", "[data][zone]")
{
    const auto records = ZoneSettingsDataset::decode(kMinimal);

    REQUIRE(records.Type == xi::ZoneType::Outdoors);
    REQUIRE(records.Misc == xi::ZoneMisc::None);
    REQUIRE(records.Music.Day == 0);
    REQUIRE(records.Music.BattleParty == 0);
    REQUIRE(records.Tax == 0.0f);
    REQUIRE(records.LevelRestriction == 0);
}

TEST_CASE("zone settings: a zone line keeps its four-character id", "[data][zone]")
{
    const auto records = ZoneSettingsDataset::decode(kMinimal);

    REQUIRE(records.ZoneLines.size() == 1);

    const auto& line = records.ZoneLines.front();

    // "z2s0" packed
    REQUIRE(line.Id == 0x3073327A);
    REQUIRE(line.DestinationZone == xi::ZoneId::SouthernSanDoria);
    // radians in, 0-255 out, truncated: 223 not 224
    REQUIRE(line.Destination.rotation == 223);

    REQUIRE(line.ScaleX == 1.0f);
    REQUIRE(line.ScaleZ == 5.0f);
}

TEST_CASE("zone settings: a malformed zone line id is rejected", "[data][zone]")
{
    constexpr auto tooLong = R"(
zonelines:
  z2s00:
    from:  [ 0.0, 0.0, 0.0 ]
    to:    east_ronfaure
    at:    [ 0.0, 0.0, 0.0 , 0.0]
    scale: [ 1.0, 1.0 ]
)";

    REQUIRE_THROWS_AS(ZoneSettingsDataset::decode(tooLong), std::runtime_error);
}

TEST_CASE("zone settings: West Ronfaure keeps every setting it declares", "[data][zone]")
{
    const auto settings = xi::data::loadZoneFile<ZoneSettingsDataset>(xi::ZoneId::WestRonfaure);
    REQUIRE(settings.has_value());

    REQUIRE(settings->Type == xi::ZoneType::Outdoors);
    REQUIRE(settings->Music.Day == 109);
    REQUIRE(settings->Music.Night == 109);
    REQUIRE(settings->Music.BattleSolo == 101);
    REQUIRE(settings->Music.BattleParty == 103);
    REQUIRE(settings->Tax == 0.0f);
    REQUIRE(settings->LevelRestriction == 0);

    REQUIRE(settings->Misc == (xi::ZoneMisc::Fellow | xi::ZoneMisc::Mount | xi::ZoneMisc::Mazurka |
                               xi::ZoneMisc::Tractor | xi::ZoneMisc::Pet | xi::ZoneMisc::Trust));

    REQUIRE(settings->ZoneLines.size() == 8);

    const auto toGhelsba = std::ranges::find(settings->ZoneLines, xi::ZoneId::GhelsbaOutpost, &xi::data::ZoneLineData::DestinationZone);
    REQUIRE(toGhelsba != settings->ZoneLines.end());
    REQUIRE(toGhelsba->Destination.x == 100.002f);
    REQUIRE(toGhelsba->Destination.rotation == 192); // 4.712389 rad
    REQUIRE(toGhelsba->ScaleZ == 4.5f);
}
