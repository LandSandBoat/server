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

#include "../../common/showmsg.h"
#include "../../common/timer.h"

#include "../status_effect.h"
#include "lua_statuseffect.h"

//======================================================//

CLuaStatusEffect::CLuaStatusEffect(CStatusEffect* StatusEffect)
{
    m_PLuaStatusEffect = StatusEffect;
}

//======================================================//

inline int32 CLuaStatusEffect::getType(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetStatusID());
    return 1;
}

//======================================================//

inline int32 CLuaStatusEffect::getSubType(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetSubID());
    return 1;
}

//======================================================//

inline int32 CLuaStatusEffect::getPower(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetPower());
    return 1;
}

inline int32 CLuaStatusEffect::getSubPower(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetSubPower());
    return 1;
}

inline int32 CLuaStatusEffect::getTier(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetTier());
    return 1;
}

//======================================================//

inline int32 CLuaStatusEffect::getDuration(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetDuration() / 1000);
    return 1;
}

//======================================================//

inline int32 CLuaStatusEffect::getStartTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L,
                    (lua_Integer)std::chrono::duration_cast<std::chrono::milliseconds>(m_PLuaStatusEffect->GetStartTime() - get_server_start_time()).count());
    return 1;
}

/************************************************************************
 *                                                                       *
 * Returns remaining ticks until expiry                                  *
 *																		*
 ************************************************************************/

inline int32 CLuaStatusEffect::getLastTick(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    long long total = 0;

    if (m_PLuaStatusEffect->GetTickTime() != 0)
    {
        auto total_ticks   = m_PLuaStatusEffect->GetDuration() / m_PLuaStatusEffect->GetTickTime();
        auto elapsed_ticks = m_PLuaStatusEffect->GetElapsedTickCount();
        total              = total_ticks - elapsed_ticks;
    }
    lua_pushinteger(L, (lua_Integer)total);
    return 1;
}

/************************************************************************
 *                                                                       *
 *  Return how long is left until the effect expires (miliseconds)       *
 *                                                                       *
 ************************************************************************/

inline int32 CLuaStatusEffect::getTimeRemaining(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);
    uint32 remaining = 0;
    if (m_PLuaStatusEffect->GetDuration() > 0)
    {
        remaining = (uint32)std::max((m_PLuaStatusEffect->GetDuration() -
                                      std::chrono::duration_cast<std::chrono::milliseconds>(server_clock::now() - m_PLuaStatusEffect->GetStartTime()).count()),
                                     std::chrono::seconds::rep{});
    }

    lua_pushinteger(L, remaining);
    return 1;
}

/************************************************************************
 *                                                                       *
 *  Returns number of elapsed ticks                                      *
 *                                                                       *
 ************************************************************************/

inline int32 CLuaStatusEffect::getTickCount(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetElapsedTickCount());
    return 1;
}

inline int32 CLuaStatusEffect::getTick(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetTickTime());
    return 1;
}

//======================================================//

inline int32 CLuaStatusEffect::setIcon(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->SetIcon((uint16)lua_tointeger(L, 1));
    return 0;
}

//======================================================//

inline int32 CLuaStatusEffect::setPower(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->SetPower((uint16)lua_tointeger(L, 1));
    return 0;
}

inline int32 CLuaStatusEffect::setSubPower(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->SetSubPower((uint16)lua_tointeger(L, 1));
    return 0;
}

inline int32 CLuaStatusEffect::setTier(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->SetTier((uint16)lua_tointeger(L, 1));
    return 0;
}

//======================================================//

inline int32 CLuaStatusEffect::setDuration(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->SetDuration((uint32)lua_tointeger(L, 1));
    return 0;
}

inline int32 CLuaStatusEffect::setTick(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->SetTickTime((uint32)lua_tointeger(L, 1));
    return 0;
}

/************************************************************************
 *                                                                       *
 *  Перезапускаем эффект                                                 *
 *                                                                       *
 ************************************************************************/

inline int32 CLuaStatusEffect::resetStartTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    m_PLuaStatusEffect->SetStartTime(server_clock::now());
    return 0;
}

inline int32 CLuaStatusEffect::setStartTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->SetStartTime(get_server_start_time() + std::chrono::milliseconds(lua_tointeger(L, 1)));
    return 0;
}

//======================================================//

inline int32 CLuaStatusEffect::addMod(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 2) || !lua_isnumber(L, 2));

    m_PLuaStatusEffect->addMod(static_cast<Mod>(lua_tointeger(L, 1)), (int16)lua_tointeger(L, 2));
    return 0;
}

//======================================================//

inline int32 CLuaStatusEffect::getFlag(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    lua_pushinteger(L, m_PLuaStatusEffect->GetFlag());
    return 1;
}

inline int32 CLuaStatusEffect::setFlag(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->SetFlag((uint32)lua_tonumber(L, 1));
    return 0;
}

inline int32 CLuaStatusEffect::unsetFlag(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaStatusEffect == nullptr);

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaStatusEffect->UnsetFlag((uint32)lua_tonumber(L, 1));
    return 0;
}

//======================================================//

void CLuaStatusEffect::Register(sol::state& lua)
{
    SOL_START(CStatusEffect, CLuaStatusEffect)
    SOL_REGISTER(getType)
    SOL_REGISTER(getSubType)
    SOL_REGISTER(setIcon)
    SOL_REGISTER(getPower)
    SOL_REGISTER(setPower)
    SOL_REGISTER(getDuration)
    SOL_REGISTER(setDuration)
    SOL_REGISTER(getStartTime)
    SOL_REGISTER(getLastTick)
    SOL_REGISTER(getTimeRemaining)
    SOL_REGISTER(getTickCount)
    SOL_REGISTER(resetStartTime)
    SOL_REGISTER(addMod)
    SOL_REGISTER(getSubPower)
    SOL_REGISTER(setSubPower)
    SOL_REGISTER(getTier)
    SOL_REGISTER(setTier)
    SOL_REGISTER(getTick)
    SOL_REGISTER(setTick)
    SOL_REGISTER(setStartTime)
    SOL_REGISTER(getFlag)
    SOL_REGISTER(setFlag)
    SOL_REGISTER(unsetFlag)
    SOL_END()
}

//======================================================//
