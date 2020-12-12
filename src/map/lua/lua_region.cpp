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

#include "lua_region.h"
#include "../region.h"

/************************************************************************
*																		*
*  Конструктор															*
*																		*
************************************************************************/

CLuaRegion::CLuaRegion(lua_State *L)
{
    if (!lua_isnil(L, -1))
    {
        m_PLuaRegion = (CRegion*)(lua_touserdata(L, -1));
        lua_pop(L, 1);
    }
    else
    {
        m_PLuaRegion = nullptr;
    }
}

/************************************************************************
*																		*
*  Конструктор															*
*																		*
************************************************************************/

CLuaRegion::CLuaRegion(CRegion* PRegion)
{
    TPZ_DEBUG_BREAK_IF(PRegion == nullptr);

    m_PLuaRegion = PRegion;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

inline int32 CLuaRegion::GetRegionID(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaRegion == nullptr);

    lua_pushinteger(L, m_PLuaRegion->GetRegionID());
    return 1;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

inline int32 CLuaRegion::GetCount(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaRegion == nullptr);

    lua_pushinteger(L, m_PLuaRegion->GetCount());
    return 1;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

inline int32 CLuaRegion::AddCount(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaRegion == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    lua_pushinteger(L, m_PLuaRegion->AddCount((int16)lua_tointeger(L, -1)));
    return 1;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

inline int32 CLuaRegion::DelCount(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaRegion == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    lua_pushinteger(L, m_PLuaRegion->DelCount((int16)lua_tointeger(L, -1)));
    return 1;
}

/************************************************************************
*																		*
*  Инициализация методов в lua											*
*																		*
************************************************************************/
// clang-format off
const char CLuaRegion::className[] = "CRegion";

Lunar<CLuaRegion>::Register_t CLuaRegion::methods[] =
{
    LUNAR_DECLARE_METHOD(CLuaRegion,GetRegionID),
    LUNAR_DECLARE_METHOD(CLuaRegion,GetCount),
    LUNAR_DECLARE_METHOD(CLuaRegion,AddCount),
    LUNAR_DECLARE_METHOD(CLuaRegion,DelCount),
    {nullptr,nullptr}
};
// clang-format on