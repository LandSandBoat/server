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

#include "zoneutils.h"

#include "ai/ai_container.h"
#include "battlefield.h"
#include "campaign_system.h"
#include "common/logging.h"
#include "common/timer.h"
#include "conquest_system.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "items/item_weapon.h"
#include "lua/luautils.h"
#include "map.h"
#include "mob_modifier.h"
#include "mob_spell_list.h"
#include "mobutils.h"
#include "packets/entity_update.h"
#include "zone_instance.h"

#include <algorithm>
#include <cstring>
#include <execution>

#include <task_system.hpp>

std::map<uint16, CZone*> g_PZoneList; // Global array of pointers for zones
CNpcEntity*              g_PTrigger;  // trigger to start events

namespace zoneutils
{
    /************************************************************************
     *                                                                       *
     *  Reaction zones to change the time of day                             *
     *                                                                       *
     ************************************************************************/

    void TOTDChange(TIMETYPE TOTD)
    {
        for (auto PZone : g_PZoneList)
        {
            PZone.second->TOTDChange(TOTD);
        }
    }

    /************************************************************************
     *                                                                       *
     *  Initialize weather for each zone and launch task if not weather      *
     *  static                                                               *
     *                                                                       *
     ************************************************************************/

    void InitializeWeather()
    {
        TracyZoneScoped;
        for (auto PZone : g_PZoneList)
        {
            if (!PZone.second->IsWeatherStatic())
            {
                PZone.second->UpdateWeather();
            }
            else
            {
                if (!PZone.second->m_WeatherVector.empty())
                {
                    PZone.second->SetWeather((WEATHER)PZone.second->m_WeatherVector.at(0).common);
                }
                else
                {
                    PZone.second->SetWeather(WEATHER_NONE); // If not weather data found, initialize with WEATHER_NONE
                }
            }
        }
        ShowDebug("InitializeWeather Finished");
    }

    void SavePlayTime()
    {
        for (auto PZone : g_PZoneList)
        {
            PZone.second->SavePlayTime();
        }
        ShowDebug("Player playtime saving finished");
    }

    CZone* GetZone(uint16 ZoneID)
    {
        if (auto PZone = g_PZoneList.find(ZoneID); PZone != g_PZoneList.end())
        {
            return PZone->second;
        }
        ShowWarning(fmt::format("Invalid zone requested: {}", ZoneID));
        return nullptr;
    }

    CNpcEntity* GetTrigger(uint16 TargID, uint16 ZoneID)
    {
        g_PTrigger->targid = TargID;
        g_PTrigger->id     = ((4096 + ZoneID) << 12) + TargID;
        return g_PTrigger;
    }

    CBaseEntity* GetEntity(uint32 ID, uint8 filter)
    {
        const uint16 DynamicEntityStart = 0x700;
        uint16       zoneID             = (ID >> 12) & 0x0FFF;
        CZone*       PZone              = GetZone(zoneID);
        if (PZone)
        {
            return PZone->GetEntity((uint16)(ID & 0x00000800 ? (ID & 0x7FF) + DynamicEntityStart : ID & 0xFFF), filter);
        }
        else
        {
            return nullptr;
        }
    }

    CCharEntity* GetCharByName(std::string const& name)
    {
        for (auto PZone : g_PZoneList)
        {
            CCharEntity* PChar = PZone.second->GetCharByName(name);

            if (PChar != nullptr)
            {
                return PChar;
            }
        }
        return nullptr;
    }

    CCharEntity* GetCharFromWorld(uint32 charid, uint16 targid)
    {
        // will not return pointers to players in Mog House
        for (auto PZone : g_PZoneList)
        {
            if (PZone.first == 0)
            {
                continue;
            }
            CBaseEntity* PEntity = PZone.second->GetEntity(targid, TYPE_PC);
            if (PEntity != nullptr && PEntity->id == charid)
            {
                return (CCharEntity*)PEntity;
            }
        }
        return nullptr;
    }

    CCharEntity* GetChar(uint32 charid)
    {
        for (auto PZone : g_PZoneList)
        {
            CBaseEntity* PEntity = PZone.second->GetCharByID(charid);
            if (PEntity)
            {
                return (CCharEntity*)PEntity;
            }
        }
        return nullptr;
    }

    CCharEntity* GetCharToUpdate(uint32 primary, uint32 tertiary)
    {
        CCharEntity* PPrimary   = nullptr;
        CCharEntity* PSecondary = nullptr;
        CCharEntity* PTertiary  = nullptr;

        for (auto PZone : g_PZoneList)
        {
            // clang-format off
            PZone.second->ForEachChar([primary, tertiary, &PPrimary, &PSecondary, &PTertiary](CCharEntity* PChar)
            {
                if (!PPrimary)
                {
                    if (PChar->id == primary)
                    {
                        PPrimary = PChar;
                    }
                    else if (PChar->PParty && PChar->PParty->GetPartyID() == primary)
                    {
                        PSecondary = PChar;
                    }
                    else if (PChar->id == tertiary)
                    {
                        PTertiary = PChar;
                    }
                }
            });
            // clang-format on

            if (PPrimary)
            {
                return PPrimary;
            }
        }
        if (PSecondary)
        {
            return PSecondary;
        }

        return PTertiary;
    }

    std::vector<uint16> GetZonesOnThisProcess()
    {
        char address[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, &map_ip, address, INET_ADDRSTRLEN);

        // clang-format off
        auto zonesQuery = fmt::sprintf(R"(
            SELECT zoneid
            FROM zone_settings
            WHERE IF(%d <> 0, '%s' = zoneip AND %d = zoneport, TRUE);
        )", map_ip.s_addr, address, map_port);
        // clang-format on

        std::vector<uint16> zonesOnThisProcess;

        int32 ret = _sql->Query(zonesQuery.c_str());
        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16 zoneId = static_cast<uint16>(_sql->GetUIntData(0));
                zonesOnThisProcess.emplace_back(zoneId);
            }
        }

        return zonesOnThisProcess;
    }

    /************************************************************************
     *                                                                       *
     *  Upload a list of NPCs to the specified zone                          *
     *                                                                       *
     ************************************************************************/

    void LoadNPCList()
    {
        TracyZoneScoped;
        ShowInfo("Loading NPCs");

        auto zonesOnThisProcess = GetZonesOnThisProcess();

        // clang-format off
        {
            ts::task_system ts;
            for (auto zoneId : zonesOnThisProcess)
            {
                ts.schedule([zoneId]()
                {
                    TracyZoneScoped;
                    auto  sql   = std::make_unique<SqlConnection>();
                    auto* PZone = g_PZoneList[zoneId];

                    auto Query = fmt::format("SELECT \
                        content_tag, \
                        npcid, \
                        npc_list.name, \
                        npc_list.polutils_name, \
                        pos_rot,\
                        pos_x,\
                        pos_y,\
                        pos_z,\
                        flag,\
                        speed,\
                        speedsub,\
                        animation,\
                        animationsub,\
                        namevis,\
                        status,\
                        entityFlags,\
                        look,\
                        name_prefix, \
                        widescan \
                        FROM npc_list INNER JOIN zone_settings \
                        ON (npcid & 0xFFF000) >> 12 = zone_settings.zoneid \
                        WHERE ((npcid & 0xFFF000) >> 12) = {}", zoneId);

                    int32 ret = sql->Query(Query.c_str());

                    if (ret != SQL_ERROR && sql->NumRows() != 0)
                    {
                        while (sql->NextRow() == SQL_SUCCESS)
                        {
                            const char* contentTag = (const char*)sql->GetData(0);
                            if (!luautils::IsContentEnabled(contentTag))
                            {
                                continue;
                            }

                            uint32 NpcID = sql->GetUIntData(1);

                            if (!(PZone->GetTypeMask() & ZONE_TYPE::INSTANCED))
                            {
                                CNpcEntity* PNpc = new CNpcEntity;
                                PNpc->targid     = NpcID & 0xFFF;
                                PNpc->id         = NpcID;

                                PNpc->name       = sql->GetStringData(2); // Internal name
                                PNpc->packetName = sql->GetStringData(3); // Name sent to the client (when applicable)

                                PNpc->loc.p.rotation = (uint8)sql->GetIntData(4);
                                PNpc->loc.p.x        = sql->GetFloatData(5);
                                PNpc->loc.p.y        = sql->GetFloatData(6);
                                PNpc->loc.p.z        = sql->GetFloatData(7);
                                PNpc->loc.p.moving   = (uint16)sql->GetUIntData(8);

                                PNpc->m_TargID = sql->GetUIntData(8) >> 16;

                                PNpc->speed    = (uint8)sql->GetIntData(9);  // Overwrites baseentity.cpp's defined speed
                                PNpc->speedsub = (uint8)sql->GetIntData(10); // Overwrites baseentity.cpp's defined speedsub

                                PNpc->animation    = (uint8)sql->GetIntData(11);
                                PNpc->animationsub = (uint8)sql->GetIntData(12);

                                PNpc->namevis = (uint8)sql->GetIntData(13);
                                PNpc->status  = static_cast<STATUS_TYPE>(sql->GetIntData(14));
                                PNpc->m_flags = sql->GetUIntData(15);

                                uint16 sqlModelID[10];
                                memcpy(&sqlModelID, sql->GetData(16), 20);
                                PNpc->look = look_t(sqlModelID);

                                PNpc->name_prefix = (uint8)sql->GetIntData(17);
                                PNpc->widescan    = (uint8)sql->GetIntData(18);

                                PZone->InsertNPC(PNpc);
                            }
                        }
                    }
                });
            }
        }
        // clang-format on

        ShowInfo("Loading NPC scripts");
        // handle npc spawn functions after they're all done loading
        // clang-format off
        ForEachZone([](CZone* PZone)
        {
            // NOTE: We have to do this in two passes because NPCs may rely on eachother.
            //     : So load them all, then spawn them all.
            PZone->ForEachNpc([](CNpcEntity* PNpc)
            {
                // Cache NPC Lua
                luautils::OnEntityLoad(PNpc);
            });

            PZone->ForEachNpc([](CNpcEntity* PNpc)
            {
                luautils::OnNpcSpawn(PNpc);
            });
        });
        // clang-format on
    }

    /************************************************************************
     *                                                                       *
     *  Upload a list of MOBs to the specified zone                          *
     *                                                                       *
     ************************************************************************/

    void LoadMOBList()
    {
        TracyZoneScoped;
        ShowInfo("Loading Mobs");

        auto zonesOnThisProcess = GetZonesOnThisProcess();

        uint8 normalLevelRangeMin = settings::get<uint8>("main.NORMAL_MOB_MAX_LEVEL_RANGE_MIN");
        uint8 normalLevelRangeMax = settings::get<uint8>("main.NORMAL_MOB_MAX_LEVEL_RANGE_MAX");

        // clang-format off
        {
            ts::task_system ts;
            for (auto zoneId : zonesOnThisProcess)
            {
                ts.schedule([normalLevelRangeMin, normalLevelRangeMax, zoneId]()
                {
                    TracyZoneScoped;
                    auto  sql   = std::make_unique<SqlConnection>();
                    auto* PZone = g_PZoneList[zoneId];

                    auto Query = fmt::format("SELECT mob_groups.zoneid, mobname, mobid, pos_rot, pos_x, pos_y, pos_z, \
                        respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, \
                        modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, \
                        ecosystemID, mobradius, speed, \
                        STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, ATT, ACC, \
                        slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, \
                        magical_sdt, fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, \
                        fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, \
                        Element, mob_pools.familyid, mob_family_system.superFamilyID, name_prefix, entityFlags, animationsub, \
                        (mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, mob_groups.poolid, \
                        allegiance, namevis, aggro, roamflag, mob_pools.skill_list_id, mob_pools.true_detection, mob_family_system.detects, \
                        mob_family_system.charmable \
                        FROM mob_groups INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid \
                        INNER JOIN mob_resistances ON mob_resistances.resist_id = mob_pools.resist_id \
                        INNER JOIN mob_spawn_points ON mob_groups.groupid = mob_spawn_points.groupid \
                        INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyID \
                        INNER JOIN zone_settings ON mob_groups.zoneid = zone_settings.zoneid \
                        WHERE NOT (pos_x = 0 AND pos_y = 0 AND pos_z = 0) \
                        AND mob_groups.zoneid = ((mobid >> 12) & 0xFFF) \
                        AND mob_groups.zoneid = {};", zoneId);

                    int32 ret = sql->Query(Query.c_str());

                    if (ret != SQL_ERROR && sql->NumRows() != 0)
                    {
                        while (sql->NextRow() == SQL_SUCCESS)
                        {
                            ZONE_TYPE zoneType = PZone->GetTypeMask();

                            if (!(zoneType & ZONE_TYPE::INSTANCED))
                            {
                                CMobEntity* PMob = new CMobEntity;

                                PMob->name.insert(0, (const char*)sql->GetData(1));
                                PMob->id = sql->GetUIntData(2);

                                PMob->targid = (uint16)PMob->id & 0x0FFF;

                                PMob->m_SpawnPoint.rotation = (uint8)sql->GetIntData(3);
                                PMob->m_SpawnPoint.x        = sql->GetFloatData(4);
                                PMob->m_SpawnPoint.y        = sql->GetFloatData(5);
                                PMob->m_SpawnPoint.z        = sql->GetFloatData(6);

                                PMob->m_RespawnTime = sql->GetUIntData(7) * 1000;
                                PMob->m_SpawnType   = (SPAWNTYPE)sql->GetUIntData(8);
                                PMob->m_DropID      = sql->GetUIntData(9);

                                PMob->HPmodifier = (uint32)sql->GetIntData(10);
                                PMob->MPmodifier = (uint32)sql->GetIntData(11);

                                PMob->m_minLevel = (uint8)sql->GetIntData(12);
                                PMob->m_maxLevel = (uint8)sql->GetIntData(13);

                                uint16 sqlModelID[10];
                                memcpy(&sqlModelID, sql->GetData(14), 20);
                                PMob->look = look_t(sqlModelID);

                                PMob->SetMJob(sql->GetIntData(15));
                                PMob->SetSJob(sql->GetIntData(16));

                                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
                                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(sql->GetIntData(17));
                                PMob->m_dmgMult = sql->GetUIntData(18);
                                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((sql->GetIntData(19) * 1000) / 60);
                                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((sql->GetIntData(19) * 1000) / 60);

                                PMob->m_Behaviour   = (uint16)sql->GetIntData(20);
                                PMob->m_Link        = (uint8)sql->GetIntData(21);
                                PMob->m_Type        = (uint8)sql->GetIntData(22);
                                PMob->m_Immunity    = (IMMUNITY)sql->GetIntData(23);
                                PMob->m_EcoSystem   = (ECOSYSTEM)sql->GetIntData(24);
                                PMob->m_ModelRadius = (float)sql->GetIntData(25);

                                PMob->speed    = (uint8)sql->GetIntData(26);
                                PMob->speedsub = (uint8)sql->GetIntData(26);

                                PMob->strRank = (uint8)sql->GetIntData(27);
                                PMob->dexRank = (uint8)sql->GetIntData(28);
                                PMob->vitRank = (uint8)sql->GetIntData(29);
                                PMob->agiRank = (uint8)sql->GetIntData(30);
                                PMob->intRank = (uint8)sql->GetIntData(31);
                                PMob->mndRank = (uint8)sql->GetIntData(32);
                                PMob->chrRank = (uint8)sql->GetIntData(33);
                                PMob->evaRank = (uint8)sql->GetIntData(34);
                                PMob->defRank = (uint8)sql->GetIntData(35);
                                PMob->attRank = (uint8)sql->GetIntData(36);
                                PMob->accRank = (uint8)sql->GetIntData(37);

                                PMob->setModifier(Mod::SLASH_SDT, (uint16)(sql->GetFloatData(38) * 1000));
                                PMob->setModifier(Mod::PIERCE_SDT, (uint16)(sql->GetFloatData(39) * 1000));
                                PMob->setModifier(Mod::HTH_SDT, (uint16)(sql->GetFloatData(40) * 1000));
                                PMob->setModifier(Mod::IMPACT_SDT, (uint16)(sql->GetFloatData(41) * 1000));

                                PMob->setModifier(Mod::UDMGMAGIC, (int16)sql->GetIntData(42)); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

                                PMob->setModifier(Mod::FIRE_SDT, (int16)sql->GetIntData(43));    // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
                                PMob->setModifier(Mod::ICE_SDT, (int16)sql->GetIntData(44));     // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
                                PMob->setModifier(Mod::WIND_SDT, (int16)sql->GetIntData(45));    // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
                                PMob->setModifier(Mod::EARTH_SDT, (int16)sql->GetIntData(46));   // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
                                PMob->setModifier(Mod::THUNDER_SDT, (int16)sql->GetIntData(47)); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
                                PMob->setModifier(Mod::WATER_SDT, (int16)sql->GetIntData(48));   // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
                                PMob->setModifier(Mod::LIGHT_SDT, (int16)sql->GetIntData(49));   // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
                                PMob->setModifier(Mod::DARK_SDT, (int16)sql->GetIntData(50));    // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

                                PMob->setModifier(Mod::FIRE_RES_RANK, (int8)(sql->GetIntData(51)));
                                PMob->setModifier(Mod::ICE_RES_RANK, (int8)(sql->GetIntData(52)));
                                PMob->setModifier(Mod::WIND_RES_RANK, (int8)(sql->GetIntData(53)));
                                PMob->setModifier(Mod::EARTH_RES_RANK, (int8)(sql->GetIntData(54)));
                                PMob->setModifier(Mod::THUNDER_RES_RANK, (int8)(sql->GetIntData(55)));
                                PMob->setModifier(Mod::WATER_RES_RANK, (int8)(sql->GetIntData(56)));
                                PMob->setModifier(Mod::LIGHT_RES_RANK, (int8)(sql->GetIntData(57)));
                                PMob->setModifier(Mod::DARK_RES_RANK, (int8)(sql->GetIntData(58)));

                                PMob->m_Element     = (uint8)sql->GetIntData(59);
                                PMob->m_Family      = (uint16)sql->GetIntData(60);
                                PMob->m_SuperFamily = (uint16)sql->GetIntData(61);
                                PMob->m_name_prefix = (uint8)sql->GetIntData(62);
                                PMob->m_flags       = (uint32)sql->GetIntData(63);

                                // Cap Level if Necessary (Don't Cap NMs)
                                if (normalLevelRangeMin > 0 && !(PMob->m_Type & MOBTYPE_NOTORIOUS) && PMob->m_minLevel > normalLevelRangeMin)
                                {
                                    PMob->m_minLevel = normalLevelRangeMin;
                                }

                                if (normalLevelRangeMax > 0 && !(PMob->m_Type & MOBTYPE_NOTORIOUS) && PMob->m_maxLevel > normalLevelRangeMax)
                                {
                                    PMob->m_maxLevel = normalLevelRangeMax;
                                }

                                // Special sub animation for Mob (yovra, jailer of love, phuabo)
                                // yovra 1: On top/in the sky, 2: , 3: On top/in the sky
                                // phuabo 1: Underwater, 2: Out of the water, 3: Goes back underwater
                                PMob->animationsub = (uint32)sql->GetIntData(64);

                                if (PMob->animationsub != 0)
                                {
                                    PMob->setMobMod(MOBMOD_SPAWN_ANIMATIONSUB, PMob->animationsub);
                                }

                                // Setup HP / MP Stat Percentage Boost
                                PMob->HPscale = sql->GetFloatData(65);
                                PMob->MPscale = sql->GetFloatData(66);

                                // Check if we should be looking up scripts for this mob
                                // PMob->m_HasSpellScript = (uint8)sql->GetIntData(67);

                                PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(sql->GetIntData(68));

                                PMob->m_Pool = sql->GetUIntData(69);

                                PMob->allegiance = static_cast<ALLEGIANCE_TYPE>(sql->GetUIntData(70));
                                PMob->namevis    = sql->GetUIntData(71);
                                PMob->m_Aggro    = sql->GetUIntData(72);

                                PMob->m_roamFlags    = (uint16)sql->GetUIntData(73);
                                PMob->m_MobSkillList = sql->GetUIntData(74);

                                PMob->m_TrueDetection = sql->GetUIntData(75);
                                PMob->setMobMod(MOBMOD_DETECTION, sql->GetUIntData(76));

                                PMob->setMobMod(MOBMOD_CHARMABLE, sql->GetUIntData(77));

                                // Overwrite base family charmables depending on mob type. Disallowed mobs which should be charmable
                                // can be set in mob_spawn_mods or in their onInitialize
                                if (PMob->m_Type & MOBTYPE_EVENT ||
                                    PMob->m_Type & MOBTYPE_FISHED ||
                                    PMob->m_Type & MOBTYPE_BATTLEFIELD ||
                                    PMob->m_Type & MOBTYPE_NOTORIOUS ||
                                    zoneType & ZONE_TYPE::DYNAMIS)
                                {
                                    PMob->setMobMod(MOBMOD_CHARMABLE, 0);
                                }

                                // must be here first to define mobmods
                                mobutils::InitializeMob(PMob);

                                PZone->InsertMOB(PMob);
                            }
                        }
                    }

                    // attach pets to mobs
                    auto PetQuery = fmt::format("SELECT mob_groups.zoneid, mob_mobid, pet_offset \
                        FROM mob_pets \
                        LEFT JOIN mob_spawn_points ON mob_pets.mob_mobid = mob_spawn_points.mobid \
                        LEFT JOIN mob_groups ON mob_spawn_points.groupid = mob_groups.groupid \
                        INNER JOIN zone_settings ON mob_groups.zoneid = zone_settings.zoneid \
                        WHERE mob_groups.zoneid = ((mobid >> 12) & 0xFFF) \
                        AND mob_groups.zoneid = {};", zoneId);

                    ret = sql->Query(PetQuery.c_str());
                    if (ret != SQL_ERROR && sql->NumRows() != 0)
                    {
                        while (sql->NextRow() == SQL_SUCCESS)
                        {
                            uint16 ZoneID   = (uint16)sql->GetUIntData(0);
                            uint32 masterid = sql->GetUIntData(1);
                            uint32 petid    = masterid + sql->GetUIntData(2);

                            CMobEntity* PMaster = (CMobEntity*)GetZone(ZoneID)->GetEntity(masterid & 0x0FFF, TYPE_MOB);
                            CMobEntity* PPet    = (CMobEntity*)GetZone(ZoneID)->GetEntity(petid & 0x0FFF, TYPE_MOB);

                            if (PMaster == nullptr)
                            {
                                ShowError("zoneutils::loadMOBList PMaster is nullptr. masterid: %d. Make sure x,y,z are not zeros, and that all entities are entered in the "
                                        "database!",
                                        masterid);
                            }
                            else if (PPet == nullptr)
                            {
                                ShowError("zoneutils::loadMOBList PPet is nullptr. petid: %d. Make sure x,y,z are not zeros!", petid);
                            }
                            else if (masterid == petid)
                            {
                                ShowError("zoneutils::loadMOBList Master and Pet are the same entity: %d", masterid);
                            }
                            else
                            {
                                // pet is always spawned by master
                                PPet->m_AllowRespawn = false;
                                PPet->m_SpawnType    = SPAWNTYPE_SCRIPTED;
                                PPet->SetDespawnTime(0s);

                                PMaster->PPet = PPet;
                                PPet->PMaster = PMaster;
                            }
                        }
                    }
                });
            }
        }
        // clang-format on

        ShowInfo("Loading Mob scripts");
        // handle mob initialise functions after they're all loaded
        // clang-format off
        ForEachZone([](CZone* PZone)
        {
            PZone->ForEachMob([](CMobEntity* PMob)
            {
                // Cache Mob Lua
                luautils::OnEntityLoad(PMob);
            });

            PZone->ForEachMob([](CMobEntity* PMob)
            {
                mobutils::AddSqlModifiers(PMob);

                luautils::OnMobInitialize(PMob);
                luautils::ApplyMixins(PMob);
                luautils::ApplyZoneMixins(PMob);

                PMob->saveModifiers();
                PMob->saveMobModifiers();
            });

            // Spawn mobs after they've all been initialized. Spawning some mobs will spawn other mobs that may not yet be initialized.
            PZone->ForEachMob([](CMobEntity* PMob)
            {
                PMob->m_AllowRespawn = PMob->m_SpawnType == SPAWNTYPE_NORMAL;
                if (PMob->m_AllowRespawn)
                {
                    PMob->Spawn();
                }
                else
                {
                    PMob->PAI->Internal_Respawn(std::chrono::milliseconds(PMob->m_RespawnTime));
                }
            });
        });
        // clang-format on
    }

    /************************************************************************
     *                                                                       *
     *  Create a new zone.                                                   *
     *                                                                       *
     ************************************************************************/

    CZone* CreateZone(uint16 ZoneID)
    {
        static const char* Query = "SELECT zonetype, restriction FROM zone_settings "
                                   "WHERE zoneid = %u LIMIT 1";

        if (_sql->Query(Query, ZoneID) != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            ZONE_TYPE zoneType    = static_cast<ZONE_TYPE>(_sql->GetUIntData(0));
            uint8     restriction = static_cast<uint8>(_sql->GetUIntData(1));
            if (zoneType & ZONE_TYPE::INSTANCED)
            {
                return new CZoneInstance((ZONEID)ZoneID, GetCurrentRegion(ZoneID), GetCurrentContinent(ZoneID), restriction);
            }
            else
            {
                return new CZone((ZONEID)ZoneID, GetCurrentRegion(ZoneID), GetCurrentContinent(ZoneID), restriction);
            }
        }
        else
        {
            ShowCritical("zoneutils::CreateZone: Cannot load zone settings (%u)", ZoneID);
            return nullptr;
        }
    }

    /************************************************************************
     *                                                                       *
     *  Initialization of zones. Revive all monsters at server start.        *
     *                                                                       *
     ************************************************************************/

    void LoadZoneList()
    {
        TracyZoneScoped;
        g_PTrigger = new CNpcEntity(); // you need to set the default model in the CNpcEntity constructor

        std::vector<uint16> zones;
        const char*         query = "SELECT zoneid FROM zone_settings WHERE IF(%d <> 0, '%s' = zoneip AND %d = zoneport, TRUE);";

        char address[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, &map_ip, address, INET_ADDRSTRLEN);
        int ret = _sql->Query(query, map_ip.s_addr, address, map_port);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                zones.emplace_back(static_cast<uint16>(_sql->GetUIntData(0)));
            }
        }
        else
        {
            ShowCritical("Unable to load any zones! Check IP and port params");
            do_final(EXIT_FAILURE);
        }

        ShowInfo(fmt::format("Loading {} zones", zones.size()));

        for (auto zone : zones)
        {
            g_PZoneList[zone] = CreateZone(zone);
        }

        if (g_PZoneList.count(0) == 0)
        {
            // False positive: "performance: Searching before insertion is not necessary."
            // cppcheck-suppress stlFindInsert
            g_PZoneList[0] = CreateZone(0);
        }

#ifdef ENV32BIT
        ShowInfo("NOTE: LOS meshes wont be loaded on the 32-bit build. They take up enough memory to crash to process.");
#endif // ENV32BIT

        // clang-format off
        {
            ts::task_system ts;
            for (auto zone : zones)
            {
                ts.schedule([zone]()
                {
                    // NOTE: It is not safe to use SQL in this parallel loop!
                    g_PZoneList[zone]->LoadNavMesh();
                });
#ifndef ENV32BIT
                // The LOS meshes take up A LOT of memory, so they're hard-disabled on 32-bit builds.
                // (If you re-enable them, you'll meed the memory limit for a 32-bit application and crash!)
                // TODO: Find a sane way around this
                ts.schedule([zone]()
                {
                    // NOTE: It is not safe to use SQL in this parallel loop!
                    g_PZoneList[zone]->LoadZoneLos();
                });
#endif // !ENV32BIT
            }
        }
        // clang-format on

        // IDs attached to xi.zone[name] need to be populated before NPCs and Mobs are loaded
        luautils::PopulateIDLookupsByZone();

        LoadNPCList();
        LoadMOBList();

        campaign::LoadState();
        campaign::LoadNations();

        for (auto PZone : g_PZoneList)
        {
            if (PZone.second->GetIP() != 0)
            {
                luautils::OnZoneInitialise(PZone.second->GetID());
            }
        }

        luautils::InitInteractionGlobal();
    }

    /************************************************************************
     *                                                                       *
     *  Return current region from zone id                                   *
     *                                                                       *
     ************************************************************************/

    REGION_TYPE GetCurrentRegion(uint16 ZoneID)
    {
        switch (ZoneID)
        {
            case ZONE_BOSTAUNIEUX_OUBLIETTE:
            case ZONE_EAST_RONFAURE:
            case ZONE_FORT_GHELSBA:
            case ZONE_GHELSBA_OUTPOST:
            case ZONE_HORLAIS_PEAK:
            case ZONE_KING_RANPERRES_TOMB:
            case ZONE_WEST_RONFAURE:
            case ZONE_YUGHOTT_GROTTO:
                return REGION_TYPE::RONFAURE;
            case ZONE_GUSGEN_MINES:
            case ZONE_KONSCHTAT_HIGHLANDS:
            case ZONE_LA_THEINE_PLATEAU:
            case ZONE_ORDELLES_CAVES:
            case ZONE_SELBINA:
            case ZONE_VALKURM_DUNES:
                return REGION_TYPE::ZULKHEIM;
            case ZONE_BATALLIA_DOWNS:
            case ZONE_CARPENTERS_LANDING:
            case ZONE_DAVOI:
            case ZONE_THE_ELDIEME_NECROPOLIS:
            case ZONE_JUGNER_FOREST:
            case ZONE_MONASTIC_CAVERN:
            case ZONE_PHANAUET_CHANNEL:
                return REGION_TYPE::NORVALLEN;
            case ZONE_DANGRUF_WADI:
            case ZONE_KORROLOKA_TUNNEL:
            case ZONE_NORTH_GUSTABERG:
            case ZONE_PALBOROUGH_MINES:
            case ZONE_SOUTH_GUSTABERG:
            case ZONE_WAUGHROON_SHRINE:
            case ZONE_ZERUHN_MINES:
                return REGION_TYPE::GUSTABERG;
            case ZONE_BEADEAUX:
            case ZONE_CRAWLERS_NEST:
            case ZONE_PASHHOW_MARSHLANDS:
            case ZONE_QULUN_DOME:
            case ZONE_ROLANBERRY_FIELDS:
                return REGION_TYPE::DERFLAND;
            case ZONE_BALGAS_DAIS:
            case ZONE_EAST_SARUTABARUTA:
            case ZONE_FULL_MOON_FOUNTAIN:
            case ZONE_GIDDEUS:
            case ZONE_INNER_HORUTOTO_RUINS:
            case ZONE_OUTER_HORUTOTO_RUINS:
            case ZONE_TORAIMARAI_CANAL:
            case ZONE_WEST_SARUTABARUTA:
                return REGION_TYPE::SARUTABARUTA;
            case ZONE_BIBIKI_BAY:
            case ZONE_BUBURIMU_PENINSULA:
            case ZONE_LABYRINTH_OF_ONZOZO:
            case ZONE_MANACLIPPER:
            case ZONE_MAZE_OF_SHAKHRAMI:
            case ZONE_MHAURA:
            case ZONE_TAHRONGI_CANYON:
                return REGION_TYPE::KOLSHUSHU;
            case ZONE_ALTAR_ROOM:
            case ZONE_ATTOHWA_CHASM:
            case ZONE_BONEYARD_GULLY:
            case ZONE_CASTLE_OZTROJA:
            case ZONE_GARLAIGE_CITADEL:
            case ZONE_MERIPHATAUD_MOUNTAINS:
            case ZONE_SAUROMUGUE_CHAMPAIGN:
                return REGION_TYPE::ARAGONEU;
            case ZONE_BEAUCEDINE_GLACIER:
            case ZONE_CLOISTER_OF_FROST:
            case ZONE_FEIYIN:
            case ZONE_PSOXJA:
            case ZONE_QUBIA_ARENA:
            case ZONE_RANGUEMONT_PASS:
            case ZONE_THE_SHROUDED_MAW:
                return REGION_TYPE::FAUREGANDI;
            case ZONE_BEARCLAW_PINNACLE:
            case ZONE_CASTLE_ZVAHL_BAILEYS:
            case ZONE_CASTLE_ZVAHL_KEEP:
            case ZONE_THRONE_ROOM:
            case ZONE_ULEGUERAND_RANGE:
            case ZONE_XARCABARD:
                return REGION_TYPE::VALDEAUNIA;
            case ZONE_BEHEMOTHS_DOMINION:
            case ZONE_LOWER_DELKFUTTS_TOWER:
            case ZONE_MIDDLE_DELKFUTTS_TOWER:
            case ZONE_QUFIM_ISLAND:
            case ZONE_STELLAR_FULCRUM:
            case ZONE_UPPER_DELKFUTTS_TOWER:
                return REGION_TYPE::QUFIMISLAND;
            case ZONE_THE_BOYAHDA_TREE:
            case ZONE_CLOISTER_OF_STORMS:
            case ZONE_DRAGONS_AERY:
            case ZONE_HALL_OF_THE_GODS:
            case ZONE_ROMAEVE:
            case ZONE_THE_SANCTUARY_OF_ZITAH:
                return REGION_TYPE::LITELOR;
            case ZONE_CLOISTER_OF_TREMORS:
            case ZONE_EASTERN_ALTEPA_DESERT:
            case ZONE_CHAMBER_OF_ORACLES:
            case ZONE_QUICKSAND_CAVES:
            case ZONE_RABAO:
            case ZONE_WESTERN_ALTEPA_DESERT:
                return REGION_TYPE::KUZOTZ;
            case ZONE_CAPE_TERIGGAN:
            case ZONE_CLOISTER_OF_GALES:
            case ZONE_GUSTAV_TUNNEL:
            case ZONE_KUFTAL_TUNNEL:
            case ZONE_VALLEY_OF_SORROWS:
                return REGION_TYPE::VOLLBOW;
            case ZONE_KAZHAM:
            case ZONE_NORG:
            case ZONE_SEA_SERPENT_GROTTO:
            case ZONE_YUHTUNGA_JUNGLE:
                return REGION_TYPE::ELSHIMOLOWLANDS;
            case ZONE_CLOISTER_OF_FLAMES:
            case ZONE_CLOISTER_OF_TIDES:
            case ZONE_DEN_OF_RANCOR:
            case ZONE_IFRITS_CAULDRON:
            case ZONE_SACRIFICIAL_CHAMBER:
            case ZONE_TEMPLE_OF_UGGALEPIH:
            case ZONE_YHOATOR_JUNGLE:
                return REGION_TYPE::ELSHIMOUPLANDS;
            case ZONE_THE_CELESTIAL_NEXUS:
            case ZONE_LALOFF_AMPHITHEATER:
            case ZONE_RUAUN_GARDENS:
            case ZONE_THE_SHRINE_OF_RUAVITAU:
            case ZONE_VELUGANNON_PALACE:
                return REGION_TYPE::TULIA;
            case ZONE_MINE_SHAFT_2716:
            case ZONE_NEWTON_MOVALPOLOS:
            case ZONE_OLDTON_MOVALPOLOS:
                return REGION_TYPE::MOVALPOLOS;
            case ZONE_LUFAISE_MEADOWS:
            case ZONE_MISAREAUX_COAST:
            case ZONE_MONARCH_LINN:
            case ZONE_PHOMIUNA_AQUEDUCTS:
            case ZONE_RIVERNE_SITE_A01:
            case ZONE_RIVERNE_SITE_B01:
            case ZONE_SACRARIUM:
            case ZONE_SEALIONS_DEN:
                return REGION_TYPE::TAVNAZIA;
            case ZONE_TAVNAZIAN_SAFEHOLD:
                return REGION_TYPE::TAVNAZIAN_MARQ;
            case ZONE_SOUTHERN_SANDORIA:
            case ZONE_NORTHERN_SANDORIA:
            case ZONE_PORT_SANDORIA:
            case ZONE_CHATEAU_DORAGUILLE:
                return REGION_TYPE::SANDORIA;
            case ZONE_BASTOK_MINES:
            case ZONE_BASTOK_MARKETS:
            case ZONE_PORT_BASTOK:
            case ZONE_METALWORKS:
                return REGION_TYPE::BASTOK;
            case ZONE_WINDURST_WATERS:
            case ZONE_WINDURST_WALLS:
            case ZONE_PORT_WINDURST:
            case ZONE_WINDURST_WOODS:
            case ZONE_HEAVENS_TOWER:
                return REGION_TYPE::WINDURST;
            case ZONE_RULUDE_GARDENS:
            case ZONE_UPPER_JEUNO:
            case ZONE_LOWER_JEUNO:
            case ZONE_PORT_JEUNO:
                return REGION_TYPE::JEUNO;
            case ZONE_DYNAMIS_BASTOK:
            case ZONE_DYNAMIS_BEAUCEDINE:
            case ZONE_DYNAMIS_BUBURIMU:
            case ZONE_DYNAMIS_JEUNO:
            case ZONE_DYNAMIS_QUFIM:
            case ZONE_DYNAMIS_SAN_DORIA:
            case ZONE_DYNAMIS_TAVNAZIA:
            case ZONE_DYNAMIS_VALKURM:
            case ZONE_DYNAMIS_WINDURST:
            case ZONE_DYNAMIS_XARCABARD:
                return REGION_TYPE::DYNAMIS;
            case ZONE_PROMYVION_DEM:
            case ZONE_PROMYVION_HOLLA:
            case ZONE_PROMYVION_MEA:
            case ZONE_PROMYVION_VAHZL:
            case ZONE_SPIRE_OF_DEM:
            case ZONE_SPIRE_OF_HOLLA:
            case ZONE_SPIRE_OF_MEA:
            case ZONE_SPIRE_OF_VAHZL:
            case ZONE_HALL_OF_TRANSFERENCE:
                return REGION_TYPE::PROMYVION;
            case ZONE_ALTAIEU:
            case ZONE_EMPYREAL_PARADOX:
            case ZONE_THE_GARDEN_OF_RUHMET:
            case ZONE_GRAND_PALACE_OF_HUXZOI:
                return REGION_TYPE::LUMORIA;
            case ZONE_APOLLYON:
            case ZONE_TEMENOS:
                return REGION_TYPE::LIMBUS;
            case ZONE_AL_ZAHBI:
            case ZONE_AHT_URHGAN_WHITEGATE:
            case ZONE_BHAFLAU_THICKETS:
            case ZONE_THE_COLOSSEUM:
                return REGION_TYPE::WEST_AHT_URHGAN;
            case ZONE_MAMOOL_JA_TRAINING_GROUNDS:
            case ZONE_MAMOOK:
            case ZONE_WAJAOM_WOODLANDS:
            case ZONE_AYDEEWA_SUBTERRANE:
            case ZONE_JADE_SEPULCHER:
                return REGION_TYPE::MAMOOL_JA_SAVAGE;
            case ZONE_HALVUNG:
            case ZONE_MOUNT_ZHAYOLM:
            case ZONE_LEBROS_CAVERN:
            case ZONE_NAVUKGO_EXECUTION_CHAMBER:
                return REGION_TYPE::HALVUNG;
            case ZONE_ARRAPAGO_REEF:
            case ZONE_CAEDARVA_MIRE:
            case ZONE_LEUJAOAM_SANCTUM:
            case ZONE_NASHMAU:
            case ZONE_HAZHALM_TESTING_GROUNDS:
            case ZONE_TALACCA_COVE:
            case ZONE_PERIQIA:
                return REGION_TYPE::ARRAPAGO;
            case ZONE_NYZUL_ISLE:
            case ZONE_ARRAPAGO_REMNANTS:
            case ZONE_ALZADAAL_UNDERSEA_RUINS:
            case ZONE_BHAFLAU_REMNANTS:
            case ZONE_SILVER_SEA_REMNANTS:
            case ZONE_ZHAYOLM_REMNANTS:
                return REGION_TYPE::ALZADAAL;
            case ZONE_SOUTHERN_SAN_DORIA_S:
            case ZONE_EAST_RONFAURE_S:
                return REGION_TYPE::RONFAURE_FRONT;
            case ZONE_BASTOK_MARKETS_S:
            case ZONE_NORTH_GUSTABERG_S:
            case ZONE_RUHOTZ_SILVERMINES:
            case ZONE_GRAUBERG_S:
                return REGION_TYPE::GUSTABERG_FRONT;
            case ZONE_WINDURST_WATERS_S:
            case ZONE_WEST_SARUTABARUTA_S:
            case ZONE_GHOYUS_REVERIE:
            case ZONE_FORT_KARUGO_NARUGO_S:
                return REGION_TYPE::SARUTA_FRONT;
            case ZONE_BATALLIA_DOWNS_S:
            case ZONE_JUGNER_FOREST_S:
            case ZONE_LA_VAULE_S:
            case ZONE_EVERBLOOM_HOLLOW:
            case ZONE_THE_ELDIEME_NECROPOLIS_S:
                return REGION_TYPE::NORVALLEN_FRONT;
            case ZONE_ROLANBERRY_FIELDS_S:
            case ZONE_PASHHOW_MARSHLANDS_S:
            case ZONE_CRAWLERS_NEST_S:
            case ZONE_BEADEAUX_S:
            case ZONE_VUNKERL_INLET_S:
                return REGION_TYPE::DERFLAND_FRONT;
            case ZONE_SAUROMUGUE_CHAMPAIGN_S:
            case ZONE_MERIPHATAUD_MOUNTAINS_S:
            case ZONE_CASTLE_OZTROJA_S:
            case ZONE_GARLAIGE_CITADEL_S:
                return REGION_TYPE::ARAGONEAU_FRONT;
            case ZONE_BEAUCEDINE_GLACIER_S:
                return REGION_TYPE::FAUREGANDI_FRONT;
            case ZONE_XARCABARD_S:
            case ZONE_CASTLE_ZVAHL_BAILEYS_S:
            case ZONE_CASTLE_ZVAHL_KEEP_S:
            case ZONE_THRONE_ROOM_S:
                return REGION_TYPE::VALDEAUNIA_FRONT;
            case ZONE_ABYSSEA_ALTEPA:
            case ZONE_ABYSSEA_ATTOHWA:
            case ZONE_ABYSSEA_EMPYREAL_PARADOX:
            case ZONE_ABYSSEA_GRAUBERG:
            case ZONE_ABYSSEA_KONSCHTAT:
            case ZONE_ABYSSEA_LA_THEINE:
            case ZONE_ABYSSEA_MISAREAUX:
            case ZONE_ABYSSEA_TAHRONGI:
            case ZONE_ABYSSEA_ULEGUERAND:
            case ZONE_ABYSSEA_VUNKERL:
                return REGION_TYPE::ABYSSEA;
            case ZONE_WALK_OF_ECHOES:
                return REGION_TYPE::THE_THRESHOLD;
            case ZONE_DIORAMA_ABDHALJS_GHELSBA:
            case ZONE_ABDHALJS_ISLE_PURGONORGO:
            case ZONE_MAQUETTE_ABDHALJS_LEGION_A:
            case ZONE_MAQUETTE_ABDHALJS_LEGION_B:
                return REGION_TYPE::ABDHALJS;
            case ZONE_WESTERN_ADOULIN:
            case ZONE_EASTERN_ADOULIN:
            case ZONE_RALA_WATERWAYS:
            case ZONE_RALA_WATERWAYS_U:
                return REGION_TYPE::ADOULIN_ISLANDS;
            case ZONE_CEIZAK_BATTLEGROUNDS:
            case ZONE_FORET_DE_HENNETIEL:
            case ZONE_SIH_GATES:
            case ZONE_MOH_GATES:
            case ZONE_CIRDAS_CAVERNS:
            case ZONE_CIRDAS_CAVERNS_U:
            case ZONE_YAHSE_HUNTING_GROUNDS:
            case ZONE_MORIMAR_BASALT_FIELDS:
                return REGION_TYPE::EAST_ULBUKA;
        }
        return REGION_TYPE::UNKNOWN;
    }

    CONTINENT_TYPE GetCurrentContinent(uint16 ZoneID)
    {
        return GetCurrentRegion(ZoneID) != REGION_TYPE::UNKNOWN ? CONTINENT_TYPE::THE_MIDDLE_LANDS : CONTINENT_TYPE::OTHER_AREAS;
    }

    int GetWeatherElement(WEATHER weather)
    {
        if (weather >= MAX_WEATHER_ID)
        {
            ShowWarning("zoneutils::GetWeatherElement() - Invalid weather passed to function.");
            return 0;
        }

        // TODO: Fix weather ordering; at the moment, this current fire, water, earth, wind, snow, thunder
        // order MUST be preserved due to the weather enums going in this order. Those enums will
        // most likely have rippling effects, such as how weather data is stored in the db
        static uint8 Element[] = {
            0, // WEATHER_NONE
            0, // WEATHER_SUNSHINE
            0, // WEATHER_CLOUDS
            0, // WEATHER_FOG
            1, // WEATHER_HOT_SPELL
            1, // WEATHER_HEAT_WAVE
            6, // WEATHER_RAIN
            6, // WEATHER_SQUALL
            4, // WEATHER_DUST_STORM
            4, // WEATHER_SAND_STORM
            3, // WEATHER_WIND
            3, // WEATHER_GALES
            2, // WEATHER_SNOW
            2, // WEATHER_BLIZZARDS
            5, // WEATHER_THUNDER
            5, // WEATHER_THUNDERSTORMS
            7, // WEATHER_AURORAS
            7, // WEATHER_STELLAR_GLARE
            8, // WEATHER_GLOOM
            8, // WEATHER_DARKNESS
        };
        return Element[weather];
    }

    /************************************************************************
     *                                                                       *
     *  Clear (free up) the list of zones                                    *
     *                                                                       *
     ************************************************************************/

    void FreeZoneList()
    {
        for (auto PZone : g_PZoneList)
        {
            destroy(PZone.second);
        }
        g_PZoneList.clear();
        destroy(g_PTrigger);
    }

    void ForEachZone(const std::function<void(CZone*)>& func)
    {
        for (auto PZone : g_PZoneList)
        {
            func(PZone.second);
        }
    }

    uint64 GetZoneIPP(uint16 zoneID)
    {
        uint64      ipp   = 0;
        const char* query = "SELECT zoneip, zoneport FROM zone_settings WHERE zoneid = %u;";

        int ret = _sql->Query(query, zoneID);

        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            inet_pton(AF_INET, (const char*)_sql->GetData(0), &ipp);
            uint64 port = _sql->GetUIntData(1);
            ipp |= (port << 32);
        }
        else
        {
            ShowCritical("zoneutils::GetZoneIPP: Cannot find zone %u", zoneID);
        }
        return ipp;
    }

    /************************************************************************
     *                                                                       *
     *  Check whether or not the zone is a residential area                  *
     *                                                                       *
     ************************************************************************/

    bool IsResidentialArea(CCharEntity* PChar)
    {
        return PChar->m_moghouseID != 0;
    }

    void AfterZoneIn(CBaseEntity* PEntity)
    {
        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PEntity);
        if (PChar != nullptr && (PChar->PBattlefield == nullptr || !PChar->PBattlefield->isEntered(PChar)))
        {
            GetZone(PChar->getZone())->updateCharLevelRestriction(PChar);
        }

        luautils::AfterZoneIn(PChar);
    }

    bool IsAlwaysOutOfNationControl(REGION_TYPE region)
    {
        return region >= REGION_TYPE::SANDORIA && region <= REGION_TYPE::LIMBUS;
    }

}; // namespace zoneutils
