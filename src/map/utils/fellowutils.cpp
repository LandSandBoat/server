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

This file is part of DarkStar-server source code.

===========================================================================
*/

#include "../../common/timer.h"
#include "../../common/utils.h"

#include <algorithm>
#include <math.h>
#include <string.h>
#include <vector>

#include "../ability.h"
#include "../enmity_container.h"
#include "../entities/fellowentity.h"
#include "../entities/mobentity.h"
#include "../grades.h"
#include "../items/item_weapon.h"
#include "../latent_effect_container.h"
#include "../map.h"
#include "../mob_spell_list.h"
#include "../status_effect_container.h"
#include "../zone_instance.h"
#include "battleutils.h"
#include "charutils.h"
#include "fellowutils.h"
#include "zoneutils.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/fellow_controller.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/states/ability_state.h"

#include "../packets/char_abilities.h"
#include "../packets/char_sync.h"
#include "../packets/char_update.h"
#include "../packets/entity_update.h"
#include "../packets/fellow_despawn.h"
#include "../packets/message_combat.h"
#include "../packets/message_special.h"
#include "../packets/message_text.h"

struct Fellow_t
{
    look_t      look;      // appearance
    std::string name;      // name
    ECOSYSTEM   EcoSystem; // ecosystem

    uint8  zoneKills;
    uint8  name_prefix;
    uint8  size; // model size
    uint16 m_Family;

    uint8 mJob;
    uint8 m_Element;
    float HPscale; // HP boost percentage
    float MPscale; // MP boost percentage

    uint16 cmbDelay;
    uint8  speed;
    // stat ranks
    uint8 strRank;
    uint8 dexRank;
    uint8 vitRank;
    uint8 agiRank;
    uint8 intRank;
    uint8 mndRank;
    uint8 chrRank;
    uint8 attRank;
    uint8 defRank;
    uint8 evaRank;
    uint8 accRank;

    // magic stuff
    bool   hasSpellScript;
    uint16 spellList;
};

std::map<uint16, Fellow_t*> g_PFellowList;

namespace fellowutils
{
    uint16 MessageOffset[MAX_ZONEID];

    void LoadFellowMessages()
    {
        zoneutils::ForEachZone([](CZone* PZone)
                               { MessageOffset[PZone->GetID()] = luautils::GetTextIDVariable(PZone->GetID(), "FELLOW_MESSAGE_OFFSET"); });
    }

    uint16 GetMessageOffset(uint16 ZoneID)
    {
        return MessageOffset[ZoneID];
    }

    uint16 GetBase(CFellowEntity* PFellow, uint8 rank)
    {
        uint8 lvl = PFellow->GetMLevel();
        if (lvl > 50)
        {
            switch (rank)
            {
                case 1:
                    return (uint16)(153 + (lvl - 50) * 5.0f); // A
                case 2:
                    return (uint16)(147 + (lvl - 50) * 4.9f); // B
                case 3:
                    return (uint16)(136 + (lvl - 50) * 4.8f); // C
                case 4:
                    return (uint16)(126 + (lvl - 50) * 4.7f); // D
                case 5:
                    return (uint16)(116 + (lvl - 50) * 4.5f); // E
                case 6:
                    return (uint16)(106 + (lvl - 50) * 4.4f); // F
                case 7:
                    return (uint16)(96 + (lvl - 50) * 4.3f); // G
            }
        }
        else
        {
            switch (rank)
            {
                case 1:
                    return (uint16)(6 + (lvl - 1) * 3.0f);
                case 2:
                    return (uint16)(5 + (lvl - 1) * 2.9f);
                case 3:
                    return (uint16)(5 + (lvl - 1) * 2.8f);
                case 4:
                    return (uint16)(4 + (lvl - 1) * 2.7f);
                case 5:
                    return (uint16)(4 + (lvl - 1) * 2.5f);
                case 6:
                    return (uint16)(3 + (lvl - 1) * 2.4f);
                case 7:
                    return (uint16)(3 + (lvl - 1) * 2.3f);
            }
        }

        ShowError("fellowutils::GetBase rank (%d) is out of bounds for fellow (%u) \n", rank, PFellow->id);
        return 0;
    }

    void LoadFellowList()
    {
        const char* Query = "SELECT\
                fellow_list.fellowid,\
                fellow_list.name,\
                fellow_list.familyid,\
                fellow_list.modelid,\
                mob_family_system.superFamilyID,\
                (mob_family_system.HP / 100),\
                (mob_family_system.MP / 100),\
                mob_family_system.speed,\
                mob_family_system.STR,\
                mob_family_system.DEX,\
                mob_family_system.VIT,\
                mob_family_system.AGI,\
                mob_family_system.INT,\
                mob_family_system.MND,\
                mob_family_system.CHR\
                FROM fellow_list, mob_family_system\
                WHERE fellow_list.familyid = mob_family_system.familyid;";
        if (sql->Query(Query) != SQL_ERROR && sql->NumRows() != 0)
        {
            while (sql->NextRow() == SQL_SUCCESS)
            {
                Fellow_t* Fellow = new Fellow_t();

                Fellow->name.insert(0, (const char*)sql->GetData(1));

                Fellow->m_Family = (uint16)sql->GetIntData(2);
                uint16 sqlModelID[10];
                memcpy(&sqlModelID, sql->GetData(3), 20);
                Fellow->look      = look_t(sqlModelID);
                Fellow->size      = 0;
                Fellow->EcoSystem = (ECOSYSTEM)sql->GetIntData(4);
                Fellow->m_Element = 0;
                Fellow->zoneKills = 0;

                Fellow->HPscale = sql->GetFloatData(5);
                Fellow->MPscale = sql->GetFloatData(6);

                Fellow->speed = (uint8)sql->GetIntData(7);

                Fellow->strRank = (uint8)sql->GetIntData(8);
                Fellow->dexRank = (uint8)sql->GetIntData(9);
                Fellow->vitRank = (uint8)sql->GetIntData(10);
                Fellow->agiRank = (uint8)sql->GetIntData(11);
                Fellow->intRank = (uint8)sql->GetIntData(12);
                Fellow->mndRank = (uint8)sql->GetIntData(13);
                Fellow->chrRank = (uint8)sql->GetIntData(14);
                Fellow->defRank = 1;
                Fellow->attRank = 1;
                Fellow->accRank = 1;

                Fellow->hasSpellScript = (bool)1;

                Fellow->spellList   = (uint16)0;
                Fellow->cmbDelay    = (uint16)240;
                Fellow->name_prefix = (uint8)40;

                uint16 fellowId         = (uint16)sql->GetUIntData(0);
                g_PFellowList[fellowId] = Fellow;
            }
        }
    }

    void LoadFellowStats(CFellowEntity* PFellow, uint8 type)
    {
        // These might need to be refined, more extensive retail data required

        float raceStat  = 0; // HP finite number for race based level.
        float jobStat   = 0; // HP end number for primary profession level.
        float sJobStat  = 0; // HP coaxial number for secondary profession.
        int32 bonusStat = 0; // HP bonus number added when certain conditions are met..

        int32 baseValueColumn   = 0; // column number with base HP
        int32 scaleTo60Column   = 1; // column number with modifier up to level 60
        int32 scaleOver30Column = 2; // column number with modifier after level 30
        int32 scaleOver60Column = 3; // column number with modifier after level 60
        int32 scaleOver75Column = 4; // column number with modifier after level 75
        int32 scaleOver60       = 2; // column number with modifier for calculating MP after level 60
        int32 scaleOver75       = 3; // column number with a modifier for calculating stats after level 75

        uint8 grade;

        uint8   mlvl = PFellow->GetMLevel();
        uint8   slvl = PFellow->GetSLevel();
        JOBTYPE mjob = PFellow->GetMJob();
        JOBTYPE sjob = PFellow->GetSJob();

        uint8 race = 0; // Human
        switch (PFellow->look.race)
        {
            case 3:
            case 4:
                race = 1;
                break; // Elvaan
            case 5:
            case 6:
                race = 2;
                break; // Tarutaru
            case 7:
                race = 3;
                break; // Mithra
            case 8:
                race = 4;
                break; // Galka
        }

        // All fellows should be equivalent stats
        race = 0;

        // give hp and mp boost every 10 levels after 25
        float HPgrowth = 1.006f;
        float MPgrowth = 1.06f;
        if (mlvl >= 75)
        {
            HPgrowth = 1.028f;
            MPgrowth = 1.28f;
        }
        else if (mlvl >= 65)
        {
            HPgrowth = 1.027f;
            MPgrowth = 1.27f;
        }
        else if (mlvl >= 55)
        {
            HPgrowth = 1.025f;
            MPgrowth = 1.25f;
        }
        else if (mlvl >= 50)
        {
            HPgrowth = 1.021f;
            MPgrowth = 1.21f;
        }
        else if (mlvl >= 45)
        {
            HPgrowth = 1.017f;
            MPgrowth = 1.17f;
        }
        else if (mlvl >= 35)
        {
            HPgrowth = 1.014f;
            MPgrowth = 1.14f;
        }
        else if (mlvl >= 25)
        {
            HPgrowth = 1.01f;
            MPgrowth = 1.1f;
        }

        if (type == FELLOW_TYPE_STALWART)
        {
            HPgrowth *= 1.03f;
            MPgrowth *= 1.03f;
        }
        else if (type == FELLOW_TYPE_FIERCE)
        {
            HPgrowth *= 1.06f;
        }
        else if (type == FELLOW_TYPE_SOOTHING)
        {
            MPgrowth *= 1.06f;
        }

        // Calculation of HP growth from the main job
        int32 mainLevelOver30     = std::clamp(mlvl - 30, 0, 30); // Calculation of condition + 1HP each LVL after level 30
        int32 mainLevelUpTo60     = (mlvl < 60 ? mlvl - 1 : 59);  // The first mode of calculation to level 60 (Used also for MP)
        int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15); // The second mode of calculation after level 60
        int32 mainLevelOver75     = (mlvl < 75 ? 0 : mlvl - 75);  // The third mode of calculation after level 75

        // Calculate the bonus amount of HP
        int32 mainLevelOver10           = (mlvl < 10 ? 0 : mlvl - 10);  // + 2HP at each level after 10
        int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10); // + 2HP at each level in the range from 50 to 60 levels
        int32 mainLevelOver60           = (mlvl < 60 ? 0 : mlvl - 60);

        // Calculation of HP growth from the sub job
        int32 subLevelOver10 = std::clamp(slvl - 10, 0, 20); // + 1HP per level after 10 (/ 2)
        int32 subLevelOver30 = (slvl < 30 ? 0 : slvl - 30);  // + 1HP per level after 30

        // Calculation by race
        grade = grade::GetRaceGrades(race, 0);

        raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                   (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                   (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Calculation by main job
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                  (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                  (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Bonus HP
        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;

        // Calculation by support job
        if (slvl > 0)
        {
            grade = grade::GetJobGrade(sjob, 0);

            sJobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * (slvl - 1)) +
                       (grade::GetHPScale(grade, scaleOver30Column) * subLevelOver30) + subLevelOver30 + subLevelOver10;
            sJobStat = sJobStat / 2;
        }

        PFellow->health.maxhp = (int16)(HPgrowth * (raceStat + jobStat + bonusStat + sJobStat));

        // The beginning of the calculation of MP

        raceStat = 0;
        jobStat  = 0;
        sJobStat = 0;

        // Calculate MP race.
        grade = grade::GetRaceGrades(race, 1);

        // If the main job does not have an MP rating, calculate the racial bonus based on the subjob level (provided that it has an MP rating)
        if (grade::GetJobGrade(mjob, 1) == 0)
        {
            if (grade::GetJobGrade(sjob, 1) != 0 && slvl > 0)
            {
                raceStat = (grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * (slvl - 1));
            }
        }
        else
        {
            // Calculation of normal racial bonus
            raceStat =
                grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 + grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        // For the main job
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat =
                grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 + grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        // For a sub job
        if (slvl > 0)
        {
            grade    = grade::GetJobGrade(sjob, 1);
            sJobStat = (grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * (slvl - 1)) / settings::get<float>("map.SJ_MP_DIVISOR");
        }

        PFellow->health.maxmp = (int16)(MPgrowth * (raceStat + jobStat + sJobStat)); // MP calculation result

        uint8 counter = 0;

        for (uint8 StatIndex = 2; StatIndex <= 8; ++StatIndex)
        {
            // race calculation
            grade    = grade::GetRaceGrades(race, StatIndex);
            raceStat = grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * mainLevelUpTo60;

            if (mainLevelOver60 > 0)
            {
                raceStat += grade::GetStatScale(grade, scaleOver60) * mainLevelOver60;

                if (mainLevelOver75 > 0)
                {
                    raceStat += grade::GetStatScale(grade, scaleOver75) * mainLevelOver75 - (mlvl >= 75 ? 0.01f : 0);
                }
            }

            // calculation by job
            grade   = grade::GetJobGrade(mjob, StatIndex);
            jobStat = grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * mainLevelUpTo60;

            if (mainLevelOver60 > 0)
            {
                jobStat += grade::GetStatScale(grade, scaleOver60) * mainLevelOver60;

                if (mainLevelOver75 > 0)
                {
                    jobStat += grade::GetStatScale(grade, scaleOver75) * mainLevelOver75 - (mlvl >= 75 ? 0.01f : 0);
                }
            }

            // calculation of the sub job
            if (slvl > 0)
            {
                grade    = grade::GetJobGrade(sjob, StatIndex);
                sJobStat = (grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * (slvl - 1)) / 2;
            }
            else
            {
                sJobStat = 0;
            }

            // Output value
            ref<uint16>(&PFellow->stats, counter) = (uint16)((raceStat + jobStat + sJobStat));
            counter += 2;
        }
    }

    void SpawnFellow(CCharEntity* PMaster, uint32 FellowID, bool spawningFromZone)
    {
        CFellowEntity* PFellow = LoadFellow(PMaster, FellowID, spawningFromZone);

        if (PFellow)
        {
            PFellow->allegiance = PMaster->allegiance;
            PMaster->StatusEffectContainer->CopyConfrontationEffect(PFellow);
            if (PMaster->PInstance)
            {
                PFellow->PInstance = PMaster->PInstance;
            }

            PMaster->loc.zone->InsertPET(PFellow);
            PMaster->m_PFellow = PFellow;
            PMaster->pushPacket(new CCharUpdatePacket(PMaster));
            PMaster->pushPacket(new CCharSyncPacket(PMaster));
            luautils::OnMobSpawn(PFellow);

            // apply stats from previous zone if this fellow is being transfered
            if (spawningFromZone == true)
            {
                PFellow->health.hp = PMaster->fellowZoningInfo.fellowHP;
                PFellow->health.mp = PMaster->fellowZoningInfo.fellowMP;
            }
            else if (spawningFromZone == false)
            {
                sql->Query("UPDATE char_fellow SET kills = 0, maxTime = %u WHERE charid = %u", GetMaxTime(PMaster), PMaster->id);
                if (PMaster->GetLocalVar("triggerFellow") == 0)
                    PMaster->pushPacket(
                        new CMessageSpecialPacket(PFellow, GetMessageOffset(PMaster->getZone()) + FELLOWMESSAGEOFFSET_CALL + GetPersonalityOffset(PMaster)));
            }
        }
        else
        {
            PMaster->resetFellowZoningInfo();
        }
    }

    uint16 GetMaxTime(CCharEntity* PChar)
    {
        uint8       bond    = 0;
        uint16      maxTime = 45 * 60; // 45 min
        const char* QueryP  = "SELECT bond FROM char_fellow WHERE charid = %u";
        if (sql->Query(QueryP, PChar->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
            bond = (uint8)sql->GetIntData(0);
        if (bond >= 120)
            maxTime = 90 * 60; // 90 min
        else if (bond >= 100)
            maxTime = 85 * 60; // 85 min
        else if (bond >= 80)
            maxTime = 80 * 60; // 80 min
        else if (bond >= 70)
            maxTime = 75 * 60; // 75 min
        else if (bond >= 60)
            maxTime = 70 * 60; // 70 min
        else if (bond >= 50)
            maxTime = 65 * 60; // 65 min
        else if (bond >= 40)
            maxTime = 60 * 60; // 60 min
        else if (bond >= 20)
            maxTime = 55 * 60; // 55 min
        else if (bond >= 10)
            maxTime = 50 * 60; // 50 min

        return maxTime;
    }

    CFellowEntity* LoadFellow(CCharEntity* PMaster, uint32 FellowID, bool spawningFromZone)
    {
        CFellowEntity* PFellow    = new CFellowEntity(PMaster);
        PFellow->loc              = PMaster->loc;
        PFellow->loc.p            = PMaster->loc.p;
        PFellow->m_OwnerID.id     = PMaster->id;
        PFellow->m_OwnerID.targid = PMaster->targid;
        Fellow_t* fellow          = g_PFellowList[FellowID];

        PMaster->fellowZoningInfo.fellowID = FellowID;

        PFellow->look = fellow->look;
        uint8 type    = 0;

        const char* QueryFace = "SELECT char_fellow.face FROM char_fellow WHERE\
            charid = %u";
        if (sql->Query(QueryFace, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->look.face = (uint8)sql->GetIntData(0);
        }
        const char* QueryMain = "SELECT item_equipment.MId FROM item_equipment, char_fellow WHERE\
            char_fellow.main = item_equipment.itemId AND\
            charid = %u";
        if (sql->Query(QueryMain, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->look.main = (uint16)sql->GetIntData(0) + 0x6000;
        }
        const char* QuerySub = "SELECT item_equipment.MId, item_weapon.skill FROM char_fellow LEFT JOIN\
            item_equipment ON (item_equipment.itemId=char_fellow.sub) LEFT JOIN item_weapon ON\
            (item_weapon.itemId=char_fellow.main) WHERE char_fellow.charid = %d";
        if (sql->Query(QuerySub, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->look.sub = (uint16)sql->GetIntData(0) + 0x7000;
        }

        if ((uint16)sql->GetIntData(1) == SKILL_HAND_TO_HAND || (((uint16)sql->GetIntData(1) == SKILL_KATANA) && settings::get<bool>("main.ALLOW_ADVENTURING_FELLOW_KATANA_DW")))
        {
            PFellow->look.sub = PFellow->look.main + 0x1000;
        }
        else if ((uint16)sql->GetIntData(1) == SKILL_GREAT_SWORD || (uint16)sql->GetIntData(1) == SKILL_GREAT_AXE ||
                 (uint16)sql->GetIntData(1) == SKILL_SCYTHE || (uint16)sql->GetIntData(1) == SKILL_POLEARM ||
                 (uint16)sql->GetIntData(1) == SKILL_GREAT_KATANA || (uint16)sql->GetIntData(1) == SKILL_STAFF)
        {
            PFellow->look.sub = 0;
        }
        uint8       personality = 0;
        const char* QueryP      = "SELECT personality FROM char_fellow WHERE charid = %u";
        if (sql->Query(QueryP, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
            personality = (uint8)sql->GetIntData(0);
        const char* QueryHead = "SELECT fellow_headgear.%s FROM fellow_headgear, char_fellow WHERE\
            char_fellow.head = fellow_headgear.rank AND\
            charid = %u";
        if (sql->Query(QueryHead, std::to_string(personality), PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->look.head = (uint16)sql->GetIntData(0) + 0x1000;
        }
        const char* QueryBody = "SELECT fellow_armor.body FROM fellow_armor, char_fellow WHERE\
            char_fellow.body = fellow_armor.rank AND\
            charid = %u";
        if (sql->Query(QueryBody, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->look.body = (uint16)sql->GetIntData(0) + 0x2000;
        }
        const char* QueryHands = "SELECT fellow_armor.hands FROM fellow_armor, char_fellow WHERE\
            char_fellow.hands = fellow_armor.rank AND\
            charid = %u";
        if (sql->Query(QueryHands, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->look.hands = (uint16)sql->GetIntData(0) + 0x3000;
        }
        const char* QueryLegs = "SELECT fellow_armor.legs FROM fellow_armor, char_fellow WHERE\
            char_fellow.legs = fellow_armor.rank AND\
            charid = %u";
        if (sql->Query(QueryLegs, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->look.legs = (uint16)sql->GetIntData(0) + 0x4000;
        }
        const char* QueryFeet = "SELECT fellow_armor.feet FROM fellow_armor, char_fellow WHERE\
            char_fellow.feet = fellow_armor.rank AND\
            charid = %u";
        if (sql->Query(QueryFeet, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->look.feet = (uint16)sql->GetIntData(0) + 0x5000;
        }
        const char* Query = "SELECT\
                char_fellow.fellowid,\
                fellow_list.name,\
                char_fellow.level,\
                char_fellow.job,\
                char_fellow.size\
                FROM char_fellow, fellow_list\
                WHERE char_fellow.fellowid = fellow_list.fellowid AND char_fellow.charid = %u";
        if (sql->Query(Query, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            PFellow->name.clear();
            PFellow->name.insert(0, (const char*)sql->GetData(1));
            PFellow->packetName.insert(0, (const char*)sql->GetData(1));

            uint8 mlvl = (uint8)sql->GetIntData(2); // pull lvl from db
            if (PMaster->GetMLevel() < mlvl)
                mlvl = PMaster->GetMLevel();
            PFellow->SetMLevel(mlvl);
            PFellow->SetSLevel(mlvl / 2);

            uint8 job  = 0;
            uint8 sjob = 0;
            type       = (uint8)sql->GetIntData(3);
            switch (type)
            {
                case 1:
                    job  = 7;
                    sjob = 1;
                    break; // Shield (PLD/WAR)
                case 2:
                    job  = 1;
                    sjob = 2;
                    break; // Attacker (WAR/MNK)
                case 3:
                    job  = 3;
                    sjob = 1;
                    break; // Healer (WHM/WAR)
                case 4:
                    job  = 7;
                    sjob = 1;
                    break; // Stalwart (PLD/WAR)
                case 5:
                    job  = 1;
                    sjob = 2;
                    break; // Fierce (WAR/MNK)
                case 6:
                    job  = 3;
                    sjob = 1;
                    break; // Soothing (WHM/WAR)
            }
            PFellow->SetMJob(job);
            PFellow->SetSJob(sjob);

            PFellow->m_ModelRadius = (uint8)sql->GetIntData(4) / 4;

            const char* Query3 = "SELECT\
                    char_fellow.main,\
                    item_weapon.skill,\
                    item_weapon.dmgType,\
                    item_weapon.hit,\
                    item_weapon.delay,\
                    item_weapon.dmg\
                    FROM char_fellow, item_weapon\
                    WHERE char_fellow.main = item_weapon.itemId AND char_fellow.charid = %u";
            if (sql->Query(Query3, PMaster->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
            {
                uint16 delay  = GetWeaponDelayByTypeAndLevel((SKILLTYPE)sql->GetIntData(1), mlvl);
                uint16 damage = GetWeaponDmgByTypeAndLevel((SKILLTYPE)sql->GetIntData(1), mlvl);
                ((CItemWeapon*)PFellow->m_Weapons[SLOT_MAIN])->setSkillType((uint8)sql->GetIntData(1));
                ((CItemWeapon*)PFellow->m_Weapons[SLOT_MAIN])->setMaxHit((uint8)sql->GetIntData(3));
                ((CItemWeapon*)PFellow->m_Weapons[SLOT_MAIN])->setDelay(delay);
                ((CItemWeapon*)PFellow->m_Weapons[SLOT_MAIN])->setBaseDelay(delay);
                ((CItemWeapon*)PFellow->m_Weapons[SLOT_MAIN])->setDamage(damage);

                if (((uint16)sql->GetIntData(1) == SKILL_KATANA) && settings::get<bool>("main.ALLOW_ADVENTURING_FELLOW_KATANA_DW"))
                {
                    PFellow->m_dualWield = true;
                    ((CItemWeapon*)PFellow->m_Weapons[SLOT_SUB])->setSkillType((uint8)sql->GetIntData(1));
                    ((CItemWeapon*)PFellow->m_Weapons[SLOT_SUB])->setMaxHit((uint8)sql->GetIntData(3));
                    // the way mobs currently attack via dual wield is to attack twice on the base delay, sub is not considered.
                    ((CItemWeapon*)PFellow->m_Weapons[SLOT_MAIN])->setDelay(delay * 2);
                    ((CItemWeapon*)PFellow->m_Weapons[SLOT_MAIN])->setBaseDelay(delay * 2);
                    ((CItemWeapon*)PFellow->m_Weapons[SLOT_SUB])->setDelay(delay);
                    ((CItemWeapon*)PFellow->m_Weapons[SLOT_SUB])->setBaseDelay(delay);
                    ((CItemWeapon*)PFellow->m_Weapons[SLOT_SUB])->setDamage(damage);
                }
            }
        }

        PFellow->m_name_prefix = fellow->name_prefix;
        PFellow->m_Family      = fellow->m_Family;
        PFellow->status        = STATUS_TYPE::NORMAL;

        switch (PFellow->GetMJob())
        {
            case JOB_PLD:
                PFellow->addModifier(Mod::DEF, GetBase(PFellow, 1));
                PFellow->addModifier(Mod::EVA, GetBase(PFellow, 3));
                PFellow->addModifier(Mod::ATT, GetBase(PFellow, 2));
                PFellow->addModifier(Mod::ACC, GetBase(PFellow, 3));
                PFellow->addModifier(Mod::MDEF, GetBase(PFellow, 3));
                break;
            case JOB_WAR:
                PFellow->addModifier(Mod::DEF, GetBase(PFellow, 2));
                PFellow->addModifier(Mod::EVA, GetBase(PFellow, 3));
                PFellow->addModifier(Mod::ATT, GetBase(PFellow, 1));
                PFellow->addModifier(Mod::ACC, GetBase(PFellow, 3));
                break;
            case JOB_WHM:
                PFellow->addModifier(Mod::DEF, GetBase(PFellow, 3));
                PFellow->addModifier(Mod::EVA, GetBase(PFellow, 5));
                PFellow->addModifier(Mod::ATT, GetBase(PFellow, 3));
                PFellow->addModifier(Mod::ACC, GetBase(PFellow, 3));
                PFellow->addModifier(Mod::MDEF, GetBase(PFellow, 1));
                PFellow->addModifier(Mod::MACC, GetBase(PFellow, 2));
                PFellow->addModifier(Mod::MEVA, GetBase(PFellow, 2));
                break;
            default:
                break;
        }

        LoadFellowStats(PFellow, type);

        uint8 mlvl = PFellow->GetMLevel();
        uint8 mJob = PFellow->GetMJob();
        for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PFellow->GetMJob(), mlvl > 99 ? 99 : mlvl);
            if (maxSkill != 0)
            {
                PFellow->WorkingSkills.skill[i] = maxSkill;
            }
        }
        for (int i = SKILL_HAND_TO_HAND; i <= SKILL_STAFF; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill(1, mlvl > 99 ? 99 : mlvl); // A+ rating with all weapon types
            if (maxSkill != 0)
            {
                PFellow->WorkingSkills.skill[i] = maxSkill;
            }
        }

        // add traits for sub and main
        battleutils::AddTraits(PFellow, traits::GetTraits(mJob), mlvl);
        battleutils::AddTraits(PFellow, traits::GetTraits(PFellow->GetSJob()), PFellow->GetSLevel());
        // ToDo: track down why these exist - and if fellows need some acc/att/etc since they dont get gear
        PFellow->addModifier(Mod::WSACC, 25);
        PFellow->addModifier(Mod::DEFP, 50);
        PFellow->addModifier(Mod::ALL_WSDMG_FIRST_HIT, 25);
        PFellow->addModifier(Mod::ENEMYCRITRATE, -25);

        PFellow->health.tp = 0;
        PFellow->UpdateHealth();
        PFellow->health.hp = PFellow->GetMaxHP();
        PFellow->health.mp = PFellow->GetMaxMP();

        return PFellow;
    }

    uint32 GetExpNEXTLevel(uint8 charlvl)
    {
        uint32 expNEXTLvl = 0;

        switch (charlvl)
        {
            case 30:
                expNEXTLvl = 5800;
                break;
            case 31:
                expNEXTLvl = 5900;
                break;
            case 32:
                expNEXTLvl = 6000;
                break;
            case 33:
                expNEXTLvl = 6100;
                break;
            case 34:
                expNEXTLvl = 6200;
                break;
            case 35:
                expNEXTLvl = 6300;
                break;
            case 36:
                expNEXTLvl = 6400;
                break;
            case 37:
                expNEXTLvl = 6500;
                break;
            case 38:
                expNEXTLvl = 6600;
                break;
            case 39:
                expNEXTLvl = 6700;
                break;
            case 40:
                expNEXTLvl = 6800;
                break;
            case 41:
                expNEXTLvl = 6900;
                break;
            case 42:
                expNEXTLvl = 7000;
                break;
            case 43:
                expNEXTLvl = 7100;
                break;
            case 44:
                expNEXTLvl = 7200;
                break;
            case 45:
                expNEXTLvl = 7300;
                break;
            case 46:
                expNEXTLvl = 7400;
                break;
            case 47:
                expNEXTLvl = 7500;
                break;
            case 48:
                expNEXTLvl = 7600;
                break;
            case 49:
                expNEXTLvl = 7700;
                break;
            case 50:
                expNEXTLvl = 7800;
                break;
            case 51:
                expNEXTLvl = 8000;
                break;
            case 52:
                expNEXTLvl = 9200;
                break;
            case 53:
                expNEXTLvl = 10400;
                break;
            case 54:
                expNEXTLvl = 11600;
                break;
            case 55:
                expNEXTLvl = 12800;
                break;
            case 56:
                expNEXTLvl = 14000;
                break;
            case 57:
                expNEXTLvl = 15200;
                break;
            case 58:
                expNEXTLvl = 16400;
                break;
            case 59:
                expNEXTLvl = 17600;
                break;
            case 60:
                expNEXTLvl = 18800;
                break;
            case 61:
                expNEXTLvl = 20000;
                break;
            case 62:
                expNEXTLvl = 21500;
                break;
            case 63:
                expNEXTLvl = 23000;
                break;
            case 64:
                expNEXTLvl = 24500;
                break;
            case 65:
                expNEXTLvl = 26000;
                break;
            case 66:
                expNEXTLvl = 27500;
                break;
            case 67:
                expNEXTLvl = 29000;
                break;
            case 68:
                expNEXTLvl = 30500;
                break;
            case 69:
                expNEXTLvl = 32000;
                break;
            case 70:
                expNEXTLvl = 34000;
                break;
            case 71:
                expNEXTLvl = 36000;
                break;
            case 72:
                expNEXTLvl = 38000;
                break;
            case 73:
                expNEXTLvl = 40000;
                break;
            case 74:
                expNEXTLvl = 42000;
                break;
            case 75:
                expNEXTLvl = 44000;
                break;
        }

        if ((charlvl >= 30) && (charlvl <= 75))
            return expNEXTLvl;

        return 0;
    }

    void DistributeExperiencePoints(CFellowEntity* PFellow, CMobEntity* PMob, CCharEntity* PChar)
    {
        uint32 exp  = 0;
        uint8  FLvl = PFellow->GetMLevel();
        uint8  MLvl = PMob->GetMLevel();

        if (FLvl < 30)
            exp = 0;
        else if (FLvl == 30)
        {
            if (MLvl - FLvl < 0)
                exp = std::clamp(((MLvl - FLvl) * 15) + 100, 0, 85);
            else if (MLvl - FLvl == 0)
                exp = 100;
            else if (MLvl - FLvl == 1)
                exp = 120;
            else if (MLvl - FLvl == 2)
                exp = 140;
            else if (MLvl - FLvl == 3)
                exp = 160;
            else if (MLvl - FLvl >= 4)
                exp = 200;
        }
        else if (FLvl > 30 && FLvl <= 50)
        {
            if (MLvl - FLvl < 0)
                exp = std::clamp(((MLvl - FLvl) * 15) + 100, 0, 85);
            else if (MLvl - FLvl == 0)
                exp = 100;
            else if (MLvl - FLvl == 1)
                exp = 125;
            else if (MLvl - FLvl == 2)
                exp = 150;
            else if (MLvl - FLvl >= 3)
                exp = 200;
        }
        else if (FLvl > 50 && FLvl <= 55)
        {
            if (MLvl - FLvl < 0)
                exp = std::clamp(((MLvl - FLvl) * 15) + 100, 0, 85);
            else if (MLvl - FLvl == 0)
                exp = 100;
            else if (MLvl - FLvl == 1)
                exp = 125;
            else if (MLvl - FLvl == 2)
                exp = 150;
            else if (MLvl - FLvl == 3)
                exp = 200;
            else if (MLvl - FLvl >= 4)
                exp = 250;
        }
        else if (FLvl > 55 && FLvl <= 60)
        {
            if (MLvl - FLvl < 0)
                exp = std::clamp(((MLvl - FLvl) * 15) + 100, 0, 85);
            else if (MLvl - FLvl == 0)
                exp = 100;
            else if (MLvl - FLvl == 1)
                exp = 130;
            else if (MLvl - FLvl == 2)
                exp = 160;
            else if (MLvl - FLvl == 3)
                exp = 200;
            else if (MLvl - FLvl == 4)
                exp = 240;
            else if (MLvl - FLvl >= 5)
                exp = 250;
        }
        else if (FLvl > 60)
        {
            if (MLvl - FLvl < 0)
                exp = std::clamp(((MLvl - FLvl) * 15) + 100, 0, 85);
            else if (MLvl - FLvl == 0)
                exp = 100;
            else if (MLvl - FLvl == 1)
                exp = 130;
            else if (MLvl - FLvl == 2)
                exp = 160;
            else if (MLvl - FLvl == 3)
                exp = 200;
            else if (MLvl - FLvl == 4)
                exp = 240;
            else if (MLvl - FLvl == 5)
                exp = 280;
            else if (MLvl - FLvl >= 6)
                exp = 300;
        }
        // ShowDebug("fellowutils::Distribute... exp is: %u\n", exp);
        fellowutils::AddExperiencePoints(PFellow, PMob, exp, PChar);
        fellowutils::AddKillCount(PChar);
    }

    void AddExperiencePoints(CFellowEntity* PFellow, CBaseEntity* PMob, uint32 exp, CCharEntity* PMaster)
    {
        if (PFellow->isDead())
            return;

        const char* fmtQuery = "SELECT\
                char_fellow.lvlcap,\
                char_fellow.level,\
                char_fellow.exp\
                FROM char_fellow\
                WHERE char_fellow.charid = %u";

        int32 ret = sql->Query(fmtQuery, PMaster->id);

        if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            uint8  currentCap = (uint8)sql->GetIntData(0);
            uint8  currentLvl = (uint8)sql->GetIntData(1);
            uint32 currentExp = (uint32)sql->GetIntData(2);

            if (exp != 0)
                currentExp += exp; // add normal exp

            if (GetExpNEXTLevel(currentLvl) != 0)
            {
                if (currentExp >= GetExpNEXTLevel(currentLvl))
                {
                    if (currentLvl >= currentCap) // can't pass cap
                        currentExp = GetExpNEXTLevel(currentLvl) - 1;
                    else
                    {
                        currentExp -= GetExpNEXTLevel(currentLvl);

                        if (currentExp >= GetExpNEXTLevel(currentLvl + 1))
                            currentExp = GetExpNEXTLevel(currentLvl + 1) - 1;

                        currentLvl += 1;

                        PFellow->UpdateHealth();
                        PFellow->health.hp = PFellow->GetMaxHP();
                        PFellow->health.mp = PFellow->GetMaxMP();

                        SaveFellowExp(PMaster, currentLvl, currentExp);
                        // fellow levels up
                        PFellow->loc.zone->PushPacket(PFellow, CHAR_INRANGE_SELF, new CMessageCombatPacket(PFellow, PMob, currentLvl, 0, 9));
                        PFellow->updatemask |= UPDATE_HP;
                        PFellow->SetLocalVar("mpNotice", 0);
                        return;
                    }
                }
            }

            SaveFellowExp(PMaster, currentLvl, currentExp);
            charutils::AddPoints(PMaster, "fellow_point", exp / 2);
        }
    }

    void SaveFellowExp(CCharEntity* PMaster, uint8 currentLvl, uint32 currentExp)
    {
        const char* Query;
        Query = "UPDATE char_fellow SET level = %u, exp = %u WHERE charid = %u";
        sql->Query(Query, currentLvl, currentExp, PMaster->id);
    }

    void AddKillCount(CCharEntity* PMaster)
    {
        const char* fmtQuery = "SELECT\
                char_fellow.bond,\
                char_fellow.kills\
                FROM char_fellow\
                WHERE char_fellow.charid = %u";

        int32 ret = sql->Query(fmtQuery, PMaster->id);

        if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            uint16 fellowBond = (uint16)sql->GetIntData(0);
            uint16 kills      = (uint16)sql->GetIntData(1);
            kills += 1;
            PMaster->m_PFellow->zoneKills += 1;

            uint16 maxKills = 15;
            if (fellowBond >= 120)
                maxKills = 30;
            else if (fellowBond >= 70)
                maxKills = 25;
            else if (fellowBond >= 30)
                maxKills = 20;

            PMaster->m_PFellow->SetLocalVar("maxKills", maxKills);
            PMaster->m_PFellow->SetLocalVar("zoneKills", PMaster->m_PFellow->zoneKills);

            if (kills == maxKills - 1)
                TriggerFellowChat(PMaster, FELLOWCHAT_NEXTLASTENEMY); // Last Kill Warning
            else if (kills == maxKills)
            {
                TriggerFellowChat(PMaster, FELLOWCHAT_LEAVE); // Last Kill Leaving
                PMaster->loc.zone->PushPacket(PMaster, CHAR_INRANGE_SELF, new CFellowDespawnPacket(PMaster->m_PFellow));
                PMaster->RemoveFellow();
            }
            const char* Query;
            Query = "UPDATE char_fellow SET kills = %u WHERE charid = %u";
            sql->Query(Query, kills, PMaster->id);
        }
    }

    uint8 GetPersonalityOffset(CCharEntity* PChar)
    {
        uint8       personality = 0;
        const char* QueryP      = "SELECT personality FROM char_fellow WHERE charid = %u";
        if (sql->Query(QueryP, PChar->id) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
            personality = (uint8)sql->GetIntData(0);
        switch (personality)
        {
            case 4:
                personality = 0;
                break;
            case 8:
                personality = 1;
                break;
            case 12:
                personality = 2;
                break;
            case 16:
                personality = 3;
                break;
            case 40:
                personality = 4;
                break;
            case 44:
                personality = 5;
                break;
            case 20:
                personality = 7;
                break;
            case 24:
                personality = 8;
                break;
            case 28:
                personality = 9;
                break;
            case 32:
                personality = 10;
                break;
            case 36:
                personality = 11;
                break;
            case 48:
                personality = 12;
                break;
        }
        return personality;
    }

    void TriggerFellowChat(CCharEntity* PChar, uint8 option)
    {
        uint16 message       = 0;
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        uint8  currentCap    = 0;
        uint8  currentLvl    = 0;
        uint32 currentExp    = 0;
        uint16 expPercent    = 0;
        uint32 expNEXTLvl    = 0;
        uint8  type          = 0;
        uint16 param         = 0;
        uint16 kills         = 0;
        uint8  chatCounter   = PChar->GetLocalVar("chatCounter");
        uint8  roll          = xirand::GetRandomNumber(3);

        const char* fmtQuery = "SELECT\
                char_fellow.lvlcap,\
                char_fellow.level,\
                char_fellow.exp,\
                char_fellow.job,\
                char_fellow.kills\
                FROM char_fellow\
                WHERE char_fellow.charid = %u";

        int32 ret = sql->Query(fmtQuery, PChar->id);

        if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            currentCap = (uint8)sql->GetIntData(0);
            currentLvl = (uint8)sql->GetIntData(1);
            currentExp = (uint32)sql->GetIntData(2);
            expNEXTLvl = GetExpNEXTLevel(currentLvl);
            type       = (uint8)sql->GetIntData(3);
            kills      = (uint16)sql->GetIntData(4);
            // ShowDebug("fellowutils:: exp: %u kills: %u\n",currentExp,kills);
        }
        if (option == FELLOWCHAT_GENERAL)
        {
            // 0-[chat(rnd 1-3)] 1-[Kills if > 0] 2-[MP status] 3-[HP status] 4-[EXP status if not capped]
            switch (chatCounter)
            {
                case 0:
                    switch (roll)
                    {
                        case 0:
                            message = FELLOWMESSAGEOFFSET_GENERAL_CHAT;
                            break;
                        case 1:
                            message = FELLOWMESSAGEOFFSET_GENERAL_CHAT2;
                            break;
                        case 2:
                            message = FELLOWMESSAGEOFFSET_GENERAL_CHAT3;
                            break;
                    }
                    if (kills > 0)
                        PChar->SetLocalVar("chatCounter", 1);
                    else if (type != 1 && type != 2 && type != 5)
                        PChar->SetLocalVar("chatCounter", 2);
                    else
                        PChar->SetLocalVar("chatCounter", 3);
                    break;
                case 1:
                    if (kills >= 11)
                        message = FELLOWMESSAGEOFFSET_HIGH_KILLS;
                    else if (kills >= 6)
                        message = FELLOWMESSAGEOFFSET_MID_KILLS;
                    else
                        message = FELLOWMESSAGEOFFSET_LOW_KILLS;
                    param = kills;
                    if (type != 1 && type != 2 && type != 5)
                        PChar->SetLocalVar("chatCounter", 2);
                    else
                        PChar->SetLocalVar("chatCounter", 3);
                    break;
                case 2:
                    if (PChar->m_PFellow->GetMPP() >= 67)
                        message = FELLOWMESSAGEOFFSET_HIGH_MP;
                    else if (PChar->m_PFellow->GetMPP() >= 34)
                        message = FELLOWMESSAGEOFFSET_MID_MP;
                    else
                        message = FELLOWMESSAGEOFFSET_LOW_MP;
                    PChar->SetLocalVar("chatCounter", 3);
                    break;
                case 3:
                    if (PChar->m_PFellow->GetHPP() >= 81)
                        message = FELLOWMESSAGEOFFSET_FULL_HP;
                    else if (PChar->m_PFellow->GetHPP() >= 61)
                        message = FELLOWMESSAGEOFFSET_HIGH_HP;
                    else if (PChar->m_PFellow->GetHPP() >= 41)
                        message = FELLOWMESSAGEOFFSET_MID_HP;
                    else if (PChar->m_PFellow->GetHPP() >= 21)
                        message = FELLOWMESSAGEOFFSET_LOW_HP;
                    else if (PChar->m_PFellow->GetHPP() >= 1)
                        message = FELLOWMESSAGEOFFSET_NO_HP;
                    if (currentCap != currentLvl)
                        PChar->SetLocalVar("chatCounter", 4);
                    else
                        PChar->SetLocalVar("chatCounter", 0);
                    break;
                case 4:
                    expPercent = (100 * currentExp) / expNEXTLvl;
                    if (expPercent >= 80)
                        message = FELLOWMESSAGEOFFSET_HIGH_EXP;
                    else if (expPercent >= 60)
                        message = FELLOWMESSAGEOFFSET_MORE_EXP;
                    else if (expPercent >= 40)
                        message = FELLOWMESSAGEOFFSET_MID_EXP;
                    else if (expPercent >= 20)
                        message = FELLOWMESSAGEOFFSET_SOME_EXP;
                    else
                        message = FELLOWMESSAGEOFFSET_LOW_EXP;
                    PChar->SetLocalVar("chatCounter", 0);
                    break;
            }
        }
        else if (option == FELLOWCHAT_DISBAND)
            message = FELLOWMESSAGEOFFSET_DISBAND;
        else if (option == FELLOWCHAT_NEXTLASTENEMY)
            message = FELLOWMESSAGEOFFSET_NEXT_LAST_ENEMY;
        else if (option == FELLOWCHAT_LEAVE)
            message = FELLOWMESSAGEOFFSET_LEAVE;

        PChar->pushPacket(new CMessageSpecialPacket(PChar->m_PFellow, MessageOffset + message + GetPersonalityOffset(PChar), param));
    }

    void AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget)
    {
        XI_DEBUG_BREAK_IF(((CCharEntity*)PMaster)->m_PFellow == nullptr);

        CBattleEntity* PFellow = ((CCharEntity*)PMaster)->m_PFellow;
        if (!PFellow->StatusEffectContainer->HasPreventActionEffect())
        {
            PFellow->PAI->Engage(PTarget->targid);
        }
    }

    void RetreatToMaster(CBattleEntity* PMaster)
    {
        XI_DEBUG_BREAK_IF(((CCharEntity*)PMaster)->m_PFellow == nullptr);

        CBattleEntity* PFellow = ((CCharEntity*)PMaster)->m_PFellow;
        if (!PFellow->StatusEffectContainer->HasPreventActionEffect())
        {
            PFellow->PAI->Disengage();
        }
    }

    uint16 GetWeaponDmgByTypeAndLevel(SKILLTYPE skillType, uint8 level)
    {
        // Damage found by taking x/y level/damage at multiple points, excluding outliers (CrossCounters, Soboro, etc) and applying a linear line fit algorithm
        uint16 damage = 6;
        switch (skillType)
        {
            case SKILL_HAND_TO_HAND:
                damage = floor(level * 0.6 + 2.5); // includes base dmg gained from skill, unique to HtH
                break;
            case SKILL_DAGGER:
                damage = floor(level * 0.4 + 2.3);
                break;
            case SKILL_GREAT_SWORD:
                damage = floor((level * 1.05) + 12.5);
                break;
            case SKILL_AXE:
                damage = floor((level * .58) + 7.8);
                break;
            case SKILL_GREAT_AXE:
                damage = floor((level * 1.13) + 15.9);
                break;
            case SKILL_SCYTHE:
                damage = floor((level * 1.19) + 15.5);
                break;
            case SKILL_POLEARM: // Assuming lance class
                damage = floor((level * 1.12) + 13.29);
                break;
            case SKILL_KATANA:
                damage = (level * 0.5) + 4;
                break;
            case SKILL_GREAT_KATANA:
                damage = floor((level * 0.98) + 14.14);
                break;
            case SKILL_CLUB:
                damage = floor((level * 0.51) + 4.8);
                break;
            case SKILL_STAFF: // Pole class
                damage = floor((level * 0.71) + 8.39);
                break;
            case SKILL_SWORD:
            default:
                damage = floor((level * 0.5) + 5);
                break;
        }
        return damage;
    }
    uint16 GetWeaponDelayByTypeAndLevel(SKILLTYPE skillType, uint8 level)
    {
        uint16 delay = 236;
        switch (skillType)
        {
            case SKILL_HAND_TO_HAND:
                delay = 480;
                break;
            case SKILL_DAGGER:
                delay = 195;
                break;
            case SKILL_GREAT_SWORD:
                delay = 444;
                break;
            case SKILL_AXE:
                delay = 276;
                break;
            case SKILL_GREAT_AXE:
                delay = 504;
                break;
            case SKILL_SCYTHE:
                delay = 528;
                break;
            case SKILL_POLEARM: // Assuming lance class
                delay = 492;
                break;
            case SKILL_KATANA:
                delay = 227;
                break;
            case SKILL_GREAT_KATANA:
                delay = 450;
                break;
            case SKILL_CLUB:
                delay = 300;
                break;
            case SKILL_STAFF: // Pole class
                delay = 402;
                break;
            case SKILL_SWORD:
            default:
                delay = 236;
                break;
        }
        return (delay * 1000) / 60;
    }

}; // namespace fellowutils
