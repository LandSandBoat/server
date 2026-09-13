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

// What trait.cpp and battleutils expect from data/traits.yaml.

#include "map/data/datasets/traits/dataset.h"
#include "map/data/yaml/merge.h"
#include "map/utils/dataset_loader.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <array>
#include <fstream>
#include <iterator>
#include <string>

namespace
{

using TraitsDataset = xi::data::datasets::traits::Dataset;

auto traitRecords() -> const xi::data::Traits*
{
    static const auto loaded = xi::data::loadDataset<TraitsDataset>();
    return &loaded;
}

auto slurp(const std::string& path) -> std::string
{
    std::ifstream input(path, std::ios::binary);
    return { std::istreambuf_iterator<char>(input), std::istreambuf_iterator<char>() };
}

auto findRank(const xi::data::Traits& traits, const xi::Job job, const xi::Trait trait, const uint8 rank) -> const xi::data::TraitData&
{
    const auto it = std::ranges::find_if(traits,
                                         [&](const xi::data::TraitData& entry)
                                         {
                                             return entry.Job == job && entry.Id == trait && entry.Rank == rank;
                                         });
    REQUIRE(it != traits.end());
    return *it;
}

} // namespace

TEST_CASE("traits: dancer skillchain bonus reaches rank 5", "[data][trait]")
{
    const auto& top = findRank(*traitRecords(), xi::Job::DNC, xi::Trait::SkillchainBonus, 5);
    CHECK(top.Level == 97);
    CHECK(top.Value == 23);
    CHECK(top.Content == xi::Content::Abyssea);
}

TEST_CASE("traits: a rank without modifiers still exists", "[data][trait]")
{
    const auto& alertness = findRank(*traitRecords(), xi::Job::RNG, xi::Trait::Alertness, 1);
    CHECK(alertness.Mod == xi::Mod::NONE);
    CHECK(alertness.Value == 0);
}

TEST_CASE("traits: a lone rank keeps its number", "[data][trait]")
{
    const auto& treasureHunter = findRank(*traitRecords(), xi::Job::THF, xi::Trait::TreasureHunterIi, 2);
    CHECK(treasureHunter.Level == 45);
    CHECK(treasureHunter.Mod == xi::Mod::TREASURE_HUNTER);
}

TEST_CASE("traits: higher ranks come first", "[data][trait]")
{
    const auto& entries = *traitRecords();
    for (std::size_t index = 1; index < entries.size(); ++index)
    {
        const auto& previous = entries[index - 1];
        const auto& current  = entries[index];
        if (previous.Job == current.Job && previous.Id == current.Id)
        {
            CHECK(previous.Rank >= current.Rank);
        }
    }
}

TEST_CASE("traits: era rov module reverts monk max hp boost levels", "[data][trait]")
{
    const auto modules = std::array{ slurp("modules/era/data/rov/traits.yaml") };
    const auto traits  = TraitsDataset::decode(xi::data::mergeYaml(slurp("data/traits.yaml"), modules));

    CHECK(findRank(traits, xi::Job::MNK, xi::Trait::MaxHpBoost, 1).Level == 15);
    CHECK(findRank(traits, xi::Job::MNK, xi::Trait::MaxHpBoost, 2).Level == 35);
    CHECK(findRank(traits, xi::Job::MNK, xi::Trait::MaxHpBoost, 3).Level == 55);
    CHECK(findRank(traits, xi::Job::MNK, xi::Trait::MaxHpBoost, 4).Level == 70);
    CHECK(findRank(traits, xi::Job::MNK, xi::Trait::MaxHpBoost, 4).Value == 180);
}

TEST_CASE("traits: era soa module makes desperate blows merit unlocked", "[data][trait]")
{
    const auto modules = std::array{ slurp("modules/era/data/soa/traits.yaml") };
    const auto traits  = TraitsDataset::decode(xi::data::mergeYaml(slurp("data/traits.yaml"), modules));

    const auto& desperateBlows = findRank(traits, xi::Job::DRK, xi::Trait::DesperateBlows, 1);
    CHECK(desperateBlows.Level == 75);
    CHECK(desperateBlows.Value == 0);
    CHECK(desperateBlows.Merit == xi::Merit::DesperateBlows);
    CHECK(desperateBlows.Content == xi::Content::Toau);

    const auto& recycle = findRank(traits, xi::Job::RNG, xi::Trait::Recycle, 3);
    CHECK(recycle.Level == 75);
    CHECK(recycle.Value == 30);
    CHECK(recycle.Merit == xi::Merit::Recycle);
}

TEST_CASE("traits: a module patch adds a rank and drops another", "[data][trait]")
{
    const auto patch   = std::string{ R"(traits:
  accuracy_bonus:
    jobs:
      drg:
        3: null
      war:
        1: 50
)" };
    const auto modules = std::array{ patch };
    const auto traits  = TraitsDataset::decode(xi::data::mergeYaml(slurp("data/traits.yaml"), modules));

    const auto& war = findRank(traits, xi::Job::WAR, xi::Trait::AccuracyBonus, 1);
    CHECK(war.Level == 50);
    CHECK(war.Mod == xi::Mod::ACC);
    CHECK(war.Value == 10);
    CHECK(findRank(traits, xi::Job::DRG, xi::Trait::AccuracyBonus, 2).Level == 60);
    CHECK(std::ranges::none_of(traits,
                               [](const xi::data::TraitData& entry)
                               {
                                   return entry.Job == xi::Job::DRG && entry.Id == xi::Trait::AccuracyBonus && entry.Rank == 3;
                               }));
}

TEST_CASE("traits: a rank at level 0 is rejected", "[data][trait]")
{
    const auto patch   = std::string{ R"(traits:
  accuracy_bonus:
    jobs:
      rng:
        1: {level: 0}
)" };
    const auto modules = std::array{ patch };

    CHECK_THROWS(TraitsDataset::decode(xi::data::mergeYaml(slurp("data/traits.yaml"), modules)));
}

TEST_CASE("traits: a job rank missing from ranks is rejected", "[data][trait]")
{
    const auto patch   = std::string{ R"(traits:
  accuracy_bonus:
    jobs:
      rng:
        7: 99
)" };
    const auto modules = std::array{ patch };

    CHECK_THROWS(TraitsDataset::decode(xi::data::mergeYaml(slurp("data/traits.yaml"), modules)));
}

TEST_CASE("traits: a rank no job gets is rejected", "[data][trait]")
{
    const auto patch   = std::string{ R"(traits:
  accuracy_bonus:
    ranks:
      7: {acc: 85}
)" };
    const auto modules = std::array{ patch };

    CHECK_THROWS(TraitsDataset::decode(xi::data::mergeYaml(slurp("data/traits.yaml"), modules)));
}

TEST_CASE("traits: a patch on a job rank keeps its content tag", "[data][trait]")
{
    const auto patch   = std::string{ R"(traits:
  accuracy_bonus:
    jobs:
      drg:
        2: {level: 55}
)" };
    const auto modules = std::array{ patch };
    const auto traits  = TraitsDataset::decode(xi::data::mergeYaml(slurp("data/traits.yaml"), modules));

    const auto& drg = findRank(traits, xi::Job::DRG, xi::Trait::AccuracyBonus, 2);
    CHECK(drg.Level == 55);
    CHECK(drg.Content == xi::Content::Toau);
}
