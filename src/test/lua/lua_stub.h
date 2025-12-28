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

#include "lua_spy.h"

class CLuaStub : public CLuaSpy
{
public:
    CLuaStub(const std::string& path, const sol::object& originalFunc, sol::optional<sol::object> impl = sol::nullopt);
    ~CLuaStub() override;

    void returnValue(const sol::object& value);
    void sideEffect(const sol::protected_function& func);

    auto        operator()(sol::variadic_args args) -> sol::as_returns_t<std::vector<sol::object>> override;
    static void Register();

private:
    sol::optional<sol::object>             returnValue_;
    sol::optional<sol::protected_function> implementation_;
    sol::optional<sol::protected_function> sideEffect_;
};
