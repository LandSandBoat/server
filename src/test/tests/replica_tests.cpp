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

#include <catch2/catch_test_macros.hpp>

#include "common/ipc.h"
#include "common/replica/mirrored.h"
#include "common/replica/owned.h"

#include <deque>
#include <map>
#include <set>
#include <string>
#include <vector>

namespace replica_tests
{

struct Part
{
    uint32      id{};
    std::string name{};

    auto operator==(const Part&) const -> bool = default;
};

struct Crate
{
    uint32                        ownerId{};
    uint32                        shelfId{};
    std::vector<Part>             parts{};
    std::set<uint32>              tags{};
    std::map<std::string, uint32> counts{};
    uint8                         slot{};

    auto operator==(const Crate&) const -> bool = default;
};

struct Shelf
{
    std::vector<uint32> crateIds{};

    auto operator==(const Shelf&) const -> bool = default;
};

struct AddPart
{
    uint64 crateId{};
    uint32 partId{};
};

struct Discard
{
    uint64 crateId{};
};

struct Unhandled
{
    uint64 crateId{};
};

const auto kMap1 = IPP(1, 1);
const auto kMap2 = IPP(2, 2);

// one owner, two mirrors
struct Rig
{
    std::deque<std::pair<IPP, ipc::ReplicaSync>> toOwner;
    std::deque<ipc::ReplicaSync>                 toMap1;
    std::deque<ipc::ReplicaSync>                 toMap2;

    xi::replica::Owner  owner;
    xi::replica::Mirror mirror1;
    xi::replica::Mirror mirror2;

    Rig()
    : mirror1([this](const ipc::ReplicaSync& message)
              {
                  toOwner.emplace_back(kMap1, roundTrip(message));
              })
    , mirror2([this](const ipc::ReplicaSync& message)
              {
                  toOwner.emplace_back(kMap2, roundTrip(message));
              })
    {
        initOwner(1);
    }

    void initOwner(uint32 epoch)
    {
        owner.init(
            { kMap1, kMap2 },
            [this](const IPP& mirror, const ipc::ReplicaSync& message)
            {
                if (mirror == kMap1)
                {
                    toMap1.push_back(roundTrip(message));
                }
                else
                {
                    toMap2.push_back(roundTrip(message));
                }
            },
            epoch);
    }

    // through the real encoder
    static auto roundTrip(const ipc::ReplicaSync& message) -> ipc::ReplicaSync
    {
        const auto decoded = ipc::fromBytesWithHeader<ipc::ReplicaSync>(ipc::toBytesWithHeader(message));
        REQUIRE(decoded.has_value());
        return *decoded;
    }

    void deliver()
    {
        while (!toOwner.empty() || !toMap1.empty() || !toMap2.empty())
        {
            if (!toOwner.empty())
            {
                const auto [from, message] = toOwner.front();
                toOwner.pop_front();
                owner.receive(from, message);
            }

            if (!toMap1.empty())
            {
                const auto message = toMap1.front();
                toMap1.pop_front();
                mirror1.receive(message);
            }

            if (!toMap2.empty())
            {
                const auto message = toMap2.front();
                toMap2.pop_front();
                mirror2.receive(message);
            }
        }
    }

    // one owner pump
    void pump()
    {
        deliver();
        owner.flush();
        deliver();
    }
};

} // namespace replica_tests

using namespace replica_tests;
using xi::replica::Mirrored;
using xi::replica::Owned;

TEST_CASE("Replica: an object written on the owner reaches every mirror", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    auto& map2  = rig.mirror2.store<Crate>();
    rig.pump();

    auto created = 0;
    map1.setOnChange([&](uint64, const Crate* before, const Crate* after)
                     {
                         if (!before && after)
                         {
                             ++created;
                         }
                     });

    world[7] = Crate{ .ownerId = 1, .parts = { { 1, "first" } }, .slot = 1 };
    rig.pump();

    CHECK(created == 1);
    REQUIRE(map1.get(7) != nullptr);
    CHECK(*map1.get(7) == *world.get(7));
    REQUIRE(map2.get(7) != nullptr);
    CHECK(map2.get(7)->slot == 1);
}

TEST_CASE("Replica: the change hook gets the object before and after", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    rig.pump();

    world[7] = Crate{ .ownerId = 1, .tags = { 3 } };
    rig.pump();

    auto updates = 0;
    map1.setOnChange([&](uint64, const Crate* before, const Crate* after)
                     {
                         REQUIRE(before != nullptr);
                         REQUIRE(after != nullptr);
                         ++updates;
                         CHECK(before->ownerId == 1);
                         CHECK(after->ownerId == 3);
                         CHECK(before->parts.empty());
                         CHECK(after->parts.size() == 1);
                         CHECK(before->tags == after->tags);
                     });

    // several writes in one pump arrive as one change
    world[7].parts.push_back({ 2, "second" });
    world[7].ownerId = 2;
    world[7].ownerId = 3;
    rig.owner.flush();
    REQUIRE(rig.toMap1.size() == 1);
    CHECK(rig.toMap1.back().items.size() == 1);
    rig.pump();

    CHECK(updates == 1);

    // nothing changed, nothing sent
    rig.owner.flush();
    CHECK(rig.toMap1.empty());
}

TEST_CASE("Replica: erasing on the owner destroys the copies", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    rig.pump();

    world[1] = Crate{ .ownerId = 10 };
    rig.pump();
    REQUIRE(map1.get(1) != nullptr);

    auto lastOwner = uint32{};
    map1.setOnChange([&](uint64, const Crate* before, const Crate* after)
                     {
                         if (before && !after)
                         {
                             lastOwner = before->ownerId;
                         }
                     });

    world.erase(1);
    rig.pump();

    CHECK(map1.get(1) == nullptr);
    CHECK(lastOwner == 10);
}

TEST_CASE("Replica: a pump is one message per mirror and hooks see all of it", "[replica]")
{
    auto  rig          = Rig{};
    auto& worldCrates  = rig.owner.store<Crate>();
    auto& worldShelves = rig.owner.store<Shelf>();
    auto& mapCrates    = rig.mirror1.store<Crate>();
    auto& mapShelves   = rig.mirror1.store<Shelf>();
    rig.pump();

    worldCrates[1] = Crate{ .ownerId = 10 };
    worldCrates[2] = Crate{ .ownerId = 20 };
    rig.pump();

    auto sawShelf = 0;
    mapCrates.setOnChange([&](uint64, const Crate*, const Crate* after)
                          {
                              if (after && mapShelves.get(after->shelfId) != nullptr)
                              {
                                  ++sawShelf;
                              }
                          });

    worldShelves[100]      = Shelf{ .crateIds = { 1, 2 } };
    worldCrates[1].shelfId = 100;
    worldCrates[2].shelfId = 100;
    rig.owner.flush();

    REQUIRE(rig.toMap1.size() == 1);
    CHECK(rig.toMap1.back().items.size() == 3);
    rig.pump();

    CHECK(sawShelf == 2);
}

TEST_CASE("Replica: a mirror asks, the owner decides, and the change comes back", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    rig.pump();

    world[7] = Crate{ .ownerId = 1, .parts = { { 1, "first" } } };
    rig.pump();

    auto askedBy = IPP();
    world.setOnRequest<AddPart>([&](const IPP& mirror, const AddPart& request)
                                {
                                    askedBy = mirror;
                                    if (world.get(request.crateId)->parts.size() < 2)
                                    {
                                        world[request.crateId].parts.push_back({ request.partId, "second" });
                                    }
                                });

    world.setOnRequest<Discard>([&](const IPP&, const Discard& request)
                                {
                                    world.erase(request.crateId);
                                });

    map1.request(AddPart{ .crateId = 7, .partId = 2 });
    map1.request(AddPart{ .crateId = 7, .partId = 3 });

    // nothing changes on the mirror until the owner answers
    CHECK(map1.get(7)->parts.size() == 1);
    rig.pump();

    CHECK(askedBy == kMap1);
    REQUIRE(map1.get(7)->parts.size() == 2);
    CHECK(map1.get(7)->parts[1].id == 2);

    // a request type nobody handles changes nothing
    map1.request(Unhandled{ .crateId = 7 });
    rig.pump();
    CHECK(map1.get(7) != nullptr);

    // each request type reaches its own handler
    map1.request(Discard{ .crateId = 7 });
    rig.pump();
    CHECK(map1.get(7) == nullptr);
}

TEST_CASE("Replica: an object is streamed only to its audience", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    auto& map2  = rig.mirror2.store<Crate>();
    rig.pump();

    auto everyone = false;
    world.setAudience([&](uint64, const Crate& crate)
                      {
                          if (everyone)
                          {
                              return std::vector<IPP>{ kMap1, kMap2 };
                          }

                          if (crate.slot == 1)
                          {
                              return std::vector<IPP>{ kMap1 };
                          }

                          return std::vector<IPP>{};
                      });

    world[7] = Crate{ .ownerId = 9, .slot = 1 };
    rig.pump();
    CHECK(map1.get(7) != nullptr);
    CHECK(map2.get(7) == nullptr);

    // leaving the audience destroys the copy
    world[7].slot = 0;
    rig.pump();
    CHECK(map1.get(7) == nullptr);
    CHECK(world.get(7) != nullptr);

    // joining it sends the object, with no write needed
    everyone = true;
    rig.pump();
    REQUIRE(map2.get(7) != nullptr);
    CHECK(map2.get(7)->ownerId == 9);
    CHECK(map1.get(7) != nullptr);
}

TEST_CASE("Replica: a store attached late gets only what it is in the audience for", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    world.setAudience([](uint64 id, const Crate&)
                      {
                          if (id == 1)
                          {
                              return std::vector<IPP>{ kMap1, kMap2 };
                          }

                          return std::vector<IPP>{ kMap2 };
                      });

    world[1] = Crate{ .ownerId = 10 };
    world[2] = Crate{ .ownerId = 20 };
    rig.pump();

    auto& map1 = rig.mirror1.store<Crate>();
    rig.pump();

    REQUIRE(map1.get(1) != nullptr);
    CHECK(map1.get(1)->ownerId == 10);
    CHECK(map1.get(2) == nullptr);
}

TEST_CASE("Replica: an unreadable body changes nothing and is repaired when the mirror polls", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    rig.pump();

    world[7] = Crate{ .ownerId = 1, .slot = 1 };
    rig.pump();

    world[7].ownerId = 5;
    rig.owner.flush();
    REQUIRE(rig.toMap1.size() == 1);
    auto corrupt = rig.toMap1.front();
    rig.toMap1.clear();
    corrupt.items.front().body.pop_back();

    rig.mirror1.receive(corrupt);
    CHECK(map1.get(7)->ownerId == 1);
    CHECK_FALSE(rig.mirror1.synced());

    rig.mirror1.poll();
    rig.pump();
    CHECK(map1.get(7)->ownerId == 5);
    CHECK(rig.mirror1.synced());
}

TEST_CASE("Replica: an owner restart that changes nothing fires no hook", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    rig.pump();

    world[1] = Crate{ .ownerId = 10 };
    world[2] = Crate{ .ownerId = 20 };
    rig.pump();

    auto destroyed = 0;
    auto others    = 0;
    map1.setOnChange([&](uint64, const Crate* before, const Crate* after)
                     {
                         if (before && !after)
                         {
                             ++destroyed;
                         }
                         else
                         {
                             ++others;
                         }
                     });

    // the owner comes back holding only one of them
    world.erase(2);
    rig.owner.flush();
    rig.toMap1.clear();
    rig.initOwner(2);
    rig.pump();

    CHECK(destroyed == 1);
    CHECK(others == 0);
    REQUIRE(map1.get(1) != nullptr);
    CHECK(map1.get(1)->ownerId == 10);
    CHECK(map1.get(2) == nullptr);
}

TEST_CASE("Replica: a mirror that missed the restart catches up when it polls", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    rig.pump();

    world[1] = Crate{ .ownerId = 10 };
    rig.pump();

    // announcement and the next update are lost
    rig.initOwner(2);
    world[1].ownerId = 11;
    rig.owner.flush();
    rig.toMap1.clear();
    rig.toMap2.clear();

    rig.mirror1.poll();
    rig.pump();

    REQUIRE(map1.get(1) != nullptr);
    CHECK(map1.get(1)->ownerId == 11);
}

TEST_CASE("Replica: a lost update is repaired by the next message", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    rig.pump();

    world[1] = Crate{ .ownerId = 10 };
    world[2] = Crate{ .ownerId = 20 };
    rig.pump();

    auto changes = 0;
    map1.setOnChange([&](uint64, const Crate*, const Crate*)
                     {
                         ++changes;
                     });

    world[1].ownerId = 11;
    rig.owner.flush();
    rig.toMap1.clear();

    world[2].ownerId = 21;
    rig.pump();

    CHECK(map1.get(1)->ownerId == 11);
    CHECK(map1.get(2)->ownerId == 21);
    CHECK(changes == 2);
    CHECK(rig.mirror1.synced());
}

TEST_CASE("Replica: a lost last message is repaired when the mirror polls", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();
    rig.pump();

    world[1] = Crate{ .ownerId = 10 };
    world[2] = Crate{ .ownerId = 20 };
    rig.pump();

    // an update and a destroy, both lost
    world[1].ownerId = 11;
    world.erase(2);
    rig.owner.flush();
    rig.toMap1.clear();
    rig.pump();
    CHECK(map1.get(1)->ownerId == 10);
    CHECK(map1.get(2) != nullptr);

    rig.mirror1.poll();
    rig.pump();

    CHECK(map1.get(1)->ownerId == 11);
    CHECK(map1.get(2) == nullptr);
}

TEST_CASE("Replica: a lost snapshot is asked for again", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    rig.pump();

    world[1] = Crate{ .ownerId = 10 };
    rig.pump();

    // the answer to the first request never arrives
    auto& map1 = rig.mirror1.store<Crate>();
    REQUIRE(rig.toOwner.size() == 1);
    rig.owner.receive(rig.toOwner.front().first, rig.toOwner.front().second);
    rig.toOwner.clear();
    rig.toMap1.clear();
    CHECK(map1.get(1) == nullptr);

    rig.mirror1.poll();
    rig.pump();

    REQUIRE(map1.get(1) != nullptr);
    CHECK(map1.get(1)->ownerId == 10);
}

TEST_CASE("Replica: a request sent before the first sync is not sent", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    auto& map1  = rig.mirror1.store<Crate>();

    auto asked = 0;
    world.setOnRequest<Discard>([&](const IPP&, const Discard&)
                                {
                                    ++asked;
                                });

    CHECK_FALSE(rig.mirror1.synced());
    const auto queued = rig.toOwner.size();
    map1.request(Discard{ .crateId = 7 });
    CHECK(rig.toOwner.size() == queued);

    rig.pump();
    CHECK(rig.mirror1.synced());
    map1.request(Discard{ .crateId = 7 });
    rig.pump();
    CHECK(asked == 1);
}

TEST_CASE("Replica: a lost request for a store added late is asked for again", "[replica]")
{
    auto  rig   = Rig{};
    auto& world = rig.owner.store<Crate>();
    world[1]    = Crate{ .ownerId = 10 };
    rig.pump();
    CHECK(rig.mirror1.synced());

    auto& map1 = rig.mirror1.store<Crate>();
    rig.toOwner.clear();
    rig.pump();
    CHECK(map1.get(1) == nullptr);
    CHECK_FALSE(rig.mirror1.synced());

    rig.mirror1.poll();
    rig.pump();

    REQUIRE(map1.get(1) != nullptr);
    CHECK(map1.get(1)->ownerId == 10);
    CHECK(rig.mirror1.synced());
}

TEST_CASE("Replica: stores added late arrive together", "[replica]")
{
    auto  rig         = Rig{};
    auto& worldCrates = rig.owner.store<Crate>();
    auto& worldShelf  = rig.owner.store<Shelf>();
    worldShelf[100]   = Shelf{ .crateIds = { 1 } };
    worldCrates[1]    = Crate{ .ownerId = 10, .shelfId = 100 };
    rig.pump();

    auto& mapCrates  = rig.mirror1.store<Crate>();
    auto& mapShelves = rig.mirror1.store<Shelf>();

    auto sawShelf = 0;
    mapCrates.setOnChange([&](uint64, const Crate*, const Crate* after)
                          {
                              if (after && mapShelves.get(after->shelfId) != nullptr)
                              {
                                  ++sawShelf;
                              }
                          });

    rig.pump();

    CHECK(sawShelf == 1);
    CHECK(rig.mirror1.synced());
}
