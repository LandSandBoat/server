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

#ifndef _LUAINSTANCE_H
#define _LUAINSTANCE_H

#include "../../common/cbasetypes.h"
#include "luautils.h"

class CInstance;
class CLuaInstance
{
    CInstance* m_PLuaInstance;
public:

    static const char className[];
    static Lunar<CLuaInstance>::Register_t methods[];

    CLuaInstance(lua_State*);
    CLuaInstance(CInstance*);

    CInstance* GetInstance() const
    {
        return m_PLuaInstance;
    }

    int32 getID(lua_State*);
    int32 getAllies(lua_State*);
    int32 getChars(lua_State*);
    int32 getMobs(lua_State*);
    int32 getNpcs(lua_State*);
    int32 getPets(lua_State*);
    int32 getTimeLimit(lua_State*);
    int32 getEntryPos(lua_State*);
    int32 getLastTimeUpdate(lua_State*);
    int32 getProgress(lua_State*);
    int32 getWipeTime(lua_State*);
    int32 getEntity(lua_State*);
    int32 getStage(lua_State*);

    int32 setLevelCap(lua_State*);
    int32 setLastTimeUpdate(lua_State*);
    int32 setProgress(lua_State*);
    int32 setWipeTime(lua_State*);
    int32 setStage(lua_State*);

    int32 fail(lua_State*);
    int32 failed(lua_State*);
    int32 complete(lua_State*);
    int32 completed(lua_State*);

    int32 insertAlly(lua_State*);
};

#endif
