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

#ifndef _LUASTATUSEFFECT_H
#define _LUASTATUSEFFECT_H

#include "../../common/cbasetypes.h"
#include "luautils.h"

class CStatusEffect;
class CLuaStatusEffect
{
    CStatusEffect* m_PLuaStatusEffect;

public:
    CLuaStatusEffect(CStatusEffect*);

    CStatusEffect* GetStatusEffect() const
    {
        return m_PLuaStatusEffect;
    }

    int32 getType(lua_State*);
    int32 getSubType(lua_State*);
    int32 getPower(lua_State*);
    int32 getSubPower(lua_State*);
    int32 getTier(lua_State*);
    int32 getDuration(lua_State*);
    int32 getStartTime(lua_State*);
    int32 getLastTick(lua_State*);
    int32 getTimeRemaining(lua_State*);
    int32 getTickCount(lua_State*);
    int32 getTick(lua_State*);

    int32 setIcon(lua_State*);
    int32 setPower(lua_State*);
    int32 setSubPower(lua_State*);
    int32 setTier(lua_State*);
    int32 setDuration(lua_State*);
    int32 setTick(lua_State*);
    int32 setStartTime(lua_State*);

    int32 resetStartTime(lua_State*);

    int32 addMod(lua_State*);
    int32 getFlag(lua_State*);
    int32 setFlag(lua_State*);
    int32 unsetFlag(lua_State*);

    static void Register(sol::state& lua);
};

#endif
