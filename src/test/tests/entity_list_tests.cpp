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

//
// EntityList_t container-contract tests.
//
// Zone entity lists are FlatHashMap on purpose, and gameplay depends on the
// container semantics locked down here:
//
//   - Iteration happens in INSERTION order. Name-based entity lookups return
//     the first match, so spawn order decides which of several same-named NPCs
//     wins (e.g. the "Cavernous Maw" NPCs in the WotG missions). A container
//     swap that changes iteration order breaks zones in ways only end-to-end
//     tests catch late; these tests catch it at unit level.
//
//   - erase() uses a move-from-back strategy, and inserts can reallocate,
//     invalidating every iterator/pointer/reference. The tests document both
//     hazards so the rules aren't tribal knowledge.
//
// These run via Catch2 during xi_test startup, before the Lua engine boots.
//

#include "map/entities/base_entity.h"
#include "map/zone.h"

#include <catch2/catch_test_macros.hpp>

#include <memory>
#include <string>
#include <type_traits>
#include <vector>

namespace
{

// CBaseEntity is abstract (Tick/PostTick); the tests only need identity and a name.
class TestEntity final : public CBaseEntity
{
public:
    explicit TestEntity(uint16 _targid, std::string _name)
    {
        targid = _targid;
        name   = std::move(_name);
    }

    auto Tick(timer::time_point) -> Task<void> override
    {
        co_return;
    }

    void PostTick() override
    {
    }
};

// The alias the rest of these tests assume. If someone swaps EntityList_t to a
// different container, this fires before any behavioral test gets a chance to
// fail more confusingly.
static_assert(std::is_same_v<EntityList_t, FlatHashMap<uint16, CBaseEntity*>>,
              "EntityList_t changed container type - revisit the iteration-order and invalidation "
              "assumptions documented in zone.h and locked down in entity_list_tests.cpp");

auto makeEntities(const std::vector<std::pair<uint16, std::string>>& specs) -> std::vector<std::unique_ptr<TestEntity>>
{
    std::vector<std::unique_ptr<TestEntity>> out;
    out.reserve(specs.size());
    for (const auto& [targid, name] : specs)
    {
        out.emplace_back(std::make_unique<TestEntity>(targid, name));
    }
    return out;
}

TEST_CASE("EntityList_t iterates in insertion order, not key order", "[entity_list]")
{
    // Keys deliberately scrambled: if iteration were key-ordered or hash-ordered
    // this exact sequence coming back would be a miracle.
    const auto entities = makeEntities({
        { 0x150, "Delta" },
        { 0x002, "Alpha" },
        { 0x1FF, "Echo" },
        { 0x0AB, "Bravo" },
        { 0x001, "Charlie" },
    });

    EntityList_t list;
    for (const auto& entity : entities)
    {
        list[entity->targid] = entity.get();
    }

    std::vector<const CBaseEntity*> seen;
    for (const auto& [targid, PEntity] : list)
    {
        seen.push_back(PEntity);
    }

    REQUIRE(seen.size() == entities.size());
    for (std::size_t i = 0; i < entities.size(); ++i)
    {
        CHECK(seen[i] == entities[i].get());
    }
}

TEST_CASE("first name match is decided by spawn (insertion) order", "[entity_list]")
{
    // Three same-named NPCs, inserted with descending targids so key order and
    // insertion order disagree. A first-match name scan (what zone lookups do)
    // must find the earliest-inserted one.
    const auto entities = makeEntities({
        { 0x300, "Cavernous Maw" },
        { 0x200, "Cavernous Maw" },
        { 0x100, "Cavernous Maw" },
    });

    EntityList_t list;
    for (const auto& entity : entities)
    {
        list[entity->targid] = entity.get();
    }

    const CBaseEntity* firstMatch = nullptr;
    for (const auto& [targid, PEntity] : list)
    {
        if (PEntity->name == "Cavernous Maw")
        {
            firstMatch = PEntity;
            break;
        }
    }

    REQUIRE(firstMatch == entities.front().get());
    CHECK(firstMatch->targid == 0x300);
}

TEST_CASE("erase moves the last element into the erased slot", "[entity_list]")
{
    // ankerl::unordered_dense keeps its elements dense by filling an erased
    // slot with the LAST element. So a despawn reorders the tail: insertion
    // order is only stable for elements in front of every erasure.
    const auto entities = makeEntities({
        { 1, "A" },
        { 2, "B" },
        { 3, "C" },
        { 4, "D" },
    });

    EntityList_t list;
    for (const auto& entity : entities)
    {
        list[entity->targid] = entity.get();
    }

    list.erase(2); // B despawns; D takes its slot

    std::vector<std::string> order;
    for (const auto& [targid, PEntity] : list)
    {
        order.push_back(PEntity->name);
    }

    REQUIRE(order == std::vector<std::string>{ "A", "D", "C" });
}

TEST_CASE("insert can relocate storage: never hold references across an insert", "[entity_list]")
{
    // The canary for the invalidation rule. Growth allocates a new dense array
    // while the old one is still live, so the relocated element's address must
    // differ. If this ever fails, the container gained stable addresses and
    // the "no references across insert" rule can be re-evaluated.
    auto first = std::make_unique<TestEntity>(1, "First");

    EntityList_t list;
    list[first->targid] = first.get();

    const auto* addressBefore = &list.find(1)->second;

    std::vector<std::unique_ptr<TestEntity>> filler;
    for (uint16 targid = 2; targid <= 1024; ++targid)
    {
        filler.emplace_back(std::make_unique<TestEntity>(targid, "Filler"));
        list[targid] = filler.back().get();
    }

    const auto* addressAfter = &list.find(1)->second;

    CHECK(addressBefore != addressAfter);
    CHECK(list.find(1)->second == first.get()); // the value survived the moves intact
}

} // namespace
