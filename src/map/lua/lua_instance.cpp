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

#include "lua_instance.h"

#include "instance.h"
#include "lua_baseentity.h"
#include "luautils.h"
#include "utils/instanceutils.h"
#include "utils/mobutils.h"

CLuaInstance::CLuaInstance(CInstance* PInstance)
: m_PLuaInstance(PInstance)
{
    if (PInstance == nullptr)
    {
        ShowError("CLuaInstance created with nullptr instead of valid CInstance*!");
    }
}

uint16 CLuaInstance::getID()
{
    return m_PLuaInstance->GetID();
}

const std::string& CLuaInstance::getName()
{
    return m_PLuaInstance->GetName();
}

CLuaZone CLuaInstance::getZone()
{
    return CLuaZone(m_PLuaInstance->GetZone());
}

uint32 CLuaInstance::getEntranceZoneID()
{
    return instanceutils::GetInstanceData(m_PLuaInstance->GetID()).entrance_zone;
}

sol::table CLuaInstance::getAllies()
{
    auto table = lua.create_table();
    for (auto& member : m_PLuaInstance->m_allyList)
    {
        table.add(CLuaBaseEntity(member.second));
    }

    return table;
}

sol::table CLuaInstance::getChars()
{
    auto table = lua.create_table();
    for (auto& member : m_PLuaInstance->m_charList)
    {
        table.add(CLuaBaseEntity(member.second));
    }

    return table;
}

sol::table CLuaInstance::getMobs()
{
    auto table = lua.create_table();
    for (auto& member : m_PLuaInstance->m_mobList)
    {
        table.add(CLuaBaseEntity(member.second));
    }

    return table;
}

sol::table CLuaInstance::getNpcs()
{
    auto table = lua.create_table();
    for (auto& member : m_PLuaInstance->m_npcList)
    {
        table.add(CLuaBaseEntity(member.second));
    }

    return table;
}

sol::table CLuaInstance::getPets()
{
    auto table = lua.create_table();
    for (auto& member : m_PLuaInstance->m_petList)
    {
        table.add(CLuaBaseEntity(member.second));
    }

    return table;
}

uint32 CLuaInstance::getTimeLimit()
{
    uint32 limit = std::chrono::duration_cast<std::chrono::minutes>(m_PLuaInstance->GetTimeLimit()).count();
    return limit;
}

sol::table CLuaInstance::getEntryPos()
{
    position_t entry = m_PLuaInstance->GetEntryLoc();
    sol::table table = lua.create_table();

    table["x"]   = entry.x;
    table["y"]   = entry.y;
    table["z"]   = entry.z;
    table["rot"] = entry.rotation;

    return table;
}

uint8 CLuaInstance::getLevelCap()
{
    return m_PLuaInstance->GetLevelCap();
}

uint32 CLuaInstance::getLastTimeUpdate()
{
    auto time_ms = std::chrono::duration_cast<std::chrono::milliseconds>(m_PLuaInstance->GetLastTimeUpdate()).count();
    return static_cast<uint32>(time_ms);
}

uint32 CLuaInstance::getProgress()
{
    return m_PLuaInstance->GetProgress();
}

uint32 CLuaInstance::getWipeTime()
{
    auto time_ms = std::chrono::duration_cast<std::chrono::milliseconds>(m_PLuaInstance->GetWipeTime()).count();
    return static_cast<uint32>(time_ms);
}

std::optional<CLuaBaseEntity> CLuaInstance::getEntity(uint16 targid, sol::object const& filterObj)
{
    uint8 filter = -1;
    if (filterObj.is<uint8>())
    {
        filter = filterObj.as<uint8>();
    }

    CBaseEntity* PEntity = m_PLuaInstance->GetEntity(targid, filter);

    if (PEntity)
    {
        return std::optional<CLuaBaseEntity>(PEntity);
    }

    return std::nullopt;
}

uint32 CLuaInstance::getStage()
{
    return m_PLuaInstance->GetStage();
}

uint64_t CLuaInstance::getLocalVar(std::string const& name)
{
    return m_PLuaInstance->GetLocalVar(name);
}

void CLuaInstance::setLevelCap(uint8 cap)
{
    m_PLuaInstance->SetLevelCap(cap);
}

void CLuaInstance::setLastTimeUpdate(uint32 ms)
{
    m_PLuaInstance->SetLastTimeUpdate(std::chrono::milliseconds(ms));
}

void CLuaInstance::setTimeLimit(uint32 seconds)
{
    m_PLuaInstance->SetTimeLimit(std::chrono::seconds(seconds));
}

void CLuaInstance::setProgress(uint32 progress)
{
    m_PLuaInstance->SetProgress(progress);
}

void CLuaInstance::setWipeTime(uint32 ms)
{
    m_PLuaInstance->SetWipeTime(std::chrono::milliseconds(ms));
}

void CLuaInstance::setStage(uint32 stage)
{
    m_PLuaInstance->SetStage(stage);
}

void CLuaInstance::setLocalVar(std::string const& name, uint64_t value)
{
    m_PLuaInstance->SetLocalVar(name, value);
}

void CLuaInstance::fail()
{
    m_PLuaInstance->Fail();
}

bool CLuaInstance::failed()
{
    return m_PLuaInstance->Failed();
}

void CLuaInstance::complete()
{
    m_PLuaInstance->Complete();
}

bool CLuaInstance::completed()
{
    return m_PLuaInstance->Completed();
}

std::optional<CLuaBaseEntity> CLuaInstance::insertAlly(uint32 groupid)
{
    CMobEntity* PAlly = mobutils::InstantiateAlly(groupid, m_PLuaInstance->GetZone()->GetID(), m_PLuaInstance);

    if (PAlly)
    {
        return std::optional<CLuaBaseEntity>(PAlly);
    }

    ShowError("CLuaBattlefield::insertAlly - group ID %u not found!", groupid);
    return std::nullopt;
}

//==========================================================//

void CLuaInstance::Register()
{
    SOL_USERTYPE("CInstance", CLuaInstance);
    SOL_REGISTER("getID", CLuaInstance::getID);
    SOL_REGISTER("getName", CLuaInstance::getName);
    SOL_REGISTER("getZone", CLuaInstance::getZone);
    SOL_REGISTER("getEntranceZoneID", CLuaInstance::getEntranceZoneID);
    SOL_REGISTER("setLevelCap", CLuaInstance::setLevelCap);
    SOL_REGISTER("getAllies", CLuaInstance::getAllies);
    SOL_REGISTER("getChars", CLuaInstance::getChars);
    SOL_REGISTER("getMobs", CLuaInstance::getMobs);
    SOL_REGISTER("getNpcs", CLuaInstance::getNpcs);
    SOL_REGISTER("getPets", CLuaInstance::getPets);
    SOL_REGISTER("getTimeLimit", CLuaInstance::getTimeLimit);
    SOL_REGISTER("setTimeLimit", CLuaInstance::setTimeLimit);
    SOL_REGISTER("getEntryPos", CLuaInstance::getEntryPos);
    SOL_REGISTER("getLevelCap", CLuaInstance::getLevelCap);
    SOL_REGISTER("getLastTimeUpdate", CLuaInstance::getLastTimeUpdate);
    SOL_REGISTER("setLastTimeUpdate", CLuaInstance::setLastTimeUpdate);
    SOL_REGISTER("getProgress", CLuaInstance::getProgress);
    SOL_REGISTER("getEntity", CLuaInstance::getEntity);
    SOL_REGISTER("setProgress", CLuaInstance::setProgress);
    SOL_REGISTER("getWipeTime", CLuaInstance::getWipeTime);
    SOL_REGISTER("setWipeTime", CLuaInstance::setWipeTime);
    SOL_REGISTER("getStage", CLuaInstance::getStage);
    SOL_REGISTER("setStage", CLuaInstance::setStage);
    SOL_REGISTER("fail", CLuaInstance::fail);
    SOL_REGISTER("failed", CLuaInstance::failed);
    SOL_REGISTER("complete", CLuaInstance::complete);
    SOL_REGISTER("completed", CLuaInstance::completed);
    SOL_REGISTER("insertAlly", CLuaInstance::insertAlly);
    SOL_REGISTER("getLocalVar", CLuaInstance::getLocalVar);
    SOL_REGISTER("setLocalVar", CLuaInstance::setLocalVar);
}

std::ostream& operator<<(std::ostream& os, const CLuaInstance& instance)
{
    std::string id = instance.m_PLuaInstance ? std::to_string(instance.m_PLuaInstance->GetID()) : "nullptr";
    return os << "CLuaInstance(" << id << ")";
}

//======================================================//
