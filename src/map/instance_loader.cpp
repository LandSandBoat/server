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

#include <chrono>
#include <future>

#include "instance_loader.h"
#include "zone_instance.h"

#include "common/async.h"
#include "common/sql.h"

#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "instance.h"
#include "items/item_weapon.h"
#include "lua/luautils.h"
#include "mob_modifier.h"
#include "mob_spell_list.h"
#include "zone_entities.h"
#include "zone_instance.h"

#include "utils/instanceutils.h"
#include "utils/mobutils.h"
#include "utils/zoneutils.h"

CInstanceLoader::CInstanceLoader(const ipc::InstanceLoadRequest& message)
{
    TracyZoneScoped;

    const auto instanceData = instanceutils::GetInstanceData(message.instanceId);
    CZone*     PZone        = zoneutils::GetZone(instanceData.instanceZoneId);

    if (!PZone || !(PZone->GetTypeMask() & ZONE_TYPE::INSTANCED))
    {
        ShowError("Invalid zone for instanceId: %d", message.instanceId);
        return;
    }

    m_PZone     = PZone;
    m_PInstance = static_cast<CZoneInstance*>(PZone)->CreateInstance(message.instanceId);

    m_PInstance->RegisterCommander(message.requesterId);

    for (const auto charId : message.memberIds)
    {
        m_PInstance->RegisterChar(charId);
    }

    // clang-format off
    Async::getInstance()->submit([this]
    {
        loadInstanceMobSQL();
        loadInstanceNPCSQL();

        m_LoadPhase = LoadPhase::Lua;
    });
    // clang-format on;
}

CInstanceLoader::~CInstanceLoader()
{
    TracyZoneScoped;
}

void CInstanceLoader::loadInstanceMobSQL()
{
    TracyZoneScoped;

    // TODO: Extract this query out so it's shared with the similar one in LoadMOBList

    const auto query = "SELECT mobname, mobid, pos_rot, pos_x, pos_y, pos_z, "
                       "respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, "
                       "modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, "
                       "ecosystemID, mobradius, speed, "
                       "STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, ATT, ACC, "
                       "slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, "
                       "magical_sdt, fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, "
                       "fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, "
                       "Element, mob_pools.familyid, mob_family_system.superFamilyID, name_prefix, entityFlags, animationsub, "
                       "(mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, mob_groups.poolid, "
                       "allegiance, namevis, aggro, mob_pools.skill_list_id, mob_pools.true_detection, detects, "
                       "mob_family_system.charmable "
                       "FROM instance_entities "
                       "INNER JOIN mob_spawn_points ON instance_entities.id = mob_spawn_points.mobid "
                       "INNER JOIN mob_groups ON mob_groups.groupid = mob_spawn_points.groupid AND mob_groups.zoneid=((mob_spawn_points.mobid>>12)&0xFFF) "
                       "INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid "
                       "INNER JOIN mob_resistances ON mob_resistances.resist_id = mob_pools.resist_id "
                       "INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyID "
                       "WHERE instanceid = ? AND NOT (pos_x = 0 AND pos_y = 0 AND pos_z = 0)";

    const auto rset = db::preparedStmt(query, m_PInstance->GetID());

    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        CMobEntity* PMob = new CMobEntity();

        PMob->name   = rset->get<std::string>("mobname");
        PMob->id     = rset->get<uint32>("mobid");
        PMob->targid = PMob->id & 0x0FFF;

        PMob->m_SpawnPoint.rotation = rset->get<uint8>("pos_rot");
        PMob->m_SpawnPoint.x        = rset->get<float>("pos_x");
        PMob->m_SpawnPoint.y        = rset->get<float>("pos_y");
        PMob->m_SpawnPoint.z        = rset->get<float>("pos_z");
        PMob->loc.p                 = PMob->m_SpawnPoint;

        PMob->m_RespawnTime = rset->get<uint32>("respawntime") * 1000;
        PMob->m_SpawnType   = static_cast<SPAWNTYPE>(rset->get<uint8>("spawntype"));
        PMob->m_DropID      = rset->get<uint32>("dropid");

        PMob->HPmodifier = rset->get<uint32>("HP");
        PMob->MPmodifier = rset->get<uint32>("MP");

        PMob->m_minLevel = rset->get<uint8>("minLevel");
        PMob->m_maxLevel = rset->get<uint8>("maxLevel");

        db::extractFromBlob(rset, "modelid", PMob->look);

        PMob->SetMJob(rset->get<uint8>("mJob"));
        PMob->SetSJob(rset->get<uint8>("sJob"));

        auto* mainWeapon = static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN]);

        mainWeapon->setMaxHit(1);
        mainWeapon->setSkillType(rset->get<uint8>("cmbSkill"));

        PMob->m_dmgMult = rset->get<uint16>("cmbDmgMult");

        mainWeapon->setDelay((rset->get<uint16>("cmbDelay") * 1000) / 60);
        mainWeapon->setBaseDelay((rset->get<uint16>("cmbDelay") * 1000) / 60);

        PMob->m_Behavior    = static_cast<BEHAVIOR>(rset->get<uint8>("behavior"));
        PMob->m_Link        = rset->get<uint32>("links");
        PMob->m_Type        = static_cast<MOBTYPE>(rset->get<uint32>("mobType"));
        PMob->m_Immunity    = rset->get<uint32>("immunity");
        PMob->m_EcoSystem   = static_cast<ECOSYSTEM>(rset->get<uint32>("ecosystemID"));
        PMob->m_ModelRadius = rset->get<float>("mobradius");

        PMob->baseSpeed      = rset->get<uint8>("speed");
        PMob->animationSpeed = rset->get<uint8>("speed");
        PMob->UpdateSpeed();

        PMob->strRank = rset->get<uint8>("STR");
        PMob->dexRank = rset->get<uint8>("DEX");
        PMob->vitRank = rset->get<uint8>("VIT");
        PMob->agiRank = rset->get<uint8>("AGI");
        PMob->intRank = rset->get<uint8>("INT");
        PMob->mndRank = rset->get<uint8>("MND");
        PMob->chrRank = rset->get<uint8>("CHR");
        PMob->evaRank = rset->get<uint8>("EVA");
        PMob->defRank = rset->get<uint8>("DEF");
        PMob->attRank = rset->get<uint8>("ATT");
        PMob->accRank = rset->get<uint8>("ACC");

        PMob->setModifier(Mod::SLASH_SDT, rset->get<int16>("slash_sdt"));
        PMob->setModifier(Mod::PIERCE_SDT, rset->get<int16>("pierce_sdt"));
        PMob->setModifier(Mod::HTH_SDT, rset->get<int16>("h2h_sdt"));
        PMob->setModifier(Mod::IMPACT_SDT, rset->get<int16>("impact_sdt"));

        PMob->setModifier(Mod::UDMGMAGIC, rset->get<int16>("magical_sdt"));

        PMob->setModifier(Mod::FIRE_SDT, rset->get<int16>("fire_sdt"));
        PMob->setModifier(Mod::ICE_SDT, rset->get<int16>("ice_sdt"));
        PMob->setModifier(Mod::WIND_SDT, rset->get<int16>("wind_sdt"));
        PMob->setModifier(Mod::EARTH_SDT, rset->get<int16>("earth_sdt"));
        PMob->setModifier(Mod::THUNDER_SDT, rset->get<int16>("lightning_sdt"));
        PMob->setModifier(Mod::WATER_SDT, rset->get<int16>("water_sdt"));
        PMob->setModifier(Mod::LIGHT_SDT, rset->get<int16>("light_sdt"));
        PMob->setModifier(Mod::DARK_SDT, rset->get<int16>("dark_sdt"));

        PMob->setModifier(Mod::FIRE_RES_RANK, rset->get<int8>("fire_res_rank"));
        PMob->setModifier(Mod::ICE_RES_RANK, rset->get<int8>("ice_res_rank"));
        PMob->setModifier(Mod::WIND_RES_RANK, rset->get<int8>("wind_res_rank"));
        PMob->setModifier(Mod::EARTH_RES_RANK, rset->get<int8>("earth_res_rank"));
        PMob->setModifier(Mod::THUNDER_RES_RANK, rset->get<int8>("lightning_res_rank"));
        PMob->setModifier(Mod::WATER_RES_RANK, rset->get<int8>("water_res_rank"));
        PMob->setModifier(Mod::LIGHT_RES_RANK, rset->get<int8>("light_res_rank"));
        PMob->setModifier(Mod::DARK_RES_RANK, rset->get<int8>("dark_res_rank"));

        PMob->m_Element     = rset->get<uint8>("Element");
        PMob->m_Family      = rset->get<uint16>("familyid");
        PMob->m_SuperFamily = rset->get<uint16>("superFamilyID");
        PMob->m_name_prefix = rset->get<uint8>("name_prefix");
        PMob->m_flags       = rset->get<uint32>("entityFlags");

        // Special sub animation for Mob (yovra, jailer of love, phuabo)
        // yovra 1: On top/in the sky, 2: , 3: On top/in the sky
        // phuabo 1: Underwater, 2: Out of the water, 3: Goes back underwater
        PMob->animationsub = rset->get<uint8>("animationsub");

        // Setup HP / MP Stat Percentage Boost
        PMob->HPscale = rset->get<float>("(mob_family_system.HP / 100)");
        PMob->MPscale = rset->get<float>("(mob_family_system.MP / 100)");

        PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(rset->get<uint16>("spellList"));

        PMob->m_Pool = rset->get<uint32>("poolid");

        PMob->allegiance = static_cast<ALLEGIANCE_TYPE>(rset->get<uint8>("allegiance"));
        PMob->namevis    = rset->get<uint8>("namevis");
        PMob->m_Aggro    = rset->get<bool>("aggro");

        // If a special instanced mob aggros, it should always aggro regardless of level.
        if (PMob->m_Type & MOBTYPE_EVENT)
        {
            PMob->setMobMod(MOBMOD_ALWAYS_AGGRO, PMob->m_Aggro);
        }

        PMob->m_MobSkillList  = rset->get<uint16>("skill_list_id");
        PMob->m_TrueDetection = rset->get<bool>("true_detection");
        PMob->setMobMod(MOBMOD_DETECTION, rset->get<uint16>("detects"));

        PMob->setMobMod(MOBMOD_CHARMABLE, rset->get<uint16>("charmable"));

        // Overwrite base family charmables depending on mob type. Disallowed mobs which should be charmable
        // can be set in their onInitialize
        if (PMob->m_Type & MOBTYPE_EVENT ||
            PMob->m_Type & MOBTYPE_FISHED ||
            PMob->m_Type & MOBTYPE_BATTLEFIELD ||
            PMob->m_Type & MOBTYPE_NOTORIOUS)
        {
            PMob->setMobMod(MOBMOD_CHARMABLE, 0);
        }

        // must be here first to define mobmods
        mobutils::InitializeMob(PMob);

        PMob->PInstance = m_PInstance;

        m_PInstance->InsertMOB(PMob);
    }
}

void CInstanceLoader::loadInstanceMobLua()
{
    TracyZoneScoped;

    // clang-format off
    // Finish setting up Mobs
    m_PInstance->ForEachMob([&](CMobEntity* PMob)
    {
        luautils::OnMobInitialize(PMob);
        luautils::ApplyMixins(PMob);

        PMob->saveModifiers();
        PMob->saveMobModifiers();

        // Add to cache
        luautils::CacheLuaObjectFromFile(
            fmt::format("./scripts/zones/{}/mobs/{}.lua",
                        PMob->loc.zone->getName(),
                        PMob->getName()));
    });
    // clang-format on
}

void CInstanceLoader::loadInstanceNPCSQL()
{
    TracyZoneScoped;

    // TODO: Extract this query out so it's shared with the similar one in LoadNPCList

    const auto query = "SELECT npcid, name, pos_rot, pos_x, pos_y, pos_z, "
                       "flag, speed, speedsub, animation, animationsub, namevis, "
                       "status, entityFlags, look, name_prefix, widescan  "
                       "FROM instance_entities INNER JOIN npc_list ON "
                       "(instance_entities.id = npc_list.npcid) "
                       "WHERE instanceid = ? AND npcid >= ? AND npcid < ?";

    uint32 zoneMin = (m_PZone->GetID() << 12) + 0x1000000;
    uint32 zoneMax = zoneMin + 1024;

    const auto rset = db::preparedStmt(query, m_PInstance->GetID(), zoneMin, zoneMax);

    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        CNpcEntity* PNpc = new CNpcEntity;

        PNpc->id     = rset->get<uint32>("npcid");
        PNpc->targid = PNpc->id & 0x0FFF;

        PNpc->name = rset->get<std::string>("name");

        PNpc->loc.p.rotation = rset->get<uint8>("pos_rot");
        PNpc->loc.p.x        = rset->get<float>("pos_x");
        PNpc->loc.p.y        = rset->get<float>("pos_y");
        PNpc->loc.p.z        = rset->get<float>("pos_z");
        PNpc->loc.p.moving   = rset->get<uint16>("flag");

        PNpc->m_TargID = rset->get<uint32>("flag") >> 16;

        PNpc->animationSpeed = rset->get<uint8>("speedsub");
        PNpc->baseSpeed      = rset->get<uint8>("speed");
        PNpc->UpdateSpeed();

        PNpc->animation    = rset->get<uint8>("animation");
        PNpc->animationsub = rset->get<uint8>("animationsub");

        PNpc->namevis = rset->get<uint8>("namevis");
        PNpc->status  = static_cast<STATUS_TYPE>(rset->get<uint8>("status"));
        PNpc->m_flags = rset->get<uint32>("entityFlags");

        db::extractFromBlob(rset, "look", PNpc->look);

        PNpc->name_prefix = rset->get<uint8>("name_prefix");
        PNpc->widescan    = rset->get<uint8>("widescan");

        PNpc->PInstance = m_PInstance;

        m_PInstance->InsertNPC(PNpc);
    }
}

void CInstanceLoader::loadInstanceNPCLua()
{
    TracyZoneScoped;

    // clang-format off
    // Finish setting up NPCs
    m_PInstance->ForEachNpc([&](CNpcEntity* PNpc)
    {
        luautils::OnNpcSpawn(PNpc);

        // Add to cache
        luautils::CacheLuaObjectFromFile(
            fmt::format("./scripts/zones/{}/npcs/{}.lua",
                        PNpc->loc.zone->getName(),
                        PNpc->getName()));
    });
    // clang-format on
}

void CInstanceLoader::update()
{
    switch (m_LoadPhase)
    {
        case LoadPhase::SQLPending:
            break;
        case LoadPhase::Lua:
            loadInstanceMobLua();
            loadInstanceNPCLua();
            luautils::OnInstanceCreated(m_PInstance);
            m_LoadPhase = LoadPhase::Done;
            break;
        case LoadPhase::Done:
            break;
    }
}

bool CInstanceLoader::ready()
{
    return m_LoadPhase == LoadPhase::Done;
}

auto CInstanceLoader::getInstance() -> CInstance*
{
    return m_PInstance;
}
