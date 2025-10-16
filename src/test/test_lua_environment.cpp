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

#include "test_lua_environment.h"
#include "common/logging.h"
#include "common/lua.h"
#include "lua/helpers/lua_client_entity_pair_actions.h"
#include "lua/helpers/lua_client_entity_pair_bcnm.h"
#include "lua/helpers/lua_client_entity_pair_entities.h"
#include "lua/helpers/lua_client_entity_pair_events.h"
#include "lua/helpers/lua_client_entity_pair_packets.h"
#include "lua/lua_client_entity_pair.h"
#include "lua/lua_simulation.h"
#include "lua/lua_spy.h"
#include "lua/lua_stub.h"
#include "lua/lua_test_entity.h"
#include "lua/lua_test_entity_assertions.h"
#include "mock_manager.h"

TestLuaEnvironment::TestLuaEnvironment(MockManager* mockManager)
: mockManager_(mockManager)
{
    ShowInfo("Preparing Lua environment for tests");

    // Revert the global tostring function to the original implementation
    lua.set_function("tostring", lua.get<sol::function>("_tostring"));

    registerCoreLuaBindings();
    registerTestSpecificFunctions();
}

// Register core Lua bindings needed for tests
void TestLuaEnvironment::registerCoreLuaBindings() const
{
    CLuaSimulation::Register();
    CLuaClientEntityPairActions::Register();
    CLuaClientEntityPairBCNM::Register();
    CLuaClientEntityPairEntities::Register();
    CLuaClientEntityPairEvents::Register();
    CLuaClientEntityPairPackets::Register();
    CLuaTestEntityAssertions::Register();
    CLuaTestEntity::Register();
    CLuaClientEntityPair::Register();
    CLuaSpy::Register();
    CLuaStub::Register();
}

// Register global functions used to define tests and suites, and for mocking/spying
void TestLuaEnvironment::registerTestSpecificFunctions() const
{
    // clang-format off
    lua.set_function("DebugTest", [](const std::string& message)
    {
        DebugTest(message);
    });

    lua.set_function("InfoTest", [](const std::string& message)
    {
        ShowInfo(message);
    });

    lua.set_function("stub", [this](const std::string& path, const sol::optional<sol::object>& impl)
    {
        return mockManager_->stub(path, impl.value_or(sol::lua_nil));
    });

    // alias mock() to stub() for now
    lua.set_function("mock", [this](const std::string& path, const sol::optional<sol::object>& impl)
    {
        return mockManager_->stub(path, impl.value_or(sol::lua_nil));
    });

    lua.set_function("spy", [this](const std::string& path)
    {
        return mockManager_->spy(path);
    });
    // clang-format on
}
