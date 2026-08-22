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

// Invariants LoadNPCList relies on, checked against West Ronfaure.

#include "map/data/datasets/zones/npcs/dataset.h"
#include "map/data/loader.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <ranges>
#include <stdexcept>
#include <vector>

namespace
{

using NpcsDataset = xi::data::datasets::zones::npcs::Dataset;

auto westRonfaure() -> const xi::data::Npcs&
{
    static const auto loaded = xi::data::loadZoneFile<NpcsDataset>(xi::ZoneId::WestRonfaure);
    REQUIRE(loaded.has_value());
    return *loaded;
}

auto npcAt(const uint32 id) -> const xi::data::NpcData&
{
    const auto& npcs  = westRonfaure();
    const auto  entry = std::ranges::find(npcs, id, &xi::data::NpcData::Id);
    REQUIRE(entry != npcs.end());
    return *entry;
}

auto southernSanDoria() -> const xi::data::Npcs&
{
    static const auto loaded = xi::data::loadZoneFile<NpcsDataset>(xi::ZoneId::SouthernSanDoria);
    REQUIRE(loaded.has_value());
    return *loaded;
}

} // namespace

// keyed by id in the file, so a repeat means two collapsed
TEST_CASE("npcs: every npc in a zone has its own id", "[data][npc]")
{
    std::vector<uint32> ids;
    for (const auto& npc : westRonfaure())
    {
        ids.push_back(npc.Id);
    }

    std::ranges::sort(ids);
    REQUIRE(std::ranges::adjacent_find(ids) == ids.end());
}

TEST_CASE("npcs: omitted fields fall back to their defaults", "[data][npc]")
{
    // deviates only in status, content and display name
    const auto& npc = npcAt(17187483);

    REQUIRE(npc.Script == "Achieve_Master");
    REQUIRE(npc.DisplayName == "Achieve Master");
    REQUIRE(npc.Position.x == 0.0f);
    REQUIRE(npc.Position.y == 0.0f);
    REQUIRE(npc.Position.z == 0.0f);
    REQUIRE(npc.Position.rotation == 0);
    REQUIRE(npc.Position.moving == 0);
    REQUIRE(npc.LookAt == 0);
    REQUIRE(npc.Animation == xi::Animation::None);
    REQUIRE(npc.AnimationSub == 0);
    REQUIRE(npc.Status == xi::Status::Disappear);
    REQUIRE(npc.NameVis == static_cast<xi::NameVis>(0));
    REQUIRE(npc.EntityFlags == static_cast<xi::EntityFlags>(3));
    REQUIRE(npc.NamePrefix == 0);
    REQUIRE(npc.Speed == 50);
    REQUIRE(npc.AnimationSpeed == 50);
    REQUIRE_FALSE(npc.Widescan);
    REQUIRE(npc.Content == xi::Content::Soa);

    // look 0x0000 0x0032: standard, model 50
    REQUIRE(npc.Look[0] == 0);
    REQUIRE(npc.Look[1] == 50);
}

TEST_CASE("npcs: an equipped look keeps every slot", "[data][npc]")
{
    // Aaveleon: look 0100 0003 1C10 1C20 1C30 1C40 1C50 0060 0070 0000
    const auto& npc = npcAt(17187490);

    REQUIRE(npc.Script == "Aaveleon");
    REQUIRE(npc.Look[0] == 1);      // equipped
    REQUIRE(npc.Look[1] == 0x0300); // face 0, race 3
    REQUIRE(npc.Look[2] == 0x101C); // head
    REQUIRE(npc.Look[3] == 0x201C); // body
    REQUIRE(npc.Look[4] == 0x301C); // hands
    REQUIRE(npc.Look[5] == 0x401C); // legs
    REQUIRE(npc.Look[6] == 0x501C); // feet
    REQUIRE(npc.Look[7] == 0x6000); // main
    REQUIRE(npc.Look[8] == 0x7000); // sub
    REQUIRE(npc.Look[9] == 0);      // ranged

    REQUIRE(npc.Status == xi::Status::Normal);
    REQUIRE(npc.EntityFlags == static_cast<xi::EntityFlags>(27));
    REQUIRE(npc.NamePrefix == 32);
    REQUIRE(npc.AnimationSub == 1);
    REQUIRE(npc.Position.rotation == 248);
    REQUIRE(npc.Position.moving == 6);
    REQUIRE(npc.Widescan);
}

TEST_CASE("npcs: a movement flag keeps its high bit", "[data][npc]")
{
    // 0x8001: low bits a MovTime, high bit a flag
    const auto& npc = npcAt(17187513);

    REQUIRE(npc.Position.moving == 0x8001);
    REQUIRE(npc.LookAt == 0);
    REQUIRE(npc.Widescan);
}

TEST_CASE("npcs: name_vis keeps bits no enum member covers", "[data][npc]")
{
    // bit 0x4, no enum member covers it
    REQUIRE(npcAt(17187466).NameVis == static_cast<xi::NameVis>(4));
}

TEST_CASE("npcs: an unknown look type is rejected", "[data][npc]")
{
    constexpr auto wrongType = R"(
npcs:
  17187292:
    script: Test
    render:
      look: { type: hovercraft }
)";

    REQUIRE_THROWS_AS(NpcsDataset::decode(wrongType), std::runtime_error);
}

TEST_CASE("npcs: a door carries the id the client reads, and other npcs carry none", "[data][npc]")
{
    const auto& npcs = southernSanDoria();

    const auto door = std::ranges::find(npcs, 17719443u, &xi::data::NpcData::Id);
    REQUIRE(door != npcs.end());
    REQUIRE(door->DoorId == 811939423u);

    const auto plain = std::ranges::find(npcs, 17719297u, &xi::data::NpcData::Id);
    REQUIRE(plain != npcs.end());
    REQUIRE(plain->Script == "Ceraule");
    REQUIRE_FALSE(plain->DoorId.has_value());
}
