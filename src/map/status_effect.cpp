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

#include "common/utils.h"

#include "entities/battleentity.h"
#include "status_effect.h"

#include "status_effect_container.h"
#include <utility>

CStatusEffect::CStatusEffect(EFFECT id, uint16 icon, uint16 power, timer::duration tick, timer::duration duration, uint32 subid, uint16 subPower, uint16 tier, uint32 flags, uint16 sourceType, uint32 sourceTypeParam, uint32 originID)
: m_StatusID(id)
, m_SubID(subid)
, m_Icon(icon)
, m_Power(power)
, m_SubPower(subPower)
, m_Tier(tier)
, m_Flags(flags)
, m_OriginID(originID)
, m_SourceType(sourceType)
, m_SourceTypeParam(sourceTypeParam)
, m_TickTime(tick)
, m_Duration(duration)
{
    if (m_TickTime < 3s && m_TickTime != 0s)
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

auto CStatusEffect::GetSourceType() const -> uint16
{
    return m_SourceType;
}

auto CStatusEffect::GetSourceTypeParam() const -> uint32
{
    return m_SourceTypeParam;
}

auto CStatusEffect::GetOriginID() const -> uint32
{
    return m_OriginID;
}

uint16 CStatusEffect::GetEffectType() const
{
    return m_Type;
}

uint8 CStatusEffect::GetEffectSlot() const
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

uint32 CStatusEffect::GetEffectFlags() const
{
    return m_Flags;
}

timer::duration CStatusEffect::GetTickTime() const
{
    return m_TickTime;
}

timer::duration CStatusEffect::GetDuration() const
{
    return m_Duration;
}

int CStatusEffect::GetElapsedTickCount() const
{
    return m_tickCount;
}

timer::time_point CStatusEffect::GetStartTime()
{
    return m_StartTime;
}

void CStatusEffect::SetEffectFlags(uint32 Flags)
{
    m_Flags = Flags;
}

void CStatusEffect::AddEffectFlag(uint32 Flag)
{
    m_Flags |= Flag;
}

void CStatusEffect::DelEffectFlag(uint32 flag)
{
    m_Flags &= ~flag;
}

bool CStatusEffect::HasEffectFlag(uint32 Flag)
{
    if (m_Flags & Flag)
    {
        return true;
    }
    return false;
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

auto CStatusEffect::SetSource(uint16 sourceType, uint32 sourceTypeParam) -> void
{
    m_SourceType      = sourceType;
    m_SourceTypeParam = sourceTypeParam;
}

auto CStatusEffect::SetOriginID(uint32 originID) -> void
{
    m_OriginID = originID;
}

void CStatusEffect::SetEffectType(uint16 Type)
{
    m_Type = Type;
}

void CStatusEffect::SetEffectSlot(uint8 Slot)
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

void CStatusEffect::SetDuration(timer::duration Duration)
{
    m_Duration = Duration;
}

void CStatusEffect::SetStartTime(timer::time_point StartTime)
{
    m_tickCount = 0;
    m_StartTime = StartTime;
}

void CStatusEffect::SetTickTime(timer::duration tick)
{
    m_TickTime = tick;
}

void CStatusEffect::IncrementElapsedTickCount()
{
    ++m_tickCount;
}

void CStatusEffect::SetEffectName(std::string name)
{
    m_Name = std::move(name);
}

void CStatusEffect::addMod(Mod modType, int16 amount)
{
    // Since an effect's mod list is only applied to entity when adding the effect
    // we need to add the mod to the entity manually if the effect is already applied
    if (m_POwner)
    {
        m_POwner->addModifier(modType, amount);
    }

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

void CStatusEffect::setMod(Mod modType, int16 value)
{
    for (auto& i : modList)
    {
        if (i.getModID() == modType)
        {
            // Since an effect's mod list is only applied to entity when adding the effect
            // we need to add the mod to the entity manually if the effect is already applied
            if (m_POwner)
            {
                m_POwner->addModifier(modType, value - i.getModAmount());
            }

            i.setModAmount(value);
            return;
        }
    }
    modList.emplace_back(modType, value);

    // Since an effect's mod list is only applied to entity when adding the effect
    // we need to add the mod to the entity manually if the effect is already applied
    if (m_POwner)
    {
        m_POwner->addModifier(modType, value);
    }
}
