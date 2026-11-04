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

#include <common/scheduler/scheduler.h>

#include <map/map_session.h>
#include <map/map_session_container.h>

#include <catch2/catch_test_macros.hpp>

namespace
{

// Above every real and test char id
constexpr auto kCharId = 4000000000U;

} // namespace

TEST_CASE("Releasing a char closes its pending session", "[map][session]")
{
    auto scheduler = Scheduler(1);
    auto sessions  = MapSessionContainer(scheduler);

    REQUIRE(sessions.createPendingSession(kCharId) != nullptr);

    sessions.releaseCharacter(kCharId);

    CHECK(sessions.getPendingSessionByCharId(kCharId) == nullptr);
}

TEST_CASE("Releasing a char closes only a session that is zoning out", "[map][session]")
{
    auto scheduler = Scheduler(1);
    auto sessions  = MapSessionContainer(scheduler);

    auto* session   = sessions.createSession(IPP(kCharId, 1));
    session->charID = kCharId;

    session->blowfish.status = BLOWFISH_ACCEPTED;
    sessions.releaseCharacter(kCharId);
    CHECK(sessions.getSessionByCharId(kCharId) == session);

    session->blowfish.status = BLOWFISH_PENDING_ZONE;
    sessions.releaseCharacter(kCharId);
    CHECK(sessions.getSessionByCharId(kCharId) == nullptr);
}
