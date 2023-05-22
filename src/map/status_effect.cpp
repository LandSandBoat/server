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

#include "../common/utils.h"

#include "entities/battleentity.h"
#include "status_effect.h"

#include "status_effect_container.h"
#include <utility>

CStatusEffect::CStatusEffect(EFFECT id, uint16 icon, uint16 power, uint32 tick, uint32 duration, uint32 subid, uint16 subPower, uint16 tier, uint32 flags)
: m_StatusID(id)
, m_SubID(subid)
, m_Icon(icon)
, m_Power(power)
, m_SubPower(subPower)
, m_Tier(tier)
, m_Flag(flags)
, m_TickTime(tick * 1000)
, m_Duration(duration * 1000)
{
    if (m_TickTime < 3000 && m_TickTime != 0)
    {
        ShowWarning("Status Effect tick time less than 3s is no longer supported.  Effect ID: %d", id);
    }
}

CStatusEffect::~CStatusEffect() = default;

const std::string& CStatusEffect::GetName()
{
    return m_Name;
}

void CStatusEffect::SetOwner(CBattleEntity* Owner)
{
    m_POwner = Owner;
}

EFFECT CStatusEffect::GetStatusID()
{
    return m_StatusID;
}

CBattleEntity* CStatusEffect::GetOwner()
{
    return m_POwner;
}

uint32 CStatusEffect::GetSubID() const
{
    return m_SubID;
}

uint16 CStatusEffect::GetType() const
{
    return m_Type;
}

uint8 CStatusEffect::GetSlot() const
{
    return m_Slot;
}

uint16 CStatusEffect::GetIcon() const
{
    return m_Icon;
}

uint16 CStatusEffect::GetPower() const
{
    return m_Power;
}

uint16 CStatusEffect::GetSubPower() const
{
    return m_SubPower;
}

uint16 CStatusEffect::GetTier() const
{
    return m_Tier;
}

uint32 CStatusEffect::GetFlag() const
{
    return m_Flag;
}

uint32 CStatusEffect::GetTickTime() const
{
    return m_TickTime;
}

uint32 CStatusEffect::GetDuration() const
{
    return m_Duration;
}

int CStatusEffect::GetElapsedTickCount() const
{
    return m_tickCount;
}

time_point CStatusEffect::GetStartTime()
{
    return m_StartTime;
}

void CStatusEffect::SetFlag(uint32 Flag)
{
    m_Flag |= Flag;
}

void CStatusEffect::UnsetFlag(uint32 flag)
{
    m_Flag &= ~flag;
}

void CStatusEffect::SetIcon(uint16 Icon)
{
    if (m_POwner == nullptr)
    {
        ShowWarning("m_POwner was null.");
        return;
    }

    m_Icon = Icon;
    m_POwner->StatusEffectContainer->UpdateStatusIcons();
}

void CStatusEffect::SetType(uint16 Type)
{
    m_Type = Type;
}

void CStatusEffect::SetSlot(uint8 Slot)
{
    m_Slot = Slot;
}

void CStatusEffect::SetPower(uint16 Power)
{
    m_Power = Power;
}

void CStatusEffect::SetSubPower(uint16 subPower)
{
    m_SubPower = subPower;
}

void CStatusEffect::SetTier(uint16 tier)
{
    m_Tier = tier;
}

void CStatusEffect::SetDuration(uint32 Duration)
{
    m_Duration = Duration;
}

void CStatusEffect::SetStartTime(time_point StartTime)
{
    m_tickCount = 0;
    m_StartTime = StartTime;
}

void CStatusEffect::SetTickTime(uint32 tick)
{
    m_TickTime = tick;
}

void CStatusEffect::IncrementElapsedTickCount()
{
    ++m_tickCount;
}

void CStatusEffect::SetName(std::string name)
{
    m_Name = std::move(name);
}

void CStatusEffect::addMod(Mod modType, int16 amount)
{
    for (auto& i : modList)
    {
        if (i.getModID() == modType)
        {
            i.setModAmount(i.getModAmount() + amount);
            return;
        }
    }
    modList.emplace_back(modType, amount);
}
