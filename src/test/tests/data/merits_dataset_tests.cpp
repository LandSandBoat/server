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

// Invariants merit.cpp and charutils rely on when reading data/merits.yaml.

#include "map/data/datasets/merits/dataset.h"
#include "map/data/loader.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <optional>
#include <utility>
#include <vector>

namespace
{

using MeritsDataset = xi::data::datasets::merits::Dataset;

auto merits() -> const xi::data::Merits*
{
    static const auto loaded = xi::data::loadDataset<MeritsDataset>();
    return &loaded;
}

} // namespace

TEST_CASE("merits: every category resolves its own slice", "[data][merit]")
{
    const auto& records = *merits();

    size_t covered = 0;
    for (const auto& category : records.Categories)
    {
        REQUIRE(category.Count > 0);
        REQUIRE(category.Offset + category.Count <= records.Entries.size());

        // Ids may have gaps, but they stay inside the category, even, and ordered.
        for (uint8 position = 0; position < category.Count; ++position)
        {
            const auto& entry  = records.Entries[category.Offset + position];
            const auto  offset = std::to_underlying(entry.Id) - std::to_underlying(category.Id);

            CHECK(entry.Category == category.Id);
            CHECK(offset >= 0);
            CHECK(offset < 64);
            CHECK(offset % 2 == 0);

            if (position > 0)
            {
                CHECK(entry.Id > records.Entries[category.Offset + position - 1].Id);
            }
        }

        covered += category.Count;
    }

    CHECK(covered == records.Entries.size());
}

TEST_CASE("merits: skills map to the merit that raises them", "[data][merit]")
{
    const auto& records = *merits();

    const auto meritFor = [&records](const xi::SkillType skill)
    {
        const auto match = records.MeritBySkill.find(skill);
        if (match == records.MeritBySkill.end())
        {
            return std::optional<xi::Merit>{};
        }

        return std::optional{ match->second };
    };

    CHECK(meritFor(xi::SkillType::Dagger) == xi::Merit::DaggerSkill);
    CHECK(meritFor(xi::SkillType::Guard) == xi::Merit::GuardingSkill);
    CHECK(meritFor(xi::SkillType::Parry) == xi::Merit::ParryingSkill);

    // Crafting skills are never merited.
    CHECK(!meritFor(xi::SkillType::Smithing).has_value());
}

TEST_CASE("merits: level caps cover every level", "[data][merit]")
{
    const auto& caps = merits()->LevelCaps;

    // GetMeritValue indexes this with a raw character level, so every slot is filled.
    CHECK(caps[0] == 0);
    CHECK(caps[9] == 0);
    CHECK(caps[10] == 1);
    CHECK(caps[49] == 4);
    CHECK(caps[50] == 5);
    CHECK(caps[74] == 9);
    CHECK(caps[75] == 10);
    CHECK(caps[79] == 10);
    CHECK(caps[80] == 15);
    CHECK(caps[99] == 15);

    // Past the last breakpoint the cap holds rather than falling back to zero.
    CHECK(caps[255] == 15);
}

TEST_CASE("merits: a merit only grants what it names", "[data][merit]")
{
    const auto& records = *merits();

    const auto find = [&records](const xi::Merit id)
    {
        return std::ranges::find(records.Entries, id, &xi::data::MeritData::Id);
    };

    // Thunderstorm is a blood pact whose name collides with the scholar spell.
    const auto thunderstorm = find(xi::Merit::Thunderstorm);
    REQUIRE(thunderstorm != records.Entries.end());
    CHECK(thunderstorm->Spell.empty());

    const auto exenterator = find(xi::Merit::Exenterator);
    REQUIRE(exenterator != records.Entries.end());
    CHECK(exenterator->WeaponSkill == "exenterator");
    CHECK(exenterator->Spell.empty());

    // Weapon skill unlocks belong to the weapon skill category and nowhere else.
    for (const auto& entry : records.Entries)
    {
        if (!entry.WeaponSkill.empty())
        {
            CHECK(entry.Category == xi::MeritCategory::WeaponSkills);
        }
    }
}

TEST_CASE("merits: a category job list reaches its merits", "[data][merit]")
{
    const auto& records = *merits();

    const auto find = [&records](const xi::Merit id)
    {
        return std::ranges::find(records.Entries, id, &xi::data::MeritData::Id);
    };

    const auto applies = [](const auto& entry, const xi::Job job)
    {
        return std::ranges::contains(entry->Jobs, job);
    };

    // berserk_recast writes no jobs of its own and inherits war_group_1's list.
    const auto berserk = find(xi::Merit::BerserkRecast);
    REQUIRE(berserk != records.Entries.end());
    CHECK(berserk->Jobs == std::vector{ xi::Job::WAR });

    // max_hp writes no jobs anywhere, so it applies to every job.
    const auto maxHp = find(xi::Merit::MaxHp);
    REQUIRE(maxHp != records.Entries.end());
    CHECK(applies(maxHp, xi::Job::GEO));
    CHECK(applies(maxHp, xi::Job::RUN));

    // great_sword_skill writes its own list, overriding the category.
    const auto greatSword = find(xi::Merit::GreatSwordSkill);
    REQUIRE(greatSword != records.Entries.end());
    CHECK(!applies(greatSword, xi::Job::WHM));
    CHECK(applies(greatSword, xi::Job::PLD));
}
