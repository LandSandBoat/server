/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#ifndef _LUA_H
#define _LUA_H

#include "lua.hpp"
#include <sol/sol.hpp>

extern sol::state lua;

void lua_init();
auto lua_to_string_depth(sol::object const& obj, std::size_t depth) -> std::string;
auto lua_to_string(sol::variadic_args va) -> std::string;
void lua_print(sol::variadic_args va);
auto lua_fmt(std::string fmtStr, sol::variadic_args va) -> std::string;

#endif // _LUA_H
