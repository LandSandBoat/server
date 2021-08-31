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

#include "../../common/logging.h"
#include "../../common/timer.h"

#include "../battlefield.h"
#include "../entities/charentity.h"
#include "../entities/npcentity.h"
#include "../entities/mobentity.h"
#include "../status_effect_container.h"
#include "../utils/mobutils.h"
#include "../utils/zoneutils.h"
#include "lua_baseentity.h"
#include "lua_battlefield.h"

CLuaBattlefield::CLuaBattlefield(CBattlefield* PBattlefield)
: m_PLuaBattlefield(PBattlefield)
{
    if (PBattlefield == nullptr)
    {
        ShowError("CLuaBattlefield created with nullptr instead of valid CBattlefield*!");
    }
}

uint16 CLuaBattlefield::getID()
{
    return m_PLuaBattlefield->GetID();
}

uint8 CLuaBattlefield::getArea()
{
    return m_PLuaBattlefield->GetArea();
}

uint32 CLuaBattlefield::getTimeLimit()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetTimeLimit()).count();
}

uint32 CLuaBattlefield::getTimeInside()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetTimeInside()).count();
}

uint32 CLuaBattlefield::getRemainingTime()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetRemainingTime()).count();
}

uint32 CLuaBattlefield::getFightTick()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetFightTime() - m_PLuaBattlefield->GetStartTime()).count();
}

uint32 CLuaBattlefield::getWipeTime()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetWipeTime() - get_server_start_time()).count();
}

uint32 CLuaBattlefield::getFightTime()
{
    return std::chrono::duration_cast<std::chrono::seconds>(get_server_start_time() - m_PLuaBattlefield->GetFightTime()).count();
}

sol::table CLuaBattlefield::getPlayers()
{
    auto table = luautils::lua.create_table();
    m_PLuaBattlefield->ForEachPlayer([&](CCharEntity* PChar) {
        if (PChar)
        {
            table.add(CLuaBaseEntity(PChar));
        }
    });
    return table;
}

sol::table CLuaBattlefield::getMobs(bool required, bool adds)
{
    auto table = luautils::lua.create_table();

    if (required && !m_PLuaBattlefield->m_RequiredEnemyList.empty())
    {
        m_PLuaBattlefield->ForEachRequiredEnemy([&](CMobEntity* PMob) {
            table.add(CLuaBaseEntity(PMob));
        });
    }

    if (adds && !m_PLuaBattlefield->m_AdditionalEnemyList.empty())
    {
        m_PLuaBattlefield->ForEachAdditionalEnemy([&](CMobEntity* PMob) {
            table.add(CLuaBaseEntity(PMob));
        });
    }

    return table;
}

sol::table CLuaBattlefield::getNPCs()
{
    auto table = luautils::lua.create_table();
    m_PLuaBattlefield->ForEachNpc([&](CNpcEntity* PNpc) {
        table.add(CLuaBaseEntity(PNpc));
    });
    return table;
}

sol::table CLuaBattlefield::getAllies()
{
    auto table = luautils::lua.create_table();
    m_PLuaBattlefield->ForEachAlly([&](CMobEntity* PAlly) {
        table.add(CLuaBaseEntity(PAlly));
    });
    return table;
}

std::tuple<std::string, uint32, uint32> CLuaBattlefield::getRecord()
{
    const auto& record = m_PLuaBattlefield->GetRecord();

    auto   name = record.name;
    uint32 time = std::chrono::duration_cast<std::chrono::seconds>(record.time).count();
    uint32 size = record.partySize;

    return std::make_tuple(name, time, size);
}

uint8 CLuaBattlefield::getStatus()
{
    return m_PLuaBattlefield->GetStatus();
}

uint64_t CLuaBattlefield::getLocalVar(std::string name)
{
    return m_PLuaBattlefield->GetLocalVar(name);
}

uint32 CLuaBattlefield::getLastTimeUpdate()
{
    auto count = std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetLastTimeUpdate()).count();
    return count;
}

std::pair<uint32, std::string> CLuaBattlefield::getInitiator()
{
    const auto& initiator = m_PLuaBattlefield->GetInitiator();
    return std::make_pair(initiator.id, initiator.name);
}

void CLuaBattlefield::setLocalVar(std::string name, uint64_t value)
{
    m_PLuaBattlefield->SetLocalVar(name, value);
}

void CLuaBattlefield::setLastTimeUpdate(uint32 seconds)
{
    m_PLuaBattlefield->SetLastTimeUpdate(std::chrono::seconds(seconds));
}

void CLuaBattlefield::setTimeLimit(uint32 seconds)
{
    m_PLuaBattlefield->SetTimeLimit(std::chrono::seconds(seconds));
}

void CLuaBattlefield::setWipeTime(uint32 seconds)
{
    m_PLuaBattlefield->SetWipeTime(get_server_start_time() + std::chrono::seconds(seconds));
}

void CLuaBattlefield::setRecord(std::string name, uint32 seconds)
{
    m_PLuaBattlefield->SetRecord(name, std::chrono::seconds(seconds), m_PLuaBattlefield->GetPlayerCount());
}

void CLuaBattlefield::setStatus(uint8 status)
{
    m_PLuaBattlefield->SetStatus(status);
}

bool CLuaBattlefield::loadMobs()
{
    return m_PLuaBattlefield->LoadMobs();
}

bool CLuaBattlefield::spawnLoot(sol::object const& PEntityObj)
{
    CBaseEntity* PEntity = PEntityObj.is<CLuaBaseEntity*>() ? PEntityObj.as<CLuaBaseEntity*>()->GetBaseEntity() : nullptr;

    return m_PLuaBattlefield->SpawnLoot(PEntity);
}

std::optional<CLuaBaseEntity> CLuaBattlefield::insertEntity(uint16 targid, bool ally, bool inBattlefield)
{
    BATTLEFIELDMOBCONDITION conditions = static_cast<BATTLEFIELDMOBCONDITION>(0);
    ENTITYTYPE              filter     = static_cast<ENTITYTYPE>(0x1F);

    auto* PEntity =
        ally ? mobutils::InstantiateAlly(targid, m_PLuaBattlefield->GetZoneID()) : m_PLuaBattlefield->GetZone()->GetEntity(targid, filter);

    if (PEntity)
    {
        m_PLuaBattlefield->InsertEntity(PEntity, inBattlefield, conditions, ally);
        return std::optional<CLuaBaseEntity>(PEntity);
    }

    ShowError("CLuaBattlefield::insertEntity - targid ID %u not found!", targid);
    return std::nullopt;
}

bool CLuaBattlefield::cleanup(bool cleanup)
{
    return m_PLuaBattlefield->CanCleanup(cleanup);
}

void CLuaBattlefield::win()
{
    m_PLuaBattlefield->SetStatus(static_cast<uint8>(BATTLEFIELD_STATUS_WON));
    m_PLuaBattlefield->CanCleanup(true);
}

void CLuaBattlefield::lose()
{
    m_PLuaBattlefield->SetStatus(static_cast<uint8>(BATTLEFIELD_STATUS_LOST));
    m_PLuaBattlefield->CanCleanup(true);
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

std::ostream& operator<<(std::ostream& os, const CLuaBattlefield& battlefield)
{
    std::string id = battlefield.m_PLuaBattlefield ? std::to_string(battlefield.m_PLuaBattlefield->GetID()) : "nullptr";
    return os << "CLuaBattlefield(" << id << ")";
}

//==========================================================//
