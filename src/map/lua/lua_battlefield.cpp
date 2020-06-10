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

#include "lua_battlefield.h"
#include "lua_baseentity.h"
#include "../battlefield.h"
#include "../entities/charentity.h"
#include "../utils/mobutils.h"
#include "../utils/zoneutils.h"
#include "../status_effect_container.h"


/************************************************************************
*																		*
*  Constructor															*
*																		*
************************************************************************/

CLuaBattlefield::CLuaBattlefield(lua_State *L)
{
    if (!lua_isnil(L, -1))
    {
        m_PLuaBattlefield = (CBattlefield*)(lua_touserdata(L, -1));
        lua_pop(L, 1);
    }
    else
    {
        m_PLuaBattlefield = nullptr;
    }
}

/************************************************************************
*																		*
*  Constructor															*
*																		*
************************************************************************/

CLuaBattlefield::CLuaBattlefield(CBattlefield* PBattlefield)
{
    m_PLuaBattlefield = PBattlefield;
}

/************************************************************************
*                                                                       *
*						Get methods								        *
*                                                                       *
************************************************************************/

inline int32 CLuaBattlefield::getID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_pushinteger(L, m_PLuaBattlefield->GetID());
    return 1;
}

inline int32 CLuaBattlefield::getArea(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_pushinteger(L, m_PLuaBattlefield->GetArea());
    return 1;
}

inline int32 CLuaBattlefield::getTimeLimit(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_pushinteger(L, (lua_Integer)std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetTimeLimit()).count());
    return 1;
}

inline int32 CLuaBattlefield::getTimeInside(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    auto duration = std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetTimeInside()).count();

    lua_pushinteger(L, (lua_Integer)duration);
    return 1;
}

inline int32 CLuaBattlefield::getRemainingTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_pushinteger(L, (lua_Integer)std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetRemainingTime()).count());
    return 1;
}

inline int32 CLuaBattlefield::getFightTick(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_pushinteger(L, (lua_Integer)std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetFightTime() - m_PLuaBattlefield->GetStartTime()).count());
    return 1;
}

inline int32 CLuaBattlefield::getWipeTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    auto count = std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetWipeTime() - get_server_start_time()).count();

    lua_pushinteger(L, (lua_Integer)count);
    return 1;
}

inline int32 CLuaBattlefield::getFightTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_pushinteger(L, (lua_Integer)std::chrono::duration_cast<std::chrono::seconds>(get_server_start_time() - m_PLuaBattlefield->GetFightTime()).count());
    return 1;
}

inline int32 CLuaBattlefield::getPlayers(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_createtable(L, (int)m_PLuaBattlefield->m_EnteredPlayers.size(), 0);
    int i = 1;

    m_PLuaBattlefield->ForEachPlayer([&](CCharEntity* PChar)
    {
        if (PChar)
        {
            lua_getglobal(L, CLuaBaseEntity::className);
            lua_pushstring(L, "new");
            lua_gettable(L, -2);
            lua_insert(L, -2);
            lua_pushlightuserdata(L, (void*)PChar);
            lua_pcall(L, 2, 1, 0);
            lua_rawseti(L, -2, i++);
        }
    });
    return 1;
}

inline int32 CLuaBattlefield::getMobs(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    // do we want just required mobs, all mobs, or just mobs not needed to win
    auto required = lua_isnil(L, 1) ? true : lua_toboolean(L, 1);
    auto adds = lua_isnil(L, 2) ? false : lua_toboolean(L, 2);

    auto size = required ? m_PLuaBattlefield->m_RequiredEnemyList.size() : 0;
    size = size + (adds ? m_PLuaBattlefield->m_AdditionalEnemyList.size() : 0);

    lua_createtable(L, (int)size, 0);

    auto i = 1;

    if (required && m_PLuaBattlefield->m_RequiredEnemyList.size() > 0)
    {
        m_PLuaBattlefield->ForEachRequiredEnemy([&](CMobEntity* PMob)
        {
            lua_getglobal(L, CLuaBaseEntity::className);
            lua_pushstring(L, "new");
            lua_gettable(L, -2);
            lua_insert(L, -2);
            lua_pushlightuserdata(L, (void*)PMob);
            lua_pcall(L, 2, 1, 0);

            lua_rawseti(L, -2, i++);
        });
    }

    if (adds && m_PLuaBattlefield->m_AdditionalEnemyList.size() > 0)
    {
        m_PLuaBattlefield->ForEachAdditionalEnemy([&](CMobEntity* PMob)
        {
            lua_getglobal(L, CLuaBaseEntity::className);
            lua_pushstring(L, "new");
            lua_gettable(L, -2);
            lua_insert(L, -2);
            lua_pushlightuserdata(L, (void*)PMob);
            lua_pcall(L, 2, 1, 0);


            lua_rawseti(L, -2, i++);

        });
    }
    return 1;
}

inline int32 CLuaBattlefield::getNPCs(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_createtable(L, (int)m_PLuaBattlefield->m_NpcList.size(), 0);
    int i = 1;

    m_PLuaBattlefield->ForEachNpc([&](CNpcEntity* PNpc)
    {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)PNpc);
        lua_pcall(L, 2, 1, 0);

        lua_rawseti(L, -2, i++);
    });
    return 1;
}

inline int32 CLuaBattlefield::getAllies(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_createtable(L, (int)m_PLuaBattlefield->m_AllyList.size(), 0);
    lua_gettop(L);
    int i = 1;

    m_PLuaBattlefield->ForEachAlly([&](CMobEntity* PAlly)
    {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, PAlly);

        if (lua_pcall(L, 2, 1, 0))
            return;

        lua_rawseti(L, -2, i++);
    });

    return 1;
}

inline int32 CLuaBattlefield::getRecord(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    const auto& record = m_PLuaBattlefield->GetRecord();

    lua_pushstring(L, record.name.c_str());
    lua_pushinteger(L, (lua_Integer)std::chrono::duration_cast<std::chrono::seconds>(record.time).count());
    lua_pushinteger(L, (lua_Integer)record.partySize);
    return 3;
}

inline int32 CLuaBattlefield::getStatus(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    lua_pushinteger(L, m_PLuaBattlefield->GetStatus());
    return 1;
}

inline int32 CLuaBattlefield::getLocalVar(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isstring(L, 1));

    lua_pushinteger(L, (lua_Integer)m_PLuaBattlefield->GetLocalVar(lua_tostring(L, 1)));
    return 1;
}

inline int32 CLuaBattlefield::getLastTimeUpdate(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    auto count = std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetLastTimeUpdate()).count();

    lua_pushinteger(L, (lua_Integer)count);
    return 1;
}

inline int32 CLuaBattlefield::getInitiator(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    const auto& initiator = m_PLuaBattlefield->GetInitiator();

    lua_pushinteger(L, (lua_Integer)initiator.id);
    lua_pushstring(L, initiator.name.c_str());
    return 2;
}

inline int32 CLuaBattlefield::setLocalVar(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isstring(L, 1));
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 2) || !lua_isnumber(L, 2));

    m_PLuaBattlefield->SetLocalVar(lua_tostring(L, 1), (uint64_t)lua_tointeger(L, 2));
    return 0;
}

inline int32 CLuaBattlefield::setLastTimeUpdate(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaBattlefield->SetLastTimeUpdate(std::chrono::seconds(lua_tointeger(L, 1)));
    return 0;
}

inline int32 CLuaBattlefield::setTimeLimit(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaBattlefield->SetTimeLimit(std::chrono::seconds(lua_tointeger(L, 1)));
    return 0;
}

inline int32 CLuaBattlefield::setWipeTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    m_PLuaBattlefield->SetWipeTime(get_server_start_time() + std::chrono::seconds(lua_tointeger(L, 1)));
    return 0;
}

inline int32 CLuaBattlefield::setRecord(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isstring(L, 1));
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 2) || !lua_isnumber(L, 2));

    auto name = lua_tostring(L, 1);
    auto time = lua_tointeger(L, 2);
    auto partySize = (lua_isnil(L, 3) || !lua_isnumber(L, 3)) ? m_PLuaBattlefield->GetPlayerCount() : lua_tointeger(L, 1);
    m_PLuaBattlefield->SetRecord((char*)name, std::chrono::seconds(time), partySize);
    return 0;
}

inline int32 CLuaBattlefield::setStatus(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    auto status = lua_tointeger(L, 1);

    m_PLuaBattlefield->SetStatus((uint8)status);
    return 0;
}

inline int32 CLuaBattlefield::loadMobs(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    m_PLuaBattlefield->LoadMobs();
    return 0;
}

inline int32 CLuaBattlefield::spawnLoot(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    CBaseEntity* PEntity = !lua_isnil(L, 1) && lua_isuserdata(L, 1) ? Lunar<CLuaBaseEntity>::check(L, 1)->GetBaseEntity() : nullptr;
    lua_pushboolean(L, m_PLuaBattlefield->SpawnLoot(PEntity));
    return 1;
}

inline int32 CLuaBattlefield::insertEntity(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1));

    auto PLuaEntity = !lua_isnumber(L, 1) ? Lunar<CLuaBaseEntity>::check(L, 1) : nullptr;
    auto PEntity = PLuaEntity ? PLuaEntity->GetBaseEntity() : nullptr;

    auto targid = PEntity ? PEntity->targid : lua_tointeger(L, 1);
    bool ally = !lua_isnil(L, 2) ? lua_toboolean(L, 2) : false;
    bool inBattlefield = !lua_isnil(L, 3) ? lua_toboolean(L, 3) : false;
    BATTLEFIELDMOBCONDITION conditions = static_cast<BATTLEFIELDMOBCONDITION>(!lua_isnil(L, 4) ? lua_tointeger(L, 4) : 0);

    // entity type
    ENTITYTYPE filter = static_cast<ENTITYTYPE>(0x1F);

    if (!PEntity)
        PEntity = ally ? mobutils::InstantiateAlly((uint32)targid, m_PLuaBattlefield->GetZoneID()) : m_PLuaBattlefield->GetZone()->GetEntity((uint16)targid, filter);

    if (PEntity)
    {
        m_PLuaBattlefield->InsertEntity(PEntity, inBattlefield, conditions, ally);

        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)PEntity);
        lua_pcall(L, 2, 1, 0);
    }
    else
    {
        ShowError(CL_RED "CLuaBattlefield::insertEntity - targid ID %u not found!" CL_RESET, targid);
        lua_pushnil(L);
    }
    return 1;
}

inline int32 CLuaBattlefield::cleanup(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);

    auto cleanup = !lua_isnil(L, 1) ? lua_toboolean(L, 1) : false;

    lua_pushboolean(L, m_PLuaBattlefield->CanCleanup(cleanup));
    return 1;
}

inline int32 CLuaBattlefield::win(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    m_PLuaBattlefield->SetStatus(static_cast<uint8>(BATTLEFIELD_STATUS_WON));
    m_PLuaBattlefield->CanCleanup(true);
    return 0;
}

inline int32 CLuaBattlefield::lose(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    m_PLuaBattlefield->SetStatus(static_cast<uint8>(BATTLEFIELD_STATUS_LOST));
    m_PLuaBattlefield->CanCleanup(true);
    return 0;
}

/************************************************************************
*																		*
*  declare lua function													*
*																		*
************************************************************************/

const char CLuaBattlefield::className[] = "CBattlefield";
Lunar<CLuaBattlefield>::Register_t CLuaBattlefield::methods[] =
{
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getID),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getArea),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getTimeLimit),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getRemainingTime),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getTimeInside),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getFightTick),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getWipeTime),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getFightTime),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getPlayers),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getMobs),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getNPCs),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getAllies),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getRecord),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getStatus),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getLastTimeUpdate),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getInitiator),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,getLocalVar),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,setLocalVar),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,setLastTimeUpdate),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,setTimeLimit),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,setWipeTime),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,setRecord),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,setStatus),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,loadMobs),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,spawnLoot),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,insertEntity),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,cleanup),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,win),
    LUNAR_DECLARE_METHOD(CLuaBattlefield,lose),
    { nullptr,nullptr }
};
