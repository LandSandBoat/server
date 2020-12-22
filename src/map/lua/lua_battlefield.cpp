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

#include "../battlefield.h"
#include "../entities/charentity.h"
#include "../status_effect_container.h"
#include "../utils/mobutils.h"
#include "../utils/zoneutils.h"
#include "lua_baseentity.h"
#include "lua_battlefield.h"

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

    lua_pushinteger(
        L, (lua_Integer)std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetFightTime() - m_PLuaBattlefield->GetStartTime()).count());
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

    m_PLuaBattlefield->ForEachPlayer([&](CCharEntity* PChar) {
        if (PChar)
        {
            lua_getglobal(L, "CBaseEntity");
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
    auto adds     = lua_isnil(L, 2) ? false : lua_toboolean(L, 2);

    auto size = required ? m_PLuaBattlefield->m_RequiredEnemyList.size() : 0;
    size      = size + (adds ? m_PLuaBattlefield->m_AdditionalEnemyList.size() : 0);

    lua_createtable(L, (int)size, 0);

    auto i = 1;

    if (required && !m_PLuaBattlefield->m_RequiredEnemyList.empty())
    {
        m_PLuaBattlefield->ForEachRequiredEnemy([&](CMobEntity* PMob) {
            lua_getglobal(L, "CBaseEntity");
            lua_pushstring(L, "new");
            lua_gettable(L, -2);
            lua_insert(L, -2);
            lua_pushlightuserdata(L, (void*)PMob);
            lua_pcall(L, 2, 1, 0);

            lua_rawseti(L, -2, i++);
        });
    }

    if (adds && !m_PLuaBattlefield->m_AdditionalEnemyList.empty())
    {
        m_PLuaBattlefield->ForEachAdditionalEnemy([&](CMobEntity* PMob) {
            lua_getglobal(L, "CBaseEntity");
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

    m_PLuaBattlefield->ForEachNpc([&](CNpcEntity* PNpc) {
        lua_getglobal(L, "CBaseEntity");
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

    m_PLuaBattlefield->ForEachAlly([&](CMobEntity* PAlly) {
        lua_getglobal(L, "CBaseEntity");
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, PAlly);

        if (lua_pcall(L, 2, 1, 0))
        {
            return;
        }

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

    const auto* name      = lua_tostring(L, 1);
    auto        time      = lua_tointeger(L, 2);
    auto        partySize = (lua_isnil(L, 3) || !lua_isnumber(L, 3)) ? m_PLuaBattlefield->GetPlayerCount() : lua_tointeger(L, 1);
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
    // CBaseEntity* PEntity = !lua_isnil(L, 1) && lua_isuserdata(L, 1) ? Lunar<CLuaBaseEntity>::check(L, 1)->GetBaseEntity() : nullptr;
    // lua_pushboolean(L, m_PLuaBattlefield->SpawnLoot(PEntity));
    return 1;
}

inline int32 CLuaBattlefield::insertEntity(lua_State* L)
{
    /*
    TPZ_DEBUG_BREAK_IF(m_PLuaBattlefield == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1));

    auto* PLuaEntity = !lua_isnumber(L, 1) ? Lunar<CLuaBaseEntity>::check(L, 1) : nullptr;
    auto* PEntity    = PLuaEntity ? PLuaEntity->GetBaseEntity() : nullptr;

    auto                    targid        = PEntity ? PEntity->targid : lua_tointeger(L, 1);
    bool                    ally          = !lua_isnil(L, 2) ? lua_toboolean(L, 2) : false;
    bool                    inBattlefield = !lua_isnil(L, 3) ? lua_toboolean(L, 3) : false;
    BATTLEFIELDMOBCONDITION conditions    = static_cast<BATTLEFIELDMOBCONDITION>(!lua_isnil(L, 4) ? lua_tointeger(L, 4) : 0);

    // entity type
    ENTITYTYPE filter = static_cast<ENTITYTYPE>(0x1F);

    if (!PEntity)
    {
        PEntity =
            ally ? mobutils::InstantiateAlly((uint32)targid, m_PLuaBattlefield->GetZoneID()) : m_PLuaBattlefield->GetZone()->GetEntity((uint16)targid, filter);
    }

    if (PEntity)
    {
        m_PLuaBattlefield->InsertEntity(PEntity, inBattlefield, conditions, ally);

        lua_getglobal(L, "CBaseEntity");
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
    */
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

//==========================================================//

void CLuaBattlefield::Register()
{
    SOL_USERTYPE("CBattlefield", CLuaBattlefield);
    SOL_REGISTER("getID", CLuaBattlefield::getID);
    SOL_REGISTER("getArea", CLuaBattlefield::getArea);
    SOL_REGISTER("getTimeLimit", CLuaBattlefield::getTimeLimit);
    SOL_REGISTER("getRemainingTime", CLuaBattlefield::getRemainingTime);
    SOL_REGISTER("getTimeInside", CLuaBattlefield::getTimeInside);
    SOL_REGISTER("getFightTick", CLuaBattlefield::getFightTick);
    SOL_REGISTER("getWipeTime", CLuaBattlefield::getWipeTime);
    SOL_REGISTER("getFightTime", CLuaBattlefield::getFightTime);
    SOL_REGISTER("getPlayers", CLuaBattlefield::getPlayers);
    SOL_REGISTER("getMobs", CLuaBattlefield::getMobs);
    SOL_REGISTER("getNPCs", CLuaBattlefield::getNPCs);
    SOL_REGISTER("getAllies", CLuaBattlefield::getAllies);
    SOL_REGISTER("getRecord", CLuaBattlefield::getRecord);
    SOL_REGISTER("getStatus", CLuaBattlefield::getStatus);
    SOL_REGISTER("getLastTimeUpdate", CLuaBattlefield::getLastTimeUpdate);
    SOL_REGISTER("getInitiator", CLuaBattlefield::getInitiator);
    SOL_REGISTER("getLocalVar", CLuaBattlefield::getLocalVar);
    SOL_REGISTER("setLocalVar", CLuaBattlefield::setLocalVar);
    SOL_REGISTER("setLastTimeUpdate", CLuaBattlefield::setLastTimeUpdate);
    SOL_REGISTER("setTimeLimit", CLuaBattlefield::setTimeLimit);
    SOL_REGISTER("setWipeTime", CLuaBattlefield::setWipeTime);
    SOL_REGISTER("setRecord", CLuaBattlefield::setRecord);
    SOL_REGISTER("setStatus", CLuaBattlefield::setStatus);
    SOL_REGISTER("loadMobs", CLuaBattlefield::loadMobs);
    SOL_REGISTER("spawnLoot", CLuaBattlefield::spawnLoot);
    SOL_REGISTER("insertEntity", CLuaBattlefield::insertEntity);
    SOL_REGISTER("cleanup", CLuaBattlefield::cleanup);
    SOL_REGISTER("win", CLuaBattlefield::win);
    SOL_REGISTER("lose", CLuaBattlefield::lose);
};

//==========================================================//
