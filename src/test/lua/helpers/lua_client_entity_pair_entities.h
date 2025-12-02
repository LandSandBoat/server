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

#include <sol/sol.hpp>

class CLuaBaseEntity;
class CLuaTestEntity;
class CLuaClientEntityPair;
class CLuaClientEntityPairEntities
{
public:
    CLuaClientEntityPairEntities(CLuaClientEntityPair* parent);
    ~CLuaClientEntityPairEntities() = default;

    auto get(const sol::object& entityQuery) const -> std::optional<CLuaTestEntity>;
    auto moveTo(const sol::object& entityQuery) const -> std::optional<CLuaTestEntity>;
    auto gotoAndTrigger(const sol::object& entityQuery, const sol::optional<sol::table>& expectedEvent) const -> std::optional<CLuaTestEntity>;

    static void Register();

private:
    CLuaClientEntityPair* parent_;
};
