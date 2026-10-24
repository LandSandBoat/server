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

#include "exdata/timer_info.h"

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
    m_AssignTime  = timer::time_point{};
    m_LastUseTime = timer::time_point{};
    m_AoE         = 0;
}

CItemUsable::CItemUsable(const CItemUsable& other)
: CItem(other)
, m_UseDelay(other.m_UseDelay)
, m_MaxCharges(other.m_MaxCharges)
, m_Animation(other.m_Animation)
, m_AnimationTime(other.m_AnimationTime)
, m_ActivationTime(other.m_ActivationTime)
, m_ValidTarget(other.m_ValidTarget)
, m_ReuseDelay(other.m_ReuseDelay)
, m_AssignTime(other.m_AssignTime)
, m_LastUseTime(other.m_LastUseTime)
, m_AoE(other.m_AoE)
{
}

CItemUsable::~CItemUsable() = default;

void CItemUsable::setUseDelay(timer::duration UseDelay)
{
    m_UseDelay = UseDelay;
}

auto CItemUsable::getUseDelay() const -> timer::duration
{
    return m_UseDelay;
}

void CItemUsable::setReuseDelay(timer::duration ReuseDelay)
{
    m_ReuseDelay = ReuseDelay;
}

auto CItemUsable::getReuseDelay() const -> timer::duration
{
    return m_ReuseDelay;
}

void CItemUsable::setLastUseTime(timer::time_point LastUseTime)
{
    m_LastUseTime                                    = LastUseTime;
    this->exdata<Exdata::ItemTimerInfo>().TimeValue1 = earth_time::vanadiel_timestamp(timer::to_utc(LastUseTime));
}

auto CItemUsable::getLastUseTime() -> timer::time_point
{
    return m_LastUseTime;
}

auto CItemUsable::getNextUseTime() -> timer::time_point
{
    return getLastUseTime() + m_ReuseDelay;
}

void CItemUsable::setCurrentCharges(uint8 CurrCharges)
{
    this->exdata<Exdata::ItemTimerInfo>().RemainingCharges = std::clamp<uint8>(CurrCharges, 0, m_MaxCharges);
}

auto CItemUsable::getCurrentCharges() const -> uint8
{
    return this->exdata<Exdata::ItemTimerInfo>().RemainingCharges;
}

void CItemUsable::setMaxCharges(uint8 MaxCharges)
{
    m_MaxCharges = MaxCharges;
}

auto CItemUsable::getMaxCharges() const -> uint8
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

auto CItemUsable::getAnimationTime() const -> timer::duration
{
    return m_AnimationTime;
}

void CItemUsable::setActivationTime(timer::duration ActivationTime)
{
    m_ActivationTime = ActivationTime;
}

auto CItemUsable::getActivationTime() const -> timer::duration
{
    return m_ActivationTime;
}

void CItemUsable::setValidTarget(uint16 ValidTarget)
{
    m_ValidTarget = ValidTarget;
}

auto CItemUsable::getValidTarget() const -> uint16
{
    return m_ValidTarget;
}

auto CItemUsable::getAoE() const -> uint16
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

auto CItemUsable::getReuseTime() -> timer::duration
{
    timer::time_point CurrentTime = timer::now();
    auto              ReuseTime   = std::max<timer::time_point>(m_AssignTime + m_UseDelay, getLastUseTime() + m_ReuseDelay);

    return (ReuseTime > CurrentTime ? ReuseTime - CurrentTime : 0s);
}
