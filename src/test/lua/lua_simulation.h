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

#include "common/cbasetypes.h"
#include "entities/baseentity.h"
#include "lua_client_entity_pair.h"

#include <sol/forward.hpp>

enum class TickType : uint8_t;
class InMemorySink;
class MapEngine;
class CLuaBaseEntity;

enum class REGION_TYPE : uint8;
enum NATION_TYPE : uint8;

enum class ClientScope : uint8_t
{
    Suite,   // Created during setup() - persists for duration of suite
    TestCase // Created during before_each() or test - cleaned up after each test case
};

struct ClientInfo
{
    std::unique_ptr<CLuaClientEntityPair> client;
    ClientScope                           scope{ ClientScope::TestCase };
};

class CLuaSimulation
{
public:
    CLuaSimulation(MapEngine* _mapServer, const std::shared_ptr<InMemorySink>& _sink);

    CLuaSimulation(const CLuaSimulation&)            = delete;
    CLuaSimulation& operator=(const CLuaSimulation&) = delete;
    CLuaSimulation(CLuaSimulation&&)                 = default;
    CLuaSimulation& operator=(CLuaSimulation&&)      = default;

    void cleanClients(std::optional<ClientScope> scope = std::nullopt);
    void tick(std::optional<TickType> boundary = std::nullopt) const;
    void processClientUpdates() const;
    void tickEntity(CLuaBaseEntity& entity) const;
    void skipTime(uint32 seconds) const;
    void setVanaTime(uint8 vanaHour, uint8 vanaMinute) const;
    void setVanaDay(uint8 day) const;
    void skipToNextVanaDay() const;
    void setRegionOwner(REGION_TYPE region, NATION_TYPE nation) const;
    void setSeed(uint64 seed) const;
    void seed() const;
    void setSetupContext(bool inSetup);
    auto spawnPlayer(sol::optional<sol::table> params) -> CLuaClientEntityPair*;

    static void Register();

private:
    std::vector<ClientInfo>       clients_;
    bool                          inSetupContext_{ false };
    MapEngine*                    engine_{ nullptr };
    std::shared_ptr<InMemorySink> sink_{ nullptr };
};
