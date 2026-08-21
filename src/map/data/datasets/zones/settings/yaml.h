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
#include "data/enums/zone.h"
#include "data/enums/zone_misc.h"
#include "data/enums/zone_type.h"
#include "data/yaml/enum_token.h"

#include <glaze/glaze.hpp>

#include <array>
#include <map>
#include <optional>
#include <string>
#include <vector>

namespace xi::data::datasets::zones::settings::wire
{

using ZoneType = std::optional<std::vector<yaml::EnumToken<xi::ZoneType>>>;
using ZoneMisc = std::optional<std::vector<yaml::EnumToken<xi::ZoneMisc>>>;

struct Music
{
    std::optional<uint16> day;
    std::optional<uint16> night;
    std::optional<uint16> battle_solo;
    std::optional<uint16> battle_party;
};

struct ZoneLine
{
    std::array<float, 3>        from;
    yaml::EnumToken<xi::ZoneId> to;
    std::vector<float>          at;
    std::array<float, 2>        scale;
};

struct Document
{
    ZoneType                                       type;
    ZoneMisc                                       misc;
    std::optional<Music>                           music;
    std::optional<float>                           tax;
    std::optional<uint8>                           level_restriction;
    std::optional<std::map<std::string, ZoneLine>> zonelines;
};

} // namespace xi::data::datasets::zones::settings::wire

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::Music>
{
    glz::schema day{ .description = "Background music by day. Defaults to 0 (silence)." };
    glz::schema night{ .description = "Background music by night. Defaults to 0 (silence)." };
    glz::schema battle_solo{ .description = "Battle music when fighting alone. Defaults to 0." };
    glz::schema battle_party{ .description = "Battle music when fighting in a party. Defaults to 0." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::ZoneLine>
{
    glz::schema from{ .description = "Centre of the trigger box in this zone, as x, y, z." };
    glz::schema to{ .description = "Destination zone." };
    glz::schema at{ .description = "Centre of the arrival box in the destination zone, as x, y, z and optionally a facing in radians." };
    glz::schema scale{ .description = "Arrival box dimensions along x and z. Players are spread across eight slots along the longer side." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::Document>
{
    glz::schema type{
        .description = "Zone classification flags. Defaults to an empty list.",
        .uniqueItems = true,
    };
    glz::schema misc{
        .description = "Abilities and systems permitted in this zone. Defaults to an empty list.",
        .uniqueItems = true,
    };
    glz::schema music{ .description = "Background and battle music. Omitted slots default to 0." };
    glz::schema tax{
        .description = "Percent added to bazaar purchases in this zone. Defaults to 0, and every zone reads 0 today.",
        .minimum     = 0.0,
        .maximum     = 100.0,
    };
    glz::schema level_restriction{
        .description = "Level cap enforced on entry. Defaults to 0, meaning uncapped.",
        .minimum     = 0L,
        .maximum     = 99L,
    };
    glz::schema zonelines{ .description = "Outbound transitions, keyed by their four-character client id such as z2s0." };
};
