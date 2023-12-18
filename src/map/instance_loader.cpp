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

CInstanceLoader::CInstanceLoader(uint16 instanceid, CCharEntity* PRequester)
{
    TracyZoneScoped;
    auto   instanceData = instanceutils::GetInstanceData(instanceid);
    CZone* PZone        = zoneutils::GetZone(instanceData.instance_zone);

    if (!PZone || !(PZone->GetTypeMask() & ZONE_TYPE::INSTANCED))
    {
        ShowError("Invalid zone for instanceid: %d", instanceid);
        return;
    }

    requester = PRequester;
    zone      = PZone;
    instance  = ((CZoneInstance*)PZone)->CreateInstance(instanceid);
}

CInstanceLoader::~CInstanceLoader()
{
    TracyZoneScoped;
}

CInstance* CInstanceLoader::LoadInstance()
{
    TracyZoneScoped;
    const char* Query = "SELECT mobname, mobid, pos_rot, pos_x, pos_y, pos_z, \
            respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, \
            modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, \
            ecosystemID, mobradius, speed, \
            STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, ATT, ACC, \
            slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, \
            magical_sdt, fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, \
            fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, \
            Element, mob_pools.familyid, name_prefix, entityFlags, animationsub, \
            (mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, mob_groups.poolid, \
            allegiance, namevis, aggro, mob_pools.skill_list_id, mob_pools.true_detection, detects, \
            mob_family_system.charmable \
            FROM instance_entities INNER JOIN mob_spawn_points ON instance_entities.id = mob_spawn_points.mobid \
            INNER JOIN mob_groups ON mob_groups.groupid = mob_spawn_points.groupid and mob_groups.zoneid=((mob_spawn_points.mobid>>12)&0xFFF) \
            INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid \
            INNER JOIN mob_resistances ON mob_resistances.resist_id = mob_pools.resist_id \
            INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyID \
            WHERE instanceid = %u AND NOT (pos_x = 0 AND pos_y = 0 AND pos_z = 0);";

    int32 ret = _sql->Query(Query, instance->GetID());

    if (!instance->Failed() && ret != SQL_ERROR /*&& sql->NumRows() != 0*/)
    {
        while (_sql->NextRow() == SQL_SUCCESS)
        {
            CMobEntity* PMob = new CMobEntity;

            PMob->name.insert(0, (const char*)_sql->GetData(0));
            PMob->id     = _sql->GetUIntData(1);
            PMob->targid = (uint16)PMob->id & 0x0FFF;

            PMob->m_SpawnPoint.rotation = (uint8)_sql->GetIntData(2);
            PMob->m_SpawnPoint.x        = _sql->GetFloatData(3);
            PMob->m_SpawnPoint.y        = _sql->GetFloatData(4);
            PMob->m_SpawnPoint.z        = _sql->GetFloatData(5);

            PMob->m_RespawnTime = _sql->GetUIntData(6) * 1000;
            PMob->m_SpawnType   = (SPAWNTYPE)_sql->GetUIntData(7);
            PMob->m_DropID      = _sql->GetUIntData(8);

            PMob->HPmodifier = (uint32)_sql->GetIntData(9);
            PMob->MPmodifier = (uint32)_sql->GetIntData(10);

            PMob->m_minLevel = (uint8)_sql->GetIntData(11);
            PMob->m_maxLevel = (uint8)_sql->GetIntData(12);

            uint16 sqlModelID[10];
            memcpy(&sqlModelID, _sql->GetData(13), 20);
            PMob->look = look_t(sqlModelID);

            PMob->SetMJob(_sql->GetIntData(14));
            PMob->SetSJob(_sql->GetIntData(15));

            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(_sql->GetIntData(16));
            PMob->m_dmgMult = _sql->GetUIntData(17);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((_sql->GetIntData(18) * 1000) / 60);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((_sql->GetIntData(18) * 1000) / 60);

            PMob->m_Behaviour   = (uint16)_sql->GetIntData(19);
            PMob->m_Link        = (uint8)_sql->GetIntData(20);
            PMob->m_Type        = (uint8)_sql->GetIntData(21);
            PMob->m_Immunity    = (IMMUNITY)_sql->GetIntData(22);
            PMob->m_EcoSystem   = (ECOSYSTEM)_sql->GetIntData(23);
            PMob->m_ModelRadius = (float)_sql->GetIntData(24);

            PMob->speed    = (uint8)_sql->GetIntData(25);
            PMob->speedsub = (uint8)_sql->GetIntData(25);

            PMob->strRank = (uint8)_sql->GetIntData(26);
            PMob->dexRank = (uint8)_sql->GetIntData(27);
            PMob->vitRank = (uint8)_sql->GetIntData(28);
            PMob->agiRank = (uint8)_sql->GetIntData(29);
            PMob->intRank = (uint8)_sql->GetIntData(30);
            PMob->mndRank = (uint8)_sql->GetIntData(31);
            PMob->chrRank = (uint8)_sql->GetIntData(32);
            PMob->evaRank = (uint8)_sql->GetIntData(33);
            PMob->defRank = (uint8)_sql->GetIntData(34);
            PMob->attRank = (uint8)_sql->GetIntData(35);
            PMob->accRank = (uint8)_sql->GetIntData(36);

            PMob->setModifier(Mod::SLASH_SDT, (uint16)(_sql->GetFloatData(37) * 1000));
            PMob->setModifier(Mod::PIERCE_SDT, (uint16)(_sql->GetFloatData(38) * 1000));
            PMob->setModifier(Mod::HTH_SDT, (uint16)(_sql->GetFloatData(39) * 1000));
            PMob->setModifier(Mod::IMPACT_SDT, (uint16)(_sql->GetFloatData(40) * 1000));

            PMob->setModifier(Mod::UDMGMAGIC, (int16)_sql->GetIntData(41)); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

            PMob->setModifier(Mod::FIRE_SDT, (int16)_sql->GetIntData(42));    // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(Mod::ICE_SDT, (int16)_sql->GetIntData(43));     // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(Mod::WIND_SDT, (int16)_sql->GetIntData(44));    // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(Mod::EARTH_SDT, (int16)_sql->GetIntData(45));   // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(Mod::THUNDER_SDT, (int16)_sql->GetIntData(46)); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(Mod::WATER_SDT, (int16)_sql->GetIntData(47));   // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(Mod::LIGHT_SDT, (int16)_sql->GetIntData(48));   // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
            PMob->setModifier(Mod::DARK_SDT, (int16)_sql->GetIntData(49));    // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

            PMob->setModifier(Mod::FIRE_RES_RANK, (int8)(_sql->GetIntData(50)));
            PMob->setModifier(Mod::ICE_RES_RANK, (int8)(_sql->GetIntData(51)));
            PMob->setModifier(Mod::WIND_RES_RANK, (int8)(_sql->GetIntData(52)));
            PMob->setModifier(Mod::EARTH_RES_RANK, (int8)(_sql->GetIntData(53)));
            PMob->setModifier(Mod::THUNDER_RES_RANK, (int8)(_sql->GetIntData(54)));
            PMob->setModifier(Mod::WATER_RES_RANK, (int8)(_sql->GetIntData(55)));
            PMob->setModifier(Mod::LIGHT_RES_RANK, (int8)(_sql->GetIntData(56)));
            PMob->setModifier(Mod::DARK_RES_RANK, (int8)(_sql->GetIntData(57)));

            PMob->m_Element     = (uint8)_sql->GetIntData(58);
            PMob->m_Family      = (uint16)_sql->GetIntData(59);
            PMob->m_name_prefix = (uint8)_sql->GetIntData(60);
            PMob->m_flags       = (uint32)_sql->GetIntData(61);

            // Special sub animation for Mob (yovra, jailer of love, phuabo)
            // yovra 1: On top/in the sky, 2: , 3: On top/in the sky
            // phuabo 1: Underwater, 2: Out of the water, 3: Goes back underwater
            PMob->animationsub = (uint32)_sql->GetIntData(62);

            // Setup HP / MP Stat Percentage Boost
            PMob->HPscale = _sql->GetFloatData(63);
            PMob->MPscale = _sql->GetFloatData(64);

            // TODO: Remove me
            // Check if we should be looking up scripts for this mob
            // PMob->m_HasSpellScript = (uint8)sql->GetIntData(65);

            PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(_sql->GetIntData(66));

            PMob->m_Pool = _sql->GetUIntData(67);

            PMob->allegiance = static_cast<ALLEGIANCE_TYPE>(_sql->GetUIntData(68));
            PMob->namevis    = _sql->GetUIntData(69);

            uint32 aggro  = _sql->GetUIntData(70);
            PMob->m_Aggro = aggro;

            // If a special instanced mob aggros, it should always aggro regardless of level.
            if (PMob->m_Type & MOBTYPE_EVENT)
            {
                PMob->setMobMod(MOBMOD_ALWAYS_AGGRO, aggro);
            }

            PMob->m_MobSkillList  = _sql->GetUIntData(71);
            PMob->m_TrueDetection = _sql->GetUIntData(72);
            PMob->setMobMod(MOBMOD_DETECTION, _sql->GetUIntData(73));

            PMob->setMobMod(MOBMOD_CHARMABLE, _sql->GetUIntData(74));

            // Overwrite base family charmables depending on mob type. Disallowed mobs which should be charmable
            // can be set in mob_spawn_mods or in their onInitialize
            if (PMob->m_Type & MOBTYPE_EVENT || PMob->m_Type & MOBTYPE_FISHED || PMob->m_Type & MOBTYPE_BATTLEFIELD || PMob->m_Type & MOBTYPE_NOTORIOUS)
            {
                PMob->setMobMod(MOBMOD_CHARMABLE, 0);
            }

            // must be here first to define mobmods
            mobutils::InitializeMob(PMob);
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

        ret = _sql->Query(Query, instance->GetID(), zoneMin, zoneMax);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                CNpcEntity* PNpc = new CNpcEntity;
                PNpc->id         = _sql->GetUIntData(0);
                PNpc->targid     = PNpc->id & 0xFFF;

                PNpc->name.insert(0, (const char*)_sql->GetData(1));

                PNpc->loc.p.rotation = (uint8)_sql->GetIntData(2);
                PNpc->loc.p.x        = _sql->GetFloatData(3);
                PNpc->loc.p.y        = _sql->GetFloatData(4);
                PNpc->loc.p.z        = _sql->GetFloatData(5);
                PNpc->loc.p.moving   = (uint16)_sql->GetUIntData(6);

                PNpc->m_TargID = _sql->GetUIntData(6) >> 16; // "quite likely"

                PNpc->speed        = (uint8)_sql->GetIntData(7);
                PNpc->speedsub     = (uint8)_sql->GetIntData(8);
                PNpc->animation    = (uint8)_sql->GetIntData(9);
                PNpc->animationsub = (uint8)_sql->GetIntData(10);

                PNpc->namevis = (uint8)_sql->GetIntData(11);
                PNpc->status  = static_cast<STATUS_TYPE>(_sql->GetIntData(12));
                PNpc->m_flags = _sql->GetUIntData(13);

                uint16 sqlModelID[10];
                memcpy(&sqlModelID, _sql->GetData(14), 20);
                PNpc->look = look_t(sqlModelID);

                PNpc->name_prefix = (uint8)_sql->GetIntData(15);
                PNpc->widescan    = (uint8)_sql->GetIntData(16);

                PNpc->PInstance = instance;

                instance->InsertNPC(PNpc);
            }
        }

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
                            PMob.second->loc.zone->getName(),
                            PMob.second->getName()));
        }

        // Finish setting up NPCs
        for (auto PNpc : instance->m_npcList)
        {
            luautils::OnNpcSpawn(PNpc.second);

            // Add to cache
            luautils::CacheLuaObjectFromFile(
                fmt::format("./scripts/zones/{}/npcs/{}.lua",
                            PNpc.second->loc.zone->getName(),
                            PNpc.second->getName()));
        }

        // Cache Instance script (TODO: This will be done multiple times, don't do that)
        luautils::CacheLuaObjectFromFile(instanceutils::GetInstanceData(instance->GetID()).filename);

        // Finish setup
        luautils::OnInstanceCreatedCallback(requester, instance);
        luautils::OnInstanceCreated(instance);
    }
    return instance;
}
