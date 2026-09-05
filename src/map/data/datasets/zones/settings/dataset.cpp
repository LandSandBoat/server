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
#include <limits>
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

// Phases run back to back from the offset. One may leave its length out and take whatever the cycle has left.
auto convertPhases(const std::vector<wire::TransportPhase>& source, const uint32 every, const std::string_view name, const std::map<std::string, position_t>& places) -> std::vector<TransportPhaseData>
{
    if (source.empty())
    {
        throw std::runtime_error(fmt::format("transport '{}' declares no phases", name));
    }

    // A run with no cycle length holds its single phase forever.
    if (every == 0)
    {
        if (source.size() != 1 || source.front().seconds)
        {
            throw std::runtime_error(fmt::format("transport '{}' has no cycle length, so it needs exactly one phase with no length of its own", name));
        }

        return { TransportPhaseData{
            .State     = yaml::resolveEnum(source.front().state),
            .Animation = yaml::resolveEnum(source.front().animation),
            .Start     = 0,
            .End       = std::numeric_limits<uint32>::max(),
        } };
    }

    const auto open = std::ranges::count_if(source,
                                            [](const auto& phase)
                                            {
                                                return !phase.seconds.has_value();
                                            });
    if (open > 1)
    {
        throw std::runtime_error(fmt::format("transport '{}' leaves {} phases without a length; at most one may", name, open));
    }

    uint32 stated{};
    for (const auto& phase : source)
    {
        stated += phase.seconds.value_or(0);
    }

    if (stated > every)
    {
        throw std::runtime_error(fmt::format("transport '{}' phases run {}s, longer than its {}s cycle", name, stated, every));
    }

    if (open == 0 && stated != every)
    {
        throw std::runtime_error(fmt::format("transport '{}' phases run {}s, short of its {}s cycle, and no phase is open-ended", name, stated, every));
    }

    std::vector<TransportPhaseData> phases;
    phases.reserve(source.size());

    uint32 cursor{};
    for (const auto& phase : source)
    {
        const auto length = phase.seconds.value_or(every - stated);

        std::vector<TransportMoveData> moves;
        for (const auto& move : phase.moves.value_or(std::vector<wire::TransportMove>{}))
        {
            const auto place = places.find(move.to);
            if (place == places.end())
            {
                throw std::runtime_error(fmt::format("transport '{}' moves to '{}', which is not one of its places", name, move.to));
            }

            moves.emplace_back(TransportMoveData{ .Where = place->second, .After = move.after.value_or(0) });
        }

        phases.emplace_back(TransportPhaseData{
            .State     = yaml::resolveEnum(phase.state),
            .Animation = yaml::resolveEnum(phase.animation),
            .Start     = cursor,
            .End       = cursor + length,
            .Moves     = std::move(moves),
            .Hide      = phase.hide,
        });

        cursor += length;
    }

    return phases;
}

auto convertTransports(const std::optional<wire::TransportSchedule>& schedule) -> std::vector<TransportData>
{
    if (!schedule)
    {
        return {};
    }

    std::vector<TransportData> transports;
    transports.reserve(schedule->runs.size());
    for (const auto& [name, source] : schedule->runs)
    {
        std::vector<xi::ZoneId> crossings;
        for (const auto& zone : source.voyage.value_or(std::vector<yaml::EnumToken<xi::ZoneId>>{}))
        {
            crossings.emplace_back(yaml::resolveEnum(zone));
        }

        // A decorative ship declares no berth and keeps whatever spot the zone file gave it.
        const auto dock = [&]() -> std::optional<position_t>
        {
            if (!source.dock)
            {
                return std::nullopt;
            }

            return shared::toPosition(source.dock, fmt::format("transport '{}'", name));
        }();

        // The berth is always addressable by name, so a run that never leaves it needs no places at all.
        std::map<std::string, position_t> places;
        if (dock)
        {
            places.emplace("dock", *dock);
        }

        for (const auto& [place, at] : source.places.value_or(std::map<std::string, std::array<float, 3>>{}))
        {
            places.emplace(place, position_t{ at[0], at[1], at[2], 0, 0 });
        }

        transports.emplace_back(TransportData{
            .Name      = name,
            .Ship      = schedule->ship,
            .Door      = source.door.value_or(std::string{}),
            .Dock      = dock,
            .Boundary  = source.boundary.value_or(0),
            .Crossings = crossings,
            .Every     = source.every.value_or(0),
            .Offset    = source.offset.value_or(0),
            .Disembark = source.disembark.value_or(0),
            .Phases    = convertPhases(source.phases, source.every.value_or(0), name, places),
        });
    }

    return transports;
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
        .Transports       = convertTransports(document.transport),
    };
}

} // namespace xi::data::datasets::zones::settings
