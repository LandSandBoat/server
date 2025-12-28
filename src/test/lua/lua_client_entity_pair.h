/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#pragma once

#include "helpers/lua_client_entity_pair_actions.h"
#include "helpers/lua_client_entity_pair_bcnm.h"
#include "helpers/lua_client_entity_pair_entities.h"
#include "helpers/lua_client_entity_pair_events.h"
#include "helpers/lua_client_entity_pair_packets.h"
#include "lua_test_entity.h"

#include <memory>
#include <optional>

enum ZONEID : uint16;

class CLuaSimulation;
class TestChar;
class MapEngine;
class CLuaClientEntityPair : public CLuaTestEntity
{
public:
    CLuaClientEntityPair(std::unique_ptr<TestChar> testChar, CLuaSimulation* simulation, MapEngine* mapServer);
    ~CLuaClientEntityPair() override;

    void tick();
    void gotoZone(ZONEID zoneId, sol::optional<sol::table> pos);
    auto isPendingZone() const -> bool;
    auto getItemInvSlot(uint16 itemId, uint8 quantity) const -> std::optional<uint16>;
    void claimAndKillMob(const sol::object& mobQuery, sol::optional<sol::table> params);
    void claimAndKillMobs(sol::variadic_args mobQueries);

    auto actions() -> CLuaClientEntityPairActions;
    auto bcnm() -> CLuaClientEntityPairBCNM;
    auto events() -> CLuaClientEntityPairEvents;
    auto entities() -> CLuaClientEntityPairEntities;
    auto packets() -> CLuaClientEntityPairPackets;

    auto testChar() const -> TestChar*;
    auto simulation() const -> CLuaSimulation*;

    static void Register();

private:
    std::unique_ptr<TestChar> testChar_;
    CLuaSimulation*           simulation_;
    MapEngine*                engine_;
};
