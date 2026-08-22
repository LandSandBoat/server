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

#include "instance_loader.h"
#include "zone_instance.h"

#include "data/enums/mob_mod.h"
#include "entities/mob_entity.h"
#include "entities/npc_entity.h"
#include "instance.h"
#include "items/item_weapon.h"
#include "lua/luautils.h"
#include "mob_spell_list.h"

#include "utils/instanceutils.h"
#include "utils/mobutils.h"
#include "utils/zoneutils.h"

CInstanceLoader::CInstanceLoader(uint32 instanceid, CCharEntity* PRequester)
{
    TracyZoneScoped;

    auto   instanceData = instanceutils::GetInstanceData(instanceid);
    CZone* PZone        = zoneutils::GetZone(instanceData.instance_zone);

    if (!PZone || !((PZone->GetTypeMask() & xi::ZoneType::Instanced) != xi::ZoneType::Unknown))
    {
        ShowError("Invalid zone for instanceid: %d", instanceid);
        return;
    }

    m_PRequester = PRequester;
    m_PZone      = PZone;
    m_PInstance  = ((CZoneInstance*)PZone)->CreateInstance(instanceid);
}

CInstanceLoader::~CInstanceLoader()
{
    TracyZoneScoped;
}

auto CInstanceLoader::LoadInstance() const -> CInstance*
{
    TracyZoneScoped;

    const auto realZoneId      = m_PZone->GetID();
    const auto overlayId       = m_PInstance->overlayId();
    const auto effectiveZoneId = (overlayId != 0) ? overlayId : static_cast<uint32>(realZoneId);

    auto rset = db::preparedStmt("SELECT mobname, mobid, pos_rot, pos_x, pos_y, pos_z, "
                                 "respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, "
                                 "modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, "
                                 "slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, "
                                 "magical_sdt, fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, "
                                 "fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, "
                                 "paralyze_res_rank, bind_res_rank, silence_res_rank, slow_res_rank, poison_res_rank, light_sleep_res_rank, dark_sleep_res_rank, blind_res_rank, stun_res_rank, gravity_res_rank, "
                                 "mob_pools.speciesid, name_prefix, entityFlags, animationsub, "
                                 "hasSpellScript, spellList, mob_groups.poolid, "
                                 "allegiance, namevis, aggro, mob_pools.roamflag, mob_pools.skill_list_id, mob_pools.true_detection, "
                                 "mob_pools.modelSize, mob_pools.modelHitboxSize "
                                 "FROM instance_entities "
                                 "INNER JOIN mob_spawn_points ON instance_entities.id = mob_spawn_points.mobid "
                                 "INNER JOIN mob_groups ON mob_groups.groupid = mob_spawn_points.groupid AND mob_groups.zoneid = ? "
                                 "INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid "
                                 "INNER JOIN mob_resistances ON mob_resistances.resist_id = mob_pools.resist_id "
                                 "WHERE instanceid = ? "
                                 "  AND ((mob_spawn_points.mobid >> 12) & 0xFFF) = ? "
                                 "  AND NOT (pos_x = 0 AND pos_y = 0 AND pos_z = 0)",
                                 realZoneId,
                                 m_PInstance->GetID(),
                                 effectiveZoneId);

    if (!m_PInstance->Failed())
    {
        FOR_DB_MULTIPLE_RESULTS(rset)
        {
            auto* PMob = new CMobEntity();

            PMob->name.insert(0, rset->get<std::string>("mobname"));
            PMob->id     = rset->get<uint32>("mobid");
            PMob->targid = static_cast<uint16>(PMob->id) & 0x0FFF;

            PMob->m_SpawnPoint.rotation = rset->get<uint8>("pos_rot");
            PMob->m_SpawnPoint.x        = rset->get<float>("pos_x");
            PMob->m_SpawnPoint.y        = rset->get<float>("pos_y");
            PMob->m_SpawnPoint.z        = rset->get<float>("pos_z");
            PMob->loc.p                 = PMob->m_SpawnPoint;

            PMob->m_RespawnTime = std::chrono::seconds(rset->get<uint32>("respawntime"));
            PMob->m_SpawnType   = rset->get<xi::SpawnType>("spawntype");
            PMob->m_DropID      = rset->get<uint32>("dropid");

            PMob->HPmodifier = rset->get<uint32>("HP");
            PMob->MPmodifier = rset->get<uint32>("MP");

            PMob->m_minLevel = rset->get<uint8>("minLevel");
            PMob->m_maxLevel = rset->get<uint8>("maxLevel");

            uint16 sqlModelID[10];
            db::extractFromBlob(rset, "modelid", sqlModelID);
            PMob->look = look_t(sqlModelID);

            PMob->SetMJob(rset->get<uint8>("mJob"));
            PMob->SetSJob(rset->get<uint8>("sJob"));

            static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
            static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setSkillType(rset->get<xi::SkillType>("cmbSkill"));
            PMob->m_dmgMult = rset->get<uint16>("cmbDmgMult");
            static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setDelay(rset->get<uint16>("cmbDelay"));
            static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setBaseDelay(rset->get<uint16>("cmbDelay"));

            PMob->m_Behavior = rset->get<xi::Behavior>("behavior");
            PMob->m_Type     = rset->get<xi::MobType>("mobType");
            PMob->m_Immunity = rset->get<xi::Immunity>("immunity");

            PMob->setModifier(xi::Mod::SLASH_SDT, rset->get<int16>("slash_sdt"));
            PMob->setModifier(xi::Mod::PIERCE_SDT, rset->get<int16>("pierce_sdt"));
            PMob->setModifier(xi::Mod::HTH_SDT, rset->get<int16>("h2h_sdt"));
            PMob->setModifier(xi::Mod::IMPACT_SDT, rset->get<int16>("impact_sdt"));

            PMob->setModifier(xi::Mod::UDMGMAGIC, rset->get<int16>("magical_sdt")); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

            PMob->setModifier(xi::Mod::FIRE_SDT, rset->get<int16>("fire_sdt"));         // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(xi::Mod::ICE_SDT, rset->get<int16>("ice_sdt"));           // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(xi::Mod::WIND_SDT, rset->get<int16>("wind_sdt"));         // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(xi::Mod::EARTH_SDT, rset->get<int16>("earth_sdt"));       // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(xi::Mod::THUNDER_SDT, rset->get<int16>("lightning_sdt")); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(xi::Mod::WATER_SDT, rset->get<int16>("water_sdt"));       // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(xi::Mod::LIGHT_SDT, rset->get<int16>("light_sdt"));       // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(xi::Mod::DARK_SDT, rset->get<int16>("dark_sdt"));         // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

            PMob->setModifier(xi::Mod::FIRE_RES_RANK, rset->get<int8>("fire_res_rank"));
            PMob->setModifier(xi::Mod::ICE_RES_RANK, rset->get<int8>("ice_res_rank"));
            PMob->setModifier(xi::Mod::WIND_RES_RANK, rset->get<int8>("wind_res_rank"));
            PMob->setModifier(xi::Mod::EARTH_RES_RANK, rset->get<int8>("earth_res_rank"));
            PMob->setModifier(xi::Mod::THUNDER_RES_RANK, rset->get<int8>("lightning_res_rank"));
            PMob->setModifier(xi::Mod::WATER_RES_RANK, rset->get<int8>("water_res_rank"));
            PMob->setModifier(xi::Mod::LIGHT_RES_RANK, rset->get<int8>("light_res_rank"));
            PMob->setModifier(xi::Mod::DARK_RES_RANK, rset->get<int8>("dark_res_rank"));

            PMob->setModifier(xi::Mod::PARALYZE_RES_RANK, rset->get<int8>("paralyze_res_rank"));
            PMob->setModifier(xi::Mod::BIND_RES_RANK, rset->get<int8>("bind_res_rank"));
            PMob->setModifier(xi::Mod::SILENCE_RES_RANK, rset->get<int8>("silence_res_rank"));
            PMob->setModifier(xi::Mod::SLOW_RES_RANK, rset->get<int8>("slow_res_rank"));
            PMob->setModifier(xi::Mod::POISON_RES_RANK, rset->get<int8>("poison_res_rank"));
            PMob->setModifier(xi::Mod::LIGHT_SLEEP_RES_RANK, rset->get<int8>("light_sleep_res_rank"));
            PMob->setModifier(xi::Mod::DARK_SLEEP_RES_RANK, rset->get<int8>("dark_sleep_res_rank"));
            PMob->setModifier(xi::Mod::BLIND_RES_RANK, rset->get<int8>("blind_res_rank"));
            PMob->setModifier(xi::Mod::STUN_RES_RANK, rset->get<int8>("stun_res_rank"));
            PMob->setModifier(xi::Mod::GRAVITY_RES_RANK, rset->get<int8>("gravity_res_rank"));

            PMob->m_Species     = rset->get<uint16>("speciesid");
            PMob->m_name_prefix = rset->get<uint8>("name_prefix");
            mobutils::ApplySpecies(PMob);
            PMob->m_flags = rset->get<xi::EntityFlags>("entityFlags");

            // Special sub animation for Mob (yovra, jailer of love, phuabo)
            // yovra 1: On top/in the sky, 2: , 3: On top/in the sky
            // phuabo 1: Underwater, 2: Out of the water, 3: Goes back underwater
            PMob->animationsub = rset->get<uint32>("animationsub");

            PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(rset->get<uint16>("spellList"));

            PMob->m_Pool = rset->get<uint32>("poolid");

            PMob->allegiance      = rset->get<xi::Allegiance>("allegiance");
            PMob->namevis         = rset->get<xi::NameVis>("namevis");
            PMob->m_roamFlags     = rset->get<xi::RoamFlag>("roamflag");
            PMob->modelHitboxSize = std::max<float>(0.0f, rset->getOrDefault<float>("modelHitboxSize", 0) / 10.f);
            PMob->modelSize       = rset->getOrDefault<uint8>("modelSize", 0);
            const auto aggro      = rset->get<uint32>("aggro");
            PMob->m_Aggro         = aggro;
            // If a special instanced mob aggros, it should always aggro regardless of level.
            if ((PMob->m_Type & xi::MobType::Event) != xi::MobType::Normal)
            {
                PMob->setMobMod(xi::MobMod::AlwaysAggro, aggro);
            }

            PMob->m_MobSkillList  = rset->get<uint16>("skill_list_id");
            PMob->m_Link          = rset->get<uint8>("links");
            PMob->m_TrueDetection = rset->get<bool>("true_detection");

            // must be here first to define mobmods
            mobutils::InitializeMob(PMob);
            PMob->PInstance = m_PInstance;

            m_PInstance->InsertMOB(PMob);
        }

        const uint32 zoneMin = (effectiveZoneId << 12) + 0x1000000;
        const uint32 zoneMax = zoneMin + 1024;

        rset = db::preparedStmt("SELECT npcid, name, pos_rot, pos_x, pos_y, pos_z, "
                                "flag, speed, speedsub, animation, animationsub, namevis, "
                                "status, entityFlags, look, name_prefix, widescan "
                                "FROM instance_entities INNER JOIN npc_list ON "
                                "(instance_entities.id = npc_list.npcid) "
                                "WHERE instanceid = ? AND npcid >= ? AND npcid < ?",
                                m_PInstance->GetID(),
                                zoneMin,
                                zoneMax);
        FOR_DB_MULTIPLE_RESULTS(rset)
        {
            CNpcEntity* PNpc = new CNpcEntity;
            PNpc->id         = rset->get<uint32>("npcid");
            PNpc->targid     = PNpc->id & 0xFFF;

            PNpc->name.insert(0, rset->get<std::string>("name"));

            PNpc->loc.p.rotation = rset->get<uint8>("pos_rot");
            PNpc->loc.p.x        = rset->get<float>("pos_x");
            PNpc->loc.p.y        = rset->get<float>("pos_y");
            PNpc->loc.p.z        = rset->get<float>("pos_z");
            PNpc->loc.p.moving   = rset->get<uint16>("flag");

            PNpc->m_TargID = rset->get<uint32>("flag") >> 16; // "quite likely"

            PNpc->baseSpeed      = rset->get<uint8>("speed");
            PNpc->animationSpeed = rset->get<uint8>("speedsub");
            PNpc->UpdateSpeed();
            PNpc->animation    = rset->get<xi::Animation>("animation");
            PNpc->animationsub = rset->get<uint8>("animationsub");

            PNpc->namevis = rset->get<xi::NameVis>("namevis");
            PNpc->status  = rset->get<xi::Status>("status");
            PNpc->m_flags = rset->get<xi::EntityFlags>("entityFlags");

            uint16 sqlModelID[10];
            db::extractFromBlob(rset, "look", sqlModelID);
            PNpc->look = look_t(sqlModelID);

            PNpc->name_prefix = rset->get<uint8>("name_prefix");
            PNpc->setWidescan(rset->get<uint8>("widescan"));

            PNpc->PInstance = m_PInstance;

            m_PInstance->InsertNPC(PNpc);
        }

        // Cache every entity script before running any handler.
        // Entities may rely on one-another.
        m_PInstance->ForEachMob(
            [](CMobEntity* PMob)
            {
                luautils::OnEntityLoad(PMob);
            });

        m_PInstance->ForEachNpc(
            [](CNpcEntity* PNpc)
            {
                luautils::OnEntityLoad(PNpc);
            });

        // Finish setting up Mobs
        m_PInstance->ForEachMob(
            [&](CMobEntity* PMob)
            {
                luautils::OnMobInitialize(PMob);
                m_PInstance->FindPartyForMob(PMob);
                luautils::ApplyMixins(PMob);
                PMob->saveModifiers();
                PMob->saveMobModifiers();
            });

        // Finish setting up NPCs
        m_PInstance->ForEachNpc(
            [](CNpcEntity* PNpc)
            {
                luautils::OnNpcSpawn(PNpc);
            });

        // Cache Instance script (TODO: This will be done multiple times, don't do that)
        luautils::LoadLuaObjectFromFile(instanceutils::GetInstanceData(m_PInstance->GetID()).filename);

        // Finish setup
        luautils::OnInstanceCreatedCallback(m_PRequester, m_PInstance);
        luautils::OnInstanceCreated(m_PInstance);
    }

    return m_PInstance;
}
