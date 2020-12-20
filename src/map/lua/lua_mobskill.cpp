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

#include "../mobskill.h"
#include "lua_mobskill.h"

/************************************************************************
 *                                                                       *
 *  Constructor                                                          *
 *                                                                       *
 ************************************************************************/

CLuaMobSkill::CLuaMobSkill(lua_State* L)
{
    if (!lua_isnil(L, -1))
    {
        m_PLuaMobSkill = (CMobSkill*)(lua_touserdata(L, -1));
        lua_pop(L, 1);
    }
    else
    {
        m_PLuaMobSkill = nullptr;
    }
}

/************************************************************************
 *                                                                       *
 *  Constructor                                                          *
 *                                                                       *
 ************************************************************************/

CLuaMobSkill::CLuaMobSkill(CMobSkill* PSkill)
{
    m_PLuaMobSkill = PSkill;
}

/************************************************************************
 *                                                                       *
 *  Set the tp skill message to be displayed (cure/damage/enfeeb)        *
 *                                                                       *
 ************************************************************************/

inline int32 CLuaMobSkill::setMsg(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaMobSkill->setMsg((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaMobSkill::hasMissMsg(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushboolean(L, m_PLuaMobSkill->hasMissMsg());
    return 1;
}

inline int32 CLuaMobSkill::isSingle(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushboolean(L, m_PLuaMobSkill->isSingle());
    return 1;
}

inline int32 CLuaMobSkill::isAoE(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushboolean(L, m_PLuaMobSkill->isAoE());
    return 1;
}

inline int32 CLuaMobSkill::isConal(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushboolean(L, m_PLuaMobSkill->isConal());
    return 1;
}

inline int32 CLuaMobSkill::getTotalTargets(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushinteger(L, m_PLuaMobSkill->getTotalTargets());
    return 1;
}

inline int32 CLuaMobSkill::getMsg(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushinteger(L, m_PLuaMobSkill->getMsg());
    return 1;
}

inline int32 CLuaMobSkill::getID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushinteger(L, m_PLuaMobSkill->getID());
    return 1;
}

inline int32 CLuaMobSkill::getParam(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushinteger(L, m_PLuaMobSkill->getParam());
    return 1;
}

/*************************************************************************

            get the TP for calculations

**************************************************************************/

inline int32 CLuaMobSkill::getTP(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushnumber(L, (float)m_PLuaMobSkill->getTP());
    return 1;
}

// Retrieves the Monsters HP% as it was at the start of mobskill
inline int32 CLuaMobSkill::getMobHPP(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaMobSkill == nullptr);

    lua_pushinteger(L, m_PLuaMobSkill->getHPP());
    return 1;
}

/************************************************************************
 *                                                                       *
 *  declare lua function                                                 *
 *                                                                       *
 ************************************************************************/
// clang-format off
const char CLuaMobSkill::className[] = "CMobSkill";
Lunar<CLuaMobSkill>::Register_t CLuaMobSkill::methods[] =
{
    LUNAR_DECLARE_METHOD(CLuaMobSkill,setMsg),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,getMsg),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,hasMissMsg),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,isAoE),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,isConal),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,isSingle),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,getParam),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,getID),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,getTotalTargets),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,getTP),
    LUNAR_DECLARE_METHOD(CLuaMobSkill,getMobHPP),
    {nullptr,nullptr}
};
// clang-format on
