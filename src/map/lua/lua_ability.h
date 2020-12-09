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

#ifndef _LUAABILITY_H
#define _LUAABILITY_H

#include "../../common/cbasetypes.h"
#include "luautils.h"

class CAbility;

class CLuaAbility
{
    CAbility* m_PLuaAbility;

public:

    static const char className[];
    static Lunar<CLuaAbility>::Register_t methods[];

    CLuaAbility(lua_State*);
    CLuaAbility(CAbility*);

    CAbility* GetAbility() const
    {
        return m_PLuaAbility;
    }

    int32 getID(lua_State*);
    int32 getMsg(lua_State*);
    int32 getRecast(lua_State*);
    int32 getRange(lua_State*);
    int32 getName(lua_State*);
    int32 getAnimation(lua_State*);
    int32 setMsg(lua_State*);
    int32 setAnimation(lua_State*);
    int32 setRecast(lua_State*);
    int32 setCE(lua_State*);
    int32 setVE(lua_State*);
    int32 setRange(lua_State*);
};

#endif
