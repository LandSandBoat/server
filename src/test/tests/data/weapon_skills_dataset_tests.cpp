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

#include "data/enums/action_target.h"
#include "data/enums/job.h"
#include "data/enums/skill_type.h"
#include "data/enums/weapon_skill.h"
#include "map/data/datasets/weapon_skills/dataset.h"
#include "map/data/yaml/merge.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <array>
#include <fstream>
#include <iterator>
#include <string>
#include <variant>
#include <vector>

namespace
{

using WeaponSkillsDataset = xi::data::datasets::weapon_skills::Dataset;

auto slurp(const std::string& path) -> std::string
{
    std::ifstream input(path, std::ios::binary);
    return { std::istreambuf_iterator<char>(input), std::istreambuf_iterator<char>() };
}

auto find(const xi::data::WeaponSkills& weaponSkills, const xi::WeaponSkill id) -> const xi::data::WeaponSkillData&
{
    const auto it = std::ranges::find(weaponSkills, id, &xi::data::WeaponSkillData::Id);
    REQUIRE(it != weaponSkills.end());
    return *it;
}

} // namespace

TEST_CASE("weapon_skills: targeting and area read from data/weapon_skills.yaml", "[data][weaponskill]")
{
    const auto weaponSkills = WeaponSkillsDataset::decode(slurp("data/weapon_skills.yaml"));

    const auto& combo = find(weaponSkills, xi::WeaponSkill::Combo);
    CHECK(combo.Skill == xi::SkillType::HandToHand);
    CHECK(combo.Level == 5);
    CHECK(combo.Jobs == std::vector{ xi::Job::WAR, xi::Job::MNK, xi::Job::THF, xi::Job::NIN, xi::Job::PUP, xi::Job::DNC });
    CHECK(combo.Range == 3.0f);
    CHECK(combo.Target == xi::ActionTarget::Hostile);
    CHECK_FALSE(combo.Aoe.has_value());

    const auto& sonicThrust = find(weaponSkills, xi::WeaponSkill::SonicThrust);
    REQUIRE(sonicThrust.Aoe.has_value());
    CHECK(std::get<xi::data::AoeConeData>(sonicThrust.Aoe->Shape).Distance == 10.0f);

    const auto& moonlight = find(weaponSkills, xi::WeaponSkill::Moonlight);
    CHECK(moonlight.Target == xi::ActionTarget::Self);
    REQUIRE(moonlight.Aoe.has_value());
    CHECK(moonlight.Aoe->Affects == (xi::ActionTarget::Self | xi::ActionTarget::Party));
}

TEST_CASE("weapon_skills: era module reverts ranged reach and starter levels", "[data][weaponskill]")
{
    const auto modules      = std::array{ slurp("modules/era/data/weapon_skills.yaml") };
    const auto weaponSkills = WeaponSkillsDataset::decode(xi::data::mergeYaml(slurp("data/weapon_skills.yaml"), modules));

    const auto& flamingArrow = find(weaponSkills, xi::WeaponSkill::FlamingArrow);
    CHECK(flamingArrow.Range == 15.0f);
    CHECK(flamingArrow.Level == 10);
    CHECK(find(weaponSkills, xi::WeaponSkill::AsuranFists).Jobs == std::vector{ xi::Job::MNK });
}

TEST_CASE("weapon_skills: an area is a sphere or a cone, not both", "[data][weaponskill]")
{
    const auto modules = std::array{ std::string{ "weapon_skills:\n  sonic_thrust:\n    aoe:\n      sphere: {origin: target, radius: 4}\n" } };

    CHECK_THROWS(WeaponSkillsDataset::decode(xi::data::mergeYaml(slurp("data/weapon_skills.yaml"), modules)));
}
