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

#include "item_usable.h"

#include "common/utils.h"
#include "common/vana_time.h"
#include "enums/action/animation.h"

CItemUsable::CItemUsable(uint16 id)
: CItem(id)
, m_UseDelay(0s)
, m_AnimationTime(0s)
, m_ActivationTime(0s)
, m_ReuseDelay(0s)
{
    setType(ITEM_USABLE);

    m_MaxCharges  = 0;
    m_Animation   = 0;
    m_ValidTarget = 0;
    m_AssignTime  = timer::time_point::min();
    m_LastUseTime = timer::time_point::min();
    m_AoE         = 0;
}

CItemUsable::~CItemUsable() = default;

void CItemUsable::setUseDelay(timer::duration UseDelay)
{
    m_UseDelay = UseDelay;
}

timer::duration CItemUsable::getUseDelay() const
{
    return m_UseDelay;
}

void CItemUsable::setReuseDelay(timer::duration ReuseDelay)
{
    m_ReuseDelay = ReuseDelay;
}

timer::duration CItemUsable::getReuseDelay() const
{
    return m_ReuseDelay;
}

void CItemUsable::setLastUseTime(timer::time_point LastUseTime)
{
    m_LastUseTime              = LastUseTime;
    ref<uint32>(m_extra, 0x04) = earth_time::vanadiel_timestamp(timer::to_utc(LastUseTime));
}

timer::time_point CItemUsable::getLastUseTime()
{
    return m_LastUseTime;
}

timer::time_point CItemUsable::getNextUseTime()
{
    return getLastUseTime() + m_ReuseDelay;
}

void CItemUsable::setCurrentCharges(uint8 CurrCharges)
{
    ref<uint8>(m_extra, 0x01) = std::clamp<uint8>(CurrCharges, 0, m_MaxCharges);
}

uint8 CItemUsable::getCurrentCharges()
{
    return ref<uint8>(m_extra, 0x01);
}

void CItemUsable::setMaxCharges(uint8 MaxCharges)
{
    m_MaxCharges = MaxCharges;
}

uint8 CItemUsable::getMaxCharges() const
{
    return m_MaxCharges;
}

void CItemUsable::setAnimationID(uint16 Animation)
{
    m_Animation = Animation;
}

auto CItemUsable::getAnimationID() const -> ActionAnimation
{
    return static_cast<ActionAnimation>(m_Animation);
}

void CItemUsable::setAnimationTime(timer::duration AnimationTime)
{
    m_AnimationTime = AnimationTime;
}

timer::duration CItemUsable::getAnimationTime() const
{
    return m_AnimationTime;
}

void CItemUsable::setActivationTime(timer::duration ActivationTime)
{
    m_ActivationTime = ActivationTime;
}

timer::duration CItemUsable::getActivationTime() const
{
    return m_ActivationTime;
}

void CItemUsable::setValidTarget(uint16 ValidTarget)
{
    m_ValidTarget = ValidTarget;
}

uint16 CItemUsable::getValidTarget() const
{
    return m_ValidTarget;
}

uint16 CItemUsable::getAoE() const
{
    return m_AoE;
}

void CItemUsable::setAoE(uint16 AoE)
{
    m_AoE = AoE;
}

void CItemUsable::setAssignTime(timer::time_point time)
{
    m_AssignTime = time;
}

timer::duration CItemUsable::getReuseTime()
{
    timer::time_point CurrentTime = timer::now();
    auto              ReuseTime   = std::max<timer::time_point>(m_AssignTime + m_UseDelay, getLastUseTime() + m_ReuseDelay);

    return (ReuseTime > CurrentTime ? ReuseTime - CurrentTime : 0s);
}
