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

#include "map/transports/voyage.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>

TEST_CASE("Voyage schedule honors boarding and disembarking boundaries", "[transport_voyage]")
{
    const Voyage voyage{
        .offset        = 20,
        .every         = 100,
        .disembarkFrom = 70,
        .boardingEnds  = 10,
    };

    CHECK_FALSE(voyage.carrying(29));
    CHECK(voyage.carrying(30));
    CHECK(voyage.carrying(89));
    CHECK_FALSE(voyage.carrying(90));
    CHECK(voyage.latestCompletedAt(0) == -10);
    CHECK(voyage.latestCompletedAt(89) == -10);
    CHECK(voyage.latestCompletedAt(90) == 90);
    CHECK(voyage.latestCompletedAt(91) == 90);
    CHECK(voyage.latestCompletedAt(190) == 190);
    CHECK(voyage.latestCompletedAt(1007) == 990);
}

TEST_CASE("Voyage schedule handles passenger windows crossing the cycle boundary", "[transport_voyage]")
{
    const Voyage voyage{
        .offset        = 20,
        .every         = 100,
        .disembarkFrom = 10,
        .boardingEnds  = 80,
    };

    CHECK(voyage.carrying(0));
    CHECK(voyage.carrying(29));
    CHECK_FALSE(voyage.carrying(30));
    CHECK_FALSE(voyage.carrying(99));
    CHECK(voyage.carrying(100));
    CHECK(voyage.carrying(129));
    CHECK_FALSE(voyage.carrying(130));
    CHECK(voyage.latestCompletedAt(0) == -70);
    CHECK(voyage.latestCompletedAt(29) == -70);
    CHECK(voyage.latestCompletedAt(30) == 30);
    CHECK(voyage.latestCompletedAt(129) == 30);
    CHECK(voyage.latestCompletedAt(130) == 130);
}

TEST_CASE("Shared voyage schedules complete after both directions finish", "[transport_voyage]")
{
    const Voyage outbound{
        .offset        = 0,
        .every         = 100,
        .disembarkFrom = 40,
        .boardingEnds  = 10,
    };
    const Voyage inbound{
        .offset        = 30,
        .every         = 100,
        .disembarkFrom = 40,
        .boardingEnds  = 10,
    };
    VoyageEndState state;

    CHECK_FALSE(state.update(std::max(outbound.latestCompletedAt(0), inbound.latestCompletedAt(0)), false));
    CHECK(outbound.carrying(39));
    CHECK_FALSE(inbound.carrying(39));
    CHECK_FALSE(outbound.carrying(40));
    CHECK(inbound.carrying(40));
    CHECK_FALSE(state.update(std::max(outbound.latestCompletedAt(40), inbound.latestCompletedAt(40)), outbound.carrying(40) || inbound.carrying(40)));
    CHECK_FALSE(outbound.carrying(70));
    CHECK_FALSE(inbound.carrying(70));
    CHECK(state.update(std::max(outbound.latestCompletedAt(70), inbound.latestCompletedAt(70)), outbound.carrying(70) || inbound.carrying(70)));
}

TEST_CASE("Voyage cleanup does not fire for a completion before startup", "[transport_voyage]")
{
    VoyageEndState state;

    CHECK_FALSE(state.update(100, false));
    CHECK_FALSE(state.update(100, false));
    CHECK(state.update(200, false));
}

TEST_CASE("Voyage cleanup fires immediately at scheduled completion and does not repeat", "[transport_voyage]")
{
    VoyageEndState state;

    CHECK_FALSE(state.update(100, true));
    CHECK(state.update(200, false));
    CHECK_FALSE(state.update(200, false));
    CHECK_FALSE(state.update(200, false));
}

TEST_CASE("Voyage cleanup waits while another leg still carries passengers", "[transport_voyage]")
{
    VoyageEndState state;

    CHECK_FALSE(state.update(100, true));
    CHECK_FALSE(state.update(200, true));
    CHECK_FALSE(state.update(250, true));
    CHECK(state.update(250, false));
    CHECK_FALSE(state.update(250, false));
}

TEST_CASE("Voyage cleanup catches a skipped completion on an empty ride", "[transport_voyage]")
{
    VoyageEndState state;

    CHECK_FALSE(state.update(100, false));
    CHECK(state.update(1000, false));
    CHECK_FALSE(state.update(1000, false));
}

TEST_CASE("Voyage cleanup runs once and leaves later dock spawns for the next voyage", "[transport_voyage]")
{
    VoyageEndState state;

    CHECK_FALSE(state.update(100, true));
    CHECK(state.update(200, false));

    // A later spawn is safe from repeated ticks in the same dock interval.
    CHECK_FALSE(state.update(200, false));
    CHECK_FALSE(state.update(200, false));
    CHECK_FALSE(state.update(200, true));
    CHECK(state.update(300, false));
    CHECK_FALSE(state.update(300, false));
}

TEST_CASE("Voyage cleanup drops an old pending completion when the clock moves backward", "[transport_voyage]")
{
    VoyageEndState state;

    CHECK_FALSE(state.update(1000, true));
    CHECK_FALSE(state.update(1200, true));
    CHECK_FALSE(state.update(900, false));
    CHECK_FALSE(state.update(900, false));
    CHECK(state.update(1100, false));
}
