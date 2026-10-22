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
#include "data/enums/action_target.h"
#include "data/enums/element.h"
#include "data/enums/job.h"
#include "data/enums/skill_type.h"
#include "data/enums/skillchain_type.h"
#include "data/enums/weapon_skill.h"
#include "data/enums/ws_unlock.h"
#include "data/shared_types/action_area/dataset.h"

#include <optional>
#include <string>
#include <string_view>
#include <vector>

namespace xi::data
{

struct WeaponSkillData
{
    xi::WeaponSkill                 Id{};
    std::string                     Name{};
    xi::SkillType                   Skill{};
    uint16                          Level{}; // skill level that grants it, 0 when only a weapon or an unlock does
    std::vector<xi::Job>            Jobs{};
    bool                            MainJobOnly{};
    xi::WsUnlock                    Unlock{};
    xi::Element                     Element{};
    uint8                           Animation{};
    std::vector<xi::SkillchainType> Skillchain{};
    float                           Range{};
    xi::ActionTarget                Target{};
    std::optional<AoeData>          Aoe{};
};

using WeaponSkills = std::vector<WeaponSkillData>; // ordered by id

} // namespace xi::data

namespace xi::data::datasets::weapon_skills::wire
{

struct Document;

}

namespace xi::data::datasets::weapon_skills
{

struct Dataset
{
    using Records      = WeaponSkills;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "weapon_skills" };
    static constexpr std::string_view kTitle{ "Weapon Skills" };
    static constexpr std::string_view kDescription{ "Weapon skills, who can use them, and their range and area." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::weapon_skills
