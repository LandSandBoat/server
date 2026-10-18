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

#include "data/enums/job.h"
#include "data/enums/skill_rank.h"
#include "data/enums/skill_type.h"
#include "map/data/datasets/skills/dataset.h"
#include "map/data/yaml/merge.h"

#include <catch2/catch_test_macros.hpp>

#include <array>
#include <fstream>
#include <iterator>
#include <string>

namespace
{

using SkillsDataset = xi::data::datasets::skills::Dataset;

auto slurp(const std::string& path) -> std::string
{
    std::ifstream input(path, std::ios::binary);
    return { std::istreambuf_iterator<char>(input), std::istreambuf_iterator<char>() };
}

auto rank(const xi::data::Skills& skills, const xi::SkillType skill, const xi::Job job) -> xi::SkillRank
{
    return static_cast<xi::SkillRank>(skills.Ranks[static_cast<std::size_t>(skill)][static_cast<std::size_t>(job)]);
}

auto cap(const xi::data::Skills& skills, const uint8 level, const xi::SkillRank skillRank) -> uint16
{
    return skills.Caps[level][static_cast<std::size_t>(skillRank)];
}

} // namespace

TEST_CASE("skills: ranks and caps read from data/skills.yaml", "[data][skill]")
{
    const auto skills = SkillsDataset::decode(slurp("data/skills.yaml"));

    CHECK(rank(skills, xi::SkillType::GreatAxe, xi::Job::WAR) == xi::SkillRank::APlus);
    CHECK(rank(skills, xi::SkillType::Dagger, xi::Job::THF) == xi::SkillRank::APlus);
    CHECK(rank(skills, xi::SkillType::Katana, xi::Job::WAR) == xi::SkillRank::None);

    CHECK(cap(skills, 1, xi::SkillRank::APlus) == 6);
    CHECK(cap(skills, 99, xi::SkillRank::APlus) == 424);
    CHECK(cap(skills, 60, xi::SkillRank::G) == 141);
    CHECK(cap(skills, 99, xi::SkillRank::G) == 228);
    CHECK(skills.Caps[0] == std::array<uint16, xi::data::kSkillRanks>{});
}

TEST_CASE("skills: era module reverts the 2014 and 2015 rank increases", "[data][skill]")
{
    const auto modules = std::array{ slurp("modules/era/data/skills.yaml") };
    const auto skills  = SkillsDataset::decode(xi::data::mergeYaml(slurp("data/skills.yaml"), modules));

    CHECK(rank(skills, xi::SkillType::Dagger, xi::Job::THF) == xi::SkillRank::A);
    CHECK(rank(skills, xi::SkillType::Dagger, xi::Job::DNC) == xi::SkillRank::BPlus);
    CHECK(rank(skills, xi::SkillType::Archery, xi::Job::RNG) == xi::SkillRank::A);
    CHECK(rank(skills, xi::SkillType::Dagger, xi::Job::WAR) == xi::SkillRank::BMinus);
}

TEST_CASE("skills: every level from 1 to 99 needs a cap row", "[data][skill]")
{
    auto       text = slurp("data/skills.yaml");
    const auto row  = text.find("\n    50: ");
    text.erase(row, text.find('\n', row + 1) - row);

    CHECK_THROWS(SkillsDataset::decode(text));
}

TEST_CASE("skills: a module cannot add a cap row past level 99", "[data][skill]")
{
    const auto modules = std::array{ std::string{ "skills:\n  caps:\n    100: {a_plus: 1, a: 1, b_plus: 1, b: 1, b_minus: 1, c_plus: 1, c: 1, c_minus: 1, d: 1, e: 1, f: 1, g: 1}\n" } };

    CHECK_THROWS(SkillsDataset::decode(xi::data::mergeYaml(slurp("data/skills.yaml"), modules)));
}
