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
#include "common/types/hash_map.h"
#include "data/enums/ecosystem.h"
#include "data/enums/job.h"
#include "data/enums/mod.h"
#include "data/enums/monstrosity_instinct.h"
#include "data/enums/monstrosity_species.h"
#include "data/enums/monstrosity_variant.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <array>
#include <map>
#include <optional>
#include <string>
#include <vector>

namespace xi::data::datasets::monstrosity::wire
{

struct TpSkill
{
    std::string skill{};
    uint16      dat_skill_id{};
    uint16      mob_skill_id{};
    uint8       unlock_level{};
    uint16      tp_cost{};
    bool        enabled{ false };
};

struct Species
{
    yaml::EnumToken<xi::MonstrositySpecies> family{};
    uint16                                  species_code{};
    std::string                             name{};
    yaml::EnumToken<xi::Job>                mjob{};
    yaml::EnumToken<xi::Job>                sjob{};
    uint8                                   size{};
    uint16                                  look{};
    yaml::EnumToken<xi::Ecosystem>          ecosystem{};
    std::optional<uint16>                   mob_species;
    std::optional<uint16>                   hp_scale;
    std::optional<std::vector<TpSkill>>     tp_skills;
};

struct Instinct
{
    uint16                                            id{};
    uint8                                             cost{};
    std::string                                       name{};
    std::optional<std::string>                        effect;
    std::optional<yaml::EnumKeyedMap<xi::Mod, int16>> mods;
};

struct ShopSlot
{
    std::optional<yaml::EnumToken<xi::MonstrositySpecies>>           species;
    std::optional<yaml::EnumToken<xi::MonstrosityVariant>>           variant;
    uint16                                                           infamy{};
    std::optional<yaml::EnumKeyedMap<xi::MonstrositySpecies, uint8>> requirements;
};

struct LevelUnlock
{
    std::optional<yaml::EnumToken<xi::MonstrositySpecies>>           species;
    std::optional<yaml::EnumToken<xi::MonstrosityVariant>>           variant;
    std::optional<yaml::EnumKeyedMap<xi::MonstrositySpecies, uint8>> requirements;
};

struct UnlinkedSpecies
{
    uint16               species_code{};
    std::string          name{};
    std::vector<TpSkill> tp_skills{};
};

struct Document
{
    struct Tables
    {
        HashMap<uint8, uint32>                                exp_table;
        std::map<uint8, std::vector<ShopSlot>>                teyrnon_shop;
        std::vector<LevelUnlock>                              level_unlocks;
        std::map<std::string, Instinct>                       instincts;
        std::map<std::string, Species>                        species;
        std::optional<std::map<std::string, UnlinkedSpecies>> unlinked_tp_skills;
    };

    Tables monstrosity;

    using YamlRoot = yaml::DatasetRoot<&Document::monstrosity>;
};

} // namespace xi::data::datasets::monstrosity::wire

template <>
struct glz::json_schema<xi::data::datasets::monstrosity::wire::TpSkill>
{
    glz::schema skill{ .description = "Name of the move, matching its mob_skills row." };
    glz::schema dat_skill_id{ .description = "Id the client sends when the move is used.", .minimum = 1L, .maximum = 65535L };
    glz::schema mob_skill_id{ .description = "mob_skills row that runs when the move resolves.", .minimum = 1L, .maximum = 65535L };
    glz::schema unlock_level{ .description = "Species level the move becomes available at. Mostly unverified.", .minimum = 1L, .maximum = 99L };
    glz::schema tp_cost{ .description = "TP the move costs. A Monipulator spends only this, not the whole bar.", .minimum = 0L, .maximum = 3000L };
    glz::schema enabled{ .description = "Only true once a retail capture has verified the move." };
};

template <>
struct glz::json_schema<xi::data::datasets::monstrosity::wire::Species>
{
    glz::schema family{ .description = "Family whose level this species shares." };
    glz::schema species_code{ .description = "Species code the client and char_monstrosity use.", .minimum = 1L, .maximum = 65535L };
    glz::schema name{ .description = "Display name." };
    glz::schema mjob{ .description = "Main job granted while this species." };
    glz::schema sjob{ .description = "Sub job granted while this species." };
    glz::schema size{ .description = "0 small, 1 medium, 2 large.", .minimum = 0L, .maximum = 2L };
    glz::schema look{ .description = "Model id.", .minimum = 0L, .maximum = 65535L };
    glz::schema ecosystem{ .description = "Ecosystem for correlation. Unclassified correlates with nothing." };
    glz::schema mob_species{ .description = "data/ecosystems.yaml species whose stat ranks the base stats use. Absent keeps the player formula." };
    glz::schema hp_scale{ .description = "Percent applied to the mob HP formula. Defaults to 240.", .minimum = 100L, .maximum = 400L };
    glz::schema tp_skills{ .description = "TP moves this species can use." };
};

template <>
struct glz::json_schema<xi::data::datasets::monstrosity::wire::Instinct>
{
    glz::schema id{ .description = "Instinct id as sent by the client.", .minimum = 1L, .maximum = 65535L };
    glz::schema cost{ .description = "Instinct point cost to equip.", .minimum = 0L, .maximum = 255L };
    glz::schema name{ .description = "Display name." };
    glz::schema effect{ .description = "Effect text from the client item (29696 plus the instinct id)." };
    glz::schema mods{ .description = "Modifiers granted while equipped, keyed by modifier name." };
};

template <>
struct glz::json_schema<xi::data::datasets::monstrosity::wire::ShopSlot>
{
    glz::schema species{ .description = "Family the slot unlocks. Set this or variant." };
    glz::schema variant{ .description = "Variant the slot unlocks. Set this or species." };
    glz::schema infamy{ .description = "Infamy cost, fixed by the client event.", .minimum = 0L, .maximum = 65535L };
    glz::schema requirements{ .description = "Family levels needed before the slot is offered." };
};

template <>
struct glz::json_schema<xi::data::datasets::monstrosity::wire::LevelUnlock>
{
    glz::schema species{ .description = "Family granted at level 1. Set this or variant." };
    glz::schema variant{ .description = "Variant granted. Set this or species." };
    glz::schema requirements{ .description = "Family levels that all have to be reached." };
};

template <>
struct glz::json_schema<xi::data::datasets::monstrosity::wire::UnlinkedSpecies>
{
    glz::schema species_code{ .description = "Species code the old table used.", .minimum = 1L, .maximum = 65535L };
    glz::schema name{ .description = "Species name as it appeared in the old table." };
    glz::schema tp_skills{ .description = "TP moves recorded for that species." };
};

template <>
struct glz::json_schema<xi::data::datasets::monstrosity::wire::Document::Tables>
{
    glz::schema exp_table{ .description = "Exp needed to clear each level." };
    glz::schema teyrnon_shop{ .description = "Teyrnon's shop by menu page. List position is the menu slot." };
    glz::schema level_unlocks{ .description = "Families and variants granted on reaching family levels." };
    glz::schema instincts{ .description = "Instincts keyed by name." };
    glz::schema species{ .description = "Species keyed by name." };
    glz::schema unlinked_tp_skills{ .description = "TP moves whose species is missing from `species`, kept so they are not lost." };
};

template <>
struct glz::json_schema<xi::data::datasets::monstrosity::wire::Document>
{
    glz::schema monstrosity{ .description = "Monstrosity species, instincts, TP moves and the exp curve." };
};
