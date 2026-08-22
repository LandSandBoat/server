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

// Invariants LoadMOBList relies on, checked against West Ronfaure.

#include "map/data/datasets/zones/mobs/dataset.h"
#include "map/data/loader.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <ranges>
#include <stdexcept>
#include <string>
#include <vector>

namespace
{

using MobsDataset = xi::data::datasets::zones::mobs::Dataset;

auto westRonfaure() -> const xi::data::Mobs&
{
    static const auto loaded = xi::data::loadZoneFile<MobsDataset>(xi::ZoneId::WestRonfaure);
    REQUIRE(loaded.has_value());
    return *loaded;
}

auto spawnAt(const uint32 id) -> const xi::data::MobSpawnData&
{
    const auto& spawns = westRonfaure().Spawns;
    const auto  entry  = std::ranges::find(spawns, id, &xi::data::MobSpawnData::Id);
    REQUIRE(entry != spawns.end());
    return *entry;
}

auto templateNamed(const std::string& name) -> const xi::data::MobTemplateData&
{
    const auto entry = westRonfaure().Templates.find(name);
    REQUIRE(entry != westRonfaure().Templates.end());
    return entry->second;
}

} // namespace

// keyed by id in the file, so a repeat means two collapsed
TEST_CASE("mobs: every spawn in a zone has its own id", "[data][mob]")
{
    std::vector<uint32> ids;
    for (const auto& spawn : westRonfaure().Spawns)
    {
        ids.push_back(spawn.Id);
    }

    std::ranges::sort(ids);
    REQUIRE(std::ranges::adjacent_find(ids) == ids.end());
}

TEST_CASE("mobs: spawns with no template still reserve their id", "[data][mob]")
{
    const auto& spawn = spawnAt(17187301);

    REQUIRE(spawn.TemplateName.empty());
    REQUIRE(spawn.Script == "Wayward_Worm");
    REQUIRE_FALSE(spawn.Placed);
}

TEST_CASE("mobs: a spawn id carries its zone and act index", "[data][mob]")
{
    const auto& spawn = spawnAt(17186822);

    REQUIRE(((spawn.Id >> 12) & 0xFFF) == static_cast<uint32>(xi::ZoneId::WestRonfaure));
    REQUIRE(spawn.ActIndex == (17186822 & 0xFFF));
    REQUIRE(spawn.TemplateName == "Wild_Rabbit");
    REQUIRE(spawn.Placed);
}

TEST_CASE("mobs: every template a spawn names exists", "[data][mob]")
{
    const auto& mobs = westRonfaure();

    for (const auto& spawn : mobs.Spawns)
    {
        if (!spawn.TemplateName.empty())
        {
            REQUIRE(mobs.Templates.contains(spawn.TemplateName));
        }
    }
}

TEST_CASE("mobs: a template keeps its pool id and respawn", "[data][mob]")
{
    const auto& rabbit = templateNamed("Wild_Rabbit");

    REQUIRE(rabbit.Id == 4343);
    REQUIRE(rabbit.Attributes.Respawn.value_or(0) == 60);
}

TEST_CASE("mobs: loot is named inline on the template", "[data][mob]")
{
    const auto& rabbit = templateNamed("Wild_Rabbit");

    REQUIRE(rabbit.Loot.Drops.size() == 2);
    REQUIRE(rabbit.Loot.Drops[0].Item == "slice_of_hare_meat");
    REQUIRE(rabbit.Loot.Drops[0].Chance == 150);
    REQUIRE(rabbit.Loot.Steal.size() == 1);
    REQUIRE(rabbit.Loot.Steal[0] == "san_dorian_carrot");
    REQUIRE(rabbit.Loot.Despoil.size() == 2);
    REQUIRE(rabbit.Loot.Despoil[0].first == "rabbit_hide");
}

TEST_CASE("mobs: a roll names one item or a set, never both", "[data][mob]")
{
    const auto& mobs = westRonfaure();

    const auto weighted = std::ranges::find_if(mobs.Templates,
                                               [](const auto& entry)
                                               {
                                                   return std::ranges::any_of(entry.second.Loot.Drops,
                                                                              [](const auto& roll)
                                                                              {
                                                                                  return !roll.OneOf.empty();
                                                                              });
                                               });

    REQUIRE(weighted != mobs.Templates.end());

    for (const auto& roll : weighted->second.Loot.Drops)
    {
        if (!roll.OneOf.empty())
        {
            REQUIRE(roll.Item.empty());
            REQUIRE(roll.OneOf.size() > 1);
        }
    }
}

TEST_CASE("mobs: slot members resolve to declared spawns", "[data][mob]")
{
    const auto& mobs = westRonfaure();

    size_t members = 0;
    for (const auto& slot : mobs.Slots)
    {
        REQUIRE_FALSE(slot.Members.empty());
        members += slot.Members.size();

        for (const auto& member : slot.Members)
        {
            REQUIRE(std::ranges::any_of(mobs.Spawns,
                                        [&member](const xi::data::MobSpawnData& spawn)
                                        {
                                            return spawn.ActIndex == member.ActIndex;
                                        }));
        }
    }

    REQUIRE(members == 161);
}

TEST_CASE("mobs: a template keeps its resist ranks", "[data][mob]")
{
    const auto& bomb = templateNamed("Bomb");

    REQUIRE(bomb.Id == 490);
    REQUIRE(bomb.Attributes.Aggressive.value_or(false));
    REQUIRE(bomb.Attributes.Resists.at(xi::Mod::FIRE_RES_RANK) == -3);
    REQUIRE(bomb.Attributes.Resists.at(xi::Mod::ICE_RES_RANK) == 4);
}

TEST_CASE("mobs: a template keeps its mods and mob mods", "[data][mob]")
{
    const auto& digger = templateNamed("Goblin_Digger_near");

    REQUIRE(digger.Attributes.Mods.at(xi::Mod::VERMIN_KILLER) == 5);
    REQUIRE(digger.Attributes.MobMods.at(xi::MobMod::NoDespawn) == 1);
    REQUIRE(digger.Attributes.Links.value_or(false));
}

TEST_CASE("mobs: a spawn naming an unknown template is rejected", "[data][mob]")
{
    constexpr auto unknownTemplate = R"(
templates: {}
spawns:
  17186822: { template: Missing_Template, script: Test }
)";

    REQUIRE_THROWS_AS(MobsDataset::decode(unknownTemplate), std::runtime_error);
}

TEST_CASE("mobs: a slot naming an undeclared spawn is rejected", "[data][mob]")
{
    constexpr auto danglingSlot = R"(
templates: {}
spawns:
  17186822: { script: Test }
slots:
  - members:
      17186999: {}
)";

    REQUIRE_THROWS_AS(MobsDataset::decode(danglingSlot), std::runtime_error);
}

TEST_CASE("mobs: a loot chance is a named rate or its own percentage", "[data][mob]")
{
    constexpr auto rates = R"(
templates:
  Forest_Hare:
    id: 1
    species: rabbit
    loot:
      drops:
        - chance: very_rare
          item: hare_meat
        - chance: 2.5
          item: rabbit_hide
        - chance: 100
          item: giant_femur
spawns: {}
)";

    const auto  records = MobsDataset::decode(rates);
    const auto& drops   = records.Templates.at("Forest_Hare").Loot.Drops;
    REQUIRE(drops[0].Chance == 10);
    REQUIRE(drops[1].Chance == 25);
    REQUIRE(drops[2].Chance == 1000);

    constexpr auto tooLikely = R"(
templates:
  Forest_Hare:
    id: 1
    species: rabbit
    loot:
      drops:
        - chance: 150
          item: hare_meat
spawns: {}
)";

    REQUIRE_THROWS_AS(MobsDataset::decode(tooLikely), std::runtime_error);
}

TEST_CASE("mobs: a one_of shares the roll evenly or by percentage", "[data][mob]")
{
    constexpr auto both = R"(
templates:
  Forest_Hare:
    id: 1
    species: rabbit
    loot:
      drops:
        - chance: rare
          one_of: [hare_meat, rabbit_hide, nothing]
        - chance: rare
          one_of:
            giant_femur: 62.5
            hare_meat:   37.5
spawns: {}
)";

    const auto  records = MobsDataset::decode(both);
    const auto& drops   = records.Templates.at("Forest_Hare").Loot.Drops;

    // an even split carries no weights
    REQUIRE(drops[0].OneOf == std::vector<std::pair<std::string, uint16>>{ { "hare_meat", 1 }, { "rabbit_hide", 1 }, { "nothing", 1 } });

    // percentages become basis points, 10000 to the roll
    REQUIRE(drops[1].OneOf == std::vector<std::pair<std::string, uint16>>{ { "giant_femur", 6250 }, { "hare_meat", 3750 } });

    constexpr auto shortOfWhole = R"(
templates:
  Forest_Hare:
    id: 1
    species: rabbit
    loot:
      drops:
        - chance: rare
          one_of:
            giant_femur: 60
            hare_meat:   30
spawns: {}
)";

    REQUIRE_THROWS_AS(MobsDataset::decode(shortOfWhole), std::runtime_error);
}

TEST_CASE("mobs: a slot cannot allocate more than the whole roll", "[data][mob]")
{
    constexpr auto overAllocated = R"(
templates: {}
spawns:
  17186822: { script: Placeholder }
  17186823: { script: Notorious }
slots:
  - members:
      17186822: {chance: 60}
      17186823: {chance: 60}
)";

    REQUIRE_THROWS_AS(MobsDataset::decode(overAllocated), std::runtime_error);
}

TEST_CASE("mobs: a weighted member keeps its chance and cooldown", "[data][mob]")
{
    constexpr auto lottery = R"(
templates: {}
spawns:
  17186822: { script: Damselfly }
  17186823: { script: Valkurm_Emperor }
slots:
  - members:
      17186822: {}
      17186823: {chance: 10, cooldown: 28800}
)";

    const auto records = MobsDataset::decode(lottery);
    REQUIRE(records.Slots.size() == 1);

    const auto& members = records.Slots.front().Members;
    REQUIRE(members.size() == 2);

    const auto notorious = std::ranges::find(members, 10, &xi::data::MobSlotMemberData::Chance);
    REQUIRE(notorious != members.end());
    REQUIRE(notorious->Cooldown == 28800);
}

TEST_CASE("mobs: a spawn overrides its template's attributes", "[data][mob]")
{
    constexpr auto perSpawn = R"(
templates:
  Orcish_Fodder:
    id: 1
    species: rabbit
    attributes:
      render:
        look: { type: standard, model: 1 }
      spawn: {respawn: 300}
spawns:
  17186822:
    template: Orcish_Fodder
    at: [1.0, 2.0, 3.0]
  17186823:
    template: Orcish_Fodder
    at: [1.0, 2.0, 3.0]
    attributes:
      spawn:
        respawn: 900
        window: {start: 20, end: 6}
)";

    const auto records = MobsDataset::decode(perSpawn);
    REQUIRE(records.Spawns.size() == 2);

    // first inherits the respawn, second replaces it and adds a window
    const auto inherited  = std::ranges::find(records.Spawns, 17186822u, &xi::data::MobSpawnData::Id);
    const auto overridden = std::ranges::find(records.Spawns, 17186823u, &xi::data::MobSpawnData::Id);
    REQUIRE(inherited != records.Spawns.end());
    REQUIRE(overridden != records.Spawns.end());

    REQUIRE_FALSE(inherited->Attributes.Respawn.has_value());
    REQUIRE(overridden->Attributes.Respawn.value_or(0) == 900);
    REQUIRE(overridden->Attributes.SpawnWindow.has_value());
    REQUIRE(overridden->Attributes.SpawnWindow->first == 20);
}
