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

#include "data/datasets/zones/mobs/dataset.h"
#include "data/datasets/zones/mobs/yaml.h"
#include "data/shared_types/position.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <array>
#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <unordered_set>
#include <utility>
#include <variant>
#include <vector>

namespace xi::data::datasets::zones::mobs
{

namespace
{

auto convertWeights(const std::optional<std::map<std::string, uint16>>& source)
    -> std::vector<std::pair<std::string, uint16>>
{
    std::vector<std::pair<std::string, uint16>> entries;
    if (!source)
    {
        return entries;
    }

    entries.reserve(source->size());
    for (const auto& [name, weight] : *source)
    {
        entries.emplace_back(name, weight);
    }
    return entries;
}

// Shares are basis points, so a whole roll is 10000 and a percentage keeps two decimals.
auto convertOneOf(const std::optional<wire::OneOf>& source, const std::string_view key)
    -> std::vector<std::pair<std::string, uint16>>
{
    std::vector<std::pair<std::string, uint16>> members;
    if (!source)
    {
        return members;
    }

    if (const auto* even = std::get_if<std::vector<std::string>>(&*source))
    {
        if (even->empty())
        {
            throw std::runtime_error(fmt::format("template '{}' has a one_of that names nothing", key));
        }

        members.reserve(even->size());
        for (const auto& name : *even)
        {
            members.emplace_back(name, uint16{ 1 });
        }
        return members;
    }

    const auto& shares = std::get<std::map<std::string, double>>(*source);

    uint32 total = 0;
    members.reserve(shares.size());
    for (const auto& [name, percent] : shares)
    {
        if (percent <= 0.0 || percent > 100.0)
        {
            throw std::runtime_error(fmt::format("template '{}' gives one_of member '{}' a share of {}%, outside 0-100", key, name, percent));
        }

        const auto basisPoints = static_cast<uint16>(std::lround(percent * 100.0));
        total += basisPoints;
        members.emplace_back(name, basisPoints);
    }

    if (total != 10000)
    {
        throw std::runtime_error(fmt::format("template '{}' has one_of shares totalling {}%, not 100", key, total / 100.0));
    }

    return members;
}

auto convertSteal(const std::optional<wire::Steal>& source) -> std::vector<std::string>
{
    if (!source)
    {
        return {};
    }

    if (const auto* one = std::get_if<std::string>(&*source))
    {
        return { *one };
    }

    return std::get<std::vector<std::string>>(*source);
}

// A name resolves straight to its per-mille rate. A percentage is the only form needing conversion.
auto perMille(const wire::Chance& chance, const std::string_view key) -> uint16
{
    if (const auto* tier = std::get_if<yaml::EnumToken<xi::DropRate>>(&chance))
    {
        return static_cast<uint16>(yaml::resolveEnum(*tier));
    }

    const auto percent = std::get<double>(chance);
    if (percent < 0.0 || percent > 100.0)
    {
        throw std::runtime_error(fmt::format("template '{}' has a loot chance of {}%, outside 0-100", key, percent));
    }

    return static_cast<uint16>(std::lround(percent * 10.0));
}

auto convertLoot(const std::optional<wire::Loot>& source, const std::string_view key) -> LootData
{
    LootData loot;
    if (!source)
    {
        return loot;
    }

    if (source->drops)
    {
        loot.Drops.reserve(source->drops->size());
        for (const auto& roll : *source->drops)
        {
            if (roll.item.has_value() == roll.one_of.has_value())
            {
                throw std::runtime_error(fmt::format("template '{}' has a loot roll that must name either an item or a one_of", key));
            }

            loot.Drops.emplace_back(LootRollData{
                .Chance = perMille(roll.chance, key),
                .Item   = roll.item.value_or(std::string{}),
                .OneOf  = convertOneOf(roll.one_of, key),
            });
        }
    }

    loot.Steal   = convertSteal(source->steal);
    loot.Despoil = convertWeights(source->despoil);
    return loot;
}

auto convertTemplate(const std::string& key, const wire::Template& source) -> MobTemplateData
{
    if (source.id == 0)
    {
        throw std::runtime_error(fmt::format("template '{}' declares reserved pool id 0", key));
    }

    if (source.spells && source.spell_list_id)
    {
        throw std::runtime_error(fmt::format("template '{}' names its own spells and a spell_list_id", key));
    }

    if (source.spells && source.spells->empty())
    {
        throw std::runtime_error(fmt::format("template '{}' has a spells list that names nothing", key));
    }

    return {
        .Id          = source.id,
        .Name        = key,
        .DisplayName = source.display_name.value_or(key),
        .Species     = yaml::resolveEnum(source.species),
        .Type        = yaml::resolveFlags(source.type),
        .RoamFlags   = yaml::resolveFlags(source.roam),
        .SpellList   = source.spell_list_id.value_or(0),
        .SkillList   = source.skill_list_id.value_or(0),
        .Spells      = source.spells.value_or(std::vector<std::string>{}),
        .Attributes  = convertAttributes(source.attributes, key),
        .Loot        = convertLoot(source.loot, key),
        .Allegiance  = yaml::resolveEnum(source.allegiance),
        .Content     = yaml::resolveEnum(source.content),
    };
}

auto convertRoute(const std::vector<std::vector<float>>& source, const uint32 id) -> std::vector<position_t>
{
    if (source.size() < 2)
    {
        throw std::runtime_error(fmt::format("spawn {} has a route of {} waypoints", id, source.size()));
    }

    std::vector<position_t> route;
    route.reserve(source.size());
    for (const auto& point : source)
    {
        if (point.size() != 3)
        {
            throw std::runtime_error(fmt::format("spawn {} has a waypoint with {} values, not x, y, z", id, point.size()));
        }

        route.emplace_back(point[0], point[1], point[2], 0, 0);
    }

    return route;
}

auto convertSpawn(const uint32 id, const wire::Spawn& source) -> MobSpawnData
{
    // A spawn is placed exactly one way: a point, a region to roam, or a route to walk.
    const auto placements = static_cast<int>(source.at.has_value()) + static_cast<int>(source.region.has_value()) +
                            static_cast<int>(source.path.has_value()) + static_cast<int>(source.circuit.has_value());
    if (placements > 1)
    {
        throw std::runtime_error(fmt::format("spawn {} sets more than one of at, region, path and circuit", id));
    }

    const auto level = source.level.value_or(std::array<uint8, 2>{});

    MobSpawnData spawn{
        .Id           = id,
        .ActIndex     = static_cast<uint16>(id & 0xFFF),
        .TemplateName = source.templateRef.value_or(std::string{}),
        .Script       = source.script.value_or(std::string{}),
        .Placed       = placements > 0,
        .Position     = shared::toPosition(source.at, fmt::format("spawn {}", id)),
        .MinLevel     = level[0],
        .MaxLevel     = level[1],
        .Region       = source.region.value_or(std::string{}),
        .Attributes   = convertAttributes(source.attributes, fmt::format("spawn {}", id)),
    };

    if (source.circuit)
    {
        spawn.Route = convertRoute(*source.circuit, id);
    }
    else if (source.path)
    {
        // walking back along the legs is the same circuit with the return trip spelled out
        spawn.Route = convertRoute(*source.path, id);
        for (size_t index = spawn.Route.size() - 1; index > 0; --index)
        {
            spawn.Route.push_back(spawn.Route[index - 1]);
        }
    }

    return spawn;
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto document = yaml::read<YamlDocument>(text);

    Records records;

    if (document.templates)
    {
        for (const auto& [key, source] : *document.templates)
        {
            records.Templates.try_emplace(key, convertTemplate(key, source));
        }
    }

    std::unordered_set<uint32> seenIds;

    records.Spawns.reserve(document.spawns.size());
    for (const auto& [key, source] : document.spawns)
    {
        auto entry = convertSpawn(key, source);
        if (!seenIds.emplace(entry.Id).second)
        {
            throw std::runtime_error(fmt::format("duplicate spawn id {}", key));
        }

        if (entry.TemplateName.empty())
        {
            if (entry.Script.empty())
            {
                throw std::runtime_error(fmt::format("spawn {} has neither a template nor a script", key));
            }
        }
        else
        {
            const auto declared = records.Templates.find(entry.TemplateName);
            if (declared == records.Templates.end())
            {
                throw std::runtime_error(fmt::format("spawn {} references unknown template '{}'", key, entry.TemplateName));
            }

            // Most spawns are named after their template, so the script is only written when it differs.
            if (entry.Script.empty())
            {
                entry.Script = declared->second.Name;
            }
        }

        records.Spawns.emplace_back(std::move(entry));
    }

    if (document.slots)
    {
        // A slot has no id of its own: its place in the list is the id, which only has to be unique within the zone.
        records.Slots.reserve(document.slots->size());
        for (const auto& source : *document.slots)
        {
            MobSlotData slot{ .Id = static_cast<uint32>(records.Slots.size() + 1) };
            slot.Members.reserve(source.members.size());

            uint32 weighted = 0;
            for (const auto& [id, member] : source.members)
            {
                if (!seenIds.contains(id))
                {
                    throw std::runtime_error(fmt::format("slot {} lists {}, which no spawn declares", slot.Id, id));
                }

                weighted += member.chance.value_or(0);
                slot.Members.emplace_back(MobSlotMemberData{
                    .ActIndex = static_cast<uint16>(id & 0xFFF),
                    .Chance   = member.chance.value_or(0),
                    .Cooldown = member.cooldown.value_or(0),
                });
            }

            if (weighted > 100)
            {
                throw std::runtime_error(fmt::format("slot {} allocates {}% across its weighted members", slot.Id, weighted));
            }

            records.Slots.emplace_back(std::move(slot));
        }
    }

    return records;
}

void Dataset::verifyZone(const Records& records, const xi::ZoneId zoneId)
{
    for (const auto& spawn : records.Spawns)
    {
        const auto owner = (spawn.Id >> 12) & 0xFFF;
        if (owner != static_cast<uint32>(zoneId))
        {
            throw std::runtime_error(fmt::format("spawn 0x{:08X} belongs to zone {}, not {}", spawn.Id, owner, static_cast<uint32>(zoneId)));
        }
    }
}

} // namespace xi::data::datasets::zones::mobs
