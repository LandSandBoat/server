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
#include "data/enums/element.h"
#include "data/enums/job.h"
#include "data/enums/skill_type.h"
#include "data/enums/skillchain_type.h"
#include "data/enums/ws_unlock.h"
#include "data/shared_types/action_area/yaml.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <optional>
#include <string>
#include <vector>

namespace xi::data::datasets::weapon_skills::wire
{

struct WeaponSkill
{
    uint8                                                           id{};
    yaml::EnumToken<xi::SkillType>                                  skill;
    std::optional<uint16>                                           level;
    std::optional<std::vector<yaml::EnumToken<xi::Job>>>            jobs;
    std::optional<bool>                                             main_job_only;
    std::optional<yaml::EnumToken<xi::WsUnlock>>                    unlock;
    std::optional<yaml::EnumToken<xi::Element>>                     element;
    uint8                                                           animation{};
    std::optional<std::vector<yaml::EnumToken<xi::SkillchainType>>> skillchain;
    float                                                           range{};
    shared::ActionTargets                                           target;
    std::optional<shared::Aoe>                                      aoe;
};

struct Document
{
    std::map<std::string, WeaponSkill> weapon_skills;

    using YamlRoot = yaml::DatasetRoot<&Document::weapon_skills>;
};

} // namespace xi::data::datasets::weapon_skills::wire

template <>
struct glz::json_schema<xi::data::datasets::weapon_skills::wire::WeaponSkill>
{
    glz::schema id{ .description = "Client-facing weapon skill ID.", .minimum = 1L, .maximum = 255L };
    glz::schema skill{ .description = "Weapon type the weapon skill belongs to." };
    glz::schema level{ .description = "Skill level that grants the weapon skill. Omit when only a weapon or an unlock grants it.", .defaultValue = 0, .minimum = 0L, .maximum = 65535L };
    glz::schema jobs{ .description = "Jobs that learn the weapon skill from skill level or an unlock. Omit when only a weapon grants it.", .uniqueItems = true };
    glz::schema main_job_only{ .description = "Only the jobs listed as main job can use it, not as support job.", .defaultValue = false };
    glz::schema unlock{ .description = "Quest unlock the weapon skill also needs." };
    glz::schema element{ .description = "Element of the weapon skill." };
    glz::schema animation{ .description = "Animation ID sent in the action packet.", .minimum = 0L, .maximum = 255L };
    glz::schema skillchain{ .description = "Skillchain properties, highest priority first.", .maxItems = 3UL, .uniqueItems = true };
    glz::schema range{ .description = "How far the target can be, in yalms, on top of both hitboxes.", .minimum = 0L };
    glz::schema target{ .description = "Who the weapon skill can be used on.", .minItems = 1UL, .uniqueItems = true };
    glz::schema aoe{ .description = "Area the weapon skill reaches around its target. Omit for a single target." };
};

template <>
struct glz::json_schema<xi::data::datasets::weapon_skills::wire::Document>
{
    glz::schema weapon_skills{ .description = "Weapon skills keyed by their canonical name, in ID order." };
};
