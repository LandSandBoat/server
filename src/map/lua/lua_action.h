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

#ifndef _LUAACTION_H
#define _LUAACTION_H

#include "../../common/cbasetypes.h"
#include "luautils.h"

struct action_t;
struct actionList_t;
class CLuaAction
{
    action_t* m_PLuaAction;

public:

    static const char className[];
    static Lunar<CLuaAction>::Register_t methods[];

    CLuaAction(lua_State*);
    CLuaAction(action_t*);

    action_t* GetAction() const
    {
        return m_PLuaAction;
    }

    int32 ID(lua_State*);
    int32 recast(lua_State*);
    int32 actionID(lua_State*);
    int32 param(lua_State*);
    int32 messageID(lua_State*);
    int32 animation(lua_State*);
    int32 speceffect(lua_State*);
    int32 reaction(lua_State*);
    int32 addEffectParam(lua_State*);
    int32 addEffectMessage(lua_State*);
    int32 additionalEffect(lua_State*);
};

#endif
