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

#ifndef _CITEMUSABLE_H
#define _CITEMUSABLE_H

#include "common/cbasetypes.h"

#include "item.h"

class CItemUsable : public CItem
{
public:
    CItemUsable(uint16);
    virtual ~CItemUsable();

    uint8  getUseDelay() const;
    uint8  getCurrentCharges();
    uint8  getMaxCharges() const;
    uint16 getAnimationID() const;
    uint16 getAnimationTime() const;
    uint16 getActivationTime() const;
    uint16 getValidTarget() const;
    uint32 getReuseTime();
    uint32 getReuseDelay() const;
    uint32 getLastUseTime();
    uint32 getNextUseTime();
    uint16 getAoE() const;

    void setUseDelay(uint8 UseDelay);
    void setCurrentCharges(uint8 CurrCharges);
    void setMaxCharges(uint8 MaxCharges);
    void setAnimationID(uint16 Animation);
    void setAnimationTime(uint16 AnimationTime);
    void setActivationTime(uint16 ActivationTime);
    void setValidTarget(uint16 ValidTarget);
    void setReuseDelay(uint32 ReuseDelay);
    void setLastUseTime(uint32 LastUseTime);
    void setAssignTime(uint32 VanaTime);
    void setAoE(uint16 AoE);

private:
    uint8  m_UseDelay;
    uint8  m_MaxCharges;
    uint16 m_Animation;
    uint16 m_AnimationTime;
    uint16 m_ActivationTime;
    uint16 m_ValidTarget;
    uint32 m_ReuseDelay;
    uint32 m_AssignTime;
    uint16 m_AoE;
};

#endif
