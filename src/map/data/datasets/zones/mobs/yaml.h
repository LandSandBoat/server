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
#include "data/enums/allegiance.h"
#include "data/enums/content.h"
#include "data/enums/drop_rate.h"
#include "data/enums/mob_type.h"
#include "data/enums/roam_flag.h"
#include "data/enums/species.h"
#include "data/shared_types/mob_attributes/yaml.h"
#include "data/yaml/enum_token.h"

#include <glaze/glaze.hpp>

#include <array>
#include <map>
#include <optional>
#include <string>
#include <variant>
#include <vector>

namespace xi::data::datasets::zones::mobs::wire
{

// A drop rate can be DropRate enum
// chance: uncommon
//
// Or a floating percentage
// chance: 70.5
using Chance = std::variant<yaml::EnumToken<xi::DropRate>, double>;

// Array form for even-odds items.
// one_of: [fire_cluster, ice_cluster]
//
// Map form for weighted chances. Must sum to 100. 'nothing' is a valid name.
// one_of:
//   fire_cluster: 80.0
//   ice_cluster:  10.0
//   nothing:      10.0
using OneOf = std::variant<std::vector<std::string>, std::map<std::string, double>>;

// A mob has one stealable item. A few name several because the source was ambiguous.
using Steal = std::variant<std::string, std::vector<std::string>>;

struct Loot
{
    struct Roll
    {
        Chance                     chance{};
        std::optional<std::string> item;   // TODO: Use actual item enums
        std::optional<OneOf>       one_of; // TODO: Use actual item enums
    };

    std::optional<std::vector<Roll>>             drops;
    std::optional<Steal>                         steal;
    std::optional<std::map<std::string, uint16>> despoil; // TODO: This may need to move to species level
};

struct Template
{
    uint32                                                    id{};
    std::optional<std::string>                                display_name;
    yaml::EnumToken<xi::Species>                              species;
    std::optional<std::vector<yaml::EnumToken<xi::MobType>>>  type;
    std::optional<std::vector<yaml::EnumToken<xi::RoamFlag>>> roam;
    std::optional<std::vector<std::string>>                   spells;
    std::optional<uint16>                                     spell_list_id; // superseded by spells
    std::optional<uint16>                                     skill_list_id; // TODO: Bring in actual skills rather than a global list
    std::optional<shared::MobAttributes>                      attributes;
    std::optional<Loot>                                       loot;

    std::optional<yaml::EnumToken<xi::Allegiance>> allegiance;
    std::optional<yaml::EnumToken<xi::Content>>    content;
};

struct Spawn
{
    std::optional<std::string>                     templateRef;
    std::optional<std::string>                     script;
    std::optional<std::vector<float>>              at;
    std::optional<std::string>                     region;
    std::optional<std::vector<std::vector<float>>> path;
    std::optional<std::vector<std::vector<float>>> circuit;
    std::optional<std::array<uint8, 2>>            level;
    std::optional<shared::MobAttributes>           attributes;
};

struct Slot
{
    struct Member
    {
        std::optional<uint8>  chance;
        std::optional<uint32> cooldown;
    };

    std::map<uint32, Member> members;
};

struct Document
{
    std::optional<std::map<std::string, Template>> templates;
    std::map<uint32, Spawn>                        spawns;
    std::optional<std::vector<Slot>>               slots;
};

} // namespace xi::data::datasets::zones::mobs::wire

template <>
struct glz::json_schema<xi::data::datasets::zones::mobs::wire::Loot::Roll>
{
    glz::schema chance{ .description = "How often this roll yields anything: one of the drop_rate names, or a percentage between 0 and 100 when it falls between them." };
    glz::schema item{ .description = "The item it yields. Use one_of instead when the roll picks between several." };
    glz::schema one_of{ .description = "What the roll picks between once it fires. A list shares it evenly, a mapping gives each a percentage, and those must total 100. 'nothing' is a valid outcome." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::mobs::wire::Loot>
{
    glz::schema drops{ .description = "Rolls made when the mob dies. Each is independent." };
    glz::schema steal{ .description = "What Steal can take. A list means the source named several and one is picked at random." };
    glz::schema despoil{ .description = "What Despoil can take. One is picked uniformly at random. Rates not yet implemented." };
};

template <>
struct glz::meta<xi::data::datasets::zones::mobs::wire::Spawn>
{
    using T = xi::data::datasets::zones::mobs::wire::Spawn;

    // `template` is a keyword, so the member cannot carry the YAML key's name.
    static constexpr auto modify = glz::object("template", &T::templateRef);
};

template <>
struct glz::json_schema<xi::data::datasets::zones::mobs::wire::Slot::Member>
{
    glz::schema chance{
        .description = "Not implemented: no zone sets one, so a slot always picks uniformly among its members.",
        .minimum     = 0L,
        .maximum     = 100L,
    };
    glz::schema cooldown{ .description = "Seconds this member should stay out of the roll after its own death. Recorded but not yet implemented." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::mobs::wire::Slot>
{
    glz::schema members{ .description = "Spawns competing for this slot, keyed by entity id. Only one is alive at a time." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::mobs::wire::Template>
{
    glz::schema id{ .description = "Pool id this template came from. To be deprecated." };
    glz::schema display_name{ .description = "Name sent to the client when it differs from the label." };
    glz::schema species{ .description = "Species in data/ecosystems.yaml. Its attributes, and its family's and ecosystem's, are the base this template overrides." };
    glz::schema type{ .description = "Mob classification flags, such as notorious. Defaults to an empty list.", .uniqueItems = true };
    glz::schema roam{ .description = "Roaming behaviour flags. Defaults to an empty list.", .uniqueItems = true };
    glz::schema spells{ .description = "Spells this mob casts. Mutually exclusive with spell_list_id.", .uniqueItems = true };
    glz::schema spell_list_id{ .description = "Spell list id. Defaults 0, meaning none. Mutually exclusive with spells." };
    glz::schema skill_list_id{ .description = "Mob skill list id. Defaults to 0, meaning none." };
    glz::schema attributes{ .description = "Attribute overrides applied over the species chain. Same block families and species use." };
    glz::schema loot{ .description = "What this mob yields when killed, stolen from or despoiled." };
    glz::schema allegiance{ .description = "Who this mob fights for. Defaults to mob." };
    glz::schema content{ .description = "Content tag gating these spawns. Omitted means always enabled." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::mobs::wire::Spawn>
{
    glz::schema templateRef{ .description = "Template this spawn instantiates. Omitting disables this spawn entirely." };
    glz::schema script{ .description = "Script identity, resolving to scripts/zones/<zone>/mobs/<script>.lua. Defaults to the template name." };
    glz::schema at{ .description = "A fixed spawn point, as x, y, z and optionally a facing of 0-255. Mutually exclusive with region, path and circuit." };
    glz::schema region{ .description = "Name of a region in regions.yaml to spawn and roam in. Mutually exclusive with at, path and circuit." };
    glz::schema path{ .description = "Patrol route as x, y, z waypoints. Walked out and back, retracing the same legs, then looped for as long as the mob is left alone. Mutually exclusive with at, region and circuit." };
    glz::schema circuit{ .description = "Patrol route as x, y, z waypoints. Walked as a closed loop, the last waypoint leading back to the first. Mutually exclusive with at, region and path." };
    glz::schema level{ .description = "Minimum and maximum level. Defaults to 0, 0." };
    glz::schema attributes{ .description = "Attribute overrides for this spawn alone, applied over its template." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::mobs::wire::Document>
{
    glz::schema templates{ .description = "Templates this zone owns, keyed by name." };
    glz::schema spawns{ .description = "Spawn points keyed by their fully qualified entity id." };
    glz::schema slots{ .description = "Mutually exclusive spawn sets. One member of each is alive at a time." };
};
