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

#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "items/item_weapon.h"
#include "lua/luautils.h"
#include "mob_modifier.h"
#include "mob_spell_list.h"
#include "utils/mobutils.h"

CInstanceLoader::CInstanceLoader(uint8 instanceid, CZone* PZone, CCharEntity* PRequester)
{
    XI_DEBUG_BREAK_IF(PZone->GetType() != ZONE_TYPE::DUNGEON_INSTANCED);

    requester           = PRequester;
    zone                = PZone;
    CInstance* instance = ((CZoneInstance*)PZone)->CreateInstance(instanceid);

    SqlInstanceHandle = Sql_Malloc();

    if (Sql_Connect(SqlInstanceHandle, map_config.mysql_login.c_str(), map_config.mysql_password.c_str(), map_config.mysql_host.c_str(), map_config.mysql_port,
                    map_config.mysql_database.c_str()) == SQL_ERROR)
    {
        do_final(EXIT_FAILURE);
    }
    Sql_Keepalive(SqlInstanceHandle);

    task = std::async(std::launch::async, &CInstanceLoader::LoadInstance, this, instance);
}

CInstanceLoader::~CInstanceLoader()
{
    Sql_Free(SqlInstanceHandle);
}

bool CInstanceLoader::Check()
{
    if (task.valid())
    {
        if (task.wait_for(std::chrono::milliseconds(0)) == std::future_status::ready)
        {
            CInstance* instance = task.get();
            if (!instance)
            {
                // Instance failed to load
                luautils::OnInstanceCreated(requester, nullptr);
            }
            else
            {
                // Finish setting up Mobs
                for (auto PMob : instance->m_mobList)
                {
                    luautils::OnMobInitialize(PMob.second);
                    luautils::ApplyMixins(PMob.second);
                    ((CMobEntity*)PMob.second)->saveModifiers();
                    ((CMobEntity*)PMob.second)->saveMobModifiers();

                    // Add to cache
                    luautils::CacheLuaObjectFromFile(
                        fmt::format("./scripts/zones/{}/mobs/{}.lua",
                                    PMob.second->loc.zone->GetName(),
                                    PMob.second->GetName()));
                }

                // Finish setting up NPCs
                for (auto PNpc : instance->m_npcList)
                {
                    luautils::OnNpcSpawn(PNpc.second);

                    // Add to cache
                    luautils::CacheLuaObjectFromFile(
                        fmt::format("./scripts/zones/{}/npcs/{}.lua",
                                    PNpc.second->loc.zone->GetName(),
                                    PNpc.second->GetName()));
                }

                // Finish setup
                luautils::OnInstanceCreated(requester, instance);
                luautils::OnInstanceCreated(instance);
            }
            return true;
        }
    }
    return false;
}

CInstance* CInstanceLoader::LoadInstance(CInstance* instance)
{
    const char* Query = "SELECT mobname, mobid, pos_rot, pos_x, pos_y, pos_z, \
            respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, \
            modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, \
            systemid, mobsize, speed, \
            STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, ATT, ACC, \
            slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, \
            fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, \
            fire_res, ice_res, wind_res, earth_res, lightning_res, water_res, light_res, dark_res, \
            Element, mob_pools.familyid, name_prefix, entityFlags, animationsub, \
            (mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, mob_groups.poolid, \
            allegiance, namevis, aggro, mob_pools.skill_list_id, mob_pools.true_detection, detects, \
            mob_family_system.charmable \
            FROM instance_entities INNER JOIN mob_spawn_points ON instance_entities.id = mob_spawn_points.mobid \
            INNER JOIN mob_groups ON mob_groups.groupid = mob_spawn_points.groupid and mob_groups.zoneid=((mob_spawn_points.mobid>>12)&0xFFF) \
            INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid \
            INNER JOIN mob_resistances ON mob_resistances.resist_id = mob_pools.resist_id \
            INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyid \
            WHERE instanceid = %u AND NOT (pos_x = 0 AND pos_y = 0 AND pos_z = 0);";

    int32 ret = Sql_Query(SqlInstanceHandle, Query, instance->GetID());

    if (!instance->Failed() && ret != SQL_ERROR /*&& Sql_NumRows(SqlInstanceHandle) != 0*/)
    {
        while (Sql_NextRow(SqlInstanceHandle) == SQL_SUCCESS)
        {
            CMobEntity* PMob = new CMobEntity;

            PMob->name.insert(0, (const char*)Sql_GetData(SqlInstanceHandle, 0));
            PMob->id     = (uint32)Sql_GetUIntData(SqlInstanceHandle, 1);
            PMob->targid = (uint16)PMob->id & 0x0FFF;

            PMob->m_SpawnPoint.rotation = (uint8)Sql_GetIntData(SqlInstanceHandle, 2);
            PMob->m_SpawnPoint.x        = Sql_GetFloatData(SqlInstanceHandle, 3);
            PMob->m_SpawnPoint.y        = Sql_GetFloatData(SqlInstanceHandle, 4);
            PMob->m_SpawnPoint.z        = Sql_GetFloatData(SqlInstanceHandle, 5);

            PMob->m_RespawnTime = Sql_GetUIntData(SqlInstanceHandle, 6) * 1000;
            PMob->m_SpawnType   = (SPAWNTYPE)Sql_GetUIntData(SqlInstanceHandle, 7);
            PMob->m_DropID      = Sql_GetUIntData(SqlInstanceHandle, 8);

            PMob->HPmodifier = (uint32)Sql_GetIntData(SqlInstanceHandle, 9);
            PMob->MPmodifier = (uint32)Sql_GetIntData(SqlInstanceHandle, 10);

            PMob->m_minLevel = (uint8)Sql_GetIntData(SqlInstanceHandle, 11);
            PMob->m_maxLevel = (uint8)Sql_GetIntData(SqlInstanceHandle, 12);

            memcpy(&PMob->look, Sql_GetData(SqlInstanceHandle, 13), 23);

            PMob->SetMJob(Sql_GetIntData(SqlInstanceHandle, 14));
            PMob->SetSJob(Sql_GetIntData(SqlInstanceHandle, 15));

            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(Sql_GetIntData(SqlInstanceHandle, 16));
            PMob->m_dmgMult = Sql_GetUIntData(SqlInstanceHandle, 17);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((Sql_GetIntData(SqlInstanceHandle, 18) * 1000) / 60);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((Sql_GetIntData(SqlInstanceHandle, 18) * 1000) / 60);

            PMob->m_Behaviour = (uint16)Sql_GetIntData(SqlInstanceHandle, 19);
            PMob->m_Link      = (uint8)Sql_GetIntData(SqlInstanceHandle, 20);
            PMob->m_Type      = (uint8)Sql_GetIntData(SqlInstanceHandle, 21);
            PMob->m_Immunity  = (IMMUNITY)Sql_GetIntData(SqlInstanceHandle, 22);
            PMob->m_EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlInstanceHandle, 23);
            PMob->m_ModelSize = (uint8)Sql_GetIntData(SqlInstanceHandle, 24);

            PMob->speed    = (uint8)Sql_GetIntData(SqlInstanceHandle, 25);
            PMob->speedsub = (uint8)Sql_GetIntData(SqlInstanceHandle, 25);

            PMob->strRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 26);
            PMob->dexRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 27);
            PMob->vitRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 28);
            PMob->agiRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 29);
            PMob->intRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 30);
            PMob->mndRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 31);
            PMob->chrRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 32);
            PMob->evaRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 33);
            PMob->defRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 34);
            PMob->attRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 35);
            PMob->accRank = (uint8)Sql_GetIntData(SqlInstanceHandle, 36);

            PMob->setModifier(Mod::SLASH_SDT, (uint16)(Sql_GetFloatData(SqlHandle, 37) * 1000));
            PMob->setModifier(Mod::PIERCE_SDT, (uint16)(Sql_GetFloatData(SqlHandle, 38) * 1000));
            PMob->setModifier(Mod::HTH_SDT, (uint16)(Sql_GetFloatData(SqlHandle, 39) * 1000));
            PMob->setModifier(Mod::IMPACT_SDT, (uint16)(Sql_GetFloatData(SqlHandle, 40) * 1000));

            PMob->setModifier(Mod::FIRE_SDT, (int16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100));    // These are stored as floating percentages
            PMob->setModifier(Mod::ICE_SDT, (int16)((Sql_GetFloatData(SqlHandle, 42) - 1) * -100));     // and need to be adjusted into modifier units.
            PMob->setModifier(Mod::WIND_SDT, (int16)((Sql_GetFloatData(SqlHandle, 43) - 1) * -100));    // Todo: make these work like the physical ones
            PMob->setModifier(Mod::EARTH_SDT, (int16)((Sql_GetFloatData(SqlHandle, 44) - 1) * -100));
            PMob->setModifier(Mod::THUNDER_SDT, (int16)((Sql_GetFloatData(SqlHandle, 45) - 1) * -100));
            PMob->setModifier(Mod::WATER_SDT, (int16)((Sql_GetFloatData(SqlHandle, 46) - 1) * -100));
            PMob->setModifier(Mod::LIGHT_SDT, (int16)((Sql_GetFloatData(SqlHandle, 47) - 1) * -100));
            PMob->setModifier(Mod::DARK_SDT, (int16)((Sql_GetFloatData(SqlHandle, 48) - 1) * -100));

            PMob->setModifier(Mod::FIRE_RES, (int16)(Sql_GetIntData(SqlHandle, 49)));    // These are stored as signed integers which
            PMob->setModifier(Mod::ICE_RES, (int16)(Sql_GetIntData(SqlHandle, 50)));     // is directly the modifier starting value.
            PMob->setModifier(Mod::WIND_RES, (int16)(Sql_GetIntData(SqlHandle, 51)));    // Positives signify increased resist chance.
            PMob->setModifier(Mod::EARTH_RES, (int16)(Sql_GetIntData(SqlHandle, 52)));
            PMob->setModifier(Mod::THUNDER_RES, (int16)(Sql_GetIntData(SqlHandle, 53)));
            PMob->setModifier(Mod::WATER_RES, (int16)(Sql_GetIntData(SqlHandle, 54)));
            PMob->setModifier(Mod::LIGHT_RES, (int16)(Sql_GetIntData(SqlHandle, 55)));
            PMob->setModifier(Mod::DARK_RES, (int16)(Sql_GetIntData(SqlHandle, 56)));

            PMob->m_Element     = (uint8)Sql_GetIntData(SqlInstanceHandle, 57);
            PMob->m_Family      = (uint16)Sql_GetIntData(SqlInstanceHandle, 58);
            PMob->m_name_prefix = (uint8)Sql_GetIntData(SqlInstanceHandle, 59);
            PMob->m_flags       = (uint32)Sql_GetIntData(SqlInstanceHandle, 60);

            // Special sub animation for Mob (yovra, jailer of love, phuabo)
            // yovra 1: en hauteur, 2: en bas, 3: en haut
            // phuabo 1: sous l'eau, 2: sort de l'eau, 3: rentre dans l'eau
            PMob->animationsub = (uint32)Sql_GetIntData(SqlInstanceHandle, 61);

            // Setup HP / MP Stat Percentage Boost
            PMob->HPscale = Sql_GetFloatData(SqlInstanceHandle, 62);
            PMob->MPscale = Sql_GetFloatData(SqlInstanceHandle, 63);

            // Check if we should be looking up scripts for this mob
            PMob->m_HasSpellScript = (uint8)Sql_GetIntData(SqlInstanceHandle, 64);

            PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(Sql_GetIntData(SqlInstanceHandle, 65));

            PMob->m_Pool = Sql_GetUIntData(SqlInstanceHandle, 66);

            PMob->allegiance = static_cast<ALLEGIANCE_TYPE>(Sql_GetUIntData(SqlInstanceHandle, 67));
            PMob->namevis    = Sql_GetUIntData(SqlInstanceHandle, 68);

            uint32 aggro  = Sql_GetUIntData(SqlInstanceHandle, 69);
            PMob->m_Aggro = aggro;

            // If a special instanced mob aggros, it should always aggro regardless of level.
            if (PMob->m_Type & MOBTYPE_EVENT)
            {
                PMob->setMobMod(MOBMOD_ALWAYS_AGGRO, aggro);
            }

            PMob->m_MobSkillList  = Sql_GetUIntData(SqlInstanceHandle, 70);
            PMob->m_TrueDetection = Sql_GetUIntData(SqlInstanceHandle, 71);
            PMob->m_Detects       = Sql_GetUIntData(SqlInstanceHandle, 72);

            PMob->setMobMod(MOBMOD_CHARMABLE, Sql_GetUIntData(SqlInstanceHandle, 73));

            // Overwrite base family charmables depending on mob type. Disallowed mobs which should be charmable
            // can be set in mob_spawn_mods or in their onInitialize
            if (PMob->m_Type & MOBTYPE_EVENT || PMob->m_Type & MOBTYPE_FISHED || PMob->m_Type & MOBTYPE_BATTLEFIELD || PMob->m_Type & MOBTYPE_NOTORIOUS)
            {
                PMob->setMobMod(MOBMOD_CHARMABLE, 0);
            }

            // must be here first to define mobmods
            mobutils::InitializeMob(PMob, zone);
            PMob->PInstance = instance;

            instance->InsertMOB(PMob);
        }

        Query = "SELECT npcid, name, pos_rot, pos_x, pos_y, pos_z,\
			flag, speed, speedsub, animation, animationsub, namevis,\
			status, entityFlags, look, name_prefix, widescan \
			FROM instance_entities INNER JOIN npc_list ON \
			(instance_entities.id = npc_list.npcid) \
			WHERE instanceid = %u AND npcid >= %u and npcid < %u;";

        uint32 zoneMin = (zone->GetID() << 12) + 0x1000000;
        uint32 zoneMax = zoneMin + 1024;

        ret = Sql_Query(SqlInstanceHandle, Query, instance->GetID(), zoneMin, zoneMax);

        if (ret != SQL_ERROR && Sql_NumRows(SqlInstanceHandle) != 0)
        {
            while (Sql_NextRow(SqlInstanceHandle) == SQL_SUCCESS)
            {
                CNpcEntity* PNpc = new CNpcEntity;
                PNpc->id         = (uint32)Sql_GetUIntData(SqlInstanceHandle, 0);
                PNpc->targid     = PNpc->id & 0xFFF;

                PNpc->name.insert(0, (const char*)Sql_GetData(SqlInstanceHandle, 1));

                PNpc->loc.p.rotation = (uint8)Sql_GetIntData(SqlInstanceHandle, 2);
                PNpc->loc.p.x        = Sql_GetFloatData(SqlInstanceHandle, 3);
                PNpc->loc.p.y        = Sql_GetFloatData(SqlInstanceHandle, 4);
                PNpc->loc.p.z        = Sql_GetFloatData(SqlInstanceHandle, 5);
                PNpc->loc.p.moving   = (uint16)Sql_GetUIntData(SqlInstanceHandle, 6);

                PNpc->m_TargID = (uint32)Sql_GetUIntData(SqlInstanceHandle, 6) >> 16; // вполне вероятно

                PNpc->speed        = (uint8)Sql_GetIntData(SqlInstanceHandle, 7);
                PNpc->speedsub     = (uint8)Sql_GetIntData(SqlInstanceHandle, 8);
                PNpc->animation    = (uint8)Sql_GetIntData(SqlInstanceHandle, 9);
                PNpc->animationsub = (uint8)Sql_GetIntData(SqlInstanceHandle, 10);

                PNpc->namevis = (uint8)Sql_GetIntData(SqlInstanceHandle, 11);
                PNpc->status  = static_cast<STATUS_TYPE>(Sql_GetIntData(SqlInstanceHandle, 12));
                PNpc->m_flags = (uint32)Sql_GetUIntData(SqlInstanceHandle, 13);

                memcpy(&PNpc->look, Sql_GetData(SqlInstanceHandle, 14), 20);

                PNpc->name_prefix = (uint8)Sql_GetIntData(SqlInstanceHandle, 15);
                PNpc->widescan    = (uint8)Sql_GetIntData(SqlInstanceHandle, 16);

                PNpc->PInstance = instance;

                instance->InsertNPC(PNpc);
            }
        }
    }
    else
    {
        instance->Cancel();
        instance = nullptr;
    }

    return instance;
}
