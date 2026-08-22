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

#pragma once

#include "common/cbasetypes.h"
#include "common/types/position.h"
#include "data/enums/zone.h"
#include "data/enums/zone_misc.h"
#include "data/enums/zone_type.h"

#include <string_view>
#include <vector>

namespace xi::data
{

struct ZoneLineData
{
    uint32     Id{};     // four-character client id packed little-endian, e.g. "z2s0"
    position_t Origin{}; // centre of the trigger box in the owning zone
    xi::ZoneId DestinationZone{};
    position_t Destination{}; // centre of the arrival box in the destination zone
    float      ScaleX{};
    float      ScaleZ{};
};

struct ZoneMusicData
{
    uint16 Day{};
    uint16 Night{};
    uint16 BattleSolo{};
    uint16 BattleParty{};
};

struct ZoneSettings
{
    xi::ZoneType              Type{};
    xi::ZoneMisc              Misc{};
    ZoneMusicData             Music{};
    float                     Tax{}; // scaled by the consumer, as the SQL path did
    uint8                     LevelRestriction{};
    std::vector<ZoneLineData> ZoneLines{};
};

} // namespace xi::data

namespace xi::data::datasets::zones::settings::wire
{

struct Document;

}

namespace xi::data::datasets::zones::settings
{

struct Dataset
{
    using Records      = xi::data::ZoneSettings;
    using YamlDocument = wire::Document;

    // Per-zone file: data/zones/<zone>/zone.yaml
    static constexpr std::string_view kDataPath{ "zone" };
    static constexpr std::string_view kTitle{ "Zone" };
    static constexpr std::string_view kDescription{ "Zone classification, music, permitted systems, and outbound transitions." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::zones::settings
