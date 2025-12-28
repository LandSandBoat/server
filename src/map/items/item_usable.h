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

#include "enums/action/animation.h"
#include "item.h"

class CItemUsable : public CItem
{
public:
    CItemUsable(uint16);
    virtual ~CItemUsable();

    timer::duration   getUseDelay() const;
    uint8             getCurrentCharges();
    uint8             getMaxCharges() const;
    auto              getAnimationID() const -> ActionAnimation;
    timer::duration   getAnimationTime() const;
    timer::duration   getActivationTime() const;
    uint16            getValidTarget() const;
    timer::duration   getReuseTime();
    timer::duration   getReuseDelay() const;
    timer::time_point getLastUseTime();
    timer::time_point getNextUseTime();
    uint16            getAoE() const;

    void setUseDelay(timer::duration UseDelay);
    void setCurrentCharges(uint8 CurrCharges);
    void setMaxCharges(uint8 MaxCharges);
    void setAnimationID(uint16 Animation);
    void setAnimationTime(timer::duration AnimationTime);
    void setActivationTime(timer::duration ActivationTime);
    void setValidTarget(uint16 ValidTarget);
    void setReuseDelay(timer::duration ReuseDelay);
    void setLastUseTime(timer::time_point LastUseTime);
    void setAssignTime(timer::time_point VanaTime);
    void setAoE(uint16 AoE);

private:
    timer::duration   m_UseDelay;
    uint8             m_MaxCharges;
    uint16            m_Animation;
    timer::duration   m_AnimationTime;
    timer::duration   m_ActivationTime;
    uint16            m_ValidTarget;
    timer::duration   m_ReuseDelay;
    timer::time_point m_AssignTime;
    timer::time_point m_LastUseTime;
    uint16            m_AoE;
};

#endif
