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

#include "data/datasets/zones/settings/dataset.h"

#include "data/datasets/zones/settings/yaml.h"
#include "data/shared_types/position.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <algorithm>
#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <unordered_set>
#include <vector>

namespace xi::data::datasets::zones::settings
{

namespace
{

// Zone line ids are a four-character client token stored as its little-endian bytes.
auto packZoneLineId(const std::string_view key) -> uint32
{
    if (key.size() != 4)
    {
        throw std::runtime_error(fmt::format("zone line '{}' is not four characters", key));
    }

    uint32 id{};
    for (size_t index = 0; index < key.size(); ++index)
    {
        id |= static_cast<uint32>(static_cast<uint8>(key[index])) << (index * 8);
    }
    return id;
}

auto convertMusic(const std::optional<wire::Music>& source) -> ZoneMusicData
{
    if (!source)
    {
        return {};
    }

    return {
        .Day         = source->day.value_or(0),
        .Night       = source->night.value_or(0),
        .BattleSolo  = source->battle_solo.value_or(0),
        .BattleParty = source->battle_party.value_or(0),
    };
}

auto convertZoneLines(const std::optional<std::map<std::string, wire::ZoneLine>>& entries) -> std::vector<ZoneLineData>
{
    if (!entries)
    {
        return {};
    }

    std::vector<ZoneLineData>  lines;
    std::unordered_set<uint32> seen;
    lines.reserve(entries->size());
    for (const auto& [key, source] : *entries)
    {
        const auto id = packZoneLineId(key);
        if (!seen.emplace(id).second)
        {
            throw std::runtime_error(fmt::format("duplicate zone line '{}'", key));
        }

        lines.emplace_back(ZoneLineData{
            .Id              = id,
            .Origin          = { source.from[0], source.from[1], source.from[2], 0, 0 },
            .DestinationZone = yaml::resolveEnum(source.to),
            .Destination     = shared::toPositionFacingRadians(source.at, fmt::format("zone line '{}'", key)),
            .ScaleX          = source.scale[0],
            .ScaleZ          = source.scale[1],
        });
    }
    return lines;
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto document = yaml::read<YamlDocument>(text);

    return {
        .Type             = yaml::resolveFlags(document.type),
        .Misc             = yaml::resolveFlags(document.misc),
        .Music            = convertMusic(document.music),
        .Tax              = document.tax.value_or(0.0f),
        .LevelRestriction = document.level_restriction.value_or(0),
        .ZoneLines        = convertZoneLines(document.zonelines),
    };
}

} // namespace xi::data::datasets::zones::settings
