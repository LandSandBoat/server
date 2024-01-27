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

#include "common/logging.h"
#include "common/timer.h"

#include "lua_statuseffect.h"
#include "status_effect.h"

//======================================================//

CLuaStatusEffect::CLuaStatusEffect(CStatusEffect* StatusEffect)
: m_PLuaStatusEffect(StatusEffect)
{
    if (StatusEffect == nullptr)
    {
        ShowError("CLuaStatusEffect created with nullptr instead of valid CStatusEffect*!");
    }
}

//======================================================//

uint32 CLuaStatusEffect::getEffectType()
{
    return m_PLuaStatusEffect->GetStatusID();
}

//======================================================//

uint32 CLuaStatusEffect::getSubType()
{
    return m_PLuaStatusEffect->GetSubID();
}

//======================================================//

uint16 CLuaStatusEffect::getPower()
{
    return m_PLuaStatusEffect->GetPower();
}

uint16 CLuaStatusEffect::getSubPower()
{
    return m_PLuaStatusEffect->GetSubPower();
}

uint16 CLuaStatusEffect::getTier()
{
    return m_PLuaStatusEffect->GetTier();
}

//======================================================//

uint32 CLuaStatusEffect::getDuration()
{
    return m_PLuaStatusEffect->GetDuration() / 1000;
}

//======================================================//

uint32 CLuaStatusEffect::getStartTime()
{
    return (uint32)std::chrono::duration_cast<std::chrono::milliseconds>(m_PLuaStatusEffect->GetStartTime() - get_server_start_time()).count();
}

/************************************************************************
 *                                                                       *
 * Returns remaining ticks until expiry                                  *
 *                                                                        *
 ************************************************************************/

uint32 CLuaStatusEffect::getLastTick()
{
    uint32 total = 0;

    if (m_PLuaStatusEffect->GetTickTime() != 0)
    {
        uint32 total_ticks   = m_PLuaStatusEffect->GetDuration() / m_PLuaStatusEffect->GetTickTime();
        uint32 elapsed_ticks = m_PLuaStatusEffect->GetElapsedTickCount();
        total                = total_ticks - elapsed_ticks;
    }

    return total;
}

/************************************************************************
 *                                                                       *
 *  Return how long is left until the effect expires (miliseconds)       *
 *                                                                       *
 ************************************************************************/

uint32 CLuaStatusEffect::getTimeRemaining()
{
    uint32 remaining = 0;
    if (m_PLuaStatusEffect->GetDuration() > 0)
    {
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(server_clock::now() - m_PLuaStatusEffect->GetStartTime()).count();
        remaining     = (uint32)std::max(m_PLuaStatusEffect->GetDuration() - duration, std::chrono::seconds::rep{});
    }

    return remaining;
}

/************************************************************************
 *                                                                       *
 *  Returns number of elapsed ticks                                      *
 *                                                                       *
 ************************************************************************/

uint32 CLuaStatusEffect::getTickCount()
{
    return m_PLuaStatusEffect->GetElapsedTickCount();
}

uint32 CLuaStatusEffect::getTick()
{
    return m_PLuaStatusEffect->GetTickTime();
}

//======================================================//

void CLuaStatusEffect::setIcon(uint16 icon)
{
    m_PLuaStatusEffect->SetIcon(icon);
}

//======================================================//

void CLuaStatusEffect::setPower(uint16 power)
{
    m_PLuaStatusEffect->SetPower(power);
}

void CLuaStatusEffect::setSubPower(uint16 subpower)
{
    m_PLuaStatusEffect->SetSubPower(subpower);
}

void CLuaStatusEffect::setTier(uint16 tier)
{
    m_PLuaStatusEffect->SetTier(tier);
}

//======================================================//

void CLuaStatusEffect::setDuration(uint32 duration)
{
    m_PLuaStatusEffect->SetDuration(duration);
}

void CLuaStatusEffect::setTick(uint32 tick)
{
    m_PLuaStatusEffect->SetTickTime(tick);
}

/************************************************************************
 *                                                                       *
 * Restarting the effect                                                 *
 *                                                                       *
 ************************************************************************/

void CLuaStatusEffect::resetStartTime()
{
    m_PLuaStatusEffect->SetStartTime(server_clock::now());
}

void CLuaStatusEffect::setStartTime(uint32 time)
{
    m_PLuaStatusEffect->SetStartTime(get_server_start_time() + std::chrono::milliseconds(time));
}

//======================================================//

void CLuaStatusEffect::addMod(uint16 mod, int16 amount)
{
    m_PLuaStatusEffect->addMod(static_cast<Mod>(mod), amount);
}

//======================================================//

uint32 CLuaStatusEffect::getEffectFlags()
{
    return m_PLuaStatusEffect->GetEffectFlags();
}

void CLuaStatusEffect::setEffectFlags(uint32 flags)
{
    m_PLuaStatusEffect->SetEffectFlags(flags);
}

void CLuaStatusEffect::addEffectFlag(uint32 flag)
{
    m_PLuaStatusEffect->AddEffectFlag(flag);
}

void CLuaStatusEffect::delEffectFlag(uint32 flag)
{
    m_PLuaStatusEffect->DelEffectFlag(flag);
}

bool CLuaStatusEffect::hasEffectFlag(uint32 flag)
{
    return m_PLuaStatusEffect->HasEffectFlag(flag);
}

uint16 CLuaStatusEffect::getIcon()
{
    return m_PLuaStatusEffect->GetIcon();
}

//======================================================//

void CLuaStatusEffect::Register()
{
    SOL_USERTYPE("CStatusEffect", CLuaStatusEffect);
    SOL_REGISTER("getEffectType", CLuaStatusEffect::getEffectType);
    SOL_REGISTER("getSubType", CLuaStatusEffect::getSubType);
    SOL_REGISTER("setIcon", CLuaStatusEffect::setIcon);
    SOL_REGISTER("getPower", CLuaStatusEffect::getPower);
    SOL_REGISTER("setPower", CLuaStatusEffect::setPower);
    SOL_REGISTER("getDuration", CLuaStatusEffect::getDuration);
    SOL_REGISTER("setDuration", CLuaStatusEffect::setDuration);
    SOL_REGISTER("getStartTime", CLuaStatusEffect::getStartTime);
    SOL_REGISTER("getLastTick", CLuaStatusEffect::getLastTick);
    SOL_REGISTER("getTimeRemaining", CLuaStatusEffect::getTimeRemaining);
    SOL_REGISTER("getTickCount", CLuaStatusEffect::getTickCount);
    SOL_REGISTER("resetStartTime", CLuaStatusEffect::resetStartTime);
    SOL_REGISTER("addMod", CLuaStatusEffect::addMod);
    SOL_REGISTER("getSubPower", CLuaStatusEffect::getSubPower);
    SOL_REGISTER("setSubPower", CLuaStatusEffect::setSubPower);
    SOL_REGISTER("getTier", CLuaStatusEffect::getTier);
    SOL_REGISTER("setTier", CLuaStatusEffect::setTier);
    SOL_REGISTER("getTick", CLuaStatusEffect::getTick);
    SOL_REGISTER("setTick", CLuaStatusEffect::setTick);
    SOL_REGISTER("setStartTime", CLuaStatusEffect::setStartTime);
    SOL_REGISTER("getEffectFlags", CLuaStatusEffect::getEffectFlags);
    SOL_REGISTER("setEffectFlags", CLuaStatusEffect::setEffectFlags);
    SOL_REGISTER("addEffectFlag", CLuaStatusEffect::addEffectFlag);
    SOL_REGISTER("delEffectFlag", CLuaStatusEffect::delEffectFlag);
    SOL_REGISTER("hasEffectFlag", CLuaStatusEffect::hasEffectFlag);
    SOL_REGISTER("getIcon", CLuaStatusEffect::getIcon);
}

std::ostream& operator<<(std::ostream& os, const CLuaStatusEffect& effect)
{
    std::string id = effect.GetStatusEffect() ? std::to_string(effect.GetStatusEffect()->GetStatusID()) : "nullptr";
    return os << "CLuaStatusEffect(" << id << ")";
}

//======================================================//
