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

#ifndef _LUASPELL_H
#define _LUASPELL_H

#include "../../common/cbasetypes.h"
#include "luautils.h"

class CSpell;
class CLuaSpell
{
    CSpell* m_PLuaSpell;

public:
    CLuaSpell(CSpell*);

    CSpell* GetSpell() const
    {
        return m_PLuaSpell;
    }

    int32 setMsg(lua_State*);
    int32 setAoE(lua_State*);
    int32 setFlag(lua_State*);
    int32 setRadius(lua_State*);
    int32 setAnimation(lua_State*);
    int32 setMPCost(lua_State*);
    int32 canTargetEnemy(lua_State*);
    int32 isAoE(lua_State*);
    int32 tookEffect(lua_State*);
    int32 getTotalTargets(lua_State*);
    int32 getMagicBurstMessage(lua_State*);
    int32 getElement(lua_State*);
    int32 getID(lua_State*);
    int32 getMPCost(lua_State*);
    int32 getSkillType(lua_State*);
    int32 getSpellGroup(lua_State*);
    int32 getFlag(lua_State*);
    int32 castTime(lua_State*);

    static void Register();
};

#endif
