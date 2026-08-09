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
#include "data/enums/job.h"
#include "data/enums/skill_type.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <optional>
#include <string>
#include <vector>

namespace xi::data::datasets::merits::wire
{

using JobList   = std::vector<yaml::EnumToken<xi::Job>>;
using SkillList = std::vector<yaml::EnumToken<xi::SkillType>>;

struct Merit
{
    uint16                     id{};
    uint16                     value{};
    std::string                upgrade_cost;
    std::optional<uint8>       max_upgrades;
    std::optional<JobList>     jobs;
    std::optional<SkillList>   skills;
    std::optional<std::string> spell;
    std::optional<std::string> weapon_skill;
};

struct Category
{
    uint16                       id{};
    uint8                        max_upgrades{};
    std::optional<JobList>       jobs;
    std::map<std::string, Merit> merits;
};

struct LevelCap
{
    uint8 level{};
    uint8 cap{};
};

struct Merits
{
    std::map<std::string, std::vector<uint8>> upgrade_costs;
    std::vector<LevelCap>                     level_caps;
    std::map<std::string, Category>           categories;
};

struct Document
{
    Merits merits;

    using YamlRoot = yaml::DatasetRoot<&Document::merits>;
};

} // namespace xi::data::datasets::merits::wire

template <>
struct glz::json_schema<xi::data::datasets::merits::wire::Merit>
{
    glz::schema id{ .description = "Client-facing merit ID. Its category ID plus an even offset.", .minimum = 64L, .maximum = 65535L };
    glz::schema value{ .description = "What one upgrade is worth; the unit depends on the merit.", .minimum = 0L, .maximum = 65535L };
    glz::schema upgrade_cost{ .description = "Upgrade cost table this merit spends from." };
    glz::schema max_upgrades{ .description = "How far this merit can be upgraded. Defaults to the cost table's length and cannot exceed it; zero leaves it visible but unbuyable.", .minimum = 0L, .maximum = 255L };
    glz::schema jobs{ .description = "Jobs this merit applies to. Falls back to the category's list, then to every job.", .uniqueItems = true };
    glz::schema skills{ .description = "Skills this merit raises, each by `value` per upgrade.", .uniqueItems = true };
    glz::schema spell{ .description = "Spell in spell_list the character knows while this merit has any upgrades." };
    glz::schema weapon_skill{ .description = "Weapon skill in weapon_skills the character has while this merit has any upgrades." };
};

template <>
struct glz::json_schema<xi::data::datasets::merits::wire::Category>
{
    glz::schema id{ .description = "Client-facing category ID. Must be a multiple of 64.", .minimum = 64L, .maximum = 65535L };
    glz::schema max_upgrades{ .description = "How many upgrades can be bought across this category.", .minimum = 0L, .maximum = 255L };
    glz::schema jobs{ .description = "Jobs every merit here applies to, unless a merit says otherwise.", .uniqueItems = true };
    glz::schema merits{ .description = "Merits keyed by their canonical name, in ascending ID order." };
};

template <>
struct glz::json_schema<xi::data::datasets::merits::wire::LevelCap>
{
    glz::schema level{ .description = "Character level this cap starts applying at.", .minimum = 0L, .maximum = 255L };
    glz::schema cap{ .description = "Upgrades that count from this level until the next entry.", .minimum = 0L, .maximum = 255L };
};

template <>
struct glz::json_schema<xi::data::datasets::merits::wire::Merits>
{
    glz::schema upgrade_costs{ .description = "Upgrade cost tables keyed by name. Each entry is what that upgrade costs in merit points." };
    glz::schema level_caps{ .description = "How many upgrades of a merit count toward its effect, by character level. Ascending, opening at level 0." };
    glz::schema categories{ .description = "Merit categories keyed by their canonical name, in client menu order." };
};

template <>
struct glz::json_schema<xi::data::datasets::merits::wire::Document>
{
    glz::schema merits{ .description = "Merit categories, plus the cost tables and level caps they reference." };
};
