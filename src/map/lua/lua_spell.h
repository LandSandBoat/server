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

#include "common/cbasetypes.h"
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

    friend std::ostream& operator<<(std::ostream& out, const CLuaSpell& spell);

    void   setMsg(uint16 messageID);
    void   setModifier(uint8 modifier);
    void   setAoE(uint8 aoe);
    void   setFlag(uint8 flags);
    void   setRadius(float radius);
    void   setAnimation(uint16 animationID);
    void   setCastTime(uint32 casttime);
    void   setMPCost(uint16 mpcost);
    bool   canTargetEnemy();
    uint8  isAoE();
    bool   tookEffect();
    uint16 getTotalTargets();
    uint16 getMagicBurstMessage();
    uint16 getElement();
    uint16 getID();
    uint16 getMPCost();
    uint8  getSkillType();
    uint8  getSpellGroup();
    uint8  getSpellFamily();
    uint8  getFlag();
    uint32 getCastTime();
    uint32 getPrimaryTargetID();

    static void Register();
};

#endif
