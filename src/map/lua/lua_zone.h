/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#ifndef _LUAZONE_H
#define _LUAZONE_H

#include "../../common/cbasetypes.h"
#include "../../common/lua/lunar.h"

class CZone;
class CLuaZone
{
    CZone* m_pLuaZone;
public:

    static const char className[];
    static Lunar<CLuaZone>::Register_t methods[];

    CLuaZone(lua_State*);
    CLuaZone(CZone*);

    CZone* GetZone()const
    {
        return m_pLuaZone;
    }

    int32 registerRegion(lua_State*);
    int32 levelRestriction(lua_State*);
    int32 getPlayers(lua_State*);
    int32 getID(lua_State*);
    int32 getRegionID(lua_State*);
    int32 getType(lua_State*);
    int32 getBattlefieldByInitiator(lua_State*);
    int32 battlefieldsFull(lua_State*);
    int32 getWeather(lua_State*);
};

#endif
