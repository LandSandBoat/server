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

#include "lua_ability.h"
#include "../ability.h"


/************************************************************************
*																		*
*  Конструктор															*
*																		*
************************************************************************/

CLuaAbility::CLuaAbility(lua_State *L)
{
    if (!lua_isnil(L, -1))
    {
        m_PLuaAbility = (CAbility*)(lua_touserdata(L, -1));
        lua_pop(L, 1);
    }
    else
    {
        m_PLuaAbility = nullptr;
    }
}

/************************************************************************
*																		*
*  Конструктор															*
*																		*
************************************************************************/

CLuaAbility::CLuaAbility(CAbility* PAbility)
{
    m_PLuaAbility = PAbility;
}

inline int32 CLuaAbility::getID(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);

    lua_pushinteger(L, m_PLuaAbility->getID());
    return 1;
}


int32 CLuaAbility::getMsg(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);

    lua_pushinteger(L, m_PLuaAbility->getMessage());
    return 1;
}

inline int32 CLuaAbility::getRecast(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);

    lua_pushinteger(L, m_PLuaAbility->getRecastTime());
    return 1;
}

inline int32 CLuaAbility::getRange(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);

    lua_pushinteger(L, (lua_Integer)m_PLuaAbility->getRange());
    return 1;
}

inline int32 CLuaAbility::getName(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);

    lua_pushstring(L, (const char*)m_PLuaAbility->getName());
    return 1;
}

int32 CLuaAbility::getAnimation(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);

    lua_pushinteger(L, m_PLuaAbility->getAnimationID());
    return 1;
}

inline int32 CLuaAbility::setMsg(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaAbility->setMessage((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaAbility::setAnimation(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaAbility->setAnimationID((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaAbility::setRecast(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaAbility->setRecastTime((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaAbility::setCE(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaAbility->setCE((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaAbility::setVE(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaAbility->setVE((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaAbility::setRange(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaAbility == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaAbility->setRange((float)lua_tointeger(L, -1));
    return 0;
}

/************************************************************************
*																		*
*  Инициализация методов в lua											*
*																		*
************************************************************************/
// clang-format off
const char CLuaAbility::className[] = "CAbility";

Lunar<CLuaAbility>::Register_t CLuaAbility::methods[] =
{
    LUNAR_DECLARE_METHOD(CLuaAbility,getID),
    LUNAR_DECLARE_METHOD(CLuaAbility,getRecast),
    LUNAR_DECLARE_METHOD(CLuaAbility,getRange),
    LUNAR_DECLARE_METHOD(CLuaAbility,getName),
    LUNAR_DECLARE_METHOD(CLuaAbility,getAnimation),
    LUNAR_DECLARE_METHOD(CLuaAbility,getMsg),
    LUNAR_DECLARE_METHOD(CLuaAbility,setMsg),
    LUNAR_DECLARE_METHOD(CLuaAbility,setAnimation),
    LUNAR_DECLARE_METHOD(CLuaAbility,setRecast),
    LUNAR_DECLARE_METHOD(CLuaAbility,setCE),
    LUNAR_DECLARE_METHOD(CLuaAbility,setVE),
    LUNAR_DECLARE_METHOD(CLuaAbility,setRange),
    {nullptr,nullptr}
};
// clang-format on
