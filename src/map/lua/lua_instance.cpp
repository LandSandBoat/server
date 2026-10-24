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

#include "lua_instance.h"

#include "common/logging.h"
#include "common/timer.h"

#include "entities/npc_entity.h"
#include "instance.h"
#include "lua_base_entity.h"
#include "lua_zone.h"
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

auto CLuaInstance::getID() -> uint16
{
    return m_PLuaInstance->GetID();
}

auto CLuaInstance::getName() -> const std::string&
{
    return m_PLuaInstance->GetName();
}

auto CLuaInstance::getZone() -> CLuaZone
{
    return CLuaZone(m_PLuaInstance->GetZone());
}

auto CLuaInstance::getEntranceZoneID() -> uint32
{
    return instanceutils::GetInstanceData(m_PLuaInstance->GetID()).entrance_zone;
}

auto CLuaInstance::getAllies() -> sol::table
{
    // clang-format off
    auto table = lua.create_table();
    m_PLuaInstance->ForEachAlly([&](CMobEntity* PAlly)
    {
        table.add(CLuaBaseEntity(PAlly));
    });
    return table;
    // clang-format on
}

auto CLuaInstance::getChars() -> sol::table
{
    // clang-format off
    auto table = lua.create_table();
    m_PLuaInstance->ForEachChar([&](CCharEntity* PChar)
    {
        table.add(CLuaBaseEntity(PChar));
    });
    return table;
    // clang-format on
}

auto CLuaInstance::getMobs() -> sol::table
{
    // clang-format off
    auto table = lua.create_table();
    m_PLuaInstance->ForEachMob([&](CMobEntity* PMob)
    {
        table.add(CLuaBaseEntity(PMob));
    });
    return table;
    // clang-format on
}

auto CLuaInstance::getNpcs() -> sol::table
{
    // clang-format off
    auto table = lua.create_table();
    m_PLuaInstance->ForEachNpc([&](CNpcEntity* PNpc)
    {
        table.add(CLuaBaseEntity(PNpc));
    });
    return table;
    // clang-format on
}

auto CLuaInstance::getPets() -> sol::table
{
    // clang-format off
    auto table = lua.create_table();
    m_PLuaInstance->ForEachPet([&](CPetEntity* PPet)
    {
        table.add(CLuaBaseEntity(PPet));
    });
    return table;
    // clang-format on
}

auto CLuaInstance::getTimeLimit() -> uint32
{
    return static_cast<uint32>(timer::count_seconds(m_PLuaInstance->GetTimeLimit()));
}

auto CLuaInstance::getEntryPos() -> sol::table
{
    position_t entry = m_PLuaInstance->GetEntryLoc();
    sol::table table = lua.create_table();

    table["x"]   = entry.x;
    table["y"]   = entry.y;
    table["z"]   = entry.z;
    table["rot"] = entry.rotation;

    return table;
}

auto CLuaInstance::getLevelCap() -> uint8
{
    return m_PLuaInstance->GetLevelCap();
}

auto CLuaInstance::getLastTimeUpdate() -> uint32
{
    return static_cast<uint32>(timer::count_seconds(m_PLuaInstance->GetLastTimeUpdate()));
}

auto CLuaInstance::getProgress() -> uint32
{
    return m_PLuaInstance->GetProgress();
}

auto CLuaInstance::getWipeTime() -> uint32
{
    return static_cast<uint32>(timer::count_seconds(m_PLuaInstance->GetWipeTime()));
}

auto CLuaInstance::getEntity(uint16 targid, const sol::object& filterObj) -> CBaseEntity*
{
    uint8 filter = -1;
    if (filterObj.is<uint8>())
    {
        filter = filterObj.as<uint8>();
    }

    return m_PLuaInstance->GetEntity(targid, filter);
}

auto CLuaInstance::getStage() -> uint32
{
    return m_PLuaInstance->GetStage();
}

auto CLuaInstance::getLocalVar(const std::string& name) -> uint64_t
{
    return m_PLuaInstance->GetLocalVar(name);
}

void CLuaInstance::setLevelCap(uint8 cap)
{
    m_PLuaInstance->SetLevelCap(cap);
}

void CLuaInstance::setLastTimeUpdate(uint32 seconds)
{
    m_PLuaInstance->SetLastTimeUpdate(std::chrono::seconds(seconds));
}

void CLuaInstance::setTimeLimit(uint32 seconds)
{
    m_PLuaInstance->SetTimeLimit(std::chrono::seconds(seconds));
}

void CLuaInstance::setProgress(uint32 progress)
{
    m_PLuaInstance->SetProgress(progress);
}

void CLuaInstance::setWipeTime(uint32 seconds)
{
    m_PLuaInstance->SetWipeTime(std::chrono::seconds(seconds));
}

void CLuaInstance::setStage(uint32 stage)
{
    m_PLuaInstance->SetStage(stage);
}

void CLuaInstance::setLocalVar(const std::string& name, uint64_t value)
{
    m_PLuaInstance->SetLocalVar(name, value);
}

void CLuaInstance::fail()
{
    m_PLuaInstance->Fail();
}

auto CLuaInstance::failed() -> bool
{
    return m_PLuaInstance->Failed();
}

void CLuaInstance::complete()
{
    m_PLuaInstance->Complete();
}

auto CLuaInstance::completed() -> bool
{
    return m_PLuaInstance->Completed();
}

auto CLuaInstance::insertAlly(uint32 groupid) -> CBaseEntity*
{
    CMobEntity* PAlly = mobutils::InstantiateAlly(groupid, m_PLuaInstance->GetZone()->GetID(), m_PLuaInstance);

    if (PAlly)
    {
        return PAlly;
    }

    ShowError("CLuaBattlefield::insertAlly - group ID %u not found!", groupid);
    return PAlly;
}

auto CLuaInstance::insertDynamicEntity(sol::table table) -> CBaseEntity*
{
    return luautils::GenerateDynamicEntity(m_PLuaInstance->GetZone(), m_PLuaInstance, std::move(table));
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
    SOL_REGISTER("insertDynamicEntity", CLuaInstance::insertDynamicEntity);
    SOL_REGISTER("getLocalVar", CLuaInstance::getLocalVar);
    SOL_REGISTER("setLocalVar", CLuaInstance::setLocalVar);
}

auto operator<<(std::ostream& os, const CLuaInstance& instance) -> std::ostream&
{
    std::string id = instance.m_PLuaInstance ? std::to_string(instance.m_PLuaInstance->GetID()) : "nullptr";
    return os << "CLuaInstance(" << id << ")";
}

//======================================================//
