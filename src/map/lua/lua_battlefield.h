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

#ifndef _LUABATTLEFIELD_H
#define _LUABATTLEFIELD_H

#include "../../common/cbasetypes.h"
#include "luautils.h"

class CBattlefield;

class CLuaBattlefield
{
    CBattlefield* m_PLuaBattlefield;

public:
    static const char                         className[];
    static Lunar<CLuaBattlefield>::Register_t methods[];

    CLuaBattlefield(lua_State*);
    CLuaBattlefield(CBattlefield*);

    CBattlefield* GetBattlefield() const
    {
        return m_PLuaBattlefield;
    }
    int32 getID(lua_State*);
    int32 getArea(lua_State*);
    int32 getTimeLimit(lua_State*);
    int32 getTimeInside(lua_State*);
    int32 getRemainingTime(lua_State*);
    int32 getFightTick(lua_State*);
    int32 getWipeTime(lua_State*);
    int32 getFightTime(lua_State*);
    int32 getPlayers(lua_State*);
    int32 getMobs(lua_State*);
    int32 getNPCs(lua_State*);
    int32 getAllies(lua_State*);
    int32 getRecord(lua_State*);
    int32 getStatus(lua_State*);
    int32 getLocalVar(lua_State*);
    int32 getLastTimeUpdate(lua_State*);
    int32 getInitiator(lua_State*);

    int32 setLastTimeUpdate(lua_State*);
    int32 setTimeLimit(lua_State*);
    int32 setFightTick(lua_State*);
    int32 setWipeTime(lua_State*);
    int32 setRecord(lua_State*);
    int32 setStatus(lua_State*);
    int32 setLocalVar(lua_State*);
    int32 loadMobs(lua_State*);
    int32 spawnLoot(lua_State*);
    int32 insertEntity(lua_State*);
    int32 cleanup(lua_State*);
    int32 win(lua_State*);
    int32 lose(lua_State*);
};

#endif
