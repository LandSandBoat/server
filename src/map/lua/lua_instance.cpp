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

#include "lua_instance.h"

#include "lua_baseentity.h"
#include "luautils.h"
#include "../instance.h"
#include "../utils/mobutils.h"


/************************************************************************
*																		*
*  Constructor															*
*																		*
************************************************************************/

CLuaInstance::CLuaInstance(lua_State *L)
{
    if (!lua_isnil(L, -1))
    {
        m_PLuaInstance = (CInstance*)(lua_touserdata(L, -1));
        lua_pop(L, 1);
    }
    else
    {
        m_PLuaInstance = nullptr;
    }
}

/************************************************************************
*																		*
*  Constructor															*
*																		*
************************************************************************/

CLuaInstance::CLuaInstance(CInstance* PInstance)
{
    m_PLuaInstance = PInstance;
}

inline int32 CLuaInstance::getID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_pushinteger(L, m_PLuaInstance->GetID());

    return 1;
}

inline int32 CLuaInstance::getAllies(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_createtable(L, (int)m_PLuaInstance->m_allyList.size(), 0);
    int i = 1;
    for (auto member : m_PLuaInstance->m_allyList)
    {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)member.second);
        lua_pcall(L, 2, 1, 0);

        lua_rawseti(L, -2, i++);
    }

    return 1;
}

inline int32 CLuaInstance::getChars(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_createtable(L, (int)m_PLuaInstance->m_charList.size(), 0);
    int i = 1;
    for (auto member : m_PLuaInstance->m_charList)
    {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)member.second);
        lua_pcall(L, 2, 1, 0);

        lua_rawseti(L, -2, i++);
    }

    return 1;
}

inline int32 CLuaInstance::getMobs(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_createtable(L, (int)m_PLuaInstance->m_mobList.size(), 0);
    int i = 1;
    for (auto member : m_PLuaInstance->m_mobList)
    {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)member.second);
        lua_pcall(L, 2, 1, 0);

        lua_rawseti(L, -2, i++);
    }

    return 1;
}

inline int32 CLuaInstance::getNpcs(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_createtable(L, (int)m_PLuaInstance->m_npcList.size(), 0);
    int i = 1;
    for (auto member : m_PLuaInstance->m_npcList)
    {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)member.second);
        lua_pcall(L, 2, 1, 0);

        lua_rawseti(L, -2, i++);
    }

    return 1;
}

inline int32 CLuaInstance::getPets(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_createtable(L, (int)m_PLuaInstance->m_petList.size(), 0);
    int i = 1;
    for (auto member : m_PLuaInstance->m_petList)
    {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)member.second);
        lua_pcall(L, 2, 1, 0);

        lua_rawseti(L, -2, i++);
    }

    return 1;
}

inline int32 CLuaInstance::getTimeLimit(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    auto limit = std::chrono::duration_cast<std::chrono::minutes>( m_PLuaInstance->GetTimeLimit()).count();

    lua_pushinteger(L, limit);

    return 1;
}

inline int32 CLuaInstance::getEntryPos(lua_State* L)
{
    lua_createtable(L, 4, 0);
    int8 newTable = lua_gettop(L);

    position_t entry = m_PLuaInstance->GetEntryLoc();

    lua_pushnumber(L, entry.x);
    lua_setfield(L, newTable, "x");

    lua_pushnumber(L, entry.y);
    lua_setfield(L, newTable, "y");

    lua_pushnumber(L, entry.z);
    lua_setfield(L, newTable, "z");

    lua_pushnumber(L, entry.rotation);
    lua_setfield(L, newTable, "rot");

    return 1;
}

inline int32 CLuaInstance::getLastTimeUpdate(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_pushinteger(L, (lua_Integer)std::chrono::duration_cast<std::chrono::milliseconds>(m_PLuaInstance->GetLastTimeUpdate()).count());

    return 1;
}

inline int32 CLuaInstance::getProgress(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_pushinteger(L, m_PLuaInstance->GetProgress());

    return 1;
}

inline int32 CLuaInstance::getWipeTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_pushinteger(L, (lua_Integer)std::chrono::duration_cast<std::chrono::milliseconds>(m_PLuaInstance->GetWipeTime()).count());

    return 1;
}

inline int32 CLuaInstance::getEntity(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    auto targid = (uint16)lua_tointeger(L, 1);

    uint8 filter = -1;
    if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
    {
        filter = (uint8)lua_tointeger(L, 2);
    }

    CBaseEntity* PEntity = m_PLuaInstance->GetEntity(targid, filter);

    if (PEntity)
    {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)(PEntity));
        lua_pcall(L, 2, 1, 0);
    }
    else
    {
        lua_pushnil(L);
    }
    return 1;
}

inline int32 CLuaInstance::getStage(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_pushinteger(L, m_PLuaInstance->GetStage());

    return 1;
}

inline int32 CLuaInstance::setLevelCap(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaInstance->SetLevelCap((uint8)lua_tonumber(L, 1));

    return 0;
}

inline int32 CLuaInstance::setLastTimeUpdate(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaInstance->SetLastTimeUpdate(std::chrono::milliseconds(lua_tointeger(L, 1)));

    return 0;
}

inline int32 CLuaInstance::setProgress(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaInstance->SetProgress((uint32)lua_tointeger(L, 1));

    return 0;
}

inline int32 CLuaInstance::setWipeTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaInstance->SetWipeTime(std::chrono::milliseconds(lua_tointeger(L, 1)));

    return 0;
}

inline int32 CLuaInstance::setStage(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaInstance->SetStage((uint32)lua_tointeger(L, 1));

    return 0;
}

inline int32 CLuaInstance::fail(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    m_PLuaInstance->Fail();

    return 0;
}

inline int32 CLuaInstance::failed(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_pushboolean(L, m_PLuaInstance->Failed());

    return 1;
}

inline int32 CLuaInstance::complete(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    m_PLuaInstance->Complete();

    return 0;
}

inline int32 CLuaInstance::completed(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);

    lua_pushboolean(L, m_PLuaInstance->Completed());

    return 1;
}

inline int32 CLuaInstance::insertAlly(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaInstance == nullptr);
    TPZ_DEBUG_BREAK_IF(!lua_isnumber(L, 1) || lua_isnil(L, 1));

    auto groupid = (uint32)lua_tointeger(L, 1);

    CMobEntity* PAlly = mobutils::InstantiateAlly(groupid, m_PLuaInstance->GetZone()->GetID(), m_PLuaInstance);
    if (PAlly)
    {
        m_PLuaInstance->InsertAlly(PAlly);

        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)PAlly);
        lua_pcall(L, 2, 1, 0);
    }
    else
    {
        lua_pushnil(L);
        ShowError(CL_RED "CLuaBattlefield::insertAlly - group ID %u not found!" CL_RESET, groupid);
    }
    return 1;
}

/************************************************************************
*																		*
*  declare lua function													*
*																		*
************************************************************************/
// clang-format off
const char CLuaInstance::className[] = "CInstance";
Lunar<CLuaInstance>::Register_t CLuaInstance::methods[] =
{
    LUNAR_DECLARE_METHOD(CLuaInstance, getID),
    LUNAR_DECLARE_METHOD(CLuaInstance, setLevelCap),
    LUNAR_DECLARE_METHOD(CLuaInstance, getAllies),
    LUNAR_DECLARE_METHOD(CLuaInstance, getChars),
    LUNAR_DECLARE_METHOD(CLuaInstance, getMobs),
    LUNAR_DECLARE_METHOD(CLuaInstance, getNpcs),
    LUNAR_DECLARE_METHOD(CLuaInstance, getPets),
    LUNAR_DECLARE_METHOD(CLuaInstance, getTimeLimit),
    LUNAR_DECLARE_METHOD(CLuaInstance, getEntryPos),
    LUNAR_DECLARE_METHOD(CLuaInstance, getLastTimeUpdate),
    LUNAR_DECLARE_METHOD(CLuaInstance, setLastTimeUpdate),
    LUNAR_DECLARE_METHOD(CLuaInstance, getProgress),
    LUNAR_DECLARE_METHOD(CLuaInstance, getEntity),
    LUNAR_DECLARE_METHOD(CLuaInstance, setProgress),
    LUNAR_DECLARE_METHOD(CLuaInstance, getWipeTime),
    LUNAR_DECLARE_METHOD(CLuaInstance, setWipeTime),
    LUNAR_DECLARE_METHOD(CLuaInstance, getStage),
    LUNAR_DECLARE_METHOD(CLuaInstance, setStage),
    LUNAR_DECLARE_METHOD(CLuaInstance, fail),
    LUNAR_DECLARE_METHOD(CLuaInstance, failed),
    LUNAR_DECLARE_METHOD(CLuaInstance, complete),
    LUNAR_DECLARE_METHOD(CLuaInstance, completed),
    LUNAR_DECLARE_METHOD(CLuaInstance, insertAlly),
    { nullptr, nullptr }
};
// clang-format on
