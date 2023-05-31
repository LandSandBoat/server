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

#include "campaign_system.h"
#include "entities/charentity.h"
#include "entities/npcentity.h"
#include "mob_modifier.h"
#include "trigger_area.h"
#include "utils/mobutils.h"
#include "zone.h"
#include "zone_entities.h"

#include "lua_baseentity.h"
#include "lua_zone.h"

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

void CLuaZone::registerTriggerArea(uint32 triggerAreaID, float x1, float y1, float z1, float x2, float y2, float z2)
{
    bool circleRegion = false;
    if (approximatelyEqual(x2, 0.0f) &&
        approximatelyEqual(y2, 0.0f) &&
        approximatelyEqual(z2, 0.0f))
    {
        circleRegion = true; // Parameters were 0, we must be a circle.
    }

    CTriggerArea* region = new CTriggerArea(triggerAreaID, circleRegion);

    // If this is a circle, parameter 3 (which would otherwise be vertical coordinate) will be the radius.
    region->SetULCorner(x1, y1, z1);
    region->SetLRCorner(x2, y2, z2);

    m_pLuaZone->InsertTriggerArea(region);
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
        table.add(CLuaBaseEntity(PChar));
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
    return m_pLuaZone->GetName();
}

REGION_TYPE CLuaZone::getRegionID()
{
    return m_pLuaZone->GetRegionID();
}

ZONE_TYPE CLuaZone::getType()
{
    return m_pLuaZone->GetType();
}

std::optional<CLuaBattlefield> CLuaZone::getBattlefieldByInitiator(uint32 charID)
{
    if (m_pLuaZone->m_BattlefieldHandler)
    {
        return std::optional<CLuaBattlefield>(m_pLuaZone->m_BattlefieldHandler->GetBattlefieldByInitiator(charID));
    }
    return std::nullopt;
}

bool CLuaZone::battlefieldsFull(int battlefieldId)
{
    return m_pLuaZone->m_BattlefieldHandler && m_pLuaZone->m_BattlefieldHandler->ReachedMaxCapacity(battlefieldId);
}

WEATHER CLuaZone::getWeather()
{
    return m_pLuaZone->GetWeather();
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

std::optional<CLuaBaseEntity> CLuaZone::insertDynamicEntity(sol::table table)
{
    CBaseEntity* PEntity = nullptr;
    if (table.get_or<uint8>("objtype", TYPE_NPC) == TYPE_NPC)
    {
        PEntity       = new CNpcEntity();
        PEntity->name = "DefaultName";
    }
    else
    {
        auto groupId     = table.get_or<uint32>("groupId", 0);
        auto groupZoneId = table.get_or<uint32>("groupZoneId", 0);

        PEntity = mobutils::InstantiateDynamicMob(groupId, groupZoneId, m_pLuaZone->GetID());
    }

    // This can happen if the Target's Zone ID is invalid.
    if (PEntity == nullptr)
    {
        ShowWarning("Failed to insert Dynamic Entity.");
        return std::nullopt;
    }

    // NOTE: Mob allegiance is the default for NPCs
    PEntity->allegiance = static_cast<ALLEGIANCE_TYPE>(table.get_or<uint8>("allegiance", ALLEGIANCE_TYPE::MOB));

    m_pLuaZone->GetZoneEntities()->AssignDynamicTargIDandLongID(PEntity);

    PEntity->loc.p.rotation = table.get_or<uint8>("rotation", 0);
    PEntity->loc.p.x        = table.get_or<float>("x", 0.01);
    PEntity->loc.p.y        = table.get_or<float>("y", 0.01);
    PEntity->loc.p.z        = table.get_or<float>("z", 0.01);
    PEntity->loc.p.moving   = 0;

    auto name = table.get_or<std::string>("name", "");
    if (name.empty())
    {
        ShowWarning("Trying to spawn dynamic entity without a name! (%s - %s)",
                    PEntity->GetName(), m_pLuaZone->GetName());

        // If the name hasn't been provided, use "DefaultName" for NPCs, and whatever comes from the mob_pool for Mobs
        name = PEntity->name;
    }

    auto lookupName = "DE_" + name;

    PEntity->name       = lookupName;
    PEntity->packetName = name;

    PEntity->isRenamed = true;

    PEntity->m_bReleaseTargIDOnDisappear = table["releaseIdOnDisappear"].get_or(false);

    auto typeKey    = (PEntity->objtype == TYPE_NPC) ? "npcs" : "mobs";
    auto cacheEntry = lua[sol::create_if_nil]["xi"]["zones"][m_pLuaZone->GetName()][typeKey][lookupName];

    // Bind any functions that are passed in
    for (auto& [entryKey, entryValue] : table)
    {
        if (entryValue.get_type() == sol::type::function)
        {
            cacheEntry[entryKey] = entryValue.as<sol::function>();
        }
    }

    if (auto* PNpc = dynamic_cast<CNpcEntity*>(PEntity))
    {
        PNpc->namevis     = table.get_or<uint8>("namevis", 0);
        PNpc->status      = STATUS_TYPE::NORMAL;
        PNpc->name_prefix = 32;

        // TODO: Does this even work?
        PNpc->widescan = table.get_or<uint8>("widescan", 1);

        uint32 flags  = table.get_or<uint32>("entityFlags", 0);
        PNpc->m_flags = flags == 0 ? PNpc->m_flags : flags;

        // Ensure that the npc is triggerable if onTrigger is passed in
        auto onTrigger = table["onTrigger"].get_or<sol::function>(sol::lua_nil);
        if (onTrigger.valid())
        {
            PNpc->m_triggerable = true;
        }

        m_pLuaZone->InsertNPC(PNpc);
    }
    else if (auto* PMob = dynamic_cast<CMobEntity*>(PEntity))
    {
        auto mixins = table["mixins"].get_or<sol::table>(sol::lua_nil);
        if (mixins.valid())
        {
            // Use the global function "applyMixins"
            auto result = lua["applyMixins"](CLuaBaseEntity(PMob), mixins);
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("applyMixins: %s: %s", PMob->name.c_str(), err.what());
            }
        }

        luautils::OnEntityLoad(PMob);

        luautils::OnMobInitialize(PMob);
        luautils::ApplyMixins(PMob);
        luautils::ApplyZoneMixins(PMob);

        PMob->saveModifiers();
        PMob->saveMobModifiers();

        PMob->m_isAggroable = table["isAggroable"].get_or(false);

        PMob->spawnAnimation = static_cast<SPAWN_ANIMATION>(table["specialSpawnAnimation"].get_or(false) ? 1 : 0);

        uint32 flags  = table.get_or<uint32>("entityFlags", 0);
        PMob->m_flags = flags == 0 ? PMob->m_flags : flags;

        // Ensure mobs get a function for onMobDeath
        auto onMobDeath = table["onMobDeath"].get<sol::function>();
        if (!onMobDeath.valid())
        {
            // TODO: Using an empty C++ lambda here wasn't working.
            // Figure out why and fix.
            cacheEntry["onMobDeath"] = lua.safe_script("return function() end");
        }

        m_pLuaZone->InsertMOB(PMob);
    }

    if (table["look"].get_type() == sol::type::number)
    {
        PEntity->SetModelId(table.get<uint16>("look"));
    }
    else if (table["look"].get_type() == sol::type::string)
    {
        auto lookStr  = table.get<std::string>("look");
        PEntity->look = stringToLook(lookStr);
    }

    PEntity->updatemask |= UPDATE_ALL_CHAR;

    return CLuaBaseEntity(PEntity);
}

/************************************************************************
 *  Function: SetSoloBattleMusic(253)
 *  Purpose : Set Solo Battle music for zone
 ************************************************************************/

void CLuaZone::setSoloBattleMusic(uint8 musicId)
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

void CLuaZone::setPartyBattleMusic(uint8 musicId)
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

void CLuaZone::setBackgroundMusicDay(uint8 musicId)
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

void CLuaZone::setBackgroundMusicNight(uint8 musicId)
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
        ShowWarning("Query for entity name: %s in zone: %s returned no results", name, m_pLuaZone->GetName());
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

    SOL_REGISTER("registerTriggerArea", CLuaZone::registerTriggerArea);
    SOL_REGISTER("levelRestriction", CLuaZone::levelRestriction);
    SOL_REGISTER("getPlayers", CLuaZone::getPlayers);
    SOL_REGISTER("getNPCs", CLuaZone::getNPCs);
    SOL_REGISTER("getMobs", CLuaZone::getMobs);
    SOL_REGISTER("getID", CLuaZone::getID);
    SOL_REGISTER("getName", CLuaZone::getName);
    SOL_REGISTER("getRegionID", CLuaZone::getRegionID);
    SOL_REGISTER("getType", CLuaZone::getType);
    SOL_REGISTER("getBattlefieldByInitiator", CLuaZone::getBattlefieldByInitiator);
    SOL_REGISTER("battlefieldsFull", CLuaZone::battlefieldsFull);
    SOL_REGISTER("getWeather", CLuaZone::getWeather);
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
