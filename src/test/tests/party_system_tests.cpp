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

#include "world/party_system.h"

TEST_CASE("PartySystem: forms, changes and dissolves a party", "[party]")
{
    auto owner   = xi::replica::Owner{};
    auto parties = PartySystem(owner);

    // 1 invites 2 and 3
    parties.join(1, 2);
    parties.join(1, 3);

    const auto partyId = parties.partyOf(1);
    REQUIRE(partyId != 0);
    CHECK(parties.partyOf(3) == partyId);
    CHECK(parties.get(partyId)->leaderId == 1);
    CHECK(parties.get(partyId)->members == std::vector<uint32>{ 1, 2, 3 });

    // already in a party
    parties.join(9, 2);
    CHECK(parties.partyOf(2) == partyId);
    CHECK(parties.partyOf(9) == 0);

    parties.setLeader(3);
    CHECK(parties.get(partyId)->leaderId == 3);

    // the lead passes on when the leader leaves
    parties.leave(3);
    CHECK(parties.partyOf(3) == 0);
    CHECK(parties.get(partyId)->leaderId == 1);

    // down to one member
    parties.leave(2);
    CHECK(parties.get(partyId) == nullptr);
    CHECK(parties.partyOf(1) == 0);
}

TEST_CASE("PartySystem: a full party refuses a seventh member", "[party]")
{
    auto owner   = xi::replica::Owner{};
    auto parties = PartySystem(owner);

    for (auto charId = uint32{ 2 }; charId <= 8; ++charId)
    {
        parties.join(1, charId);
    }

    CHECK(parties.get(parties.partyOf(1))->members.size() == xi::Party::kMaxMembers);
    CHECK(parties.partyOf(7) == 0);

    parties.disband(1);
    CHECK(parties.partyOf(1) == 0);
    CHECK(parties.partyOf(6) == 0);
}

TEST_CASE("PartySystem: a founder who left can form another party", "[party]")
{
    auto owner   = xi::replica::Owner{};
    auto parties = PartySystem(owner);

    parties.join(1, 2);
    parties.join(1, 3);
    const auto first = parties.partyOf(2);

    parties.leave(1);
    parties.join(1, 4);

    CHECK(parties.partyOf(1) != first);
    CHECK(parties.partyOf(2) == first);
    CHECK(parties.get(first)->members == std::vector<uint32>{ 2, 3 });
    CHECK(parties.get(parties.partyOf(1))->members == std::vector<uint32>{ 1, 4 });
}
