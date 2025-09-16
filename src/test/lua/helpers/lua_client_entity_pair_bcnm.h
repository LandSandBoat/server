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
#include "sol/forward.hpp"

class CLuaClientEntityPair;

class CLuaClientEntityPairBCNM
{
public:
    CLuaClientEntityPairBCNM(CLuaClientEntityPair* parent);

    void killMobs(const sol::optional<sol::table>& params) const;
    void expectWin(sol::optional<sol::table> params) const;
    void enter(const sol::object& npcQuery, uint16 bcnmId, sol::optional<sol::table> items) const;

    static void Register();

private:
    CLuaClientEntityPair* parent_;
};
