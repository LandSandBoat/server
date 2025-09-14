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

#include <memory>
#include <sol/sol.hpp>
#include <string>
#include <vector>

class CLuaSpy;
class CLuaStub;
class MockManager
{
public:
    MockManager();
    ~MockManager();

    auto stub(const std::string& path, const sol::object& mockImpl = sol::lua_nil) -> CLuaStub*;
    auto spy(const std::string& path) -> CLuaSpy*;

    void restoreAll();

private:
    void setAtPath(const std::string& path, const sol::object& value) const;

    std::vector<std::unique_ptr<CLuaSpy>>  spies_;
    std::vector<std::unique_ptr<CLuaStub>> stubs_;
};
