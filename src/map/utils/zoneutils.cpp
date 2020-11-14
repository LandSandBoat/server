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

#include "../../common/showmsg.h"

#include <string.h>
#include "../../common/timer.h"

#include "../ai/ai_container.h"

#include "../lua/luautils.h"

#include "../conquest_system.h"
#include "../map.h"
#include "../entities/mobentity.h"
#include "../entities/npcentity.h"
#include "zoneutils.h"
#include "mobutils.h"
#include "../items/item_weapon.h"
#include "../mob_spell_list.h"
#include "../packets/entity_update.h"
#include "../zone_instance.h"
#include "../mob_modifier.h"


std::map<uint16, CZone*> g_PZoneList;   // глобальный массив указателей на игровые зоны
CNpcEntity*  g_PTrigger;    // триггер для запуска событий


namespace zoneutils
{

/************************************************************************
*                                                                       *
*  Реакция зон на смену времени суток                                   *
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

                //ShowDebug(CL_YELLOW"zonetuils::InitializeWeather: Static weather of %s updated to %u\n" CL_RESET, PZone.second->GetName(), PZone.second->m_WeatherVector.at(0).m_common);
            }
            else
            {
                PZone.second->SetWeather(WEATHER_NONE); // If not weather data found, initialize with WEATHER_NONE

                //ShowDebug(CL_YELLOW"zonetuils::InitializeWeather: Static weather of %s updated to WEATHER_NONE\n" CL_RESET, PZone.second->GetName());
            }
        }
    }
    ShowDebug(CL_CYAN"InitializeWeather Finished\n" CL_RESET);
}

void SavePlayTime()
{
    for (auto PZone : g_PZoneList)
    {
        PZone.second->SavePlayTime();
    }
    ShowDebug(CL_CYAN"Player playtime saving finished\n" CL_RESET);
}

/************************************************************************
*                                                                       *
*  Возвращаем указатель на класс зоны с указанным ID.                   *
*                                                                       *
************************************************************************/

CZone* GetZone(uint16 ZoneID)
{
    TPZ_DEBUG_BREAK_IF(ZoneID >= MAX_ZONEID);
    if (auto PZone = g_PZoneList.find(ZoneID); PZone != g_PZoneList.end())
    {
        return PZone->second;
    }
    return nullptr;
}

CNpcEntity* GetTrigger(uint16 TargID, uint16 ZoneID)
{
    g_PTrigger->targid = TargID;
    g_PTrigger->id = ((4096 + ZoneID) << 12) + TargID;

    ShowWarning(CL_YELLOW"Server need NPC <%u>\n" CL_RESET, g_PTrigger->id);
    return g_PTrigger;
}

/************************************************************************
*                                                                       *
*  Получаем указатель на любую сущность по ID                           *
*                                                                       *
************************************************************************/

CBaseEntity* GetEntity(uint32 ID, uint8 filter)
{
    uint16 zoneID = (ID >> 12) & 0x0FFF;
    CZone* PZone = GetZone(zoneID);
    if (PZone)
    {
        return PZone->GetEntity((uint16)(ID & 0x0FFF), filter);
    }
    else
    {
        return nullptr;
    }
}

/************************************************************************
*                                                                       *
*  Получаем указатель на персонажа по имени                             *
*                                                                       *
************************************************************************/

CCharEntity* GetCharByName(int8* name)
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

/************************************************************************
*                                                                       *
*  Получаем указатель на CCharEntity по id и targid                     *
*                                                                       *
************************************************************************/

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


CCharEntity* GetCharToUpdate(uint32 primary, uint32 ternary)
{
    CCharEntity* PPrimary = nullptr;
    CCharEntity* PSecondary = nullptr;
    CCharEntity* PTernary = nullptr;

    for (auto PZone : g_PZoneList)
    {
        PZone.second->ForEachChar([primary, ternary, &PPrimary, &PSecondary, &PTernary](CCharEntity* PChar)
        {
            if (!PPrimary)
            {
                if (PChar->id == primary)
                    PPrimary = PChar;
                else if (PChar->PParty && PChar->PParty->GetPartyID() == primary)
                    PSecondary = PChar;
                else if (PChar->id == ternary)
                    PTernary = PChar;
            }
        });
        if (PPrimary)
            return PPrimary;
    }
    if (PSecondary)
        return PSecondary;

    return PTernary;
}
/************************************************************************
*                                                                       *
*  Загружаем список NPC в указанную зону                                *
*                                                                       *
************************************************************************/

void LoadNPCList()
{
    const char* Query =
        "SELECT \
          npcid,\
          npc_list.name,\
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
          content_tag, \
          widescan \
        FROM npc_list INNER JOIN zone_settings \
        ON (npcid & 0xFFF000) >> 12 = zone_settings.zoneid \
        WHERE IF(%d <> 0, '%s' = zoneip AND %d = zoneport, TRUE);";

    char address[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &map_ip, address, INET_ADDRSTRLEN);
    int32 ret = Sql_Query(SqlHandle, Query, map_ip.s_addr, address, map_port);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            const char* contentTag = (const char*)Sql_GetData(SqlHandle, 16);

            if (luautils::IsContentEnabled(contentTag) == false)
            {
                continue;
            }

            uint32 NpcID = Sql_GetUIntData(SqlHandle, 0);
            uint16 ZoneID = (NpcID - 0x1000000) >> 12;

            if (GetZone(ZoneID)->GetType() != ZONETYPE_DUNGEON_INSTANCED)
            {
                CNpcEntity* PNpc = new CNpcEntity;
                PNpc->targid = NpcID & 0xFFF;
                PNpc->id = NpcID;

                PNpc->name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));

                PNpc->loc.p.rotation = (uint8)Sql_GetIntData(SqlHandle, 2);
                PNpc->loc.p.x = Sql_GetFloatData(SqlHandle, 3);
                PNpc->loc.p.y = Sql_GetFloatData(SqlHandle, 4);
                PNpc->loc.p.z = Sql_GetFloatData(SqlHandle, 5);
                PNpc->loc.p.moving = (uint16)Sql_GetUIntData(SqlHandle, 6);

                PNpc->m_TargID = (uint32)Sql_GetUIntData(SqlHandle, 6) >> 16; // вполне вероятно

                PNpc->speed = (uint8)Sql_GetIntData(SqlHandle, 7);    // Overwrites baseentity.cpp's defined speed
                PNpc->speedsub = (uint8)Sql_GetIntData(SqlHandle, 8); // Overwrites baseentity.cpp's defined speedsub

                PNpc->animation = (uint8)Sql_GetIntData(SqlHandle, 9);
                PNpc->animationsub = (uint8)Sql_GetIntData(SqlHandle, 10);

                PNpc->namevis = (uint8)Sql_GetIntData(SqlHandle, 11);
                PNpc->status = (STATUSTYPE)Sql_GetIntData(SqlHandle, 12);
                PNpc->m_flags = (uint32)Sql_GetUIntData(SqlHandle, 13);

                PNpc->name_prefix = (uint8)Sql_GetIntData(SqlHandle, 15);
                PNpc->widescan = (uint8)Sql_GetIntData(SqlHandle, 17);

                memcpy(&PNpc->look, Sql_GetData(SqlHandle, 14), 20);

                GetZone(ZoneID)->InsertNPC(PNpc);
            }
        }
    }

    // handle npc spawn functions after they're all done loading
    ForEachZone([](CZone* PZone)
    {
        PZone->ForEachNpc([](CNpcEntity* PNpc)
        {
            luautils::OnNpcSpawn(PNpc);
        });
    });

}

/************************************************************************
*                                                                       *
*  Загружаем список монстров в указанную зону                           *
*                                                                       *
************************************************************************/

void LoadMOBList()
{
    uint8 normalLevelRangeMin = luautils::GetSettingsVariable("NORMAL_MOB_MAX_LEVEL_RANGE_MIN");
    uint8 normalLevelRangeMax = luautils::GetSettingsVariable("NORMAL_MOB_MAX_LEVEL_RANGE_MAX");

    const char* Query =
        "SELECT mob_groups.zoneid, mobname, mobid, pos_rot, pos_x, pos_y, pos_z, \
            respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, \
            modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, \
            systemid, mobsize, speed, \
            STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, \
            Slash, Pierce, H2H, Impact, \
            Fire, Ice, Wind, Earth, Lightning, Water, Light, Dark, Element, \
            mob_pools.familyid, name_prefix, entityFlags, animationsub, \
            (mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, ATT, ACC, mob_groups.poolid, \
            allegiance, namevis, aggro, roamflag, mob_pools.skill_list_id, mob_pools.true_detection, mob_family_system.detects, \
            mob_family_system.charmable \
            FROM mob_groups INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid \
            INNER JOIN mob_spawn_points ON mob_groups.groupid = mob_spawn_points.groupid \
            INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyid \
            INNER JOIN zone_settings ON mob_groups.zoneid = zone_settings.zoneid \
            WHERE NOT (pos_x = 0 AND pos_y = 0 AND pos_z = 0) AND IF(%d <> 0, '%s' = zoneip AND %d = zoneport, TRUE) \
            AND mob_groups.zoneid = ((mobid >> 12) & 0xFFF);";

    char address[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &map_ip, address, INET_ADDRSTRLEN);
    int32 ret = Sql_Query(SqlHandle, Query, map_ip.s_addr, address, map_port);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            uint16 ZoneID = (uint16)Sql_GetUIntData(SqlHandle, 0);
            ZONETYPE zoneType = GetZone(ZoneID)->GetType();

            if (zoneType != ZONETYPE_DUNGEON_INSTANCED)
            {
                CMobEntity* PMob = new CMobEntity;

                PMob->name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
                PMob->id = (uint32)Sql_GetUIntData(SqlHandle, 2);

                PMob->targid = (uint16)PMob->id & 0x0FFF;

                PMob->m_SpawnPoint.rotation = (uint8)Sql_GetIntData(SqlHandle, 3);
                PMob->m_SpawnPoint.x = Sql_GetFloatData(SqlHandle, 4);
                PMob->m_SpawnPoint.y = Sql_GetFloatData(SqlHandle, 5);
                PMob->m_SpawnPoint.z = Sql_GetFloatData(SqlHandle, 6);

                PMob->m_RespawnTime = Sql_GetUIntData(SqlHandle, 7) * 1000;
                PMob->m_SpawnType = (SPAWNTYPE)Sql_GetUIntData(SqlHandle, 8);
                PMob->m_DropID = Sql_GetUIntData(SqlHandle, 9);

                PMob->HPmodifier = (uint32)Sql_GetIntData(SqlHandle, 10);
                PMob->MPmodifier = (uint32)Sql_GetIntData(SqlHandle, 11);

                PMob->m_minLevel = (uint8)Sql_GetIntData(SqlHandle, 12);
                PMob->m_maxLevel = (uint8)Sql_GetIntData(SqlHandle, 13);

                memcpy(&PMob->look, Sql_GetData(SqlHandle, 14), 23);

                PMob->SetMJob(Sql_GetIntData(SqlHandle, 15));
                PMob->SetSJob(Sql_GetIntData(SqlHandle, 16));

                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(Sql_GetIntData(SqlHandle, 17));
                PMob->m_dmgMult = Sql_GetUIntData(SqlHandle, 18);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((Sql_GetIntData(SqlHandle, 19) * 1000) / 60);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((Sql_GetIntData(SqlHandle, 19) * 1000) / 60);

                PMob->m_Behaviour = (uint16)Sql_GetIntData(SqlHandle, 20);
                PMob->m_Link = (uint8)Sql_GetIntData(SqlHandle, 21);
                PMob->m_Type = (uint8)Sql_GetIntData(SqlHandle, 22);
                PMob->m_Immunity = (IMMUNITY)Sql_GetIntData(SqlHandle, 23);
                PMob->m_EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlHandle, 24);
                PMob->m_ModelSize = (uint8)Sql_GetIntData(SqlHandle, 25);

                PMob->speed = (uint8)Sql_GetIntData(SqlHandle, 26);
                PMob->speedsub = (uint8)Sql_GetIntData(SqlHandle, 26);

                /*if(PMob->speed != 0)
                {
                PMob->speed += map_config.speed_mod;
                // whats this for?
                PMob->speedsub += map_config.speed_mod;
                }*/

                PMob->strRank = (uint8)Sql_GetIntData(SqlHandle, 27);
                PMob->dexRank = (uint8)Sql_GetIntData(SqlHandle, 28);
                PMob->vitRank = (uint8)Sql_GetIntData(SqlHandle, 29);
                PMob->agiRank = (uint8)Sql_GetIntData(SqlHandle, 30);
                PMob->intRank = (uint8)Sql_GetIntData(SqlHandle, 31);
                PMob->mndRank = (uint8)Sql_GetIntData(SqlHandle, 32);
                PMob->chrRank = (uint8)Sql_GetIntData(SqlHandle, 33);
                PMob->evaRank = (uint8)Sql_GetIntData(SqlHandle, 34);
                PMob->defRank = (uint8)Sql_GetIntData(SqlHandle, 35);
                PMob->attRank = (uint8)Sql_GetIntData(SqlHandle, 57);
                PMob->accRank = (uint8)Sql_GetIntData(SqlHandle, 58);

                PMob->setModifier(Mod::SLASHRES, (uint16)(Sql_GetFloatData(SqlHandle, 36) * 1000));
                PMob->setModifier(Mod::PIERCERES, (uint16)(Sql_GetFloatData(SqlHandle, 37) * 1000));
                PMob->setModifier(Mod::HTHRES, (uint16)(Sql_GetFloatData(SqlHandle, 38) * 1000));
                PMob->setModifier(Mod::IMPACTRES, (uint16)(Sql_GetFloatData(SqlHandle, 39) * 1000));

                PMob->setModifier(Mod::FIRERES, (int16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -100)); // These are stored as floating percentages
                PMob->setModifier(Mod::ICERES, (int16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100)); // and need to be adjusted into modifier units.
                PMob->setModifier(Mod::WINDRES, (int16)((Sql_GetFloatData(SqlHandle, 42) - 1) * -100)); // Higher RES = lower damage.
                PMob->setModifier(Mod::EARTHRES, (int16)((Sql_GetFloatData(SqlHandle, 43) - 1) * -100)); // Negatives signify lower resist chance.
                PMob->setModifier(Mod::THUNDERRES, (int16)((Sql_GetFloatData(SqlHandle, 44) - 1) * -100)); // Positives signify increased resist chance.
                PMob->setModifier(Mod::WATERRES, (int16)((Sql_GetFloatData(SqlHandle, 45) - 1) * -100));
                PMob->setModifier(Mod::LIGHTRES, (int16)((Sql_GetFloatData(SqlHandle, 46) - 1) * -100));
                PMob->setModifier(Mod::DARKRES, (int16)((Sql_GetFloatData(SqlHandle, 47) - 1) * -100));

                PMob->m_Element = (uint8)Sql_GetIntData(SqlHandle, 48);
                PMob->m_Family = (uint16)Sql_GetIntData(SqlHandle, 49);
                PMob->m_name_prefix = (uint8)Sql_GetIntData(SqlHandle, 50);
                PMob->m_flags = (uint32)Sql_GetIntData(SqlHandle, 51);

                // Cap Level if Necessary (Don't Cap NMs)
                if (normalLevelRangeMin > 0 && !(PMob->m_Type & MOBTYPE_NOTORIOUS) && PMob->m_minLevel > normalLevelRangeMin)
                {
                    PMob->m_minLevel = normalLevelRangeMin;
                }

                if (normalLevelRangeMax > 0 && !(PMob->m_Type & MOBTYPE_NOTORIOUS) && PMob->m_maxLevel > normalLevelRangeMax)
                {
                    PMob->m_maxLevel = normalLevelRangeMax;
                }

                //Special sub animation for Mob (yovra, jailer of love, phuabo)
                // yovra 1: en hauteur, 2: en bas, 3: en haut
                // phuabo 1: sous l'eau, 2: sort de l'eau, 3: rentre dans l'eau
                PMob->animationsub = (uint32)Sql_GetIntData(SqlHandle, 52);

                if (PMob->animationsub != 0)
                    PMob->setMobMod(MOBMOD_SPAWN_ANIMATIONSUB, PMob->animationsub);

                // Setup HP / MP Stat Percentage Boost
                PMob->HPscale = Sql_GetFloatData(SqlHandle, 53);
                PMob->MPscale = Sql_GetFloatData(SqlHandle, 54);

                // Check if we should be looking up scripts for this mob
                PMob->m_HasSpellScript = (uint8)Sql_GetIntData(SqlHandle, 55);

                PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(Sql_GetIntData(SqlHandle, 56));

                PMob->m_Pool = Sql_GetUIntData(SqlHandle, 59);

                PMob->allegiance = Sql_GetUIntData(SqlHandle, 60);
                PMob->namevis = Sql_GetUIntData(SqlHandle, 61);
                PMob->m_Aggro = Sql_GetUIntData(SqlHandle, 62);

                PMob->m_roamFlags = (uint16)Sql_GetUIntData(SqlHandle, 63);
                PMob->m_MobSkillList = Sql_GetUIntData(SqlHandle, 64);

                PMob->m_TrueDetection = Sql_GetUIntData(SqlHandle, 65);
                PMob->m_Detects = Sql_GetUIntData(SqlHandle, 66);

                PMob->setMobMod(MOBMOD_CHARMABLE, Sql_GetUIntData(SqlHandle, 67));

                // Overwrite base family charmables depending on mob type. Disallowed mobs which should be charmable
                // can be set in mob_spawn_mods or in their onInitialize
                if (PMob->m_Type & MOBTYPE_EVENT || PMob->m_Type & MOBTYPE_FISHED || PMob->m_Type & MOBTYPE_BATTLEFIELD ||
                    PMob->m_Type & MOBTYPE_NOTORIOUS || zoneType == ZONETYPE_BATTLEFIELD || zoneType == ZONETYPE_DYNAMIS)
                {
                    PMob->setMobMod(MOBMOD_CHARMABLE, 0);
                }

                // must be here first to define mobmods
                mobutils::InitializeMob(PMob, GetZone(ZoneID));

                GetZone(ZoneID)->InsertMOB(PMob);
            }
        }
    }

    // handle mob initialise functions after they're all loaded
    ForEachZone([](CZone* PZone)
    {
        PZone->ForEachMob([](CMobEntity* PMob)
        {
            luautils::OnMobInitialize(PMob);
            luautils::ApplyMixins(PMob);
            luautils::ApplyZoneMixins(PMob);
            PMob->saveModifiers();
            PMob->saveMobModifiers();
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

    // attach pets to mobs
    const char* PetQuery =
        "SELECT mob_groups.zoneid, mob_mobid, pet_offset \
        FROM mob_pets \
        LEFT JOIN mob_spawn_points ON mob_pets.mob_mobid = mob_spawn_points.mobid \
        LEFT JOIN mob_groups ON mob_spawn_points.groupid = mob_groups.groupid \
        INNER JOIN zone_settings ON mob_groups.zoneid = zone_settings.zoneid \
        WHERE IF(%d <> 0, '%s' = zoneip AND %d = zoneport, TRUE) \
        AND mob_groups.zoneid = ((mobid >> 12) & 0xFFF);";

    ret = Sql_Query(SqlHandle, PetQuery, map_ip.s_addr, address, map_port);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            uint16 ZoneID = (uint16)Sql_GetUIntData(SqlHandle, 0);
            uint32 masterid = (uint32)Sql_GetUIntData(SqlHandle,1);
            uint32 petid = masterid + (uint32)Sql_GetUIntData(SqlHandle,2);

            CMobEntity* PMaster = (CMobEntity*)GetZone(ZoneID)->GetEntity(masterid & 0x0FFF, TYPE_MOB);
            CMobEntity* PPet = (CMobEntity*)GetZone(ZoneID)->GetEntity(petid & 0x0FFF, TYPE_MOB);

            if (PMaster == nullptr)
            {
                ShowError("zoneutils::loadMOBList PMaster is NULL. masterid: %d. Make sure x,y,z are not zeros, and that all entities are entered in the database!\n", masterid);
            }
            else if (PPet == nullptr)
            {
                ShowError("zoneutils::loadMOBList PPet is NULL. petid: %d. Make sure x,y,z are not zeros!\n", petid);
            }
            else if (masterid == petid)
            {
                ShowError("zoneutils::loadMOBList Master and Pet are the same entity: %d\n", masterid);
            }
            else
            {
                // pet is always spawned by master
                PPet->m_AllowRespawn = false;
                PPet->m_SpawnType = SPAWNTYPE_SCRIPTED;
                PPet->SetDespawnTime(0s);

                PMaster->PPet = PPet;
                PPet->PMaster = PMaster;
            }
        }
    }
}

/************************************************************************
*                                                                       *
*  Creates a new zone.                                                  *
*                                                                       *
************************************************************************/

CZone* CreateZone(uint16 ZoneID)
{
    static const char* Query =
        "SELECT zonetype FROM zone_settings "
        "WHERE zoneid = %u LIMIT 1";

    if (Sql_Query(SqlHandle, Query, ZoneID) != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        if ((ZONETYPE)Sql_GetUIntData(SqlHandle, 0) == ZONETYPE_DUNGEON_INSTANCED)
        {
            return new CZoneInstance((ZONEID)ZoneID, GetCurrentRegion(ZoneID), GetCurrentContinent(ZoneID));
        }
        else
        {
            return new CZone((ZONEID)ZoneID, GetCurrentRegion(ZoneID), GetCurrentContinent(ZoneID));
        }
    }
    else
    {
        ShowFatalError(CL_RED"zoneutils::CreateZone: Cannot load zone settings (%u)\n" CL_RESET, ZoneID);
        return nullptr;
    }
}

/************************************************************************
*                                                                       *
*  Инициализация зон. Возрождаем всех монстров при старте сервера.      *
*                                                                       *
************************************************************************/

void LoadZoneList()
{
    TracyZoneScoped;
    g_PTrigger = new CNpcEntity();  // нужно в конструкторе CNpcEntity задавать модель по умолчанию

    std::vector<uint16> zones;
    const char* query = "SELECT zoneid FROM zone_settings WHERE IF(%d <> 0, '%s' = zoneip AND %d = zoneport, TRUE);";

    char address[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &map_ip, address, INET_ADDRSTRLEN);
    int ret = Sql_Query(SqlHandle, query, map_ip.s_addr, address, map_port);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            zones.push_back(Sql_GetUIntData(SqlHandle, 0));
        }
    }
    else
    {
        ShowFatalError("Unable to load any zones! Check IP and port params\n");
        do_final(EXIT_FAILURE);
    }

    for (auto zone : zones)
    {
        g_PZoneList[zone] = CreateZone(zone);
    }

    if (g_PZoneList.count(0) == 0)
    {
        g_PZoneList[0] = CreateZone(0);
    }

    LoadNPCList();
    LoadMOBList();

    for (auto PZone : g_PZoneList)
    {
        if (PZone.second->GetIP() != 0)
            luautils::OnZoneInitialise(PZone.second->GetID());
    }
}

/************************************************************************
*                                                                       *
*  Узнаем текущий регион по номеру зоны                                 *
*                                                                       *
************************************************************************/

REGIONTYPE GetCurrentRegion(uint16 ZoneID)
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
            return REGION_RONFAURE;
        case ZONE_GUSGEN_MINES:
        case ZONE_KONSCHTAT_HIGHLANDS:
        case ZONE_LA_THEINE_PLATEAU:
        case ZONE_ORDELLES_CAVES:
        case ZONE_SELBINA:
        case ZONE_VALKURM_DUNES:
            return REGION_ZULKHEIM;
        case ZONE_BATALLIA_DOWNS:
        case ZONE_CARPENTERS_LANDING:
        case ZONE_DAVOI:
        case ZONE_THE_ELDIEME_NECROPOLIS:
        case ZONE_JUGNER_FOREST:
        case ZONE_MONASTIC_CAVERN:
        case ZONE_PHANAUET_CHANNEL:
            return REGION_NORVALLEN;
        case ZONE_DANGRUF_WADI:
        case ZONE_KORROLOKA_TUNNEL:
        case ZONE_NORTH_GUSTABERG:
        case ZONE_PALBOROUGH_MINES:
        case ZONE_SOUTH_GUSTABERG:
        case ZONE_WAUGHROON_SHRINE:
        case ZONE_ZERUHN_MINES:
            return REGION_GUSTABERG;
        case ZONE_BEADEAUX:
        case ZONE_CRAWLERS_NEST:
        case ZONE_PASHHOW_MARSHLANDS:
        case ZONE_QULUN_DOME:
        case ZONE_ROLANBERRY_FIELDS:
            return REGION_DERFLAND;
        case ZONE_BALGAS_DAIS:
        case ZONE_EAST_SARUTABARUTA:
        case ZONE_FULL_MOON_FOUNTAIN:
        case ZONE_GIDDEUS:
        case ZONE_INNER_HORUTOTO_RUINS:
        case ZONE_OUTER_HORUTOTO_RUINS:
        case ZONE_TORAIMARAI_CANAL:
        case ZONE_WEST_SARUTABARUTA:
            return REGION_SARUTABARUTA;
        case ZONE_BIBIKI_BAY:
        case ZONE_BUBURIMU_PENINSULA:
        case ZONE_LABYRINTH_OF_ONZOZO:
        case ZONE_MANACLIPPER:
        case ZONE_MAZE_OF_SHAKHRAMI:
        case ZONE_MHAURA:
        case ZONE_TAHRONGI_CANYON:
            return REGION_KOLSHUSHU;
        case ZONE_ALTAR_ROOM:
        case ZONE_ATTOHWA_CHASM:
        case ZONE_BONEYARD_GULLY:
        case ZONE_CASTLE_OZTROJA:
        case ZONE_GARLAIGE_CITADEL:
        case ZONE_MERIPHATAUD_MOUNTAINS:
        case ZONE_SAUROMUGUE_CHAMPAIGN:
            return REGION_ARAGONEU;
        case ZONE_BEAUCEDINE_GLACIER:
        case ZONE_CLOISTER_OF_FROST:
        case ZONE_FEIYIN:
        case ZONE_PSOXJA:
        case ZONE_QUBIA_ARENA:
        case ZONE_RANGUEMONT_PASS:
        case ZONE_THE_SHROUDED_MAW:
            return REGION_FAUREGANDI;
        case ZONE_BEARCLAW_PINNACLE:
        case ZONE_CASTLE_ZVAHL_BAILEYS:
        case ZONE_CASTLE_ZVAHL_KEEP:
        case ZONE_THRONE_ROOM:
        case ZONE_ULEGUERAND_RANGE:
        case ZONE_XARCABARD:
            return REGION_VALDEAUNIA;
        case ZONE_BEHEMOTHS_DOMINION:
        case ZONE_LOWER_DELKFUTTS_TOWER:
        case ZONE_MIDDLE_DELKFUTTS_TOWER:
        case ZONE_QUFIM_ISLAND:
        case ZONE_STELLAR_FULCRUM:
        case ZONE_UPPER_DELKFUTTS_TOWER:
            return REGION_QUFIMISLAND;
        case ZONE_THE_BOYAHDA_TREE:
        case ZONE_CLOISTER_OF_STORMS:
        case ZONE_DRAGONS_AERY:
        case ZONE_HALL_OF_THE_GODS:
        case ZONE_ROMAEVE:
        case ZONE_THE_SANCTUARY_OF_ZITAH:
            return REGION_LITELOR;
        case ZONE_CLOISTER_OF_TREMORS:
        case ZONE_EASTERN_ALTEPA_DESERT:
        case ZONE_CHAMBER_OF_ORACLES:
        case ZONE_QUICKSAND_CAVES:
        case ZONE_RABAO:
        case ZONE_WESTERN_ALTEPA_DESERT:
            return REGION_KUZOTZ;
        case ZONE_CAPE_TERIGGAN:
        case ZONE_CLOISTER_OF_GALES:
        case ZONE_GUSTAV_TUNNEL:
        case ZONE_KUFTAL_TUNNEL:
        case ZONE_VALLEY_OF_SORROWS:
            return REGION_VOLLBOW;
        case ZONE_KAZHAM:
        case ZONE_NORG:
        case ZONE_SEA_SERPENT_GROTTO:
        case ZONE_YUHTUNGA_JUNGLE:
            return REGION_ELSHIMOLOWLANDS;
        case ZONE_CLOISTER_OF_FLAMES:
        case ZONE_CLOISTER_OF_TIDES:
        case ZONE_DEN_OF_RANCOR:
        case ZONE_IFRITS_CAULDRON:
        case ZONE_SACRIFICIAL_CHAMBER:
        case ZONE_TEMPLE_OF_UGGALEPIH:
        case ZONE_YHOATOR_JUNGLE:
            return REGION_ELSHIMOUPLANDS;
        case ZONE_THE_CELESTIAL_NEXUS:
        case ZONE_LALOFF_AMPHITHEATER:
        case ZONE_RUAUN_GARDENS:
        case ZONE_THE_SHRINE_OF_RUAVITAU:
        case ZONE_VELUGANNON_PALACE:
            return REGION_TULIA;
        case ZONE_MINE_SHAFT_2716:
        case ZONE_NEWTON_MOVALPOLOS:
        case ZONE_OLDTON_MOVALPOLOS:
            return REGION_MOVALPOLOS;
        case ZONE_LUFAISE_MEADOWS:
        case ZONE_MISAREAUX_COAST:
        case ZONE_MONARCH_LINN:
        case ZONE_PHOMIUNA_AQUEDUCTS:
        case ZONE_RIVERNE_SITE_A01:
        case ZONE_RIVERNE_SITE_B01:
        case ZONE_SACRARIUM:
        case ZONE_SEALIONS_DEN:
            return REGION_TAVNAZIA;
        case ZONE_TAVNAZIAN_SAFEHOLD:
            return REGION_TAVNAZIAN_MARQ;
        case ZONE_SOUTHERN_SANDORIA:
        case ZONE_NORTHERN_SANDORIA:
        case ZONE_PORT_SANDORIA:
        case ZONE_CHATEAU_DORAGUILLE:
            return REGION_SANDORIA;
        case ZONE_BASTOK_MINES:
        case ZONE_BASTOK_MARKETS:
        case ZONE_PORT_BASTOK:
        case ZONE_METALWORKS:
            return REGION_BASTOK;
        case ZONE_WINDURST_WATERS:
        case ZONE_WINDURST_WALLS:
        case ZONE_PORT_WINDURST:
        case ZONE_WINDURST_WOODS:
        case ZONE_HEAVENS_TOWER:
            return REGION_WINDURST;
        case ZONE_RULUDE_GARDENS:
        case ZONE_UPPER_JEUNO:
        case ZONE_LOWER_JEUNO:
        case ZONE_PORT_JEUNO:
            return REGION_JEUNO;
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
            return REGION_DYNAMIS;
        case ZONE_PROMYVION_DEM:
        case ZONE_PROMYVION_HOLLA:
        case ZONE_PROMYVION_MEA:
        case ZONE_PROMYVION_VAHZL:
        case ZONE_SPIRE_OF_DEM:
        case ZONE_SPIRE_OF_HOLLA:
        case ZONE_SPIRE_OF_MEA:
        case ZONE_SPIRE_OF_VAHZL:
        case ZONE_HALL_OF_TRANSFERENCE:
            return REGION_PROMYVION;
        case ZONE_ALTAIEU:
        case ZONE_EMPYREAL_PARADOX:
        case ZONE_THE_GARDEN_OF_RUHMET:
        case ZONE_GRAND_PALACE_OF_HUXZOI:
            return REGION_LUMORIA;
        case ZONE_APOLLYON:
        case ZONE_TEMENOS:
            return REGION_LIMBUS;
        case ZONE_AL_ZAHBI:
        case ZONE_AHT_URHGAN_WHITEGATE:
        case ZONE_BHAFLAU_THICKETS:
        case ZONE_THE_COLOSSEUM:
            return REGION_WEST_AHT_URHGAN;
        case ZONE_MAMOOL_JA_TRAINING_GROUNDS:
        case ZONE_MAMOOK:
        case ZONE_WAJAOM_WOODLANDS:
        case ZONE_AYDEEWA_SUBTERRANE:
        case ZONE_JADE_SEPULCHER:
            return REGION_MAMOOL_JA_SAVAGE;
        case ZONE_HALVUNG:
        case ZONE_MOUNT_ZHAYOLM:
        case ZONE_LEBROS_CAVERN:
        case ZONE_NAVUKGO_EXECUTION_CHAMBER:
            return REGION_HALVUNG;
        case ZONE_ARRAPAGO_REEF:
        case ZONE_CAEDARVA_MIRE:
        case ZONE_LEUJAOAM_SANCTUM:
        case ZONE_NASHMAU:
        case ZONE_HAZHALM_TESTING_GROUNDS:
        case ZONE_TALACCA_COVE:
        case ZONE_PERIQIA:
            return REGION_ARRAPAGO;
        case ZONE_NYZUL_ISLE:
        case ZONE_ARRAPAGO_REMNANTS:
        case ZONE_ALZADAAL_UNDERSEA_RUINS:
        case ZONE_SILVER_SEA_REMNANTS:
            return REGION_ALZADAAL;
        case ZONE_SOUTHERN_SAN_DORIA_S:
        case ZONE_EAST_RONFAURE_S:
            return REGION_RONFAURE_FRONT;
        case ZONE_BASTOK_MARKETS_S:
        case ZONE_NORTH_GUSTABERG_S:
        case ZONE_RUHOTZ_SILVERMINES:
        case ZONE_GRAUBERG_S:
            return REGION_GUSTABERG_FRONT;
        case ZONE_WINDURST_WATERS_S:
        case ZONE_WEST_SARUTABARUTA_S:
        case ZONE_GHOYUS_REVERIE:
        case ZONE_FORT_KARUGO_NARUGO_S:
            return REGION_SARUTA_FRONT;
        case ZONE_BATALLIA_DOWNS_S:
        case ZONE_JUGNER_FOREST_S:
        case ZONE_LA_VAULE_S:
        case ZONE_EVERBLOOM_HOLLOW:
        case ZONE_THE_ELDIEME_NECROPOLIS_S:
            return REGION_NORVALLEN_FRONT;
        case ZONE_ROLANBERRY_FIELDS_S:
        case ZONE_PASHHOW_MARSHLANDS_S:
        case ZONE_CRAWLERS_NEST_S:
        case ZONE_BEADEAUX_S:
        case ZONE_VUNKERL_INLET_S:
            return REGION_DERFLAND_FRONT;
        case ZONE_SAUROMUGUE_CHAMPAIGN_S:
        case ZONE_MERIPHATAUD_MOUNTAINS_S:
        case ZONE_CASTLE_OZTROJA_S:
        case ZONE_GARLAIGE_CITADEL_S:
            return REGION_ARAGONEAU_FRONT;
        case ZONE_BEAUCEDINE_GLACIER_S:
            return REGION_FAUREGANDI_FRONT;
        case ZONE_XARCABARD_S:
        case ZONE_CASTLE_ZVAHL_BAILEYS_S:
        case ZONE_CASTLE_ZVAHL_KEEP_S:
        case ZONE_THRONE_ROOM_S:
            return REGION_VALDEAUNIA_FRONT;
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
            return REGION_ABYSSEA;
        case ZONE_WALK_OF_ECHOES:
            return REGION_THE_THRESHOLD;
        case ZONE_DIORAMA_ABDHALJS_GHELSBA:
        case ZONE_ABDHALJS_ISLE_PURGONORGO:
        case ZONE_MAQUETTE_ABDHALJS_LEGION_A:
        case ZONE_MAQUETTE_ABDHALJS_LEGION_B:
            return REGION_ABDHALJS;
        case ZONE_WESTERN_ADOULIN:
        case ZONE_EASTERN_ADOULIN:
        case ZONE_RALA_WATERWAYS:
        case ZONE_RALA_WATERWAYS_U:
            return REGION_ADOULIN_ISLANDS;
        case ZONE_CEIZAK_BATTLEGROUNDS:
        case ZONE_FORET_DE_HENNETIEL:
        case ZONE_SIH_GATES:
        case ZONE_MOH_GATES:
        case ZONE_CIRDAS_CAVERNS:
        case ZONE_CIRDAS_CAVERNS_U:
        case ZONE_YAHSE_HUNTING_GROUNDS:
        case ZONE_MORIMAR_BASALT_FIELDS:
            return REGION_EAST_ULBUKA;
    }
    return REGION_UNKNOWN;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

CONTINENTTYPE GetCurrentContinent(uint16 ZoneID)
{
    return GetCurrentRegion(ZoneID) != REGION_UNKNOWN ? THE_MIDDLE_LANDS : OTHER_AREAS;
}

int GetWeatherElement(WEATHER weather)
{
    TPZ_DEBUG_BREAK_IF(weather >= MAX_WEATHER_ID);

    // TODO: Fix weather ordering; at the moment, this current fire, water, earth, wind, snow, thunder
    // order MUST be preserved due to the weather enums going in this order. Those enums will
    // most likely have rippling effects, such as how weather data is stored in the db
    static uint8 Element[] =
    {
        0,  //WEATHER_NONE
        0,  //WEATHER_SUNSHINE
        0,  //WEATHER_CLOUDS
        0,  //WEATHER_FOG
        1,  //WEATHER_HOT_SPELL
        1,  //WEATHER_HEAT_WAVE
        6,  //WEATHER_RAIN
        6,  //WEATHER_SQUALL
        4,  //WEATHER_DUST_STORM
        4,  //WEATHER_SAND_STORM
        3,  //WEATHER_WIND
        3,  //WEATHER_GALES
        2,  //WEATHER_SNOW
        2,  //WEATHER_BLIZZARDS
        5,  //WEATHER_THUNDER
        5,  //WEATHER_THUNDERSTORMS
        7,  //WEATHER_AURORAS
        7,  //WEATHER_STELLAR_GLARE
        8,  //WEATHER_GLOOM
        8,  //WEATHER_DARKNESS
    };
    return Element[weather];
}

/************************************************************************
*                                                                       *
*  Освобождаем список зон                                               *
*                                                                       *
************************************************************************/

void FreeZoneList()
{
    for (auto PZone : g_PZoneList)
    {
        delete PZone.second;
    }
    g_PZoneList.clear();
    delete g_PTrigger;
    g_PTrigger = nullptr;
}

void ForEachZone(std::function<void(CZone*)> func)
{
    for (auto PZone : g_PZoneList)
    {
        func(PZone.second);
    }
}

uint64 GetZoneIPP(uint16 zoneID)
{
    uint64 ipp = 0;
    const char* query = "SELECT zoneip, zoneport FROM zone_settings WHERE zoneid = %u;";

    int ret = Sql_Query(SqlHandle, query, zoneID);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        inet_pton(AF_INET, (const char*)Sql_GetData(SqlHandle, 0), &ipp);
        uint64 port = Sql_GetUIntData(SqlHandle, 1);
        ipp |= (port << 32);
    }
    else
    {
        ShowFatalError(CL_RED"zoneutils::GetZoneIPP: Cannot find zone %u\n" CL_RESET, zoneID);
    }
    return ipp;
}

/************************************************************************
*                                                                       *
*  Checks whether or not the zone is a residential area                 *
*                                                                       *
************************************************************************/

bool IsResidentialArea(CCharEntity* PChar)
{
    return PChar->m_moghouseID != 0;
}

}; // namespace zoneutils
