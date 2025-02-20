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

#include "lua_zone.h"

#include "common/logging.h"
#include "common/timer.h"

#include "entities/charentity.h"
#include "entities/npcentity.h"
#include "lua_baseentity.h"
#include "trigger_area.h"
#include "utils/mobutils.h"
#include "zone.h"
#include "zone_entities.h"

CLuaZone::CLuaZone(CZone* PZone)
: m_pLuaZone(PZone)
{
    if (PZone == nullptr)
    {
        ShowError("CLuaZone created with nullptr instead of valid CZone*!");
    }
}

/************************************************************************
 *  Function: getLocalVar()
 *  Purpose : Returns a variable assigned locally to an entity
 *  Example : if (KingArthro:getLocalVar("[POP]King_Arthro") > 0) then
 *  Notes   :
 ************************************************************************/

auto CLuaZone::getLocalVar(const char* key)
{
    return m_pLuaZone->GetLocalVar(key);
}

/************************************************************************
 *  Function: setLocalVar()
 *  Purpose : Assigns a local variable to an entity
 *  Example : mob:setLocalVar("pop", os.time() + math.random(1200,7200));
 *  Notes   :
 ************************************************************************/

void CLuaZone::setLocalVar(const char* key, uint32 val)
{
    m_pLuaZone->SetLocalVar(key, val);
}

void CLuaZone::resetLocalVars()
{
    m_pLuaZone->ResetLocalVars();
}

/************************************************************************
 *                                                                       *
 * Registering the active trigger area in the zone                       *
 * Input data format: RegionID, x1, y1, z1, x2, y2, z2                   *
 *                                                                       *
 ************************************************************************/

void CLuaZone::registerCuboidTriggerArea(uint32 triggerAreaID, float xMin, float yMin, float zMin, float xMax, float yMax, float zMax)
{
    auto tArea = std::make_unique<CCuboidTriggerArea>(triggerAreaID, xMin, yMin, zMin, xMax, yMax, zMax);
    m_pLuaZone->InsertTriggerArea(std::move(tArea));
}

void CLuaZone::registerCylindricalTriggerArea(uint32 triggerAreaID, float xPos, float zPos, float radius)
{
    auto tArea = std::make_unique<CCylindricalTriggerArea>(triggerAreaID, xPos, zPos, radius);
    m_pLuaZone->InsertTriggerArea(std::move(tArea));
}

void CLuaZone::registerSphericalTriggerArea(uint32 triggerAreaID, float xPos, float yPos, float zPos, float radius)
{
    auto tArea = std::make_unique<CSphericalTriggerArea>(triggerAreaID, xPos, yPos, zPos, radius);
    m_pLuaZone->InsertTriggerArea(std::move(tArea));
}

/************************************************************************
 *                                                                       *
 *  Setting the level limit for the zone                                 *
 *                                                                       *
 ************************************************************************/

sol::object CLuaZone::levelRestriction()
{
    return sol::lua_nil;
}

sol::table CLuaZone::getPlayers()
{
    auto table = lua.create_table();
    // clang-format off
    m_pLuaZone->ForEachChar([&table](CCharEntity* PChar)
    {
        table.add(PChar);
    });
    // clang-format on
    return table;
}

sol::table CLuaZone::getNPCs()
{
    auto table = lua.create_table();
    // clang-format off
    m_pLuaZone->ForEachNpc([&table](CNpcEntity* PNpc)
    {
        table.add(CLuaBaseEntity(PNpc));
    });
    // clang-format on
    return table;
}

sol::table CLuaZone::getMobs()
{
    auto table = lua.create_table();
    // clang-format off
    m_pLuaZone->ForEachMob([&table](CMobEntity* PMob)
    {
        table.add(CLuaBaseEntity(PMob));
    });
    // clang-format on
    return table;
}

ZONEID CLuaZone::getID()
{
    return m_pLuaZone->GetID();
}

const std::string& CLuaZone::getName()
{
    return m_pLuaZone->getName();
}

REGION_TYPE CLuaZone::getRegionID()
{
    return m_pLuaZone->GetRegionID();
}

ZONE_TYPE CLuaZone::getTypeMask()
{
    return m_pLuaZone->GetTypeMask();
}

auto CLuaZone::getBattlefieldByInitiator(uint32 charID) -> CBattlefield*
{
    if (m_pLuaZone->m_BattlefieldHandler)
    {
        return m_pLuaZone->m_BattlefieldHandler->GetBattlefieldByInitiator(charID);
    }
    return nullptr;
}

WEATHER CLuaZone::getWeather()
{
    return m_pLuaZone->GetWeather();
}

uint32 CLuaZone::getUptime()
{
    time_point currentTime   = std::chrono::system_clock::now(); // Gets the current time
    time_point zoneStartTime = get_server_start_time();          // Gets the start time of the zone group (cluster)

    long long uptime = std::chrono::duration_cast<std::chrono::seconds>(currentTime - zoneStartTime).count();
    // returns the zone up time in seconds
    return static_cast<uint32>(uptime);
}

void CLuaZone::reloadNavmesh()
{
    if (m_pLuaZone->m_navMesh)
    {
        m_pLuaZone->m_navMesh->reload();
    }
}

bool CLuaZone::isNavigablePoint(const sol::table& point)
{
    // clang-format off
    position_t position
    {
        point["x"].get_or<float>(0),
        point["y"].get_or<float>(0),
        point["z"].get_or<float>(0),
        point["moving"].get_or<uint16>(0),
        point["rot"].get_or<uint8>(0)
    };
    // clang-format on

    if (m_pLuaZone->m_navMesh)
    {
        return m_pLuaZone->m_navMesh->validPosition(position);
    }
    else // No navmesh, just nod and smile
    {
        return true;
    }
}

auto CLuaZone::insertDynamicEntity(sol::table table) -> CBaseEntity*
{
    return luautils::GenerateDynamicEntity(m_pLuaZone, nullptr, std::move(table));
}

/************************************************************************
 *  Function: SetSoloBattleMusic(253)
 *  Purpose : Set Solo Battle music for zone
 ************************************************************************/

void CLuaZone::setSoloBattleMusic(uint16 musicId)
{
    m_pLuaZone->SetSoloBattleMusic(musicId);
}

auto CLuaZone::getSoloBattleMusic()
{
    return m_pLuaZone->GetSoloBattleMusic();
}

/************************************************************************
 *  Function: SetPartyBattleMusic(253)
 *  Purpose : Set Party Battle music for zone
 ************************************************************************/

void CLuaZone::setPartyBattleMusic(uint16 musicId)
{
    m_pLuaZone->SetPartyBattleMusic(musicId);
}

auto CLuaZone::getPartyBattleMusic()
{
    return m_pLuaZone->GetPartyBattleMusic();
}

/************************************************************************
 *  Function: SetBackgroundMusicDay(253)
 *  Purpose : Set Background Day music for zone
 ************************************************************************/

void CLuaZone::setBackgroundMusicDay(uint16 musicId)
{
    m_pLuaZone->SetBackgroundMusicDay(musicId);
}

auto CLuaZone::getBackgroundMusicDay()
{
    return m_pLuaZone->GetBackgroundMusicDay();
}

/************************************************************************
 *  Function: SetBackgroundMusicNight(253)
 *  Purpose : Set Background Night music for zone
 ************************************************************************/

void CLuaZone::setBackgroundMusicNight(uint16 musicId)
{
    m_pLuaZone->SetBackgroundMusicNight(musicId);
}

auto CLuaZone::getBackgroundMusicNight()
{
    return m_pLuaZone->GetBackgroundMusicNight();
}

sol::table CLuaZone::queryEntitiesByName(std::string const& name)
{
    const QueryByNameResult_t& entities = m_pLuaZone->queryEntitiesByName(name);

    auto table = lua.create_table();
    for (CBaseEntity* entity : entities)
    {
        table.add(CLuaBaseEntity(entity));
    }

    if (table.empty())
    {
        ShowWarning("Query for entity name: %s in zone: %s returned no results", name, m_pLuaZone->getName());
    }

    return table;
}

//======================================================//

void CLuaZone::Register()
{
    SOL_USERTYPE("CZone", CLuaZone);

    SOL_REGISTER("getLocalVar", CLuaZone::getLocalVar);
    SOL_REGISTER("setLocalVar", CLuaZone::setLocalVar);
    SOL_REGISTER("resetLocalVars", CLuaZone::resetLocalVars);

    SOL_REGISTER("registerCuboidTriggerArea", CLuaZone::registerCuboidTriggerArea);
    SOL_REGISTER("registerCylindricalTriggerArea", CLuaZone::registerCylindricalTriggerArea);
    SOL_REGISTER("registerSphericalTriggerArea", CLuaZone::registerSphericalTriggerArea);

    SOL_REGISTER("levelRestriction", CLuaZone::levelRestriction);
    SOL_REGISTER("getPlayers", CLuaZone::getPlayers);
    SOL_REGISTER("getNPCs", CLuaZone::getNPCs);
    SOL_REGISTER("getMobs", CLuaZone::getMobs);
    SOL_REGISTER("getID", CLuaZone::getID);
    SOL_REGISTER("getName", CLuaZone::getName);
    SOL_REGISTER("getRegionID", CLuaZone::getRegionID);
    SOL_REGISTER("getTypeMask", CLuaZone::getTypeMask);
    SOL_REGISTER("getBattlefieldByInitiator", CLuaZone::getBattlefieldByInitiator);
    SOL_REGISTER("getWeather", CLuaZone::getWeather);
    SOL_REGISTER("getUptime", CLuaZone::getUptime);
    SOL_REGISTER("reloadNavmesh", CLuaZone::reloadNavmesh);
    SOL_REGISTER("isNavigablePoint", CLuaZone::isNavigablePoint);
    SOL_REGISTER("insertDynamicEntity", CLuaZone::insertDynamicEntity);

    SOL_REGISTER("getSoloBattleMusic", CLuaZone::getSoloBattleMusic);
    SOL_REGISTER("getPartyBattleMusic", CLuaZone::getPartyBattleMusic);
    SOL_REGISTER("getBackgroundMusicDay", CLuaZone::getBackgroundMusicDay);
    SOL_REGISTER("getBackgroundMusicNight", CLuaZone::getBackgroundMusicNight);
    SOL_REGISTER("setSoloBattleMusic", CLuaZone::setSoloBattleMusic);
    SOL_REGISTER("setPartyBattleMusic", CLuaZone::setPartyBattleMusic);
    SOL_REGISTER("setBackgroundMusicDay", CLuaZone::setBackgroundMusicDay);
    SOL_REGISTER("setBackgroundMusicNight", CLuaZone::setBackgroundMusicNight);

    SOL_REGISTER("queryEntitiesByName", CLuaZone::queryEntitiesByName);
}

std::ostream& operator<<(std::ostream& os, const CLuaZone& zone)
{
    std::string id = zone.m_pLuaZone ? std::to_string(zone.m_pLuaZone->GetID()) : "nullptr";
    return os << "CLuaZone(" << id << ")";
}

//======================================================//
