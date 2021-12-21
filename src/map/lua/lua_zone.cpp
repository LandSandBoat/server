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

#include "../region.h"

#include "../entities/charentity.h"
#include "../entities/npcentity.h"
#include "../zone.h"
#include "../zone_entities.h"
#include "lua_baseentity.h"
#include "lua_zone.h"
#include "../utils/mobutils.h"
#include "../mob_modifier.h"

CLuaZone::CLuaZone(CZone* PZone)
: m_pLuaZone(PZone)
{
    if (PZone == nullptr)
    {
        ShowError("CLuaZone created with nullptr instead of valid CZone*!");
    }
}

/************************************************************************
 *                                                                       *
 * Registering the active area in the zone                               *
 * Input data format: RegionID, x1, y1, z1, x2, y2, z2                   *
 *                                                                       *
 ************************************************************************/

void CLuaZone::registerRegion(uint32 RegionID, float x1, float y1, float z1, float x2, float y2, float z2)
{
    bool circleRegion = false;
    if (approximatelyEqual(x2, 0.0f) &&
        approximatelyEqual(y2, 0.0f) &&
        approximatelyEqual(z2, 0.0f))
    {
        circleRegion = true; // Parameters were 0, we must be a circle.
    }

    CRegion* Region = new CRegion(RegionID, circleRegion);

    // If this is a circle, parameter 3 (which would otherwise be vertical coordinate) will be the radius.
    Region->SetULCorner(x1, y1, z1);
    Region->SetLRCorner(x2, y2, z2);

    m_pLuaZone->InsertRegion(Region);
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
    auto table = luautils::lua.create_table();
    m_pLuaZone->ForEachChar([&table](CCharEntity* PChar) { table.add(CLuaBaseEntity(PChar)); });
    return table;
}

sol::table CLuaZone::getNPCs()
{
    auto table = luautils::lua.create_table();
    m_pLuaZone->ForEachNpc([&table](CNpcEntity* PNpc) { table.add(CLuaBaseEntity(PNpc)); });
    return table;
}

ZONEID CLuaZone::getID()
{
    return m_pLuaZone->GetID();
}

std::string CLuaZone::getName()
{
    return reinterpret_cast<const char*>(m_pLuaZone->GetName());
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
    m_pLuaZone->m_navMesh->reload();
}

std::optional<CLuaBaseEntity> CLuaZone::insertDynamicEntity(sol::table table)
{
    CBaseEntity* PEntity = nullptr;
    if (table.get_or<uint8>("objtype", TYPE_NPC) == TYPE_NPC)
    {
        PEntity = new CNpcEntity();
    }
    else
    {
        PEntity = new CMobEntity();
    }

    // NOTE: Mob allegiance is the default for NPCs
    PEntity->allegiance = static_cast<ALLEGIANCE_TYPE>(table.get_or<uint8>("allegiance", ALLEGIANCE_TYPE::MOB));

    uint16 ZoneID = m_pLuaZone->GetID();

    // TODO: Wrap this entity in a unique_ptr that will free this dynamic targ ID
    //       on despawn/destruction
    // TODO: The tracking of these IDs is pretty bad also, fix that in zone_entities
    PEntity->targid = m_pLuaZone->GetZoneEntities()->GetNewDynamicTargID();

    PEntity->id = 0x1000000 + (ZoneID << 12) + PEntity->targid;

    auto name = table.get_or<std::string>("name", "DynamicEntity");
    PEntity->name.insert(0, name.c_str());

    PEntity->SetModelId(table.get_or<uint16>("modelId", 0));

    PEntity->loc.zone       = m_pLuaZone;
    PEntity->loc.p.rotation = table.get_or<uint8>("rotation", 0);
    PEntity->loc.p.x        = table.get_or<float>("x", 0.01);
    PEntity->loc.p.y        = table.get_or<float>("y", 0.01);
    PEntity->loc.p.z        = table.get_or<float>("z", 0.01);
    PEntity->loc.p.moving   = 0;

    PEntity->speed        = 50;
    PEntity->speedsub     = 50;

    PEntity->animation    = 0;
    PEntity->animationsub = 0;

    PEntity->updatemask |= UPDATE_ALL_MOB;

    if (auto* PNpc = dynamic_cast<CNpcEntity*>(PEntity))
    {
        PNpc->namevis       = table.get_or<uint8>("namevis", 0);
        PNpc->status        = STATUS_TYPE::NORMAL;
        PNpc->m_flags       = table.get_or<uint32>("m_flags", 0);
        PNpc->name_prefix   = table.get_or<uint8>("name_prefix", 32);
        PNpc->widescan      = 0;
        PNpc->m_triggerable = table.get_or("triggerable", false);

        m_pLuaZone->InsertNPC(PNpc);
    }
    else if (auto* PMob = dynamic_cast<CMobEntity*>(PEntity))
    {
        PMob->m_RespawnTime = 1000;
        PMob->m_SpawnType   = SPAWNTYPE_SCRIPTED;
        PMob->m_DropID      = 0;

        PMob->m_minLevel = 80;
        PMob->m_maxLevel = 80;

        PMob->SetMJob(1);
        PMob->SetSJob(1);

        //((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
        //((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(Sql_GetIntData(SqlHandle, 17));
        //PMob->m_dmgMult = Sql_GetUIntData(SqlHandle, 18);
        //((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((Sql_GetIntData(SqlHandle, 19) * 1000) / 60);
        //((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((Sql_GetIntData(SqlHandle, 19) * 1000) / 60);

        PMob->m_Behaviour = BEHAVIOUR_NONE;
        PMob->m_Link      = 0;
        PMob->m_Type      = MOBTYPE_NORMAL;
        PMob->m_Immunity  = 0;
        PMob->m_EcoSystem = ECOSYSTEM::DRAGON;
        PMob->m_ModelSize = 0;

        PMob->speed    = 50;
        PMob->speedsub = 50;

        PMob->strRank = 1;
        PMob->dexRank = 1;
        PMob->vitRank = 1;
        PMob->agiRank = 1;
        PMob->intRank = 1;
        PMob->mndRank = 1;
        PMob->chrRank = 1;
        PMob->evaRank = 1;
        PMob->defRank = 1;
        PMob->attRank = 1;
        PMob->accRank = 1;

        PMob->m_Element     = 1;
        PMob->m_Family      = 1;
        PMob->m_name_prefix = 0;
        //PMob->m_flags       = 0;

        // Setup HP / MP Stat Percentage Boost
        PMob->HPscale = 100;
        PMob->MPscale = 100;

        // Check if we should be looking up scripts for this mob
        //PMob->m_HasSpellScript = (uint8)Sql_GetIntData(SqlHandle, 65);

        //PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(Sql_GetIntData(SqlHandle, 66));

        //PMob->m_Pool = 1280;

        PMob->allegiance = ALLEGIANCE_TYPE::MOB;
        //PMob->namevis    = 0;
        PMob->m_Aggro    = 1;

        PMob->m_roamFlags    = 0;
        PMob->m_MobSkillList = 0;

        PMob->m_TrueDetection = 1;
        PMob->m_Detects       = 1;

        PMob->namevis       = table.get_or<uint8>("namevis", 0);
        PMob->status        = STATUS_TYPE::NORMAL;
        PMob->m_flags       = table.get_or<uint32>("m_flags", 0);
        PMob->m_name_prefix = table.get_or<uint8>("name_prefix", 32);

        mobutils::CalculateStats(PMob);
        mobutils::InitializeMob(PMob, m_pLuaZone);

        PMob->health.modhp = 1000;
        PMob->health.maxhp = 1000;
        PMob->health.hp = 1000;

        // never despawn
        PMob->SetDespawnTime(0s);
        PMob->setMobMod(MOBMOD_ALLI_HATE, 200);
        PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);
        PMob->setMobMod(MOBMOD_IDLE_DESPAWN, 0);


        m_pLuaZone->InsertMOB(PMob);

        PMob->m_SpawnPoint = PMob->loc.p;
        PMob->Spawn();

        // Set spawn point after since ::Spawn() wipes it
    }

    return CLuaBaseEntity(PEntity);
}

//======================================================//

void CLuaZone::Register()
{
    SOL_USERTYPE("CZone", CLuaZone);
    SOL_REGISTER("registerRegion", CLuaZone::registerRegion);
    SOL_REGISTER("levelRestriction", CLuaZone::levelRestriction);
    SOL_REGISTER("getPlayers", CLuaZone::getPlayers);
    SOL_REGISTER("getNPCs", CLuaZone::getNPCs);
    SOL_REGISTER("getID", CLuaZone::getID);
    SOL_REGISTER("getName", CLuaZone::getName);
    SOL_REGISTER("getRegionID", CLuaZone::getRegionID);
    SOL_REGISTER("getType", CLuaZone::getType);
    SOL_REGISTER("getBattlefieldByInitiator", CLuaZone::getBattlefieldByInitiator);
    SOL_REGISTER("battlefieldsFull", CLuaZone::battlefieldsFull);
    SOL_REGISTER("getWeather", CLuaZone::getWeather);
    SOL_REGISTER("reloadNavmesh", CLuaZone::reloadNavmesh);
    SOL_REGISTER("insertDynamicEntity", CLuaZone::insertDynamicEntity);
}

std::ostream& operator<<(std::ostream& os, const CLuaZone& zone)
{
    std::string id = zone.m_pLuaZone ? std::to_string(zone.m_pLuaZone->GetID()) : "nullptr";
    return os << "CLuaZone(" << id << ")";
}

//======================================================//
