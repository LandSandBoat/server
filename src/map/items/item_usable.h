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

#pragma once

#include "common/cbasetypes.h"

#include "enums/action/animation.h"
#include "item.h"

class CItemUsable : public CItem
{
public:
    CItemUsable(uint16);
    CItemUsable(const CItemUsable& other);
    virtual ~CItemUsable();

    auto getUseDelay() const -> timer::duration;
    auto getCurrentCharges() const -> uint8;
    auto getMaxCharges() const -> uint8;
    auto getAnimationID() const -> ActionAnimation;
    auto getAnimationTime() const -> timer::duration;
    auto getActivationTime() const -> timer::duration;
    auto getValidTarget() const -> uint16;
    auto getReuseTime() -> timer::duration;
    auto getReuseDelay() const -> timer::duration;
    auto getLastUseTime() -> timer::time_point;
    auto getNextUseTime() -> timer::time_point;
    auto getAoE() const -> uint16;

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
