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

#include "../spell.h"
#include "../utils/battleutils.h"
#include "lua_spell.h"

/************************************************************************
 *																		*
 *  Конструктор															*
 *																		*
 ************************************************************************/

CLuaSpell::CLuaSpell(CSpell* PSpell)
{
    m_PLuaSpell = PSpell;
}

/************************************************************************
 *                                                                       *
 *  Устанавливаем сообщение заклинания                                   *
 *                                                                       *
 ************************************************************************/

inline int32 CLuaSpell::setMsg(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setMessage((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaSpell::setAoE(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setAOE((uint8)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaSpell::setFlag(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setFlag((uint8)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaSpell::setRadius(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setRadius((float)lua_tonumber(L, -1));
    return 0;
}

inline int32 CLuaSpell::setAnimation(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setAnimationID((uint16)lua_tonumber(L, -1));
    return 0;
}

inline int32 CLuaSpell::setMPCost(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setMPCost((uint16)lua_tonumber(L, -1));
    return 0;
}

inline int32 CLuaSpell::castTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);

    if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
    {
        m_PLuaSpell->setCastTime((uint32)lua_tointeger(L, 1));
    }
    else
    {
        lua_pushinteger(L, m_PLuaSpell->getCastTime());
    }

    return 1;
}

inline int32 CLuaSpell::canTargetEnemy(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushboolean(L, m_PLuaSpell->canTargetEnemy());
    return 1;
}

inline int32 CLuaSpell::getTotalTargets(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getTotalTargets());
    return 1;
}

inline int32 CLuaSpell::getMagicBurstMessage(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getMagicBurstMessage());
    return 1;
}

inline int32 CLuaSpell::getElement(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getElement());
    return 1;
}

inline int32 CLuaSpell::isAoE(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getAOE());
    return 1;
}

inline int32 CLuaSpell::tookEffect(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushboolean(L, m_PLuaSpell->tookEffect());
    return 1;
}

inline int32 CLuaSpell::getID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, static_cast<uint16>(m_PLuaSpell->getID()));
    return 1;
}

inline int32 CLuaSpell::getMPCost(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, static_cast<uint16>(m_PLuaSpell->getMPCost()));
    return 1;
}

inline int32 CLuaSpell::getSkillType(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getSkillType());
    return 1;
}

inline int32 CLuaSpell::getSpellGroup(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getSpellGroup());
    return 1;
}

inline int32 CLuaSpell::getFlag(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getFlag());
    return 1;
}

//======================================================//

void CLuaSpell::Register()
{
    SOL_USERTYPE("CSpell", CLuaSpell);
    SOL_REGISTER("setMsg", CLuaSpell::setMsg);
    SOL_REGISTER("setAoE", CLuaSpell::setAoE);
    SOL_REGISTER("setFlag", CLuaSpell::setFlag);
    SOL_REGISTER("setRadius", CLuaSpell::setRadius);
    SOL_REGISTER("setAnimation", CLuaSpell::setAnimation);
    SOL_REGISTER("setMPCost", CLuaSpell::setMPCost);
    SOL_REGISTER("isAoE", CLuaSpell::isAoE);
    SOL_REGISTER("tookEffect", CLuaSpell::tookEffect);
    SOL_REGISTER("getMagicBurstMessage", CLuaSpell::getMagicBurstMessage);
    SOL_REGISTER("getElement", CLuaSpell::getElement);
    SOL_REGISTER("getTotalTargets", CLuaSpell::getTotalTargets);
    SOL_REGISTER("getSkillType", CLuaSpell::getSkillType);
    SOL_REGISTER("getID", CLuaSpell::getID);
    SOL_REGISTER("getMPCost", CLuaSpell::getMPCost);
    SOL_REGISTER("getSpellGroup", CLuaSpell::getSpellGroup);
    SOL_REGISTER("getFlag", CLuaSpell::getFlag);
    SOL_REGISTER("castTime", CLuaSpell::castTime);
}

//======================================================//
