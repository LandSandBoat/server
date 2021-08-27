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

    friend std::ostream& operator<<(std::ostream& out, const CStatusEffect& effect);

    uint32 getType();
    uint32 getSubType();
    uint16 getPower();
    uint16 getSubPower();
    uint16 getTier();
    uint32 getDuration();
    uint32 getStartTime();
    uint32 getLastTick();
    uint32 getTimeRemaining();
    uint32 getTickCount();
    uint32 getTick();

    void setIcon(uint16 icon);
    void setPower(uint16 power);
    void setSubPower(uint16 subpower);
    void setTier(uint16 tier);
    void setDuration(uint32 duration);
    void setTick(uint32 tick);

    void setStartTime(uint32 time);
    void resetStartTime();

    void   addMod(uint16 mod, int16 amount);
    uint32 getFlag();
    void   setFlag(uint32 flag);
    void   unsetFlag(uint32 flag);

    static void Register();
};

#endif
