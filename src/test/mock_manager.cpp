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

#include "mock_manager.h"

#include "common/logging.h"
#include "common/lua.h"
#include "lua/lua_spy.h"
#include "lua/lua_stub.h"
#include "map/lua/luautils.h"

MockManager::MockManager()
{
}

MockManager::~MockManager()
{
    restoreAll();
}

// Installs a stub in the lua global environment at the specified path.
// The path is a dot-separated string representing the table hierarchy.
auto MockManager::stub(const std::string& path, const sol::object& mockImpl) -> CLuaStub*
{
    DebugTestFmt("Installing stub at path: {}", path);

    auto        original = luautils::detail::findGlobalLuaFunction(path);
    const auto& stub     = stubs_.emplace_back(std::make_unique<CLuaStub>(path, original, mockImpl));
    setAtPath(path, sol::make_object(lua, stub.get()));

    return stub.get();
}

// Installs a spy in the lua global environment at the specified path.
// The path is a dot-separated string representing the table hierarchy.
auto MockManager::spy(const std::string& path) -> CLuaSpy*
{
    DebugTestFmt("Installing spy at path: {}", path);

    auto        original = luautils::detail::findGlobalLuaFunction(path);
    const auto& spy      = spies_.emplace_back(std::make_unique<CLuaSpy>(path, original));
    setAtPath(path, sol::make_object(lua, spy.get()));

    return spy.get();
}

// Restores all stubs and spies to their original functions.
void MockManager::restoreAll()
{
    for (const auto& stub : stubs_)
    {
        setAtPath(stub->path(), stub->original());
    }

    for (const auto& spy : spies_)
    {
        setAtPath(spy->path(), spy->original());
    }

    stubs_.clear();
    spies_.clear();
}

// Helper function to set a value at a given path in the lua global environment.
void MockManager::setAtPath(const std::string& path, const sol::object& value) const
{
    auto parts = split(path, ".");
    if (parts.empty())
    {
        return;
    }

    sol::table current = lua.globals();

    for (size_t i = 0; i < parts.size() - 1; ++i)
    {
        current = current[parts[i]];
    }

    current[parts.back()] = value;
}
