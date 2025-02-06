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
#include "common/socket.h"
#include "common/sql.h"
#include "common/timer.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <array>
#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstring>

#include "lua/luautils.h"

#include "ai/ai_container.h"
#include "ai/states/attack_state.h"
#include "ai/states/item_state.h"
#include "ai/states/range_state.h"

#include "packets/char_abilities.h"
#include "packets/char_appearance.h"
#include "packets/char_equip.h"
#include "packets/char_health.h"
#include "packets/char_job_extra.h"
#include "packets/char_jobs.h"
#include "packets/char_recast.h"
#include "packets/char_skills.h"
#include "packets/char_stats.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/chat_message.h"
#include "packets/conquest_map.h"
#include "packets/delivery_box.h"
#include "packets/inventory_assign.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "packets/inventory_modify.h"
#include "packets/key_items.h"
#include "packets/linkshell_equip.h"
#include "packets/menu_jobpoints.h"
#include "packets/menu_merit.h"
#include "packets/message_basic.h"
#include "packets/message_combat.h"
#include "packets/message_special.h"
#include "packets/message_standard.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"
#include "packets/objective_utility.h"
#include "packets/quest_mission_log.h"
#include "packets/roe_sparkupdate.h"
#include "packets/server_ip.h"

#include "ability.h"
#include "alliance.h"
#include "conquest_system.h"
#include "grades.h"
#include "item_container.h"
#include "latent_effect_container.h"
#include "linkshell.h"
#include "map.h"
#include "message.h"
#include "mob_modifier.h"
#include "recast_container.h"
#include "roe.h"
#include "spell.h"
#include "status_effect_container.h"
#include "trade_container.h"
#include "trait.h"
#include "treasure_pool.h"
#include "unitychat.h"
#include "universal_container.h"
#include "weapon_skill.h"

#include "entities/automatonentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/petentity.h"

#include "battleutils.h"
#include "blueutils.h"
#include "charutils.h"
#include "itemutils.h"
#include "petutils.h"
#include "puppetutils.h"
#include "synthutils.h"
#include "zoneutils.h"

/************************************************************************
 *                                                                       *
 *  Experience tables                                                    *
 *                                                                       *
 ************************************************************************/

// Number of rows in the exp table
static constexpr int32                               ExpTableRowCount = 60;
std::array<std::array<uint16, 20>, ExpTableRowCount> g_ExpTable;
std::array<uint16, 100>                              g_ExpPerLevel;

namespace charutils
{
    /************************************************************************
     *                                                                       *
     *  Calculation of stats of characters                                   *
     *                                                                       *
     ************************************************************************/

    void CalculateStats(CCharEntity* PChar)
    {
        float raceStat  = 0; // The final HP number for a race-based level.
        float jobStat   = 0; // Estimate HP level for the level based on the primary profession.
        float sJobStat  = 0; // HP final number for a level based on a secondary profession.
        int32 bonusStat = 0; // HP bonus number that is added subject to some conditions.

        int32 baseValueColumn   = 0; // Column number with base number HP
        int32 scaleTo60Column   = 1; // Column number with modifier up to 60 levels
        int32 scaleOver30Column = 2; // Column number with modifier after level 30
        int32 scaleOver60Column = 3; // Column number with modifier after level 60
        int32 scaleOver75Column = 4; // Column number with modifier after level 75
        int32 scaleOver60       = 2; // Column number with modifier for MP calculation after level 60
        int32 scaleOver75       = 3; // The speaker number with the modifier to calculate the stats after the 75th level

        uint8 grade = 0;

        uint8      mlvl        = PChar->GetMLevel();
        uint8      slvl        = PChar->GetSLevel();
        JOBTYPE    mjob        = PChar->GetMJob();
        JOBTYPE    sjob        = PChar->GetSJob();
        MERIT_TYPE statMerit[] = { MERIT_STR, MERIT_DEX, MERIT_VIT, MERIT_AGI, MERIT_INT, MERIT_MND, MERIT_CHR };

        // We have to make sure we don't leave the job as JOB_MON - we CANNOT generate stats for it.
        if (mjob == JOB_MON || sjob == JOB_MON)
        {
            mjob = JOB_WAR;
            sjob = JOB_WAR;
        }

        // NOTE: Monstrosity (MON) is treated as its own job, but each species is it's own
        //     : combination of main/sub job for stats, traits and abilities.
        if (PChar->m_PMonstrosity != nullptr)
        {
            mjob = PChar->m_PMonstrosity->MainJob;
            sjob = PChar->m_PMonstrosity->SubJob;
            mlvl = PChar->m_PMonstrosity->levels[PChar->m_PMonstrosity->MonstrosityId];
            slvl = mlvl;
        }

        uint8 race = 0; // Hume

        switch (PChar->look.race)
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

        // HP Calculation from Main Job

        int32 mainLevelOver30     = std::clamp(mlvl - 30, 0, 30); // Calculation of the condition + 1HP each LVL after level 30
        int32 mainLevelUpTo60     = (mlvl < 60 ? mlvl - 1 : 59);  // The first time spent up to level 60 (is also used for MP)
        int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15); // The second calculation mode after level 60
        int32 mainLevelOver75     = (mlvl < 75 ? 0 : mlvl - 75);  // Third Calculation Mode after level 75

        // Calculation of the bonus amount of HP

        int32 mainLevelOver10           = (mlvl < 10 ? 0 : mlvl - 10);  // + 2hp at each level after 10
        int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10); // + 2hp at each level between 50 to 60 level
        int32 mainLevelOver60           = (mlvl < 60 ? 0 : mlvl - 60);

        // HP calculation of an additional profession

        int32 subLevelOver10 = std::clamp(slvl - 10, 0, 20); // + 1HP for each level after 10 (/ 2)
        int32 subLevelOver30 = (slvl < 30 ? 0 : slvl - 30);  // + 1HP for each level after 30

        // Calculate Racestat Jobstat Bonusstat Sjobstat
        // Calculation of race

        grade = grade::GetRaceGrades(race, 0);

        raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                   (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                   (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Calculation on Main Job
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                  (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                  (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Calculation of bonus HP.
        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;

        // Calculation on Support Job
        if (slvl > 0)
        {
            grade = grade::GetJobGrade(sjob, 0);

            sJobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * (slvl - 1)) +
                       (grade::GetHPScale(grade, scaleOver30Column) * subLevelOver30) + subLevelOver30 + subLevelOver10;
            sJobStat = sJobStat / 2;
        }

        uint16 MeritBonus   = PChar->PMeritPoints->GetMeritValue(MERIT_MAX_HP, PChar);
        PChar->health.maxhp = (int16)(settings::get<float>("map.PLAYER_HP_MULTIPLIER") * (raceStat + jobStat + bonusStat + sJobStat) + MeritBonus);

        // The beginning of the MP

        raceStat = 0;
        jobStat  = 0;
        sJobStat = 0;

        // Calculation of the MP race.
        grade = grade::GetRaceGrades(race, 1);

        // If Main Job has no MP rating, we calculate a racial bonus based on the level of the subjob level (provided that he has a MP rating)
        if (grade::GetJobGrade(mjob, 1) == 0)
        {
            if (grade::GetJobGrade(sjob, 1) != 0 && slvl > 0) // TODO: In this expression, an error
            {
                raceStat =
                    (grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * (slvl - 1)) / settings::get<float>("map.SJ_MP_DIVISOR"); // TODO: Here is a mistake
            }
        }
        else
        {
            // Calculation of a normal racial bonus
            raceStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                       grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        // Main Job
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                      grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        // Subjob
        if (slvl > 0)
        {
            grade    = grade::GetJobGrade(sjob, 1);
            sJobStat = (grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * (slvl - 1)) / settings::get<float>("map.SJ_MP_DIVISOR");
        }

        MeritBonus          = PChar->PMeritPoints->GetMeritValue(MERIT_MAX_MP, PChar);
        PChar->health.maxmp = (int16)(settings::get<float>("map.PLAYER_MP_MULTIPLIER") * (raceStat + jobStat + sJobStat) + MeritBonus); // MP calculation result

        // Start calculating Stats

        uint8 counter = 0;

        for (uint8 StatIndex = 2; StatIndex <= 8; ++StatIndex)
        {
            // Calculation of race
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

            // Calculation by profession
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

            // Calculation for an additional profession
            if (slvl > 0)
            {
                grade    = grade::GetJobGrade(sjob, StatIndex);
                sJobStat = (grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * (slvl - 1)) / 2;
            }
            else
            {
                sJobStat = 0;
            }

            // get each merit bonus stat, str,dex,vit and so on...
            MeritBonus = PChar->PMeritPoints->GetMeritValue(statMerit[StatIndex - 2], PChar);

            // Value output
            ref<uint16>(&PChar->stats, counter) = (uint16)(settings::get<float>("map.PLAYER_STAT_MULTIPLIER") * (raceStat + jobStat + sJobStat) + MeritBonus);
            counter += 2;
        }
    }

    /************************************************************************
     *                                                                       *
     *  The preliminary version of the character loading. Function will be   *
     *  optimized after determining all the necessary data and tables        *
     *                                                                       *
     ************************************************************************/

    CCharEntity* LoadChar(uint32 charId)
    {
        TracyZoneScoped;

        CCharEntity* PChar = new CCharEntity();
        PChar->id          = charId;

        uint8  meritPoints = 0;
        uint16 limitPoints = 0;
        int32  HP          = 0;
        int32  MP          = 0;

        // TODO: extract into LoadFromCharsSQL
        const char* fmtQuery = "SELECT "
                               "charname, "
                               "nation, "
                               "pos_zone, "
                               "pos_prevzone, "
                               "pos_rot, "
                               "pos_x, "
                               "pos_y, "
                               "pos_z, "
                               "moghouse, "
                               "boundary, "
                               "home_zone, "
                               "home_rot, "
                               "home_x, "
                               "home_y, "
                               "home_z, "
                               "missions, "
                               "assault, "
                               "campaign, "
                               "eminence, "
                               "quests, "
                               "keyitems, "
                               "abilities, "
                               "weaponskills, "
                               "titles, "
                               "zones, "
                               "playtime, "
                               "gmlevel, "
                               "languages, "
                               "mentor, "
                               "job_master, "
                               "campaign_allegiance, "
                               "isstylelocked, "
                               "settings, "
                               "chatfilters_1, "
                               "chatfilters_2, "
                               "moghancement, "
                               "UNIX_TIMESTAMP(`lastupdate`) AS lastonline "
                               "FROM chars "
                               "WHERE charid = (?)";

        auto rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->targid = 0x400;
            PChar->SetName(rset->get<std::string>("charname").c_str());

            PChar->loc.destination = rset->get<uint16>("pos_zone");
            PChar->loc.prevzone    = rset->get<uint16>("pos_prevzone");
            PChar->loc.p.rotation  = rset->get<uint8>("pos_rot");
            PChar->loc.p.x         = rset->get<float>("pos_x");
            PChar->loc.p.y         = rset->get<float>("pos_y");
            PChar->loc.p.z         = rset->get<float>("pos_z");
            PChar->m_moghouseID    = rset->get<uint32>("moghouse");
            PChar->loc.boundary    = rset->get<uint16>("boundary");

            PChar->profile.home_point.destination = rset->get<uint16>("home_zone");
            PChar->profile.home_point.p.rotation  = rset->get<uint8>("home_rot");
            PChar->profile.home_point.p.x         = rset->get<float>("home_x");
            PChar->profile.home_point.p.y         = rset->get<float>("home_y");
            PChar->profile.home_point.p.z         = rset->get<float>("home_z");

            PChar->profile.nation = rset->get<uint8>("nation");

            db::extractFromBlob(rset, "quests", PChar->m_questLog);
            db::extractFromBlob(rset, "keyitems", PChar->keys);
            db::extractFromBlob(rset, "abilities", PChar->m_LearnedAbilities);
            db::extractFromBlob(rset, "weaponskills", PChar->m_LearnedWeaponskills);
            db::extractFromBlob(rset, "titles", PChar->m_TitleList);
            db::extractFromBlob(rset, "zones", PChar->m_ZonesList);
            db::extractFromBlob(rset, "missions", PChar->m_missionLog);
            db::extractFromBlob(rset, "assault", PChar->m_assaultLog);
            db::extractFromBlob(rset, "campaign", PChar->m_campaignLog);
            db::extractFromBlob(rset, "eminence", PChar->m_eminenceLog);

            PChar->SetPlayTime(rset->get<uint32>("playtime"));
            PChar->profile.campaign_allegiance = rset->get<uint8>("campaign_allegiance");
            PChar->setStyleLocked(rset->get<uint32>("isstylelocked") == 1);
            PChar->SetMoghancement(rset->get<uint16>("moghancement"));
            PChar->lastOnline      = rset->get<uint32>("lastonline");
            PChar->search.language = rset->get<uint8>("languages");

            PChar->m_GMlevel          = rset->get<uint8>("gmlevel");
            PChar->m_mentorUnlocked   = rset->get<uint32>("mentor") > 0;
            PChar->m_jobMasterDisplay = rset->get<uint32>("job_master") > 0;

            uint32 playerSettings = rset->get<uint32>("settings");
            uint32 MessageFilter  = rset->get<uint32>("chatfilters_1");
            uint32 MessageFilter2 = rset->get<uint32>("chatfilters_2");

            std::memcpy(&PChar->playerConfig, &playerSettings, sizeof(uint32_t));
            std::memcpy(&PChar->playerConfig.MessageFilter, &MessageFilter, sizeof(uint32_t));
            std::memcpy(&PChar->playerConfig.MessageFilter2, &MessageFilter2, sizeof(uint32_t));
        }

        // TODO: Rename LoadFromCharSpellsSQL
        LoadSpells(PChar);

        // TODO: LoadFromCharProfileSQL
        fmtQuery = "SELECT "
                   "rank_points,"
                   "rank_sandoria,"
                   "rank_bastok,"
                   "rank_windurst,"
                   "fame_sandoria,"
                   "fame_bastok,"
                   "fame_windurst,"
                   "fame_norg, "
                   "fame_jeuno, "
                   "fame_aby_konschtat, "
                   "fame_aby_tahrongi, "
                   "fame_aby_latheine, "
                   "fame_aby_misareaux, "
                   "fame_aby_vunkerl, "
                   "fame_aby_attohwa, "
                   "fame_aby_altepa, "
                   "fame_aby_grauberg, "
                   "fame_aby_uleguerand, "
                   "fame_adoulin,"
                   "unity_leader "
                   "FROM char_profile "
                   "WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->profile.rankpoints = rset->get<uint16>("rank_points");

            PChar->profile.rank[0] = rset->get<uint8>("rank_sandoria");
            PChar->profile.rank[1] = rset->get<uint8>("rank_bastok");
            PChar->profile.rank[2] = rset->get<uint8>("rank_windurst");

            PChar->profile.fame[0]      = rset->get<uint16>("fame_sandoria");
            PChar->profile.fame[1]      = rset->get<uint16>("fame_bastok");
            PChar->profile.fame[2]      = rset->get<uint16>("fame_windurst");
            PChar->profile.fame[3]      = rset->get<uint16>("fame_norg");
            PChar->profile.fame[4]      = rset->get<uint16>("fame_jeuno");
            PChar->profile.fame[5]      = rset->get<uint16>("fame_aby_konschtat");
            PChar->profile.fame[6]      = rset->get<uint16>("fame_aby_tahrongi");
            PChar->profile.fame[7]      = rset->get<uint16>("fame_aby_latheine");
            PChar->profile.fame[8]      = rset->get<uint16>("fame_aby_misareaux");
            PChar->profile.fame[9]      = rset->get<uint16>("fame_aby_vunkerl");
            PChar->profile.fame[10]     = rset->get<uint16>("fame_aby_attohwa");
            PChar->profile.fame[11]     = rset->get<uint16>("fame_aby_altepa");
            PChar->profile.fame[12]     = rset->get<uint16>("fame_aby_grauberg");
            PChar->profile.fame[13]     = rset->get<uint16>("fame_aby_uleguerand");
            PChar->profile.fame[14]     = rset->get<uint16>("fame_adoulin");
            PChar->profile.unity_leader = rset->get<uint8>("unity_leader");
        }

        roeutils::onCharLoad(PChar);

        // TODO: LoadFromCharStorageSQL
        fmtQuery = "SELECT "
                   "inventory,"
                   "safe,"
                   "locker,"
                   "satchel,"
                   "sack,"
                   "`case`,"
                   "wardrobe,"
                   "wardrobe2,"
                   "wardrobe3,"
                   "wardrobe4,"
                   "wardrobe5,"
                   "wardrobe6,"
                   "wardrobe7,"
                   "wardrobe8 "
                   "FROM char_storage "
                   "WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->getStorage(LOC_INVENTORY)->AddBuff(rset->get<uint8>("inventory"));
            PChar->getStorage(LOC_MOGSAFE)->AddBuff(rset->get<uint8>("safe"));
            PChar->getStorage(LOC_MOGSAFE2)->AddBuff(rset->get<uint8>("safe"));
            PChar->getStorage(LOC_TEMPITEMS)->AddBuff(50);
            PChar->getStorage(LOC_MOGLOCKER)->AddBuff(rset->get<uint8>("locker"));
            PChar->getStorage(LOC_MOGSATCHEL)->AddBuff(rset->get<uint8>("satchel"));
            PChar->getStorage(LOC_MOGSACK)->AddBuff(rset->get<uint8>("sack"));
            PChar->getStorage(LOC_MOGCASE)->AddBuff(rset->get<uint8>("case"));

            PChar->getStorage(LOC_WARDROBE)->AddBuff(rset->get<uint8>("wardrobe"));
            PChar->getStorage(LOC_WARDROBE2)->AddBuff(rset->get<uint8>("wardrobe2"));
            PChar->getStorage(LOC_WARDROBE3)->AddBuff(rset->get<uint8>("wardrobe3"));
            PChar->getStorage(LOC_WARDROBE4)->AddBuff(rset->get<uint8>("wardrobe4"));

            PChar->getStorage(LOC_WARDROBE5)->AddBuff(rset->get<uint8>("wardrobe5"));
            PChar->getStorage(LOC_WARDROBE6)->AddBuff(rset->get<uint8>("wardrobe6"));
            PChar->getStorage(LOC_WARDROBE7)->AddBuff(rset->get<uint8>("wardrobe7"));
            PChar->getStorage(LOC_WARDROBE8)->AddBuff(rset->get<uint8>("wardrobe8"));

            // NOTE: Not from the db, hard-coded to 10!
            PChar->getStorage(LOC_RECYCLEBIN)->AddBuff(10);
        }

        // TODO: LoadFromCharLookSQL
        fmtQuery = "SELECT face, race, size, head, body, hands, legs, feet, main, sub, ranged "
                   "FROM char_look "
                   "WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->look.face = rset->get<uint8>("face");
            PChar->look.race = rset->get<uint8>("race");
            PChar->look.size = rset->get<uint8>("size");

            PChar->look.head   = rset->get<uint16>("head");
            PChar->look.body   = rset->get<uint16>("body");
            PChar->look.hands  = rset->get<uint16>("hands");
            PChar->look.legs   = rset->get<uint16>("legs");
            PChar->look.feet   = rset->get<uint16>("feet");
            PChar->look.main   = rset->get<uint16>("main");
            PChar->look.sub    = rset->get<uint16>("sub");
            PChar->look.ranged = rset->get<uint16>("ranged");

            std::memcpy(&PChar->mainlook, &PChar->look, sizeof(PChar->look));
        }

        // LoadFromCharStyleSQL
        fmtQuery = "SELECT head, body, hands, legs, feet, main, sub, ranged FROM char_style WHERE charid = (?)";
        rset     = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->styleItems[SLOT_HEAD]   = rset->get<uint16>("head");
            PChar->styleItems[SLOT_BODY]   = rset->get<uint16>("body");
            PChar->styleItems[SLOT_HANDS]  = rset->get<uint16>("hands");
            PChar->styleItems[SLOT_LEGS]   = rset->get<uint16>("legs");
            PChar->styleItems[SLOT_FEET]   = rset->get<uint16>("feet");
            PChar->styleItems[SLOT_MAIN]   = rset->get<uint16>("main");
            PChar->styleItems[SLOT_SUB]    = rset->get<uint16>("sub");
            PChar->styleItems[SLOT_RANGED] = rset->get<uint16>("ranged");
        }

        // LoadFromCharJobsSQL
        fmtQuery = "SELECT unlocked, genkai, war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng, sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run "
                   "FROM char_jobs "
                   "WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->jobs.unlocked = rset->get<uint32>("unlocked");
            PChar->jobs.genkai   = rset->get<uint8>("genkai");

            PChar->jobs.job[JOB_WAR] = rset->get<uint8>("war");
            PChar->jobs.job[JOB_MNK] = rset->get<uint8>("mnk");
            PChar->jobs.job[JOB_WHM] = rset->get<uint8>("whm");
            PChar->jobs.job[JOB_BLM] = rset->get<uint8>("blm");
            PChar->jobs.job[JOB_RDM] = rset->get<uint8>("rdm");
            PChar->jobs.job[JOB_THF] = rset->get<uint8>("thf");
            PChar->jobs.job[JOB_PLD] = rset->get<uint8>("pld");
            PChar->jobs.job[JOB_DRK] = rset->get<uint8>("drk");
            PChar->jobs.job[JOB_BST] = rset->get<uint8>("bst");
            PChar->jobs.job[JOB_BRD] = rset->get<uint8>("brd");
            PChar->jobs.job[JOB_RNG] = rset->get<uint8>("rng");
            PChar->jobs.job[JOB_SAM] = rset->get<uint8>("sam");
            PChar->jobs.job[JOB_NIN] = rset->get<uint8>("nin");
            PChar->jobs.job[JOB_DRG] = rset->get<uint8>("drg");
            PChar->jobs.job[JOB_SMN] = rset->get<uint8>("smn");
            PChar->jobs.job[JOB_BLU] = rset->get<uint8>("blu");
            PChar->jobs.job[JOB_COR] = rset->get<uint8>("cor");
            PChar->jobs.job[JOB_PUP] = rset->get<uint8>("pup");
            PChar->jobs.job[JOB_DNC] = rset->get<uint8>("dnc");
            PChar->jobs.job[JOB_SCH] = rset->get<uint8>("sch");
            PChar->jobs.job[JOB_GEO] = rset->get<uint8>("geo");
            PChar->jobs.job[JOB_RUN] = rset->get<uint8>("run");
        }

        // LoadFromCharExpSQL
        fmtQuery = "SELECT mode, war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng, sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run, merits, limits "
                   "FROM char_exp "
                   "WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->MeritMode = rset->get<uint8>("mode");

            PChar->jobs.exp[JOB_WAR] = rset->get<uint16>("war");
            PChar->jobs.exp[JOB_MNK] = rset->get<uint16>("mnk");
            PChar->jobs.exp[JOB_WHM] = rset->get<uint16>("whm");
            PChar->jobs.exp[JOB_BLM] = rset->get<uint16>("blm");
            PChar->jobs.exp[JOB_RDM] = rset->get<uint16>("rdm");
            PChar->jobs.exp[JOB_THF] = rset->get<uint16>("thf");
            PChar->jobs.exp[JOB_PLD] = rset->get<uint16>("pld");
            PChar->jobs.exp[JOB_DRK] = rset->get<uint16>("drk");
            PChar->jobs.exp[JOB_BST] = rset->get<uint16>("bst");
            PChar->jobs.exp[JOB_BRD] = rset->get<uint16>("brd");
            PChar->jobs.exp[JOB_RNG] = rset->get<uint16>("rng");
            PChar->jobs.exp[JOB_SAM] = rset->get<uint16>("sam");
            PChar->jobs.exp[JOB_NIN] = rset->get<uint16>("nin");
            PChar->jobs.exp[JOB_DRG] = rset->get<uint16>("drg");
            PChar->jobs.exp[JOB_SMN] = rset->get<uint16>("smn");
            PChar->jobs.exp[JOB_BLU] = rset->get<uint16>("blu");
            PChar->jobs.exp[JOB_COR] = rset->get<uint16>("cor");
            PChar->jobs.exp[JOB_PUP] = rset->get<uint16>("pup");
            PChar->jobs.exp[JOB_DNC] = rset->get<uint16>("dnc");
            PChar->jobs.exp[JOB_SCH] = rset->get<uint16>("sch");
            PChar->jobs.exp[JOB_GEO] = rset->get<uint16>("geo");
            PChar->jobs.exp[JOB_RUN] = rset->get<uint16>("run");

            meritPoints = rset->get<uint8>("merits");
            limitPoints = rset->get<uint16>("limits");
        }

        // TODO: LoadFromCharStatsSQL
        fmtQuery = "SELECT mjob, sjob, hp, mp, mhflag, title, bazaar_message, zoning, "
                   "pet_id, pet_type, pet_hp, pet_mp, pet_level "
                   "FROM char_stats WHERE charid = (?)";

        uint8 zoning = 0;
        rset         = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->SetMJob(rset->get<uint8>("mjob"));
            PChar->SetSJob(rset->get<uint8>("sjob"));

            HP = rset->get<int32>("hp");
            MP = rset->get<int32>("mp");

            PChar->profile.mhflag = rset->get<uint16>("mhflag");
            PChar->profile.title  = rset->get<uint16>("title");

            std::array<uint8, 512> bazaarMessageArray{};
            db::extractFromBlob(rset, "bazaar_message", bazaarMessageArray);
            const char* bazaarMessageStr = reinterpret_cast<const char*>(bazaarMessageArray.data());
            if (bazaarMessageStr != nullptr)
            {
                PChar->bazaar.message.insert(0, bazaarMessageStr);
            }
            else
            {
                PChar->bazaar.message = '\0';
            }

            zoning = rset->get<uint8>("zoning");

            // Determine if the pet should be respawned.
            int16 petHP = rset->get<int16>("pet_hp");
            if (petHP)
            {
                PChar->petZoningInfo.petHP        = petHP;
                PChar->petZoningInfo.petID        = rset->get<uint8>("pet_id");
                PChar->petZoningInfo.petMP        = rset->get<int16>("pet_mp");
                PChar->petZoningInfo.petType      = static_cast<PET_TYPE>(rset->get<uint8>("pet_type"));
                PChar->petZoningInfo.petLevel     = rset->get<uint8>("pet_level");
                PChar->petZoningInfo.respawnPet   = true;
                PChar->petZoningInfo.jugSpawnTime = static_cast<uint32>(PChar->getCharVar("jugpet-spawn-time"));
                PChar->petZoningInfo.jugDuration  = static_cast<uint32>(PChar->getCharVar("jugpet-duration-seconds"));

                // clear the charvars used for jug state
                PChar->clearCharVarsWithPrefix("jugpet-");
            }
        }

        db::query(fmt::format("UPDATE char_stats SET zoning = 0 WHERE charid = {}", PChar->id));

        if (zoning == 2)
        {
            ShowDebug("Player <%s> logging in to zone <%u>", PChar->name.c_str(), PChar->getZone());

            // Set this value so we can not process some effects until the player is fully in-game.
            // This is cleared in the player global, onGameIn function.
            PChar->SetLocalVar("gameLogin", 1);
        }

        PChar->SetMLevel(PChar->jobs.job[PChar->GetMJob()]);
        PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

        // TODO: LoadFromCharRecastSQL
        fmtQuery = "SELECT id, time, recast FROM char_recast WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                uint32    cast_time  = rset->get<uint32>("time");
                uint32    recast     = rset->get<uint32>("recast");
                time_t    now        = time(nullptr);
                uint32    chargeTime = 0;
                uint8     maxCharges = 0;
                Charge_t* charge     = ability::GetCharge(PChar, rset->get<uint32>("id"));
                if (charge != nullptr)
                {
                    chargeTime = charge->chargeTime;
                    maxCharges = charge->maxCharges;
                }
                if (now < cast_time + recast)
                {
                    PChar->PRecastContainer->Load(RECAST_ABILITY, rset->get<uint32>("id"), (cast_time + recast - (uint32)now), chargeTime, maxCharges);
                }
            }
        }

        // TODO: LoadFromCharSkillsSQL
        fmtQuery = "SELECT skillid, value, rank "
                   "FROM char_skills "
                   "WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                uint8 SkillID = rset->get<uint8>("skillid");
                if (SkillID < MAX_SKILLTYPE)
                {
                    PChar->RealSkills.skill[SkillID] = rset->get<uint16>("value");
                    if (SkillID >= SKILL_FISHING)
                    {
                        PChar->RealSkills.rank[SkillID] = rset->get<uint8>("rank");
                    }
                }
            }
        }

        // LoadFromCharUnlocksSQL
        fmtQuery = "SELECT outpost_sandy, outpost_bastok, outpost_windy, runic_portal, maw, "
                   "campaign_sandy, campaign_bastok, campaign_windy, homepoints, survivals, "
                   "abyssea_conflux, waypoints, eschan_portals, claimed_deeds, unique_event "
                   "FROM char_unlocks "
                   "WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->teleport.outpostSandy   = rset->get<uint32>("outpost_sandy");
            PChar->teleport.outpostBastok  = rset->get<uint32>("outpost_bastok");
            PChar->teleport.outpostWindy   = rset->get<uint32>("outpost_windy");
            PChar->teleport.runicPortal    = rset->get<uint32>("runic_portal");
            PChar->teleport.pastMaw        = rset->get<uint32>("maw");
            PChar->teleport.campaignSandy  = rset->get<uint32>("campaign_sandy");
            PChar->teleport.campaignBastok = rset->get<uint32>("campaign_bastok");
            PChar->teleport.campaignWindy  = rset->get<uint32>("campaign_windy");

            db::extractFromBlob(rset, "homepoints", PChar->teleport.homepoint);
            db::extractFromBlob(rset, "survivals", PChar->teleport.survival);
            db::extractFromBlob(rset, "abyssea_conflux", PChar->teleport.abysseaConflux);
            db::extractFromBlob(rset, "waypoints", PChar->teleport.waypoints);
            db::extractFromBlob(rset, "eschan_portals", PChar->teleport.eschanPortal);
            db::extractFromBlob(rset, "claimed_deeds", PChar->m_claimedDeeds);
            db::extractFromBlob(rset, "unique_event", PChar->m_uniqueEvents);
        }

        // TODO: Remove raw new's
        PChar->PMeritPoints = new CMeritPoints(PChar);
        PChar->PMeritPoints->SetMeritPoints(meritPoints);
        PChar->PMeritPoints->SetLimitPoints(limitPoints);
        PChar->PJobPoints = new CJobPoints(PChar);

        rset = db::preparedStmt("SELECT field_chocobo FROM char_pet WHERE charid = (?)", PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->m_FieldChocobo = rset->get<uint32>("field_chocobo");
        }

        // TODO: LoadCharFlagsFromSQL
        fmtQuery = "SELECT gmModeEnabled, gmHiddenEnabled FROM char_flags WHERE charid = (?)";

        rset = db::preparedStmt(fmtQuery, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            bool gmEnabled = rset->get<uint32>("gmModeEnabled");
            bool gmHidden  = rset->get<uint32>("gmHiddenEnabled");

            if (gmEnabled)
            {
                // + 3 because visible GM level starts at 3 (0 is none, 1-2 are special icons)
                PChar->visibleGmLevel = std::min(PChar->m_GMlevel + 3, 7);
            }

            PChar->m_isGMHidden = gmHidden;
        }

        monstrosity::TryPopulateMonstrosityData(PChar);

        charutils::LoadInventory(PChar);

        CalculateStats(PChar);
        jobpointutils::RefreshGiftMods(PChar);

        // This must come after refreshing gift modifiers, but before loading job traits.
        blueutils::LoadSetSpells(PChar);

        BuildingCharSkillsTable(PChar);
        BuildingCharAbilityTable(PChar);
        BuildingCharTraitsTable(PChar);

        // Order matters as this uses merits and JP gifts.
        puppetutils::LoadAutomaton(PChar);

        PChar->animation = (HP == 0 ? ANIMATION_DEATH : ANIMATION_NONE);

        PChar->StatusEffectContainer->LoadStatusEffects();

        charutils::LoadEquip(PChar);
        charutils::EmptyRecycleBin(PChar);
        bool canRestore  = zoneutils::IsResidentialArea(PChar) && HP > 0;
        PChar->health.hp = canRestore ? PChar->GetMaxHP() : HP;
        PChar->health.mp = canRestore ? PChar->GetMaxMP() : MP;
        PChar->UpdateHealth();

        luautils::OnZoneIn(PChar);
        luautils::OnGameIn(PChar, zoning == 1);

        PChar->status = STATUS_TYPE::DISAPPEAR;

        return PChar;
    }

    void LoadSpells(CCharEntity* PChar)
    {
        TracyZoneScoped;

        // disable all spells
        PChar->m_SpellList.reset();

        // Compile a list of all enabled expansions
        std::vector<std::string> enabledExpansions;
        for (auto const& expansion : { "COP", "TOAU", "WOTG", "ACP", "AMK", "ASA", "ABYSSEA", "SOA", "ROV", "TVR", "VOIDWATCH" })
        {
            if (luautils::IsContentEnabled(expansion))
            {
                enabledExpansions.push_back(fmt::format("\"{}\"", expansion));
            }
        }

        // Select all player spells from enabled expansions
        auto query = fmt::format("SELECT char_spells.spellid "
                                 "FROM char_spells "
                                 "JOIN spell_list "
                                 "ON spell_list.spellid = char_spells.spellid "
                                 "WHERE charid = (?) AND "
                                 "(spell_list.content_tag IN ({}) OR "
                                 "spell_list.content_tag IS NULL)",
                                 fmt::join(enabledExpansions, ","));

        auto rset = db::preparedStmt(query, PChar->id);
        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                uint16 spellId = rset->get<uint16>("spellid");
                if (spell::GetSpell(static_cast<SpellID>(spellId)) != nullptr)
                {
                    PChar->m_SpellList.set(spellId);
                }
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Download Character inventory                                         *
     *                                                                       *
     ************************************************************************/

    void LoadInventory(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* query = "SELECT "
                            "itemid, "
                            "location, "
                            "slot, "
                            "quantity, "
                            "bazaar, "
                            "signature, "
                            "extra "
                            "FROM char_inventory "
                            "WHERE charid = (?) "
                            "ORDER BY FIELD(location,0,1,9,2,3,4,5,6,7,8,10,11,12)";

        auto rset = db::preparedStmt(query, PChar->id);
        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                CItem* PItem = itemutils::GetItem(rset->get<uint16>("itemid"));
                if (PItem != nullptr)
                {
                    PItem->setLocationID(rset->get<uint8>("location"));
                    PItem->setSlotID(rset->get<uint8>("slot"));
                    PItem->setQuantity(rset->get<uint32>("quantity"));
                    PItem->setCharPrice(rset->get<uint32>("bazaar"));

                    db::extractFromBlob(rset, "extra", PItem->m_extra);

                    if (PItem->getCharPrice() != 0)
                    {
                        PItem->setSubType(ITEM_LOCKED);
                    }

                    if (PItem->isType(ITEM_LINKSHELL))
                    {
                        if (static_cast<CItemLinkshell*>(PItem)->GetLSType() == 0)
                        {
                            static_cast<CItemLinkshell*>(PItem)->SetLSType((LSTYPE)(PItem->getID() - 0x200));
                        }
                        char EncodedString[LinkshellStringLength] = {};
                        EncodeStringLinkshell(rset->get<std::string>("signature").c_str(), EncodedString);
                        PItem->setSignature(EncodedString);
                    }
                    else if (PItem->getFlag() & (ITEM_FLAG_INSCRIBABLE))
                    {
                        char EncodedString[SignatureStringLength] = {};
                        EncodeStringSignature(rset->get<std::string>("signature").c_str(), EncodedString);
                        PItem->setSignature(EncodedString);
                    }

                    if (PItem->isType(ITEM_FURNISHING) && (PItem->getLocationID() == LOC_MOGSAFE || PItem->getLocationID() == LOC_MOGSAFE2))
                    {
                        if (((CItemFurnishing*)PItem)->isInstalled()) // Check if furniture (furnishing) item is actually installed
                        {
                            PChar->getStorage(LOC_STORAGE)->AddBuff(((CItemFurnishing*)PItem)->getStorage());
                        }
                    }
                    PChar->getStorage(PItem->getLocationID())->InsertItem(PItem, PItem->getSlotID());
                }
            }
        }

        // apply augments
        // loop over each container
        for (uint8 i = 0; i < CONTAINER_ID::MAX_CONTAINER_ID; ++i)
        {
            CItemContainer* PItemContainer = PChar->getStorage(i);

            if (PItemContainer != nullptr)
            {
                // now find each item in the container
                for (uint8 y = 0; y < MAX_CONTAINER_SIZE; ++y)
                {
                    CItem* PItem = PItemContainer->GetItem(y);

                    // check if the item is valid and can have an augment applied to it
                    if (PItem != nullptr && ((PItem->isType(ITEM_EQUIPMENT) || PItem->isType(ITEM_WEAPON)) && !PItem->isSubType(ITEM_CHARGED)))
                    {
                        // check if there are any valid augments to be applied to the item
                        for (uint8 j = 0; j < 4; ++j)
                        {
                            // found a match, apply the augment
                            if (((CItemEquipment*)PItem)->getAugment(j) != 0)
                            {
                                ((CItemEquipment*)PItem)->ApplyAugment(j);
                            }
                        }
                    }
                }
            }
        }
    }

    void LoadEquip(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "SELECT "
                            "slotid,"
                            "equipslotid,"
                            "containerid "
                            "FROM char_equip "
                            "WHERE charid = (?)";

        auto rset = db::preparedStmt(Query, PChar->id);
        if (rset)
        {
            // equipSlotData[equipSlotId] = { slotId, containerId }
            std::map<uint8, std::pair<uint8, uint8>> equipSlotData;

            // NOTE: This data is stored in the above map since if the item has an augment, another db
            // query will occur, which will destroy the current query results.
            while (rset->next())
            {
                uint8 equipSlotId          = rset->get<uint8>("equipslotid");
                uint8 slotId               = rset->get<uint8>("slotid");
                uint8 containerId          = rset->get<uint8>("containerid");
                equipSlotData[equipSlotId] = { slotId, containerId };
            }

            CItemLinkshell* PLinkshell1   = nullptr;
            CItemLinkshell* PLinkshell2   = nullptr;
            bool            hasMainWeapon = false;

            for (auto const& [equipSlotId, inventoryLoc] : equipSlotData)
            {
                if (equipSlotId < 16)
                {
                    if (equipSlotId == SLOT_MAIN)
                    {
                        hasMainWeapon = true;
                    }

                    EquipItem(PChar, inventoryLoc.first, equipSlotId, inventoryLoc.second);
                }
                else
                {
                    CItem* PItem = PChar->getStorage(inventoryLoc.second)->GetItem(inventoryLoc.first);

                    if ((PItem != nullptr) && PItem->isType(ITEM_LINKSHELL))
                    {
                        PItem->setSubType(ITEM_LOCKED);
                        PChar->equip[equipSlotId]    = inventoryLoc.first;
                        PChar->equipLoc[equipSlotId] = inventoryLoc.second;
                        if (equipSlotId == SLOT_LINK1)
                        {
                            PLinkshell1 = (CItemLinkshell*)PItem;
                        }
                        else if (equipSlotId == SLOT_LINK2)
                        {
                            PLinkshell2 = (CItemLinkshell*)PItem;
                        }
                    }
                }
            }

            // If no weapon is equipped, equip the appropriate unarmed weapon item
            if (!hasMainWeapon)
            {
                CheckUnarmedWeapon(PChar);
            }

            if (PLinkshell1)
            {
                rset = db::preparedStmt("SELECT broken FROM linkshells WHERE linkshellid = (?) LIMIT 1", PLinkshell1->GetLSID());
                if (rset && rset->rowsCount() && rset->next() && rset->get<uint32>("broken") == 1)
                { // if the linkshell has been broken, unequip
                    uint8 SlotID     = PLinkshell1->getSlotID();
                    uint8 LocationID = PLinkshell1->getLocationID();
                    PLinkshell1->setSubType(ITEM_UNLOCKED);
                    PChar->equip[SLOT_LINK1] = 0;
                    db::query(fmt::format("DELETE char_equip FROM char_equip WHERE charid = {} AND slotid = {} AND containerid = {}",
                                          PChar->id, SlotID, LocationID));
                }
                else
                {
                    linkshell::AddOnlineMember(PChar, PLinkshell1, 1);
                }
            }

            if (PLinkshell2)
            {
                rset = db::preparedStmt("SELECT broken FROM linkshells WHERE linkshellid = (?) LIMIT 1", PLinkshell2->GetLSID());
                if (rset && rset->rowsCount() && rset->next() && rset->get<uint32>("broken") == 1)
                { // if the linkshell has been broken, unequip
                    uint8 SlotID     = PLinkshell2->getSlotID();
                    uint8 LocationID = PLinkshell2->getLocationID();
                    PLinkshell2->setSubType(ITEM_UNLOCKED);
                    PChar->equip[SLOT_LINK2] = 0;
                    db::query(fmt::format("DELETE char_equip FROM char_equip WHERE charid = {} AND slotid = {} AND containerid = {}",
                                          PChar->id, SlotID, LocationID));
                }
                else
                {
                    linkshell::AddOnlineMember(PChar, PLinkshell2, 2);
                }
            }
        }
        else
        {
            ShowError("Loading error from char_equip");
        }

        // Fill in the unarmed psuedo-weapons if no item was equipped
        if (PChar->m_Weapons[SLOT_MAIN] == nullptr)
        {
            CheckUnarmedWeapon(PChar);
        }
    }

    /************************************************************************
     *                                                                       *
     *  Send lists of current / completed quests and missions.               *
     *                                                                       *
     ************************************************************************/

    void SendQuestMissionLog(CCharEntity* PChar)
    {
        // Quests (Current + Completed):
        // --------------------------------
        for (int8 areaID = 0; areaID <= QUESTS_COALITION; areaID++)
        {
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, areaID, LOG_QUEST_CURRENT);
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, areaID, LOG_QUEST_COMPLETE);
        }

        // Completed Missions:
        // --------------------------------
        // Completed missions for Nation + Zilart Missions are all sent in single packet
        PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_ZILART, LOG_MISSION_COMPLETE);

        // Completed missions for TOAU and WOTG are sent in the same packet
        PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_TOAU, LOG_MISSION_COMPLETE);

        // Completed Assaults were sent in the same packet as completed TOAU quests

        // Completed Campaign Operations
        PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_CAMPAIGN, LOG_MISSION_COMPLETE);
        PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_CAMPAIGN, LOG_CAMPAIGN_TWO);

        // Current Missions:
        // --------------------------------
        // Current TOAU, Assault, WOTG, and Campaign mission were sent in the same packet as current TOAU quests

        // Current Nation, Zilart, COP, Add-On, SOA, and ROV missions are all sent in a shared, single packet.
        // So sending this packet updates multiple Mission logs at once.
        PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_ZILART, LOG_MISSION_CURRENT);
    }

    /************************************************************************
     *                                                                       *
     *  Send lists of character key items                                    *
     *                                                                       *
     ************************************************************************/

    void SendKeyItems(CCharEntity* PChar)
    {
        for (uint8 table = 0; table < MAX_KEYS_TABLE; table++)
        {
            PChar->pushPacket<CKeyItemsPacket>(PChar, (KEYS_TABLE)table);
        }
    }

    /************************************************************************
     *                                                                       *
     *  Send the character all its inventory                                 *
     *                                                                       *
     ************************************************************************/

    void SendInventory(CCharEntity* PChar)
    {
        auto pushContainer = [&](auto LocationID)
        {
            CItemContainer* container = PChar->getStorage(LocationID);
            if (container == nullptr)
            {
                return;
            }

            uint8 size = container->GetSize();
            for (uint8 slotID = 0; slotID <= size; ++slotID)
            {
                CItem* PItem = PChar->getStorage(LocationID)->GetItem(slotID);
                if (PItem != nullptr)
                {
                    PChar->pushPacket<CInventoryItemPacket>(PItem, LocationID, slotID);
                }
            }
        };

        // Send important items first
        // Note: it's possible that non-essential inventory items are sent in response to another packet

        // TODO: What order are these sent in?
        for (auto&& containerID : { LOC_INVENTORY, LOC_TEMPITEMS, LOC_WARDROBE, LOC_WARDROBE2, LOC_WARDROBE3, LOC_WARDROBE4,
                                    LOC_WARDROBE5, LOC_WARDROBE6, LOC_WARDROBE7, LOC_WARDROBE8,
                                    LOC_MOGSAFE, LOC_STORAGE,
                                    LOC_MOGLOCKER, LOC_MOGSATCHEL, LOC_MOGSACK, LOC_MOGCASE, LOC_MOGSAFE2 })
        {
            pushContainer(containerID);
        }

        for (int32 i = 0; i < 16; ++i)
        {
            CItem* PItem = PChar->getEquip((SLOTTYPE)i);
            if (PItem != nullptr)
            {
                PItem->setSubType(ITEM_LOCKED);
                PChar->pushPacket<CInventoryAssignPacket>(PItem, INV_NODROP);
            }
        }

        CItem* PItem = PChar->getEquip(SLOT_LINK1);
        if (PItem != nullptr)
        {
            PItem->setSubType(ITEM_LOCKED);

            PChar->pushPacket<CInventoryItemPacket>(PItem, PChar->equipLoc[SLOT_LINK1], PChar->equip[SLOT_LINK1]);
            PChar->pushPacket<CInventoryAssignPacket>(PItem, INV_LINKSHELL);
            PChar->pushPacket<CLinkshellEquipPacket>(PChar, 1);
        }

        PItem = PChar->getEquip(SLOT_LINK2);
        if (PItem != nullptr)
        {
            PItem->setSubType(ITEM_LOCKED);

            PChar->pushPacket<CInventoryItemPacket>(PItem, PChar->equipLoc[SLOT_LINK2], PChar->equip[SLOT_LINK2]);
            PChar->pushPacket<CInventoryAssignPacket>(PItem, INV_LINKSHELL);
            PChar->pushPacket<CLinkshellEquipPacket>(PChar, 2);
        }

        PChar->pushPacket<CInventoryFinishPacket>(); // "Finish" type
    }

    /************************************************************************
     *                                                                       *
     *  Add a new item to the character in the selected container            *
     *                                                                       *
     ************************************************************************/

    uint8 AddItem(CCharEntity* PChar, uint8 LocationID, uint16 ItemID, uint32 quantity, bool silence)
    {
        if (PChar->getStorage(LocationID)->GetFreeSlotsCount() == 0 || quantity == 0)
        {
            return ERROR_SLOTID;
        }

        CItem* PItem = itemutils::GetItem(ItemID);

        if (PItem != nullptr)
        {
            PItem->setQuantity(quantity);
            return AddItem(PChar, LocationID, PItem, silence);
        }
        ShowWarning("charplugin::AddItem: Item <%i> is not found in a database", ItemID);
        return ERROR_SLOTID;
    }

    /************************************************************************
     *                                                                       *
     *  Add a new item to the character in the selected container            *
     *                                                                       *
     ************************************************************************/

    uint8 AddItem(CCharEntity* PChar, uint8 LocationID, CItem* PItem, bool silence)
    {
        if (PItem->isType(ITEM_CURRENCY))
        {
            UpdateItem(PChar, LocationID, 0, PItem->getQuantity());
            destroy(PItem);
            return 0;
        }

        if (PItem->getFlag() & ITEM_FLAG_RARE)
        {
            if (HasItem(PChar, PItem->getID()))
            {
                if (!silence)
                {
                    PChar->pushPacket<CMessageStandardPacket>(PChar, PItem->getID(), 0, MsgStd::ItemEx);
                }
                destroy(PItem);
                return ERROR_SLOTID;
            }
        }

        uint8 SlotID = PChar->getStorage(LocationID)->InsertItem(PItem);

        if (SlotID != ERROR_SLOTID)
        {
            const char* Query = "INSERT INTO char_inventory("
                                "charid,"
                                "location,"
                                "slot,"
                                "itemId,"
                                "quantity,"
                                "signature,"
                                "extra) "
                                "VALUES(%u,%u,%u,%u,%u,'%s','%s')";

            char signature[DecodeStringLength];
            if (PItem->isType(ITEM_LINKSHELL))
            {
                DecodeStringLinkshell(PItem->getSignature().c_str(), signature);
            }
            else
            {
                DecodeStringSignature(PItem->getSignature().c_str(), signature);
            }

            char extra[sizeof(PItem->m_extra) * 2 + 1];
            _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

            if (_sql->Query(Query, PChar->id, LocationID, SlotID, PItem->getID(), PItem->getQuantity(), signature, extra) == SQL_ERROR)
            {
                ShowError("charplugin::AddItem: Cannot insert item to database");
                PChar->getStorage(LocationID)->InsertItem(nullptr, SlotID);
                destroy(PItem);
                return ERROR_SLOTID;
            }
            PChar->pushPacket<CInventoryItemPacket>(PItem, LocationID, SlotID);
            PChar->pushPacket<CInventoryFinishPacket>();
        }
        else
        {
            ShowDebug("charplugin::AddItem: Location %i is full", LocationID);
            destroy(PItem);
        }
        return SlotID;
    }

    /************************************************************************
     *                                                                       *
     *  Check the availability of the item from the character                *
     *                                                                       *
     ************************************************************************/

    bool HasItem(CCharEntity* PChar, uint16 ItemID)
    {
        if (ItemID == 0)
        {
            return false;
        }
        for (uint8 LocID = 0; LocID < CONTAINER_ID::MAX_CONTAINER_ID; ++LocID)
        {
            if (PChar->getStorage(LocID)->SearchItem(ItemID) != ERROR_SLOTID)
            {
                return true;
            }
        }
        return false;
    }

    uint32 getItemCount(CCharEntity* PChar, uint16 ItemID)
    {
        if (ItemID == 0)
        {
            return false;
        }

        uint32 itemCount = 0;
        for (uint8 LocID = 0; LocID < CONTAINER_ID::MAX_CONTAINER_ID; ++LocID)
        {
            CItemContainer* PItemContainer = PChar->getStorage(LocID);
            // clang-format off
            PItemContainer->ForEachItem([&ItemID, &itemCount](CItem* PItem)
            {
                if (PItem->getID() == ItemID)
                {
                    itemCount += PItem->getQuantity();
                }
            });
            // clang-format on
        }

        return itemCount;
    }

    void UpdateSubJob(CCharEntity* PChar)
    {
        jobpointutils::RefreshGiftMods(PChar);
        charutils::BuildingCharSkillsTable(PChar);
        charutils::CalculateStats(PChar);
        charutils::CheckValidEquipment(PChar);
        PChar->PRecastContainer->ChangeJob();
        charutils::BuildingCharAbilityTable(PChar);
        charutils::BuildingCharTraitsTable(PChar);

        PChar->UpdateHealth();
        PChar->health.hp = PChar->GetMaxHP();
        PChar->health.mp = PChar->GetMaxMP();

        charutils::SaveCharStats(PChar);
        charutils::SaveCharJob(PChar, PChar->GetMJob());
        charutils::SaveCharExp(PChar, PChar->GetMJob());
        PChar->updatemask |= UPDATE_HP;

        PChar->pushPacket<CCharJobsPacket>(PChar);
        PChar->pushPacket<CCharStatsPacket>(PChar);
        PChar->pushPacket<CCharSkillsPacket>(PChar);
        PChar->pushPacket<CCharRecastPacket>(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
        PChar->pushPacket<CCharStatusPacket>(PChar);
        PChar->pushPacket<CMenuMeritPacket>(PChar);
        PChar->pushPacket<CMonipulatorPacket1>(PChar);
        PChar->pushPacket<CMonipulatorPacket2>(PChar);
        PChar->pushPacket<CCharSyncPacket>(PChar);
    }

    /************************************************************************
     *                                                                       *
     *  Move the object to the specified cells or the first empty            *
     *                                                                       *
     ************************************************************************/

    uint8 MoveItem(CCharEntity* PChar, uint8 LocationID, uint8 SlotID, uint8 NewSlotID)
    {
        CItemContainer* PItemContainer = PChar->getStorage(LocationID);

        if (PItemContainer->GetFreeSlotsCount() != 0)
        {
            if (NewSlotID == ERROR_SLOTID)
            {
                NewSlotID = PItemContainer->InsertItem(PItemContainer->GetItem(SlotID));
            }
            else
            {
                if (PItemContainer->GetItem(NewSlotID) != nullptr)
                {
                    NewSlotID = ERROR_SLOTID;
                }
            }
            if (NewSlotID != ERROR_SLOTID)
            {
                const char* Query = "UPDATE char_inventory "
                                    "SET slot = %u "
                                    "WHERE charid = %u AND location = %u AND slot = %u";

                if (_sql->Query(Query, NewSlotID, PChar->id, LocationID, SlotID) != SQL_ERROR && _sql->AffectedRows() != 0)
                {
                    PItemContainer->InsertItem(nullptr, SlotID);

                    PChar->pushPacket<CInventoryItemPacket>(nullptr, LocationID, SlotID);
                    PChar->pushPacket<CInventoryItemPacket>(PItemContainer->GetItem(NewSlotID), LocationID, NewSlotID);
                    return NewSlotID;
                }
                PItemContainer->InsertItem(nullptr, NewSlotID); // We cancel all changes in the container
            }
        }
        ShowError("charutils::MoveItem: item can't be moved");
        return ERROR_SLOTID;
    }

    /************************************************************************
     *                                                                       *
     *  Update the number of items in the specified container and slot       *
     *                                                                       *
     ************************************************************************/

    uint32 UpdateItem(CCharEntity* PChar, uint8 LocationID, uint8 slotID, int32 quantity, bool force)
    {
        CItem* PItem = PChar->getStorage(LocationID)->GetItem(slotID);

        if (PItem == nullptr)
        {
            ShowDebug("UpdateItem: No item in slot %u", slotID);
            PChar->pushPacket<CInventoryItemPacket>(nullptr, LocationID, slotID);
            return 0;
        }

        uint16 ItemID = PItem->getID();

        if ((int32)(PItem->getQuantity() - PItem->getReserve() + quantity) < 0)
        {
            ShowDebug("UpdateItem: %s trying to move invalid quantity %u of itemID %u", PChar->getName(), quantity, ItemID);
            return 0;
        }

        auto* PState = dynamic_cast<CItemState*>(PChar->PAI->GetCurrentState());
        if (PState)
        {
            CItem* item = PState->GetItem();

            if (item && item->getSlotID() == PItem->getSlotID() && item->getLocationID() == PItem->getLocationID() && !force)
            {
                return 0;
            }
        }

        uint32 newQuantity = PItem->getQuantity() + quantity;

        if (newQuantity > PItem->getStackSize())
        {
            newQuantity = PItem->getStackSize();
        }

        if (newQuantity > 0 || PItem->isType(ITEM_CURRENCY))
        {
            const char* Query = "UPDATE char_inventory "
                                "SET quantity = %u "
                                "WHERE charid = %u AND location = %u AND slot = %u";

            if (_sql->Query(Query, newQuantity, PChar->id, LocationID, slotID) != SQL_ERROR)
            {
                PItem->setQuantity(newQuantity);
                PChar->pushPacket<CInventoryModifyPacket>(LocationID, slotID, newQuantity);
            }
        }
        else if (newQuantity == 0)
        {
            const char* Query = "DELETE FROM char_inventory WHERE charid = %u AND location = %u AND slot = %u";

            if (_sql->Query(Query, PChar->id, LocationID, slotID) != SQL_ERROR)
            {
                PChar->getStorage(LocationID)->InsertItem(nullptr, slotID);
                PChar->pushPacket<CInventoryItemPacket>(nullptr, LocationID, slotID);

                if (PChar->getStyleLocked() && !HasItem(PChar, ItemID))
                {
                    if (PItem->isType(ITEM_WEAPON))
                    {
                        if (PChar->styleItems[SLOT_MAIN] == ItemID)
                        {
                            charutils::UpdateWeaponStyle(PChar, SLOT_MAIN, (CItemWeapon*)PChar->getEquip(SLOT_MAIN));
                        }
                        else if (PChar->styleItems[SLOT_SUB] == ItemID)
                        {
                            charutils::UpdateWeaponStyle(PChar, SLOT_SUB, (CItemWeapon*)PChar->getEquip(SLOT_SUB));
                        }
                    }
                    else if (PItem->isType(ITEM_EQUIPMENT))
                    {
                        auto equipSlotID = ((CItemEquipment*)PItem)->getSlotType();
                        if (PChar->styleItems[equipSlotID] == ItemID)
                        {
                            switch (equipSlotID)
                            {
                                case SLOT_HEAD:
                                case SLOT_BODY:
                                case SLOT_HANDS:
                                case SLOT_LEGS:
                                case SLOT_FEET:
                                    charutils::UpdateArmorStyle(PChar, equipSlotID);
                                    break;
                            }
                        }
                    }
                }
                luautils::OnItemDrop(PChar, PItem);
                destroy(PItem);
            }
        }
        return ItemID;
    }

    // A wrapper around UpdateItem, with some packets
    void DropItem(CCharEntity* PChar, uint8 container, uint8 slotID, int32 quantity, uint16 ItemID)
    {
        if (charutils::UpdateItem(PChar, container, slotID, -quantity) != 0)
        {
            ShowInfo("Player %s DROPPING itemID: %s (%u) quantity: %u", PChar->getName(), itemutils::GetItemPointer(ItemID)->getName(), ItemID, quantity);
            PChar->pushPacket<CMessageStandardPacket>(nullptr, ItemID, quantity, MsgStd::ThrowAway);
            PChar->pushPacket<CInventoryFinishPacket>();
        }
    }

    /************************************************************************
     *                                                                       *
     *  Check the possibility of trade between characters                    *
     *                                                                       *
     ************************************************************************/

    bool CanTrade(CCharEntity* PChar, CCharEntity* PTarget)
    {
        if (PChar->m_PMonstrosity != nullptr || PTarget->m_PMonstrosity != nullptr)
        {
            return false;
        }

        if (PTarget->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() < PChar->UContainer->GetItemsCount())
        {
            ShowDebug("Unable to trade, %s doesn't have enough inventory space", PTarget->getName());
            return false;
        }

        for (uint8 slotid = 0; slotid <= 8; ++slotid)
        {
            CItem* PItem = PChar->UContainer->GetItem(slotid);

            if (PItem != nullptr && PItem->getFlag() & ITEM_FLAG_RARE)
            {
                if (HasItem(PTarget, PItem->getID()))
                {
                    ShowDebug("Unable to trade, %s has the rare item already (%s)", PTarget->getName(), PItem->getName());
                    return false;
                }
            }
        }

        return true;
    }

    /************************************************************************
     *                                                                       *
     *  Do the exchange between characters                                   *
     *                                                                       *
     ************************************************************************/

    void DoTrade(CCharEntity* PChar, CCharEntity* PTarget)
    {
        ShowDebug("%s->%s trade item movement started", PChar->getName(), PTarget->getName());
        for (uint8 slotid = 0; slotid <= 8; ++slotid)
        {
            CItem* PItem = PChar->UContainer->GetItem(slotid);

            if (PItem != nullptr)
            {
                if (PItem->getStackSize() == 1 && PItem->getReserve() == 1)
                {
                    CItem* PNewItem = itemutils::GetItem(PItem);
                    ShowDebug("Adding %s to %s inventory stacksize 1", PNewItem->getName(), PTarget->getName());
                    PNewItem->setReserve(0);
                    AddItem(PTarget, LOC_INVENTORY, PNewItem);
                }
                else
                {
                    ShowDebug("Adding %s to %s inventory", PItem->getName(), PTarget->getName());
                    AddItem(PTarget, LOC_INVENTORY, PItem->getID(), PItem->getReserve());
                }
                ShowDebug("Removing %s from %s's inventory", PItem->getName(), PChar->getName());
                auto amount = PItem->getReserve();
                PItem->setReserve(0);
                UpdateItem(PChar, LOC_INVENTORY, PItem->getSlotID(), (int32)(0 - amount));
                PChar->UContainer->ClearSlot(slotid);
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Remove equipped item from character without updating the external    *
     *  species (used as an auxiliary function in a bundle with others)      *
     *                                                                       *
     ************************************************************************/

    void UnequipItem(CCharEntity* PChar, uint8 equipSlotID, bool update)
    {
        CItem* PItem = PChar->getEquip((SLOTTYPE)equipSlotID);

        if ((PItem != nullptr) && PItem->isType(ITEM_EQUIPMENT))
        {
            // if removeSlotLookID is available it should be prioritized as it will encompass a larger set of slots
            auto removeSlotLookID = ((CItemEquipment*)PItem)->getRemoveSlotLookId();
            auto removeSlotID     = removeSlotLookID > 0 ? removeSlotLookID : ((CItemEquipment*)PItem)->getRemoveSlotId();

            // When unequipping an item, revert all associated look slots to either default or the item which is equipped
            for (auto i = 0u; i < sizeof(removeSlotID) * 8; ++i)
            {
                if (removeSlotID & (1 << i))
                {
                    if (i >= SLOT_HEAD && i <= SLOT_FEET)
                    {
                        int             itemLook     = 0;
                        CItemEquipment* equippedItem = PChar->getEquip((SLOTTYPE)i);
                        if (equippedItem)
                        {
                            itemLook = equippedItem->getModelId();
                        }

                        switch (i)
                        {
                            case SLOT_HEAD:
                                PChar->look.head = itemLook;
                                break;
                            case SLOT_BODY:
                                PChar->look.body = itemLook;
                                break;
                            case SLOT_HANDS:
                                PChar->look.hands = itemLook;
                                break;
                            case SLOT_LEGS:
                                PChar->look.legs = itemLook;
                                break;
                            case SLOT_FEET:
                                PChar->look.feet = itemLook;
                                break;
                        }
                    }
                }
            }

            // Call the LUA event before actually "unequipping" the item so the script can do stuff with it first
            if (((CItemEquipment*)PItem)->getScriptType() & SCRIPT_EQUIP || ((CItemEquipment*)PItem)->isType(ITEM_USABLE))
            {
                luautils::OnItemCheck(PChar, PItem, ITEMCHECK::UNEQUIP, nullptr);
            }

            // todo: issues as item 0 reference is being handled as a real equipment piece
            //      thought to be source of nin bug
            PChar->equip[equipSlotID]    = 0;
            PChar->equipLoc[equipSlotID] = 0;

            if (((CItemEquipment*)PItem)->getScriptType() & SCRIPT_EQUIP)
            {
                PChar->m_EquipFlag = 0;
                for (uint8 i = 0; i < 16; ++i)
                {
                    CItem* PSlotItem = PChar->getEquip(static_cast<SLOTTYPE>(i));

                    if ((PSlotItem != nullptr) && PSlotItem->isType(ITEM_EQUIPMENT))
                    {
                        PChar->m_EquipFlag |= (static_cast<CItemEquipment*>(PSlotItem))->getScriptType();
                    }
                }
            }

            if (PItem->isSubType(ITEM_CHARGED))
            {
                PChar->PRecastContainer->Del(RECAST_ITEM, PItem->getSlotID() << 8 |
                                                              PItem->getLocationID()); // Also remove item from the Recast List no matter what bag its in
            }
            PItem->setSubType(ITEM_UNLOCKED);

            if (equipSlotID == SLOT_SUB)
            {
                // Removed sub item, if main hand is empty, then possibly eligible for H2H weapon
                if (!PChar->getEquip(SLOT_MAIN) || !PChar->getEquip(SLOT_MAIN)->isType(ITEM_EQUIPMENT))
                {
                    CheckUnarmedWeapon(PChar);
                }
                PChar->m_dualWield = false;
            }
            PChar->delEquipModifiers(&((CItemEquipment*)PItem)->modList, ((CItemEquipment*)PItem)->getReqLvl(), equipSlotID);
            PChar->PLatentEffectContainer->DelLatentEffects(((CItemEquipment*)PItem)->getReqLvl(), equipSlotID);
            PChar->delPetModifiers(&((CItemEquipment*)PItem)->petModList);

            PChar->pushPacket<CInventoryAssignPacket>(PItem, INV_NORMAL); // ???
            PChar->pushPacket<CEquipPacket>(0, equipSlotID, LOC_INVENTORY);

            switch (equipSlotID)
            {
                case SLOT_HEAD:
                    PChar->look.head = 0;
                    break;
                case SLOT_BODY:
                    PChar->look.body = 0;
                    break;
                case SLOT_HANDS:
                    PChar->look.hands = 0;
                    break;
                case SLOT_LEGS:
                    PChar->look.legs = 0;
                    break;
                case SLOT_FEET:
                    PChar->look.feet = 0;
                    break;
                case SLOT_SUB:
                {
                    PChar->look.sub            = 0;
                    PChar->m_Weapons[SLOT_SUB] = itemutils::GetUnarmedItem(); // << equips "nothing" in the sub slot to prevent multi attack exploit
                    PChar->health.tp           = 0;
                    PChar->StatusEffectContainer->DelStatusEffect(EFFECT_AFTERMATH);
                    BuildingCharWeaponSkills(PChar);
                    UpdateWeaponStyle(PChar, equipSlotID, nullptr);
                }
                break;
                case SLOT_AMMO:
                {
                    if (PChar->equip[SLOT_RANGED] == 0)
                    {
                        PChar->look.ranged = 0;
                    }
                    PChar->m_Weapons[SLOT_AMMO] = nullptr;
                    UpdateWeaponStyle(PChar, equipSlotID, nullptr);
                }
                break;
                case SLOT_RANGED:
                {
                    if (PChar->equip[SLOT_RANGED] == 0)
                    {
                        PChar->look.ranged = 0;
                    }
                    PChar->m_Weapons[SLOT_RANGED] = nullptr;
                    if (((CItemWeapon*)PItem)->getSkillType() != SKILL_STRING_INSTRUMENT && ((CItemWeapon*)PItem)->getSkillType() != SKILL_WIND_INSTRUMENT)
                    {
                        PChar->health.tp = 0;
                        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_AFTERMATH);
                    }
                    BuildingCharWeaponSkills(PChar);
                    UpdateWeaponStyle(PChar, equipSlotID, nullptr);
                }
                break;
                case SLOT_MAIN:
                {
                    if (PItem->isType(ITEM_WEAPON))
                    {
                        CItemEquipment* PSub = PChar->getEquip(SLOT_SUB);

                        if (static_cast<CItemWeapon*>(PItem)->getSkillType() == SKILL_HAND_TO_HAND)
                        {
                            PChar->look.sub = 0;
                        }
                        else if (!PSub)
                        {
                            PChar->look.sub = 0;
                        }
                    }

                    if (PChar->PAI->IsEngaged())
                    {
                        auto* state = dynamic_cast<CAttackState*>(PChar->PAI->GetCurrentState());
                        if (state)
                        {
                            state->ResetAttackTimer();
                        }
                    }

                    // If main hand is empty, figure out which UnarmedItem to give the player.
                    if (!PChar->getEquip(SLOT_MAIN) || !PChar->getEquip(SLOT_MAIN)->isType(ITEM_EQUIPMENT))
                    {
                        CheckUnarmedWeapon(PChar);
                    }

                    PChar->health.tp = 0;
                    PChar->StatusEffectContainer->DelStatusEffect(EFFECT_AFTERMATH);
                    BuildingCharWeaponSkills(PChar);
                    UpdateWeaponStyle(PChar, equipSlotID, nullptr);
                }
                break;
            }

            luautils::OnItemUnequip(PChar, PItem);

            if (update)
            {
                charutils::BuildingCharSkillsTable(PChar);
                PChar->UpdateHealth();
                PChar->m_EquipSwap = true;
                PChar->updatemask |= UPDATE_LOOK;

                // Mark container dirty
                PChar->dirtyInventoryContainers[static_cast<CONTAINER_ID>(PItem->getLocationID())] = true;
            }
        }
    }

    bool hasSlotEquipped(CCharEntity* PChar, uint8 equipSlotID)
    {
        CItem* PItem = PChar->getEquip((SLOTTYPE)equipSlotID);
        return PItem != nullptr && PItem->isType(ITEM_EQUIPMENT);
    }

    void RemoveSub(CCharEntity* PChar)
    {
        CItemEquipment* PItem = PChar->getEquip(SLOT_SUB);

        if (PItem != nullptr && PItem->isType(ITEM_EQUIPMENT))
        {
            UnequipItem(PChar, SLOT_SUB);
        }
    }

    /************************************************************************
     *                                                                       *
     *  Try to equip the subject in compliance with all conditions           *
     *                                                                       *
     ************************************************************************/

    bool EquipArmor(CCharEntity* PChar, uint8 slotID, uint8 equipSlotID, uint8 containerID)
    {
        CItemEquipment* PItem   = dynamic_cast<CItemEquipment*>(PChar->getStorage(containerID)->GetItem(slotID));
        CItemEquipment* oldItem = PChar->getEquip((SLOTTYPE)equipSlotID);

        if (PItem == nullptr)
        {
            ShowDebug("No item in inventory slot %u", slotID);
            return false;
        }

        if ((PChar->m_EquipBlock & (1 << equipSlotID)) || !(PItem->getJobs() & (1 << (PChar->GetMJob() - 1))) ||
            (PItem->getSuperiorLevel() > PChar->getMod(Mod::SUPERIOR_LEVEL)) ||
            (PItem->getReqLvl() > (settings::get<bool>("map.DISABLE_GEAR_SCALING") ? PChar->GetMLevel() : PChar->jobs.job[PChar->GetMJob()])) ||
            !PItem->isEquippableByRace(PChar->look.race))
        {
            return false;
        }

        if (equipSlotID == SLOT_MAIN)
        {
            if (!(slotID == PItem->getSlotID() && oldItem && (oldItem->isType(ITEM_WEAPON) && PItem->isType(ITEM_WEAPON)) &&
                  (static_cast<CItemWeapon*>(PItem)->isTwoHanded() && static_cast<CItemWeapon*>(oldItem)->isTwoHanded())))
            {
                CItemEquipment* PSubItem = PChar->getEquip(SLOT_SUB);

                if (PSubItem != nullptr && PSubItem->isType(ITEM_EQUIPMENT) && (!PSubItem->IsShield()))
                {
                    RemoveSub(PChar);
                }
            }
        }

        UnequipItem(PChar, equipSlotID, false);

        // When equipping PItem - Remove all equip in slots which are also restricted by PItem
        // e.g. Equipping a Black Cloak should remove head equipment
        if (PItem->getEquipSlotId() & (1 << equipSlotID))
        {
            auto removeSlotID = PItem->getRemoveSlotId();

            for (auto i = 0u; i < sizeof(removeSlotID) * 8; ++i)
            {
                if (removeSlotID & (1 << i))
                {
                    UnequipItem(PChar, i, false);
                    if (i >= SLOT_HEAD && i <= SLOT_FEET)
                    {
                        switch (i)
                        {
                            case SLOT_HEAD:
                                PChar->look.head = PItem->getModelId();
                                break;
                            case SLOT_BODY:
                                PChar->look.body = PItem->getModelId();
                                break;
                            case SLOT_HANDS:
                                PChar->look.hands = PItem->getModelId();
                                break;
                            case SLOT_LEGS:
                                PChar->look.legs = PItem->getModelId();
                                break;
                            case SLOT_FEET:
                                PChar->look.feet = PItem->getModelId();
                                break;
                        }
                    }
                }
            }

            // When equipping PItem into a slot - Remove equip in other slots which may have restricted equip in this slot
            // e.g. Equipping head equipment should result in the removal of an equipped Black Cloak
            for (uint8 i = 0; i < SLOT_BACK; ++i)
            {
                CItemEquipment* armor = PChar->getEquip((SLOTTYPE)i);
                if (armor && armor->isType(ITEM_EQUIPMENT) && armor->getRemoveSlotId() & PItem->getEquipSlotId())
                {
                    UnequipItem(PChar, i, false);
                }
            }

            switch (equipSlotID)
            {
                case SLOT_MAIN:
                {
                    if (PItem->isType(ITEM_WEAPON))
                    {
                        switch (static_cast<CItemWeapon*>(PItem)->getSkillType())
                        {
                            case SKILL_HAND_TO_HAND:
                            case SKILL_GREAT_SWORD:
                            case SKILL_GREAT_AXE:
                            case SKILL_SCYTHE:
                            case SKILL_POLEARM:
                            case SKILL_GREAT_KATANA:
                            case SKILL_STAFF:
                            {
                                CItemEquipment* sub = PChar->getEquip(SLOT_SUB);
                                if (sub != nullptr && sub->isType(ITEM_EQUIPMENT))
                                {
                                    if (sub->isType(ITEM_WEAPON))
                                    {
                                        CItemWeapon* PWeapon = static_cast<CItemWeapon*>(sub);
                                        if (PWeapon->getSkillType() != SKILL_NONE || static_cast<CItemWeapon*>(PItem)->getSkillType() == SKILL_HAND_TO_HAND)
                                        {
                                            UnequipItem(PChar, SLOT_SUB, false);
                                        }
                                    }
                                    else
                                    {
                                        UnequipItem(PChar, SLOT_SUB, false);
                                    }
                                }
                                if (static_cast<CItemWeapon*>(PItem)->getSkillType() == SKILL_HAND_TO_HAND)
                                {
                                    PChar->look.sub = PItem->getModelId() + 0x1000;
                                }
                            }
                            break;
                        }
                        if (PChar->PAI->IsEngaged())
                        {
                            auto* state = dynamic_cast<CAttackState*>(PChar->PAI->GetCurrentState());
                            if (state)
                            {
                                state->ResetAttackTimer();
                            }
                        }
                        PChar->m_Weapons[SLOT_MAIN] = PItem;
                    }
                    PChar->look.main = PItem->getModelId();
                    UpdateWeaponStyle(PChar, equipSlotID, (CItemWeapon*)PItem);
                }
                break;
                case SLOT_SUB:
                {
                    CItemWeapon* weapon = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_MAIN));
                    // NULL weapon can be unarmed weapon that just got unequipped
                    if (!weapon)
                    {
                        if (PItem->IsShield())
                        {
                            PChar->look.sub = PItem->getModelId();
                            UpdateWeaponStyle(PChar, equipSlotID, PItem);
                            break;
                        }
                        else
                        {
                            return false;
                        }
                    }
                    else
                    {
                        switch (weapon->getSkillType())
                        {
                            case SKILL_HAND_TO_HAND:
                            {
                                if (!PItem->isType(ITEM_WEAPON))
                                {
                                    UnequipItem(PChar, SLOT_MAIN, false);
                                }
                                break;
                            }
                            case SKILL_DAGGER:
                            case SKILL_SWORD:
                            case SKILL_AXE:
                            case SKILL_KATANA:
                            case SKILL_CLUB:
                            {
                                CItemWeapon* PNewItemWeapon = dynamic_cast<CItemWeapon*>(PItem);
                                bool         isWeapon       = PItem->isType(ITEM_WEAPON);

                                if (isWeapon && (!charutils::hasTrait(PChar, TRAIT_DUAL_WIELD) || (PNewItemWeapon && PNewItemWeapon->getSkillType() == SKILL_NONE)))
                                {
                                    return false;
                                }
                                PChar->m_Weapons[SLOT_SUB] = PItem;
                                // only set m_dualWield if equipping a weapon (not for example a shield)
                                if (isWeapon)
                                {
                                    PChar->m_dualWield = true;
                                }
                            }
                            break;
                            default:
                            {
                                if (!PItem->isType(ITEM_WEAPON))
                                {
                                    UnequipItem(PChar, SLOT_MAIN, false);
                                }
                                else if (static_cast<CItemWeapon*>(PItem)->getSkillType() != SKILL_NONE)
                                {
                                    // allow Grips to be equipped
                                    return false;
                                }
                            }
                        }
                    }
                    PChar->look.sub = PItem->getModelId();
                    UpdateWeaponStyle(PChar, equipSlotID, PItem);
                }
                break;
                case SLOT_RANGED:
                {
                    if (PItem->isType(ITEM_WEAPON))
                    {
                        CItemWeapon* weapon = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));
                        if (weapon)
                        {
                            if (static_cast<CItemWeapon*>(PItem)->getSkillType() != weapon->getSkillType() ||
                                static_cast<CItemWeapon*>(PItem)->getSubSkillType() != weapon->getSubSkillType())
                            {
                                UnequipItem(PChar, SLOT_AMMO, false);
                            }
                        }
                        PChar->m_Weapons[SLOT_RANGED] = PItem;
                    }
                    PChar->look.ranged = PItem->getModelId();
                    UpdateWeaponStyle(PChar, equipSlotID, PItem);
                }
                break;
                case SLOT_AMMO:
                {
                    if (PItem->isType(ITEM_WEAPON))
                    {
                        CItemWeapon* weapon = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));
                        if (weapon)
                        {
                            if (static_cast<CItemWeapon*>(PItem)->getSkillType() != weapon->getSkillType() ||
                                static_cast<CItemWeapon*>(PItem)->getSubSkillType() != weapon->getSubSkillType())
                            {
                                UnequipItem(PChar, SLOT_RANGED, false);
                            }
                        }
                        if (PChar->equip[SLOT_RANGED] == 0)
                        {
                            PChar->look.ranged = PItem->getModelId();
                        }
                        PChar->m_Weapons[SLOT_AMMO] = PItem;
                        UpdateWeaponStyle(PChar, equipSlotID, PItem);
                    }
                }
                break;
                case SLOT_HEAD:
                {
                    PChar->look.head = PItem->getModelId();
                }
                break;
                case SLOT_BODY:
                {
                    PChar->look.body = PItem->getModelId();
                }
                break;
                case SLOT_HANDS:
                {
                    PChar->look.hands = PItem->getModelId();
                }
                break;
                case SLOT_LEGS:
                {
                    PChar->look.legs = PItem->getModelId();
                }
                break;
                case SLOT_FEET:
                {
                    PChar->look.feet = PItem->getModelId();
                }
                break;
            }

            PChar->equip[equipSlotID]    = slotID;
            PChar->equipLoc[equipSlotID] = containerID;

            // Changed visible equipment
            if (equipSlotID >= SLOT_HEAD && equipSlotID <= SLOT_FEET)
            {
                UpdateRemovedSlotsLook(PChar);
            }
        }
        else
        {
            ShowWarning("Item %i is not equipable in equip slot %i", PItem->getID(), equipSlotID);
            return false;
        }
        return true;
    }

    bool canEquipItemOnAnyJob(CCharEntity* PChar, CItemEquipment* PItem)
    {
        if (PItem == nullptr)
        {
            return true;
        }

        for (uint8 i = 1; i < MAX_JOBTYPE; i++)
        {
            if (PItem->getJobs() & (1 << (i - 1)) && PItem->getReqLvl() <= PChar->jobs.job[i])
            {
                // TODO: Check for Su level for the player's job, and apply to the condition.
                return true;
            }
        }
        return false;
    }

    bool hasValidStyle(CCharEntity* PChar, CItemEquipment* PItem, CItemEquipment* AItem)
    {
        if (AItem && PItem)
        {
            // Shield special case
            if (AItem->IsShield() && PItem->IsShield())
            {
                return HasItem(PChar, AItem->getID()) && canEquipItemOnAnyJob(PChar, AItem);
            }

            CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(PItem);
            CItemWeapon* AWeapon = dynamic_cast<CItemWeapon*>(AItem);

            if (PWeapon && AWeapon && PWeapon->getSkillType() == AWeapon->getSkillType())
            {
                return HasItem(PChar, AItem->getID()) && canEquipItemOnAnyJob(PChar, AItem);
            }
        }
        return false;
    }

    void SetStyleLock(CCharEntity* PChar, bool isStyleLocked)
    {
        if (isStyleLocked)
        {
            for (uint8 i = 0; i < SLOT_LINK1; i++)
            {
                auto* PItem          = PChar->getEquip((SLOTTYPE)i);
                PChar->styleItems[i] = (PItem == nullptr) ? 0 : PItem->getID();
            }
            std::memcpy(&PChar->mainlook, &PChar->look, sizeof(PChar->look));
        }
        else
        {
            for (unsigned short& styleItem : PChar->styleItems)
            {
                styleItem = 0;
            }
        }

        if (PChar->getStyleLocked() != isStyleLocked)
        {
            PChar->pushPacket<CMessageStandardPacket>(isStyleLocked ? MsgStd::StyleLockOn : MsgStd::StyleLockOff);
        }
        PChar->setStyleLocked(isStyleLocked);
    }

    void UpdateWeaponStyle(CCharEntity* PChar, uint8 equipSlotID, CItemEquipment* PItem)
    {
        if (!PChar->getStyleLocked())
        {
            return;
        }

        CItemEquipment* appearance      = dynamic_cast<CItemEquipment*>(itemutils::GetItemPointer(PChar->styleItems[equipSlotID]));
        uint16          appearanceModel = 0;
        if (appearance)
        {
            appearanceModel = appearance->getModelId();
        }

        switch (equipSlotID)
        {
            case SLOT_MAIN:
                if (hasValidStyle(PChar, PItem, appearance))
                {
                    PChar->mainlook.main = appearanceModel;
                }
                else
                {
                    PChar->mainlook.main = PChar->look.main;
                }

                if (PItem == nullptr)
                {
                    PChar->mainlook.sub = PChar->look.sub;
                }
                else
                {
                    CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(PItem);
                    if (PWeapon)
                    {
                        switch (PWeapon->getSkillType())
                        {
                            case SKILL_HAND_TO_HAND:
                                PChar->mainlook.sub = appearanceModel + 0x1000;
                                break;
                            case SKILL_GREAT_SWORD:
                            case SKILL_GREAT_AXE:
                            case SKILL_SCYTHE:
                            case SKILL_POLEARM:
                            case SKILL_GREAT_KATANA:
                            case SKILL_STAFF:
                                PChar->mainlook.sub = PChar->look.sub;
                                break;
                        }
                    }
                }
                break;
            case SLOT_SUB:
                if (hasValidStyle(PChar, PItem, appearance))
                {
                    PChar->mainlook.sub = appearanceModel;
                }
                else
                {
                    PChar->mainlook.sub = PChar->look.sub;
                }
                break;
            case SLOT_RANGED:
                if (hasValidStyle(PChar, PItem, appearance))
                {
                    PChar->mainlook.ranged = appearanceModel;
                }
                else
                {
                    PChar->mainlook.ranged = PChar->look.ranged;
                }

                break;
            default:
                break;
        }
    }

    void UpdateArmorStyle(CCharEntity* PChar, uint8 equipSlotID)
    {
        if (!PChar->getStyleLocked())
        {
            return;
        }

        uint16          itemID          = PChar->styleItems[equipSlotID];
        CItemEquipment* appearance      = dynamic_cast<CItemEquipment*>(itemutils::GetItemPointer(itemID));
        uint16          appearanceModel = 0;

        if (appearance && HasItem(PChar, itemID))
        {
            appearanceModel = appearance->getModelId();
        }

        if (!canEquipItemOnAnyJob(PChar, appearance))
        {
            return;
        }

        switch (equipSlotID)
        {
            case SLOT_HEAD:
                PChar->mainlook.head = appearanceModel;
                break;
            case SLOT_BODY:
                PChar->mainlook.body = appearanceModel;
                break;
            case SLOT_HANDS:
                PChar->mainlook.hands = appearanceModel;
                break;
            case SLOT_LEGS:
                PChar->mainlook.legs = appearanceModel;
                break;
            case SLOT_FEET:
                PChar->mainlook.feet = appearanceModel;
                break;
        }
    }

    /// <summary>
    /// Updates the Char's lockstyle look to account for gear that occupies multiple slots
    /// This includes items like Black Cloak which restricts the equip AND look of headgear.
    /// This also incluses items like Onca Suit which restricts equip and look of legs, but only look of hands and feet.
    /// </summary>
    /// <param name="PChar">Character to have Lockstyle look updated</param>
    void UpdateRemovedSlotsLookForLockStyle(CCharEntity* PChar)
    {
        if (!PChar || !PChar->getStyleLocked())
        {
            return;
        }

        auto items = PChar->styleItems;
        for (auto i = 0; i < 16; i++)
        {
            if (items[i] == 0)
            {
                continue;
            }

            auto PItem = dynamic_cast<CItemEquipment*>(itemutils::GetItem(items[i]));
            if (!PItem)
            {
                continue;
            }

            auto removeSlotID = PItem->getRemoveSlotLookId();
            if (removeSlotID > 0)
            {
                for (auto i = 4u; i <= 8u; i++)
                {
                    if (removeSlotID & (1 << i))
                    {
                        switch (i)
                        {
                            case SLOT_HEAD:
                                PChar->mainlook.head = PItem->getModelId();
                                break;
                            case SLOT_BODY:
                                PChar->mainlook.body = PItem->getModelId();
                                break;
                            case SLOT_HANDS:
                                PChar->mainlook.hands = PItem->getModelId();
                                break;
                            case SLOT_LEGS:
                                PChar->mainlook.legs = PItem->getModelId();
                                break;
                            case SLOT_FEET:
                                PChar->mainlook.feet = PItem->getModelId();
                                break;
                        }
                    }
                }
            }
        }
    }

    /// <summary>
    /// Updates the Char's look to account for gear that occupies multiple slots
    /// This includes items like Black Cloak which restricts the equip AND look of headgear.
    /// This also incluses items like Onca Suit which restricts equip and look of legs, but only look of hands and feet.
    /// </summary>
    /// <param name="PChar">Character to have look updated</param>
    void UpdateRemovedSlotsLook(CCharEntity* PChar)
    {
        if (!PChar)
        {
            return;
        }

        for (int i = SLOT_HEAD; i < SLOT_FEET; i++)
        {
            CItemEquipment* armor = PChar->getEquip((SLOTTYPE)i);
            if (armor && armor->isType(ITEM_EQUIPMENT) && armor->getRemoveSlotLookId())
            {
                auto removeSlotID = armor->getRemoveSlotLookId();
                for (int j = SLOT_HEAD; j <= SLOT_FEET; j++)
                {
                    if (removeSlotID & (1 << j))
                    {
                        switch (j)
                        {
                            case SLOT_HEAD:
                                PChar->look.head = armor->getModelId();
                                break;
                            case SLOT_BODY:
                                PChar->look.body = armor->getModelId();
                                break;
                            case SLOT_HANDS:
                                PChar->look.hands = armor->getModelId();
                                break;
                            case SLOT_LEGS:
                                PChar->look.legs = armor->getModelId();
                                break;
                            case SLOT_FEET:
                                PChar->look.feet = armor->getModelId();
                                break;
                        }
                    }
                }
            }
        }
    }

    void AddItemToRecycleBin(CCharEntity* PChar, uint32 container, uint8 slotID, uint8 quantity)
    {
        CItem*      PItem          = PChar->getStorage(container)->GetItem(slotID);
        const char* Query          = "UPDATE char_inventory SET location = %u, slot = %u WHERE charid = %u AND location = %u AND slot = %u";
        auto*       RecycleBin     = PChar->getStorage(LOC_RECYCLEBIN);
        auto*       OtherContainer = PChar->getStorage(container);

        if (PItem == nullptr)
        {
            return;
        }

        // Try and insert
        uint8 NewSlotID = PChar->getStorage(LOC_RECYCLEBIN)->InsertItem(PItem);
        if (NewSlotID != ERROR_SLOTID)
        {
            if (_sql->Query(Query, LOC_RECYCLEBIN, NewSlotID, PChar->id, container, slotID) != SQL_ERROR && _sql->AffectedRows() != 0)
            {
                // Move successful, delete original item
                OtherContainer->InsertItem(nullptr, slotID);

                // Send update packets
                PChar->pushPacket<CInventoryItemPacket>(nullptr, container, slotID);
                PChar->pushPacket<CInventoryItemPacket>(PItem, LOC_RECYCLEBIN, NewSlotID);
                PChar->pushPacket<CMessageStandardPacket>(nullptr, PItem->getID(), quantity, MsgStd::ThrowAway);
            }
            else
            {
                // Move not successful, put things back how they were
                RecycleBin->InsertItem(nullptr, NewSlotID);
                OtherContainer->InsertItem(PItem, slotID);
            }
        }
        else // Bin is full
        {
            // Evict recycle bin slot 1
            RecycleBin->InsertItem(nullptr, 1);
            _sql->Query("DELETE FROM char_inventory WHERE charid = %u AND location = %u AND slot = %u",
                        PChar->id, LOC_RECYCLEBIN, 1);

            // Move everything around to accomodate
            for (int i = 2; i <= 10; ++i)
            {
                // Update storage
                CItem* PMovingItem = RecycleBin->GetItem(i);
                RecycleBin->InsertItem(PMovingItem, i - 1);

                // Update db
                if (_sql->Query(Query, LOC_RECYCLEBIN, i - 1, PChar->id, LOC_RECYCLEBIN, i) == SQL_ERROR || _sql->AffectedRows() == 0)
                {
                    ShowError("Problem moving Recycle Bin items! (%s - %s)", PChar->getName(), PItem->getName());
                }
            }

            // Move item from original container to recycle bin
            OtherContainer->InsertItem(nullptr, slotID);
            RecycleBin->InsertItem(PItem, 10);
            if (_sql->Query(Query, LOC_RECYCLEBIN, 10, PChar->id, container, slotID) == SQL_ERROR || _sql->AffectedRows() == 0)
            {
                ShowError("Problem moving Recycle Bin items! (%s - %s)", PChar->getName(), PItem->getName());
            }

            // Send update packets
            PChar->pushPacket<CInventoryItemPacket>(nullptr, container, slotID);
            for (int i = 1; i <= 10; ++i)
            {
                CItem* PUpdatedItem = RecycleBin->GetItem(i);
                PChar->pushPacket<CInventoryItemPacket>(PUpdatedItem, LOC_RECYCLEBIN, i);
            }
            PChar->pushPacket<CMessageStandardPacket>(nullptr, PItem->getID(), quantity, MsgStd::ThrowAway);
        }
        PChar->pushPacket<CInventoryFinishPacket>();
    }

    void EmptyRecycleBin(CCharEntity* PChar)
    {
        TracyZoneScoped;

        CItemContainer* recycleBin = PChar->getStorage(LOC_RECYCLEBIN);
        const char*     Query      = "DELETE FROM char_inventory WHERE charid = %u AND location = 17";
        if (_sql->Query(Query, PChar->id) != SQL_ERROR)
        {
            recycleBin->Clear();
        }
    }

    void SaveJobChangeGear(CCharEntity* PChar)
    {
        if (PChar == nullptr)
        {
            return;
        }

        const char* Query = "REPLACE INTO char_equip_saved SET \
                                    charid = %u, \
                                    jobid = %u, \
                                    main = %u, \
                                    sub = %u, \
                                    ranged = %u, \
                                    ammo = %u, \
                                    head = %u, \
                                    body = %u, \
                                    hands = %u, \
                                    legs = %u, \
                                    feet = %u, \
                                    neck = %u, \
                                    waist = %u, \
                                    ear1 = %u, \
                                    ear2 = %u, \
                                    ring1 = %u, \
                                    ring2 = %u, \
                                    back = %u";

        auto getEquipIdFromSlot = [](CCharEntity* PChar, SLOTTYPE slot) -> uint16
        {
            return (PChar->getEquip(slot) != nullptr) ? PChar->getEquip(slot)->getID() : 0;
        };

        uint16 main   = getEquipIdFromSlot(PChar, SLOT_MAIN);
        uint16 sub    = getEquipIdFromSlot(PChar, SLOT_SUB);
        uint16 ranged = getEquipIdFromSlot(PChar, SLOT_RANGED);
        uint16 ammo   = getEquipIdFromSlot(PChar, SLOT_AMMO);
        uint16 head   = getEquipIdFromSlot(PChar, SLOT_HEAD);
        uint16 body   = getEquipIdFromSlot(PChar, SLOT_BODY);
        uint16 hands  = getEquipIdFromSlot(PChar, SLOT_HANDS);
        uint16 legs   = getEquipIdFromSlot(PChar, SLOT_LEGS);
        uint16 feet   = getEquipIdFromSlot(PChar, SLOT_FEET);
        uint16 neck   = getEquipIdFromSlot(PChar, SLOT_NECK);
        uint16 waist  = getEquipIdFromSlot(PChar, SLOT_WAIST);
        uint16 ear1   = getEquipIdFromSlot(PChar, SLOT_EAR1);
        uint16 ear2   = getEquipIdFromSlot(PChar, SLOT_EAR2);
        uint16 ring1  = getEquipIdFromSlot(PChar, SLOT_RING1);
        uint16 ring2  = getEquipIdFromSlot(PChar, SLOT_RING2);
        uint16 back   = getEquipIdFromSlot(PChar, SLOT_BACK);

        _sql->Query(Query, PChar->id, PChar->GetMJob(), main, sub, ranged, ammo,
                    head, body, hands, legs, feet, neck, waist, ear1, ear2, ring1,
                    ring2, back);
    }

    void LoadJobChangeGear(CCharEntity* PChar)
    {
        if (PChar == nullptr)
        {
            return;
        }

        const char* Query = "SELECT main, sub, ranged, ammo, head, body, hands, legs, feet, neck, waist, ear1, ear2, ring1, ring2, back FROM char_equip_saved AS equip WHERE charid = %u AND jobid = %u";

        if (_sql->Query(Query, PChar->id, PChar->GetMJob()) == SQL_SUCCESS && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            std::vector<uint8> validContainers = { LOC_INVENTORY, LOC_WARDROBE, LOC_WARDROBE2, LOC_WARDROBE3, LOC_WARDROBE4, LOC_WARDROBE5, LOC_WARDROBE6, LOC_WARDROBE7, LOC_WARDROBE8 };

            for (uint8 equipSlot = SLOT_MAIN; equipSlot <= SLOT_BACK; equipSlot++)
            {
                uint16 itemId = _sql->GetUIntData(equipSlot);

                if (itemId > 0)
                {
                    for (const auto container : validContainers)
                    {
                        bool found = false;

                        for (uint8 slot = 0; slot < PChar->getStorage(container)->GetSize(); slot++)
                        {
                            auto* PEquip = dynamic_cast<CItemEquipment*>(PChar->getStorage(container)->GetItem(slot));

                            // ensure this is the item we actually want from the db
                            if (PEquip && PEquip->getID() == itemId)
                            {
                                // Validate that we're not trying to equip the same item to two different slots
                                CItemEquipment* compareItem = nullptr;

                                // Get item that theoretically could be equipped an adjacent slot
                                if (equipSlot == SLOT_MAIN || equipSlot == SLOT_EAR1 || equipSlot == SLOT_RING1)
                                {
                                    // Check one item to the "right"
                                    compareItem = PChar->getEquip(static_cast<SLOTTYPE>(equipSlot + 1));
                                }
                                else if (equipSlot == SLOT_SUB || equipSlot == SLOT_EAR2 || equipSlot == SLOT_RING2)
                                {
                                    // Check one item to the "left"
                                    compareItem = PChar->getEquip(static_cast<SLOTTYPE>(equipSlot - 1));
                                }

                                // If there's no item to compare then this item is valid
                                // If there is, check they aren't the same via pointer comparison (2 unique copies)
                                if (!compareItem || (compareItem && compareItem != PEquip))
                                {
                                    found = true;
                                    charutils::EquipItem(PChar, PEquip->getSlotID(), equipSlot, static_cast<CONTAINER_ID>(container));
                                    break;
                                }
                            }
                        }

                        if (found)
                        {
                            break;
                        }
                    }
                }
            }
        }
    }

    void EquipItem(CCharEntity* PChar, uint8 slotID, uint8 equipSlotID, uint8 containerID)
    {
        if (PChar == nullptr || PChar->getStorage(containerID) == nullptr)
        {
            return;
        }

        CItemEquipment* PItem    = dynamic_cast<CItemEquipment*>(PChar->getStorage(containerID)->GetItem(slotID));
        CItem*          POldItem = PChar->getEquip(static_cast<SLOTTYPE>(equipSlotID));

        if (PItem && PItem == PChar->getEquip(static_cast<SLOTTYPE>(equipSlotID)))
        {
            return;
        }

        // if player attempts to change thier ranged weapon during a ranged state then prevent equip
        // this prevents players from starting a RA with short delay x-bow and ending with high dmg longbow
        if (equipSlotID == SLOT_RANGED || (equipSlotID == SLOT_AMMO && !PChar->getEquip(SLOT_RANGED)))
        {
            if (PChar->PAI && PChar->PAI->IsCurrentState<CRangeState>())
            {
                return;
            }
        }

        if (equipSlotID == SLOT_SUB && PItem && !PItem->IsShield())
        {
            auto PItemWeapon = dynamic_cast<CItemWeapon*>(PItem);
            auto PMainItem   = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_MAIN));
            if (PItemWeapon && PItemWeapon->getSkillType() == SKILL_NONE && (!PMainItem || !PMainItem->isTwoHanded()))
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 0x200);
                return;
            }

            // Disallow everything but shields if you're using H2H
            // Equipping a shield will unequip the H2H weapon and you will go barefisted with a shield
            if (PMainItem && PMainItem->getSkillType() == SKILL_HAND_TO_HAND)
            {
                return;
            }
        }

        if (slotID == 0)
        {
            CItemEquipment* PSubItem = PChar->getEquip(SLOT_SUB);

            UnequipItem(PChar, equipSlotID);

            if (equipSlotID == 0 && PSubItem && !PSubItem->IsShield())
            {
                RemoveSub(PChar);
            }

            PChar->pushPacket<CEquipPacket>(slotID, equipSlotID, containerID);
        }
        else
        {
            if ((PItem != nullptr) && PItem->isType(ITEM_EQUIPMENT))
            {
                if (!PItem->isSubType(ITEM_LOCKED) && EquipArmor(PChar, slotID, equipSlotID, containerID))
                {
                    if (PItem->getScriptType() & SCRIPT_EQUIP)
                    {
                        luautils::OnItemCheck(PChar, PItem, ITEMCHECK::EQUIP, nullptr);
                        PChar->m_EquipFlag |= PItem->getScriptType();
                    }
                    if (PItem->isType(ITEM_USABLE) && ((CItemUsable*)PItem)->getCurrentCharges() != 0)
                    {
                        PItem->setAssignTime(CVanaTime::getInstance()->getVanaTime());
                        PChar->PRecastContainer->Add(RECAST_ITEM, slotID << 8 | containerID,
                                                     PItem->getReuseTime() / 1000); // add recast timer to Recast List from any bag

                        // Do not forget to update the timer when equipping the subject

                        PChar->pushPacket<CInventoryItemPacket>(PItem, containerID, slotID);
                    }
                    PItem->setSubType(ITEM_LOCKED);

                    if (equipSlotID == SLOT_SUB)
                    {
                        // If main hand is empty, check which UnarmedItem to use.
                        if (!PChar->getEquip(SLOT_MAIN) || !PChar->getEquip(SLOT_MAIN)->isType(ITEM_EQUIPMENT))
                        {
                            CheckUnarmedWeapon(PChar);
                        }
                    }

                    PChar->addEquipModifiers(&PItem->modList, PItem->getReqLvl(), equipSlotID);
                    PChar->PLatentEffectContainer->AddLatentEffects(PItem->latentList, PItem->getReqLvl(), equipSlotID);
                    PChar->PLatentEffectContainer->CheckLatentsEquip(equipSlotID);
                    PChar->addPetModifiers(&PItem->petModList);

                    // Only call the lua onEquip if its a valid equip - e.g. has passed EquipArmor and other checks above
                    luautils::OnItemEquip(PChar, PItem);

                    PChar->pushPacket<CEquipPacket>(slotID, equipSlotID, containerID);
                    PChar->pushPacket<CInventoryAssignPacket>(PItem, INV_NODROP);
                }
            }
        }
        if (equipSlotID == SLOT_MAIN || equipSlotID == SLOT_RANGED || equipSlotID == SLOT_SUB)
        {
            if (!PItem || !PItem->isType(ITEM_EQUIPMENT) ||
                (((CItemWeapon*)PItem)->getSkillType() != SKILL_STRING_INSTRUMENT && ((CItemWeapon*)PItem)->getSkillType() != SKILL_WIND_INSTRUMENT))
            {
                // If the weapon ISN'T a wind based instrument or a string based instrument
                PChar->health.tp = 0;
                PChar->StatusEffectContainer->DelStatusEffect(EFFECT_AFTERMATH);
            }

            if (!PChar->getEquip(SLOT_MAIN) || !PChar->getEquip(SLOT_MAIN)->isType(ITEM_EQUIPMENT) ||
                PChar->m_Weapons[SLOT_MAIN] == itemutils::GetUnarmedH2HItem())
            {
                CheckUnarmedWeapon(PChar);
            }

            BuildingCharWeaponSkills(PChar);
            PChar->pushPacket<CCharAbilitiesPacket>(PChar);
        }

        charutils::BuildingCharSkillsTable(PChar);

        PChar->UpdateHealth();
        PChar->m_EquipSwap = true;
        PChar->updatemask |= UPDATE_LOOK;

        // PItem can be null if item id is 0 (unequip)
        if (PItem)
        {
            PChar->dirtyInventoryContainers[static_cast<CONTAINER_ID>(PItem->getLocationID())] = true;
        }

        if (POldItem)
        {
            PChar->dirtyInventoryContainers[static_cast<CONTAINER_ID>(POldItem->getLocationID())] = true;
        }
    }

    /************************************************************************
     *                                                                       *
     *  Check the feature of the character wearing the items equipped on it  *
     *                                                                       *
     ************************************************************************/

    void CheckValidEquipment(CCharEntity* PChar)
    {
        CItemEquipment* PItem = nullptr;

        for (uint8 slotID = 0; slotID < 16; ++slotID)
        {
            PItem = PChar->getEquip((SLOTTYPE)slotID);
            if (PItem == nullptr || !PItem->isType(ITEM_EQUIPMENT))
            {
                continue;
            }

            if (PItem->getReqLvl() > (settings::get<bool>("map.DISABLE_GEAR_SCALING") ? PChar->GetMLevel() : PChar->jobs.job[PChar->GetMJob()]))
            {
                UnequipItem(PChar, slotID);
                continue;
            }

            if (slotID == SLOT_SUB && !PItem->IsShield())
            {
                // Unequip if no main weapon or a non-grip subslot without DW
                if (!PChar->getEquip(SLOT_MAIN) || (!charutils::hasTrait(PChar, TRAIT_DUAL_WIELD) && !(((CItemWeapon*)PItem)->getSkillType() == SKILL_NONE)))
                {
                    UnequipItem(PChar, SLOT_SUB);
                    continue;
                }
            }

            if ((PItem->getJobs() & (1 << (PChar->GetMJob() - 1))) && (PItem->getEquipSlotId() & (1 << slotID)))
            {
                continue;
            }

            UnequipItem(PChar, slotID);
        }
        // Unarmed H2H weapon check
        if (!PChar->getEquip(SLOT_MAIN) || !PChar->getEquip(SLOT_MAIN)->isType(ITEM_EQUIPMENT) || PChar->m_Weapons[SLOT_MAIN] == itemutils::GetUnarmedH2HItem())
        {
            CheckUnarmedWeapon(PChar);
        }

        PChar->pushPacket<CCharAppearancePacket>(PChar);

        BuildingCharWeaponSkills(PChar);
        PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    }

    void RemoveAllEquipment(CCharEntity* PChar)
    {
        CItemEquipment* PItem = nullptr;

        for (uint8 slotID = 0; slotID < 16; ++slotID)
        {
            PItem = PChar->getEquip((SLOTTYPE)slotID);

            if ((PItem != nullptr) && PItem->isType(ITEM_EQUIPMENT))
            {
                UnequipItem(PChar, slotID);
            }
        }
        // Determines the UnarmedItem to use, since all slots are empty now.
        CheckUnarmedWeapon(PChar);

        BuildingCharWeaponSkills(PChar);
        PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    }

    /************************************************************************
     *                                                                       *
     *  Check the logic of all character equipment                           *
     *                                                                       *
     ************************************************************************/

    // Later will need to make equipment in the structure,
    // where to add a bit field indicating in which cell is the equipment with the condition
    // To begin with, this field will save us from checking cells in characters without equipment with the condition

    void CheckEquipLogic(CCharEntity* PChar, SCRIPTTYPE ScriptType, uint32 param)
    {
        if (!(PChar->m_EquipFlag & ScriptType))
        {
            return;
        }

        for (uint8 slotID = 0; slotID < 16; ++slotID)
        {
            CItem* PItem = PChar->getEquip((SLOTTYPE)slotID);

            if ((PItem != nullptr) && PItem->isType(ITEM_EQUIPMENT))
            {
                if (((CItemEquipment*)PItem)->getScriptType() & ScriptType)
                {
                    luautils::OnItemCheck(PChar, PItem, static_cast<ITEMCHECK>(param), nullptr);
                }
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Load the Characters weapon skill list                                *
     *                                                                       *
     ************************************************************************/

    void BuildingCharWeaponSkills(CCharEntity* PChar)
    {
        std::memset(&PChar->m_WeaponSkills, 0, sizeof(PChar->m_WeaponSkills));

        CItemWeapon* PItem        = nullptr;
        int          main_ws      = 0;
        int          range_ws     = 0;
        int          main_ws_dyn  = 0;
        int          range_ws_dyn = 0;

        bool isInDynamis = PChar->isInDynamis();

        for (auto&& slot :
             { std::make_tuple(SLOT_MAIN, std::ref(main_ws), std::ref(main_ws_dyn)), std::make_tuple(SLOT_RANGED, std::ref(range_ws), std::ref(range_ws_dyn)) })
        {
            if (PChar->m_Weapons[std::get<0>(slot)])
            {
                PItem = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[std::get<0>(slot)]);

                if (PItem)
                {
                    std::get<1>(slot) = battleutils::GetScaledItemModifier(PChar, PItem, Mod::ADDS_WEAPONSKILL);
                    std::get<2>(slot) = battleutils::GetScaledItemModifier(PChar, PItem, Mod::ADDS_WEAPONSKILL_DYN);
                }
            }
        }

        // add in melee ws
        PItem       = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_MAIN));
        uint8 skill = PItem ? PItem->getSkillType() : (uint8)SKILL_HAND_TO_HAND;

        const auto& MeleeWeaponSkillList = battleutils::GetWeaponSkills(skill);
        for (auto&& PSkill : MeleeWeaponSkillList)
        {
            if (battleutils::CanUseWeaponskill(PChar, PSkill) || PSkill->getID() == main_ws || (isInDynamis && (PSkill->getID() == main_ws_dyn)))
            {
                addWeaponSkill(PChar, PSkill->getID());
            }
        }

        // add in ranged ws
        PItem = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));
        if (PItem != nullptr && PItem->isType(ITEM_WEAPON) && PItem->getSkillType() != SKILL_THROWING)
        {
            skill                             = PItem ? PItem->getSkillType() : 0;
            const auto& RangedWeaponSkillList = battleutils::GetWeaponSkills(skill);
            for (auto&& PSkill : RangedWeaponSkillList)
            {
                if ((battleutils::CanUseWeaponskill(PChar, PSkill)) || PSkill->getID() == range_ws || (isInDynamis && (PSkill->getID() == range_ws_dyn)))
                {
                    addWeaponSkill(PChar, PSkill->getID());
                }
            }
        }
    }

    void BuildingCharPetAbilityTable(CCharEntity* PChar, CPetEntity* PPet, uint32 PetID)
    {
        if (PPet == nullptr || PChar == nullptr)
        {
            ShowWarning("PPet or PChar was null.");
            return;
        }

        std::memset(&PChar->m_PetCommands, 0, sizeof(PChar->m_PetCommands));

        if (PetID == 0)
        { // technically Fire Spirit but we're using this to null the abilities shown
            PChar->pushPacket<CCharAbilitiesPacket>(PChar);
            return;
        }

        if (PChar->GetMJob() == JOB_SMN || PChar->GetSJob() == JOB_SMN)
        {
            std::vector<CAbility*> AbilitiesList = ability::GetAbilities(JOB_SMN);

            for (auto PAbility : AbilitiesList)
            {
                if (PPet->GetMLevel() >= PAbility->getLevel() && ((PetID >= PETID_CARBUNCLE && PetID <= PETID_CAIT_SITH) || PetID == PETID_SIREN) && CheckAbilityAddtype(PChar, PAbility))
                {
                    if (PetID == PETID_CARBUNCLE)
                    {
                        if (PAbility->getID() >= ABILITY_HEALING_RUBY && PAbility->getID() <= ABILITY_SOOTHING_RUBY)
                        {
                            addPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY);
                        }
                        else if (PAbility->getID() == ABILITY_PACIFYING_RUBY)
                        {
                            addPetAbility(PChar, 261);
                        }
                    }
                    else if (PetID >= PETID_FENRIR && PetID <= PETID_RAMUH)
                    {
                        if (PAbility->getID() >= (ABILITY_HEALING_RUBY + ((PetID - 8) * 16)) && PAbility->getID() < (ABILITY_HEALING_RUBY + ((PetID - 7) * 16)))
                        {
                            addPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY);
                        }
                    }
                    else if (PetID == PETID_DIABOLOS)
                    {
                        if (PAbility->getID() >= ABILITY_CAMISADO && PAbility->getID() <= ABILITY_PERFECT_DEFENSE)
                        {
                            addPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY);
                        }
                    }
                    else if (PetID == PETID_CAIT_SITH)
                    {
                        if (PAbility->getID() > ABILITY_SOOTHING_RUBY && PAbility->getID() < ABILITY_MOONLIT_CHARGE)
                        {
                            addPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY);
                        }
                    }
                    else if (PetID == PETID_SIREN)
                    {
                        if (PAbility->getID() >= ABILITY_CLARSACH_CALL && PAbility->getID() <= ABILITY_HYSTERIC_ASSAULT)
                        {
                            uint16 sirenAbilltyPacketOffset = 0x1C0;
                            uint16 sirenAbilityPacketBit    = (PAbility->getID() - ABILITY_CLARSACH_CALL) + sirenAbilltyPacketOffset;
                            addPetAbility(PChar, sirenAbilityPacketBit);
                        }
                    }
                }
            }
        }
        if (PPet->getPetType() == PET_TYPE::JUG_PET)
        {
            auto skillList{ battleutils::GetMobSkillList(PPet->m_MobSkillList) };
            for (auto&& abilityid : skillList)
            {
                addPetAbility(PChar, abilityid - ABILITY_HEALING_RUBY);
            }
        }
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
    }

    /************************************************************************
     *                                                                       *
     *  Collect the work table of the character's abilities.With zero level  *
     *  There must be 2H abilities .On this condition, sift them for SJOB    *
     *                                                                       *
     ************************************************************************/

    void BuildingCharAbilityTable(CCharEntity* PChar)
    {
        if (PChar == nullptr)
        {
            ShowWarning("charutils::BuildingCharAbilityTable() - PChar was null.");
            return;
        }

        std::memset(&PChar->m_Abilities, 0, sizeof(PChar->m_Abilities));

        for (auto PAbility : ability::GetAbilities(PChar->GetMJob()))
        {
            if (PAbility == nullptr)
            {
                continue;
            }

            if (PChar->GetMLevel() >= PAbility->getLevel())
            {
                if (PAbility->getID() < ABILITY_HEALING_RUBY && PAbility->getID() != ABILITY_PET_COMMANDS && CheckAbilityAddtype(PChar, PAbility))
                {
                    addAbility(PChar, PAbility->getID());
                    Charge_t* charge     = ability::GetCharge(PChar, PAbility->getRecastId());
                    auto      chargeTime = 0;
                    auto      maxCharges = 0;
                    if (charge)
                    {
                        chargeTime = charge->chargeTime - PChar->PMeritPoints->GetMeritValue((MERIT_TYPE)charge->merit, PChar);
                        maxCharges = charge->maxCharges;
                    }
                    if (!PChar->PRecastContainer->Has(RECAST_ABILITY, PAbility->getRecastId()))
                    {
                        PChar->PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), 0, chargeTime, maxCharges);
                    }
                }
            }
            else
            {
                break;
            }
        }

        // To stop a character with no SJob to receive the traits with job = 0 in the DB.
        if (PChar->GetSJob() == JOB_NON)
        {
            return;
        }

        for (auto PAbility : ability::GetAbilities(PChar->GetSJob()))
        {
            if (PChar->GetSLevel() >= PAbility->getLevel())
            {
                if (PAbility == nullptr)
                {
                    continue;
                }

                if (PAbility->getLevel() != 0 && PAbility->getID() < ABILITY_HEALING_RUBY)
                {
                    if (PAbility->getID() != ABILITY_PET_COMMANDS && CheckAbilityAddtype(PChar, PAbility) && !(PAbility->getAddType() & ADDTYPE_MAIN_ONLY))
                    {
                        addAbility(PChar, PAbility->getID());
                        Charge_t* charge     = ability::GetCharge(PChar, PAbility->getRecastId());
                        auto      chargeTime = 0;
                        auto      maxCharges = 0;
                        if (charge)
                        {
                            chargeTime = charge->chargeTime - PChar->PMeritPoints->GetMeritValue((MERIT_TYPE)charge->merit, PChar);
                            maxCharges = charge->maxCharges;
                        }
                        if (!PChar->PRecastContainer->Has(RECAST_ABILITY, PAbility->getRecastId()))
                        {
                            PChar->PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), 0, chargeTime, maxCharges);
                        }
                    }
                }
            }
            else
            {
                break;
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Collect the work table of the character skills based on real.        *
     *  Add restrictions, note the skills of the main job (rank! = 0)        *
     *                                                                       *
     ************************************************************************/

    // TODO: This whole thing should eventually get a refactored to be less dependent on arbitrary ordering of modifier IDs and conditionals on skill ranges.
    void BuildingCharSkillsTable(CCharEntity* PChar)
    {
        MERIT_TYPE skillMerit[] = { MERIT_H2H,
                                    MERIT_DAGGER,
                                    MERIT_SWORD,
                                    MERIT_GSWORD,
                                    MERIT_AXE,
                                    MERIT_GAXE,
                                    MERIT_SCYTHE,
                                    MERIT_POLEARM,
                                    MERIT_KATANA,
                                    MERIT_GKATANA,
                                    MERIT_CLUB,
                                    MERIT_STAFF,
                                    MERIT_AUTOMATON_SKILLS,
                                    MERIT_AUTOMATON_SKILLS,
                                    MERIT_AUTOMATON_SKILLS,
                                    MERIT_ARCHERY,
                                    MERIT_MARKSMANSHIP,
                                    MERIT_THROWING,
                                    MERIT_GUARDING,
                                    MERIT_EVASION,
                                    MERIT_SHIELD,
                                    MERIT_PARRYING,
                                    MERIT_DIVINE,
                                    MERIT_HEALING,
                                    MERIT_ENHANCING,
                                    MERIT_ENFEEBLING,
                                    MERIT_ELEMENTAL,
                                    MERIT_DARK,
                                    MERIT_SUMMONING,
                                    MERIT_NINJITSU,
                                    MERIT_SINGING,
                                    MERIT_STRING,
                                    MERIT_WIND,
                                    MERIT_BLUE,
                                    MERIT_GEO,
                                    MERIT_HANDBELL };

        uint8 meritIndex = 0;

        bool automatonSkillUpdated = false;

        // Iterate over skill IDs (offsetting by 79 to get modifier ID)
        for (int32 i = 1; i < 48; ++i)
        {
            // ignore unused skills
            if ((i >= 13 && i <= 21) || (i >= 46 && i <= 47))
            {
                PChar->WorkingSkills.skill[i] = 0x8000;
                continue;
            }
            uint16 maxMainSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PChar->GetMJob(), PChar->GetMLevel());
            uint16 maxSubSkill  = battleutils::GetMaxSkill((SKILLTYPE)i, PChar->GetSJob(), PChar->GetSLevel());
            int16  skillBonus   = 0;

            // apply arts bonuses
            if ((i >= SKILL_DIVINE_MAGIC && i <= SKILL_ENFEEBLING_MAGIC && PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE })) ||
                (i >= SKILL_ENFEEBLING_MAGIC && i <= SKILL_DARK_MAGIC && PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_DARK_ARTS, EFFECT_ADDENDUM_BLACK })))
            {
                uint16 artsSkill    = battleutils::GetMaxSkill(SKILL_ENHANCING_MAGIC, JOB_RDM, PChar->GetMLevel());                  // B+ skill
                uint16 skillCapD    = battleutils::GetMaxSkill((SKILLTYPE)i, JOB_SCH, PChar->GetMLevel());                           // D skill cap
                uint16 skillCapE    = battleutils::GetMaxSkill(SKILL_DARK_MAGIC, JOB_RDM, PChar->GetMLevel());                       // E skill cap
                auto   currentSkill = std::clamp<uint16>((PChar->RealSkills.skill[i] / 10), 0, std::max(maxMainSkill, maxSubSkill)); // working skill before bonuses
                uint16 artsBaseline = 0;                                                                                             // Level based baseline to which to raise skills
                uint8  mLevel       = PChar->GetMLevel();
                if (mLevel < 51)
                {
                    artsBaseline = (uint16)(5 + 2.7 * (mLevel - 1));
                }
                else if (mLevel < 61)
                {
                    artsBaseline = (uint16)(137 + 4.7 * (mLevel - 50));
                }
                else if (mLevel < 71)
                {
                    artsBaseline = (uint16)(184 + 3.7 * (mLevel - 60));
                }
                else if (mLevel < 75)
                {
                    artsBaseline = (uint16)(221 + 5.0 * (mLevel - 70));
                }
                else // >= 75
                {
                    artsBaseline = skillCapD + 36;
                }

                if (currentSkill < skillCapE)
                {
                    // If the player's skill is below the E cap
                    // give enough bonus points to raise it to the arts baseline
                    skillBonus += std::max(artsBaseline - currentSkill, 0);
                }
                else if (currentSkill < skillCapD)
                {
                    // if the skill is at or above the E cap but below the D cap
                    // raise it up to the B+ skill cap minus the difference between the current skill rank and the scholar base skill cap (D)
                    // i.e. give a bonus of the difference between the B+ skill cap and the D skill cap
                    skillBonus += std::max((artsSkill - skillCapD), 0);
                }
                else if (currentSkill < artsSkill)
                {
                    // If the player's skill is at or above the D cap but below the B+ cap
                    // give enough bonus points to raise it to the B+ cap
                    skillBonus += std::max(artsSkill - currentSkill, 0);
                }

                if (PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE }))
                {
                    skillBonus += PChar->getMod(Mod::LIGHT_ARTS_SKILL);
                }
                else
                {
                    skillBonus += PChar->getMod(Mod::DARK_ARTS_SKILL);
                }
            }
            else if (i >= SKILL_AUTOMATON_MELEE && i <= SKILL_AUTOMATON_MAGIC)
            {
                // TODO: does this need to change if you are /PUP?
                maxMainSkill = battleutils::GetMaxSkill(1, PChar->GetMLevel()); // A+ capped down to the Automaton's rating
            }

            skillBonus += PChar->PMeritPoints->GetMeritValue(skillMerit[meritIndex], PChar);
            meritIndex++;

            // Add 79 to get the modifier ID
            skillBonus += PChar->getMod(static_cast<Mod>(i + 79)); // This can be a negative value. Example: Shiva's Shotel.

            uint8 mainSkillRank = battleutils::GetSkillRank((SKILLTYPE)i, PChar->GetMJob());
            uint8 subSkillRank  = battleutils::GetSkillRank((SKILLTYPE)i, PChar->GetSJob());

            PChar->WorkingSkills.rank[i] = mainSkillRank;

            if (mainSkillRank != 0)
            {
                PChar->RealSkills.rank[i] = mainSkillRank;
            }
            else
            {
                PChar->RealSkills.rank[i] = subSkillRank;
            }

            uint16 currentSkill = PChar->RealSkills.skill[i] / 10;

            // Main Job Skills.
            if (maxMainSkill != 0)
            {
                if (currentSkill > maxMainSkill)
                {
                    currentSkill = maxMainSkill;
                }

                int16 newSkillValue = currentSkill + skillBonus;
                if (newSkillValue < 0)
                {
                    newSkillValue = 0;
                }

                PChar->WorkingSkills.skill[i] = static_cast<uint16>(newSkillValue);

                if (currentSkill >= maxMainSkill)
                {
                    PChar->WorkingSkills.skill[i] |= 0x8000; // Blue text.
                }
            }

            // Sub Job Skills.
            else if (maxSubSkill != 0)
            {
                if (currentSkill > maxSubSkill)
                {
                    currentSkill = maxSubSkill;
                }

                int16 newSkillValue = currentSkill + skillBonus;
                if (newSkillValue < 0)
                {
                    newSkillValue = 0;
                }

                PChar->WorkingSkills.skill[i] = static_cast<uint16>(newSkillValue);

                if (currentSkill >= maxSubSkill)
                {
                    PChar->WorkingSkills.skill[i] |= 0x8000; // Blue text.
                }
            }

            // Job setup doesn't have this skill.
            else
            {
                if (skillBonus < 0)
                {
                    skillBonus = 0;
                }
                PChar->WorkingSkills.skill[i] = static_cast<uint16>(skillBonus) | 0x8000; // New value AND Blue text.
            }

            // Automaton skills are special (especially with magic...)
            if (i >= SKILL_AUTOMATON_MELEE && i <= SKILL_AUTOMATON_MAGIC)
            {
                if (auto PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet))
                {
                    switch (i)
                    {
                        case SKILL_AUTOMATON_MAGIC:
                            PAutomaton->WorkingSkills.skill[i] = PChar->WorkingSkills.skill[i];

                            PAutomaton->WorkingSkills.skill[SKILL_HEALING_MAGIC]    = PChar->WorkingSkills.skill[i];
                            PAutomaton->WorkingSkills.skill[SKILL_ENHANCING_MAGIC]  = PChar->WorkingSkills.skill[i];
                            PAutomaton->WorkingSkills.skill[SKILL_ENFEEBLING_MAGIC] = PChar->WorkingSkills.skill[i];
                            PAutomaton->WorkingSkills.skill[SKILL_ELEMENTAL_MAGIC]  = PChar->WorkingSkills.skill[i];
                            PAutomaton->WorkingSkills.skill[SKILL_DARK_MAGIC]       = PChar->WorkingSkills.skill[i];
                            break;

                        default:
                            PAutomaton->WorkingSkills.skill[i] = PChar->WorkingSkills.skill[i];
                            break;
                    }

                    automatonSkillUpdated = true;
                }
            }
        }

        for (int32 i = 48; i < 58; ++i)
        {
            PChar->WorkingSkills.skill[i] = (PChar->RealSkills.skill[i] / 10) * 0x20 + PChar->RealSkills.rank[i];

            if ((PChar->RealSkills.rank[i] + 1) * 100 <= PChar->RealSkills.skill[i])
            {
                PChar->WorkingSkills.skill[i] += 0x8000;
            }
        }

        for (int32 i = 58; i < 64; ++i)
        {
            PChar->WorkingSkills.skill[i] = 0xFFFF;
        }

        // Update skills menu
        if (automatonSkillUpdated)
        {
            PChar->pushPacket<CCharJobExtraPacket>(PChar, PChar->GetMJob() == JOB_PUP);
        }
    }

    void BuildingCharTraitsTable(CCharEntity* PChar)
    {
        for (std::size_t i = 0; i < PChar->TraitList.size(); ++i)
        {
            CTrait* PTrait = PChar->TraitList.at(i);
            PChar->delModifier(PTrait->getMod(), PTrait->getValue());
        }
        PChar->TraitList.clear();
        std::memset(&PChar->m_TraitList, 0, sizeof(PChar->m_TraitList));

        auto mjob = PChar->GetMJob();
        auto sjob = PChar->GetSJob();
        auto mlvl = PChar->GetMLevel();
        auto slvl = PChar->GetSLevel();

        // NOTE: Monstrosity (MON) is treated as its own job, but each species is it's own
        //     : combination of main/sub job for stats, traits and abilities.
        if (PChar->m_PMonstrosity != nullptr)
        {
            mjob = PChar->m_PMonstrosity->MainJob;
            sjob = PChar->m_PMonstrosity->SubJob;
            mlvl = PChar->m_PMonstrosity->levels[PChar->m_PMonstrosity->MonstrosityId];
            slvl = mlvl;
        }

        battleutils::AddTraits(PChar, traits::GetTraits(mjob), mlvl);
        battleutils::AddTraits(PChar, traits::GetTraits(sjob), slvl);

        if (mjob == JOB_BLU || sjob == JOB_BLU)
        {
            blueutils::CalculateTraits(PChar);
        }

        PChar->delModifier(Mod::MEVA, PChar->m_magicEvasion);

        PChar->m_magicEvasion = battleutils::GetMaxSkill(12, mlvl); // Player MEVA is Rank G
        PChar->addModifier(Mod::MEVA, PChar->m_magicEvasion);
    }

    /************************************************************************
     *                                                                       *
     *  Try to increase the value of the skill                               *
     *                                                                       *
     ************************************************************************/

    void TrySkillUP(CCharEntity* PChar, SKILLTYPE SkillID, uint8 lvl, bool forceSkillUp, bool useSubSkill)
    {
        TracyZoneScoped;

        // This usually happens after a crash
        uint8 rawSkillID = static_cast<uint8>(SkillID);
        if (rawSkillID >= MAX_SKILLTYPE)
        {
            ShowWarning("SkillID (%d) exceeds MAX_SKILLTYPE.", rawSkillID);
            return;
        }

        if (((PChar->WorkingSkills.rank[rawSkillID] != 0) && !(PChar->WorkingSkills.skill[rawSkillID] & 0x8000)) || useSubSkill)
        {
            uint16 CurSkill     = PChar->RealSkills.skill[rawSkillID];
            uint16 MainCapSkill = battleutils::GetMaxSkill(SkillID, PChar->GetMJob(), PChar->GetMLevel());
            uint16 SubCapSkill  = battleutils::GetMaxSkill(SkillID, PChar->GetSJob(), PChar->GetSLevel());
            uint16 MainMaxSkill = battleutils::GetMaxSkill(SkillID, PChar->GetMJob(), std::min(PChar->GetMLevel(), lvl));
            uint16 SubMaxSkill  = battleutils::GetMaxSkill(SkillID, PChar->GetSJob(), std::min(PChar->GetSLevel(), lvl));
            uint16 MaxSkill     = 0;
            uint16 CapSkill     = 0;

            if (useSubSkill)
            {
                if (MainCapSkill > SubCapSkill)
                {
                    CapSkill = MainCapSkill;
                    MaxSkill = MainMaxSkill;
                }
                else
                {
                    CapSkill = SubCapSkill;
                    MaxSkill = SubMaxSkill;
                }
            }
            else
            {
                CapSkill = MainCapSkill;
                MaxSkill = MainMaxSkill;
            }
            // Max skill this victim level will allow.
            // Note this is no longer retail accurate, since now 'decent challenge' mobs allow to cap any skill.

            int16  Diff          = MaxSkill - CurSkill / 10;
            double SkillUpChance = Diff / 5.0 + settings::get<double>("map.SKILLUP_CHANCE_MULTIPLIER") * (2.0 - log10(1.0 + CurSkill / 100));

            double random = xirand::GetRandomNumber(1.);

            if (SkillUpChance > 0.5)
            {
                SkillUpChance = 0.5;
            }

            // Check for skillup% bonus. https://www.bg-wiki.com/bg/Category:Skill_Up_Food
            // Assuming multiplicative even though rate is already a % because 0.5 + 0.8 would be > 1.
            if ((SkillID >= 1 && SkillID <= 12) || (SkillID >= 25 && SkillID <= 31))
            // if should effect automaton replace the above with: (SkillID >= 1 && SkillID <= 31)
            {
                SkillUpChance *= ((100.f + PChar->getMod(Mod::COMBAT_SKILLUP_RATE)) / 100.f);
            }
            else if (SkillID >= 32 && SkillID <= 44)
            {
                SkillUpChance *= ((100.f + PChar->getMod(Mod::MAGIC_SKILLUP_RATE)) / 100.f);
            }

            if (Diff > 0 && (random < SkillUpChance || forceSkillUp))
            {
                double chance      = 0;
                uint8  SkillAmount = 1;
                uint8  tier        = std::min(1 + (Diff / 5), 5);

                for (uint8 i = 0; i < 4; ++i) // 1 + 4 possible additional ones (maximum 5)
                {
                    random = xirand::GetRandomNumber(1.);

                    switch (tier)
                    {
                        case 5:
                            chance = 0.900;
                            break;
                        case 4:
                            chance = 0.700;
                            break;
                        case 3:
                            chance = 0.500;
                            break;
                        case 2:
                            chance = 0.300;
                            break;
                        case 1:
                            chance = 0.200;
                            break;
                        default:
                            chance = 0.000;
                            break;
                    }

                    if (chance < random || SkillAmount == 5)
                    {
                        break;
                    }

                    tier -= 1;
                    SkillAmount += 1;
                }
                // convert to 10th units
                CapSkill = CapSkill * 10;

                int16 rovBonus = 1;
                for (auto i = 2884; i <= 2890; i += 3) // RHAPSODY KI
                {
                    if (hasKeyItem(PChar, i))
                    {
                        rovBonus += 1;
                    }
                    else
                    {
                        break; // No need to check further as you can't get KI out of order, so break out.
                    }
                }
                SkillAmount *= rovBonus;
                if (SkillAmount > 9)
                {
                    SkillAmount = 9;
                }

                // Do skill amount multiplier (Will only be applied if default setting is changed)
                if (settings::get<uint8>("map.SKILLUP_AMOUNT_MULTIPLIER") > 1)
                {
                    SkillAmount += (uint8)(SkillAmount * settings::get<uint8>("map.SKILLUP_AMOUNT_MULTIPLIER"));
                    if (SkillAmount > 9)
                    {
                        SkillAmount = 9;
                    }
                }

                if (SkillAmount + CurSkill >= CapSkill)
                {
                    // skill is capped. set blue flag
                    SkillAmount = CapSkill - CurSkill;
                    PChar->WorkingSkills.skill[SkillID] |= 0x8000;
                }

                PChar->RealSkills.skill[SkillID] += SkillAmount;
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, SkillID, SkillAmount, 38);

                if ((CurSkill / 10) < (CurSkill + SkillAmount) / 10) // if gone up a level
                {
                    PChar->WorkingSkills.skill[SkillID] += 1;
                    PChar->pushPacket<CCharSkillsPacket>(PChar);
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, SkillID, (CurSkill + SkillAmount) / 10, 53);

                    CheckWeaponSkill(PChar, SkillID);
                    /* ignoring this for now
                    if (SkillID >= 1 && SkillID <= 12)
                    {
                    PChar->addModifier(Mod::ATT, 1);
                    PChar->addModifier(Mod::ACC, 1);
                    }
                    */
                }
                SaveCharSkills(PChar, SkillID);
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  When skill level gained check for weapon skill                       *
     *                                                                       *
     ************************************************************************/

    void CheckWeaponSkill(CCharEntity* PChar, uint8 skill)
    {
        auto* weapon       = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_MAIN]);
        auto* rangedWeapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_RANGED]);

        bool noOrInvalidMainWeapon   = !weapon || weapon->getSkillType() != skill;
        bool noOrInvalidRangedWeapon = !rangedWeapon || rangedWeapon->getSkillType() != skill;

        if (noOrInvalidMainWeapon && noOrInvalidRangedWeapon)
        {
            return;
        }

        const auto& WeaponSkillList = battleutils::GetWeaponSkills(skill);
        uint16      curSkill        = PChar->RealSkills.skill[skill] / 10;

        for (auto&& PSkill : WeaponSkillList)
        {
            if (curSkill == PSkill->getSkillLevel() && (battleutils::CanUseWeaponskill(PChar, PSkill)))
            {
                addWeaponSkill(PChar, PSkill->getID());
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, PSkill->getID(), PSkill->getID(), 45);
                PChar->pushPacket<CCharAbilitiesPacket>(PChar);
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Methods for working with key items                                   *
     *                                                                       *
     ************************************************************************/

    bool hasKeyItem(CCharEntity* PChar, uint16 KeyItemID)
    {
        auto table = KeyItemID / 512;

        if (table >= MAX_KEYS_TABLE)
        {
            ShowWarning("Attempt to check for keyItem out of range (%d)!", KeyItemID);
            return false;
        }

        return PChar->keys.tables[table].keyList[KeyItemID % 512];
    }

    bool seenKeyItem(CCharEntity* PChar, uint16 KeyItemID)
    {
        auto table = KeyItemID / 512;

        if (table >= MAX_KEYS_TABLE)
        {
            ShowWarning("Attempt to see for keyItem out of range (%d)!", KeyItemID);
            return false;
        }

        return PChar->keys.tables[table].seenList[KeyItemID % 512];
    }

    void unseenKeyItem(CCharEntity* PChar, uint16 KeyItemID)
    {
        auto table = KeyItemID / 512;

        if (table >= MAX_KEYS_TABLE)
        {
            ShowWarning("Attempt to unsee for keyItem out of range (%d)!", KeyItemID);
            return;
        }

        PChar->keys.tables[table].seenList[KeyItemID % 512] = false;
    }

    void addKeyItem(CCharEntity* PChar, uint16 KeyItemID)
    {
        auto table = KeyItemID / 512;

        if (table >= MAX_KEYS_TABLE)
        {
            ShowWarning("Attempt to add for keyItem out of range (%d)!", KeyItemID);
            return;
        }

        PChar->keys.tables[table].keyList[KeyItemID % 512] = true;
    }

    void delKeyItem(CCharEntity* PChar, uint16 KeyItemID)
    {
        auto table = KeyItemID / 512;

        if (table >= MAX_KEYS_TABLE)
        {
            ShowWarning("Attempt to delete keyItem out of range (%d)!", KeyItemID);
            return;
        }

        PChar->keys.tables[table].keyList[KeyItemID % 512] = false;
    }

    /************************************************************************
     *                                                                       *
     *  Methods for working with spells                                      *
     *                                                                       *
     ************************************************************************/

    int32 hasSpell(CCharEntity* PChar, uint16 SpellID)
    {
        return PChar->m_SpellList[SpellID];
    }

    int32 addSpell(CCharEntity* PChar, uint16 SpellID)
    {
        // Todo: come up with a good way to validate that the SpellID exists in the database also.
        if (SpellID > 0 && SpellID < 1024 && !hasSpell(PChar, SpellID))
        {
            PChar->m_SpellList[SpellID] = true;
            return 1;
        }
        return 0;
    }

    int32 delSpell(CCharEntity* PChar, uint16 SpellID)
    {
        if (hasSpell(PChar, SpellID))
        {
            PChar->m_SpellList[SpellID] = false;
            return 1;
        }
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Learned abilities (corsair rolls)                                    *
     *                                                                       *
     ************************************************************************/

    int32 hasLearnedAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return hasBit(AbilityID, PChar->m_LearnedAbilities, sizeof(PChar->m_LearnedAbilities));
    }

    int32 addLearnedAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return addBit(AbilityID, PChar->m_LearnedAbilities, sizeof(PChar->m_LearnedAbilities));
    }

    int32 delLearnedAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return delBit(AbilityID, PChar->m_LearnedAbilities, sizeof(PChar->m_LearnedAbilities));
    }

    /************************************************************************
     *                                                                       *
     *  Learned weaponskills                                                 *
     *                                                                       *
     ************************************************************************/

    bool hasLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId)
    {
        if (PChar == nullptr)
        {
            ShowError("PChar is null.");
            return false;
        }

        if (wsUnlockId > std::size(PChar->m_LearnedWeaponskills) - 1)
        {
            ShowError("wsUnlockId is greater than learned weaponskill bitset.");
            return false;
        }

        return PChar->m_LearnedWeaponskills[wsUnlockId];
    }

    void addLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId)
    {
        if (PChar == nullptr)
        {
            ShowError("PChar is null.");
            return;
        }

        if (wsUnlockId > std::size(PChar->m_LearnedWeaponskills) - 1)
        {
            ShowError("wsUnlockId is greater than learned weaponskill bitset.");
            return;
        }

        PChar->m_LearnedWeaponskills[wsUnlockId] = true;
    }

    void delLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId)
    {
        if (PChar == nullptr)
        {
            ShowError("PChar is null.");
            return;
        }

        if (wsUnlockId > std::size(PChar->m_LearnedWeaponskills) - 1)
        {
            ShowError("wsUnlockId is greater than learned weaponskill bitset.");
            return;
        }

        PChar->m_LearnedWeaponskills[wsUnlockId] = false;
    }

    /************************************************************************
     *                                                                       *
     *  Methods for working with titles                                      *
     *                                                                       *
     ************************************************************************/

    int32 hasTitle(CCharEntity* PChar, uint16 Title)
    {
        return hasBit(Title, PChar->m_TitleList, sizeof(PChar->m_TitleList));
    }

    int32 addTitle(CCharEntity* PChar, uint16 Title)
    {
        return addBit(Title, PChar->m_TitleList, sizeof(PChar->m_TitleList));
    }

    int32 delTitle(CCharEntity* PChar, uint16 Title)
    {
        return delBit(Title, PChar->m_TitleList, sizeof(PChar->m_TitleList));
    }

    void setTitle(CCharEntity* PChar, uint16 Title)
    {
        PChar->profile.title = Title;
        PChar->pushPacket<CCharStatsPacket>(PChar);

        addTitle(PChar, Title);
        SaveTitles(PChar);
    }

    /************************************************************************
     *                                                                       *
     *  Methods for working with basic abilities                             *
     *                                                                       *
     ************************************************************************/

    int32 hasAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return hasBit(AbilityID, PChar->m_Abilities, sizeof(PChar->m_Abilities));
    }

    int32 addAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return addBit(AbilityID, PChar->m_Abilities, sizeof(PChar->m_Abilities));
    }

    int32 delAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return delBit(AbilityID, PChar->m_Abilities, sizeof(PChar->m_Abilities));
    }

    /************************************************************************
     *                                                                       *
     *  Weapon Skill functions                                               *
     *                                                                       *
     ************************************************************************/

    int32 hasWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID)
    {
        return hasBit(WeaponSkillID, PChar->m_WeaponSkills, sizeof(PChar->m_WeaponSkills));
    }

    int32 addWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID)
    {
        return addBit(WeaponSkillID, PChar->m_WeaponSkills, sizeof(PChar->m_WeaponSkills));
    }

    int32 delWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID)
    {
        return delBit(WeaponSkillID, PChar->m_WeaponSkills, sizeof(PChar->m_WeaponSkills));
    }

    bool canUseWeaponSkill(CCharEntity* PChar, uint16 wsid)
    {
        CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(wsid);

        if (PWeaponSkill == nullptr)
        {
            ShowError("Invalid Weaponskill ID passed to function.");
            return false;
        }

        return PChar->GetSkill(PWeaponSkill->getType()) >= PWeaponSkill->getSkillLevel();
    }

    /************************************************************************
     *                                                                       *
     *  Trait Functions                                                      *
     *                                                                       *
     ************************************************************************/

    int32 hasTrait(CCharEntity* PChar, uint16 TraitID)
    {
        if (PChar->objtype != TYPE_PC)
        {
            ShowError("charutils::hasTrait Attempt to reference a trait from a non-character entity: %s %i", PChar->name.c_str(), PChar->id);
            return 0;
        }
        return hasBit(TraitID, PChar->m_TraitList, sizeof(PChar->m_TraitList));
    }

    int32 addTrait(CCharEntity* PChar, uint16 TraitID)
    {
        if (PChar->objtype != TYPE_PC)
        {
            ShowError("charutils::addTrait Attempt to reference a trait from a non-character entity: %s %i", PChar->name.c_str(), PChar->id);
            return 0;
        }
        return addBit(TraitID, PChar->m_TraitList, sizeof(PChar->m_TraitList));
    }

    int32 delTrait(CCharEntity* PChar, uint16 TraitID)
    {
        if (PChar->objtype != TYPE_PC)
        {
            ShowError("charutils::delTrait Attempt to reference a trait from a non-character entity: %s %i", PChar->name.c_str(), PChar->id);
            return 0;
        }
        return delBit(TraitID, PChar->m_TraitList, sizeof(PChar->m_TraitList));
    }

    /************************************************************************
     *                                                                       *
     *  Pet Command Functions                                                *
     *                                                                       *
     ************************************************************************/

    int32 hasPetAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return hasBit(AbilityID, PChar->m_PetCommands, sizeof(PChar->m_PetCommands));
    }

    int32 addPetAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return addBit(AbilityID, PChar->m_PetCommands, sizeof(PChar->m_PetCommands));
    }

    int32 delPetAbility(CCharEntity* PChar, uint16 AbilityID)
    {
        return delBit(AbilityID, PChar->m_PetCommands, sizeof(PChar->m_PetCommands));
    }

    /************************************************************************
     *                                                                       *
     *  Initialize the experience (exp) table                                *
     *                                                                       *
     ************************************************************************/

    void LoadExpTable()
    {
        TracyZoneScoped;

        const char* fmtQuery = "SELECT r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20 "
                               "FROM exp_table "
                               "ORDER BY level ASC "
                               "LIMIT %u";

        int32 ret = _sql->Query(fmtQuery, ExpTableRowCount);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            for (uint32 x = 0; x < ExpTableRowCount && _sql->NextRow() == SQL_SUCCESS; ++x)
            {
                for (uint32 y = 0; y < 20; ++y)
                {
                    g_ExpTable[x][y] = (uint16)_sql->GetIntData(y);
                }
            }
        }

        ret = _sql->Query("SELECT level, exp FROM exp_base LIMIT 100");

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint8 level = (uint8)_sql->GetIntData(0) - 1;

                if (level < 100)
                {
                    g_ExpPerLevel[level] = (uint16)_sql->GetIntData(1);
                }
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Return mob difficulty according to level difference                  *
     *                                                                       *
     ************************************************************************/

    EMobDifficulty CheckMob(uint8 charlvl, uint8 moblvl)
    {
        uint32 baseExp = GetBaseExp(charlvl, moblvl);

        if (baseExp >= 400)
        {
            return EMobDifficulty::IncrediblyTough;
        }
        if (baseExp >= 350)
        {
            return EMobDifficulty::VeryTough;
        }
        if (baseExp >= 220)
        {
            return EMobDifficulty::Tough;
        }
        if (baseExp >= 200)
        {
            return EMobDifficulty::EvenMatch;
        }
        if (baseExp >= 160)
        {
            return EMobDifficulty::DecentChallenge;
        }
        if (baseExp >= 60)
        {
            return EMobDifficulty::EasyPrey;
        }
        if (baseExp >= 1 && moblvl > 55)
        {
            return EMobDifficulty::IncrediblyEasyPrey;
        }

        return EMobDifficulty::TooWeak;
    }

    /************************************************************************
     *                                                                       *
     *  Unmodified EXP that the character will receive from the target       *
     *                                                                       *
     ************************************************************************/

    uint32 GetBaseExp(uint8 charlvl, uint8 moblvl)
    {
        const int32 levelDif = moblvl - charlvl + 44;

        if (charlvl > 0 && charlvl < 100)
        {
            return g_ExpTable[std::clamp(levelDif, 0, ExpTableRowCount - 1)][(charlvl - 1) / 5];
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Calculate the amount of experience required to get the next level    *
     *                                                                       *
     ************************************************************************/

    uint32 GetExpNEXTLevel(uint8 charlvl)
    {
        if (charlvl > 0 && charlvl < 100)
        {
            return g_ExpPerLevel[charlvl];
        }
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Distributes gil to party members.                                    *
     *                                                                       *
     ************************************************************************/

    // TODO: REALISATION MUST BE IN TREASUREPOOL

    void DistributeGil(CCharEntity* PChar, CMobEntity* PMob)
    {
        TracyZoneScoped;

        // work out the amount of gil to give (guessed; replace with testing)
        uint32 gil    = PMob->GetRandomGil();
        uint32 gBonus = 0;

        if (gil && settings::get<float>("map.MOB_GIL_MULTIPLIER") >= 0.0f)
        {
            gil = static_cast<uint32>(gil * settings::get<float>("map.MOB_GIL_MULTIPLIER"));
        }

        if (settings::get<uint8>("map.ALL_MOBS_GIL_BONUS"))
        {
            gBonus = settings::get<uint8>("map.ALL_MOBS_GIL_BONUS") * PMob->GetMLevel();
            gil += std::clamp<uint32>(gBonus, 1, settings::get<uint32>("map.MAX_GIL_BONUS"));
        }

        // Distribute gil to player/party/alliance
        if (PChar->PParty != nullptr)
        {
            std::vector<CCharEntity*> members;

            // First gather all valid party members
            // clang-format off
            PChar->ForAlliance([PMob, &members](CBattleEntity* PPartyMember)
            {
                if (PPartyMember->getZone() == PMob->getZone() && isWithinDistance(PPartyMember->loc.p, PMob->loc.p, 100.f))
                {
                    members.emplace_back((CCharEntity*)PPartyMember);
                }
            });
            // clang-format on

            // all members might not be in range
            if (!members.empty())
            {
                // Check for highest gilfinder tier
                uint16 gilFinderActive = 0;

                for (auto PMember : members)
                {
                    if (PMember->getMod(Mod::GILFINDER) > gilFinderActive)
                    {
                        gilFinderActive = PMember->getMod(Mod::GILFINDER);
                    }
                }

                // Calculate gil for each party member.
                uint32 gilPerPerson = static_cast<uint32>(gil / members.size());
                gilPerPerson        = gilPerPerson * (100 + gilFinderActive) / 100;

                for (auto PMember : members)
                {
                    UpdateItem(PMember, LOC_INVENTORY, 0, gilPerPerson);
                    PMember->pushPacket<CMessageBasicPacket>(PMember, PMember, gilPerPerson, 0, 565);
                }
            }
        }
        else if (isWithinDistance(PChar->loc.p, PMob->loc.p, 100.f))
        {
            // Check for gilfinder
            gil += gil * PChar->getMod(Mod::GILFINDER) / 100;
            UpdateItem(PChar, LOC_INVENTORY, 0, static_cast<int32>(gil));
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, static_cast<int32>(gil), 0, 565);
        }
    }

    void DistributeItem(CCharEntity* PChar, CBaseEntity* PEntity, uint16 itemid, uint16 dropRate)
    {
        TracyZoneScoped;

        auto   thDropRateFunction = lua["xi"]["combat"]["treasureHunter"]["getDropRate"];
        uint16 thDropRate         = dropRate * 10;

        if (auto* PMob = dynamic_cast<CMobEntity*>(PEntity))
        {
            thDropRate = thDropRateFunction(PMob->m_THLvl, thDropRate);
        }

        if (thDropRate > 0 && xirand::GetRandomNumber(1, 10000) <= thDropRate * settings::get<float>("map.DROP_RATE_MULTIPLIER"))
        {
            PChar->PTreasurePool->AddItem(itemid, PEntity);
        }
    }

    double GetPlayerShareMultiplier(uint16 membersInZone, bool regionBuff)
    {
        if (settings::get<bool>("main.DISABLE_PARTY_EXP_PENALTY"))
        {
            return 1.00;
        }

        // Alliance share
        if (membersInZone > 6)
        {
            return 1.8f / membersInZone;
        }

        // Party share
        if (regionBuff)
        {
            switch (membersInZone)
            {
                case 1:
                    return 1.00;
                case 2:
                    return 0.75;
                case 3:
                    return 0.55;
                case 4:
                    return 0.45;
                case 5:
                    return 0.39;
                case 6:
                    return 0.35;
                default:
                    return 1.8 / membersInZone;
            }
        }
        else
        {
            switch (membersInZone)
            {
                case 1:
                    return 1.00;
                case 2:
                    return 0.60;
                case 3:
                    return 0.45;
                case 4:
                    return 0.40;
                case 5:
                    return 0.37;
                case 6:
                    return 0.35;
                default:
                    return 1.8 / membersInZone;
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Allocate experience points                                           *
     *                                                                       *
     ************************************************************************/

    void DistributeExperiencePoints(CCharEntity* PChar, CMobEntity* PMob)
    {
        TracyZoneScoped;

        uint8       pcinzone = 0;
        uint8       minlevel = 0;
        uint8       maxlevel = PChar->GetMLevel();
        REGION_TYPE region   = PChar->loc.zone->GetRegionID();

        if (PChar->PParty)
        {
            if (PChar->PParty->GetSyncTarget())
            {
                if (distance(PMob->loc.p, PChar->PParty->GetSyncTarget()->loc.p) >= 100 || PChar->PParty->GetSyncTarget()->health.hp == 0)
                {
                    // clang-format off
                    PChar->ForParty([&PMob](CBattleEntity* PMember)
                    {
                        if (PMember->getZone() == PMob->getZone() && distance(PMember->loc.p, PMob->loc.p) < 100)
                        {
                            if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(PMember))
                            {
                                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 545);
                            }
                        }
                    });
                    // clang-format on

                    return;
                }
            }
        }

        // clang-format off
        PChar->ForAlliance([&pcinzone, &PMob, &minlevel, &maxlevel](CBattleEntity* PMember)
        {
            if (PMember->getZone() == PMob->getZone() && distance(PMember->loc.p, PMob->loc.p) < 100)
            {
                if (PMember->PPet != nullptr && PMember->PPet->GetMLevel() > maxlevel && PMember->PPet->objtype != TYPE_PET)
                {
                    maxlevel = PMember->PPet->GetMLevel();
                }
                if (PMember->GetMLevel() > maxlevel)
                {
                    maxlevel = PMember->GetMLevel();
                }
                else if (PMember->GetMLevel() < minlevel)
                {
                    minlevel = PMember->GetMLevel();
                }
                pcinzone++;
            }
        });
        // clang-format on

        pcinzone            = std::max(pcinzone, PMob->m_HiPartySize);
        maxlevel            = std::max(maxlevel, PMob->m_HiPCLvl);
        PMob->m_HiPartySize = pcinzone;
        PMob->m_HiPCLvl     = maxlevel;

        // clang-format off
        PChar->ForAlliance([&PMob, &region, &maxlevel, &pcinzone](CBattleEntity* PPartyMember)
        {
            CCharEntity* PMember = dynamic_cast<CCharEntity*>(PPartyMember);
            if (!PMember || PMember->isDead())
            {
                return;
            }

            bool chainactive = false;

            const uint8 moblevel    = PMob->GetMLevel();
            const uint8 memberlevel = PMember->GetMLevel();

            EMobDifficulty mobCheck = CheckMob(maxlevel, moblevel);
            float          exp      = (float)GetBaseExp(maxlevel, moblevel);

            if (mobCheck > EMobDifficulty::TooWeak)
            {
                if (PMember->getZone() == PMob->getZone())
                {
                    if (settings::get<bool>("map.EXP_PARTY_GAP_PENALTIES"))
                    {
                        uint8 partyGapNoExp = settings::get<uint8>("map.EXP_PARTY_GAP_NO_EXP");

                        if (partyGapNoExp > 0 && maxlevel >= (memberlevel + partyGapNoExp))
                        {
                            exp = 0;
                        }
                        else if (maxlevel > 50 || maxlevel > (memberlevel + 7))
                        {
                            exp *= memberlevel / (float)maxlevel;
                        }
                        else
                        {
                            exp *= GetExpNEXTLevel(memberlevel) / (float)GetExpNEXTLevel(maxlevel);
                        }
                    }

                    bool isInSignetZone =
                        PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET) &&
                        region >= REGION_TYPE::RONFAURE &&
                        region <= REGION_TYPE::JEUNO;

                    bool isInSanctionZone =
                        PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION) &&
                        region >= REGION_TYPE::WEST_AHT_URHGAN &&
                        region <= REGION_TYPE::ALZADAAL;

                    exp *= GetPlayerShareMultiplier(pcinzone, isInSignetZone || isInSanctionZone);

                    if (PMob->getMobMod(MOBMOD_EXP_BONUS))
                    {
                        const float monsterbonus = 1.f + PMob->getMobMod(MOBMOD_EXP_BONUS) / 100.f;
                        exp *= monsterbonus;
                    }

                    // Per monster caps pulled from: https://ffxiclopedia.fandom.com/wiki/Experience_Points
                    if (PMember->GetMLevel() <= 50)
                    {
                        exp = std::fmin(exp, 400.f);
                    }
                    else if (PMember->GetMLevel() <= 60)
                    {
                        exp = std::fmin(exp, 500.f);
                    }
                    else
                    {
                        exp = std::fmin(exp, 600.f);
                    }

                    if (mobCheck > EMobDifficulty::DecentChallenge)
                    {
                        if (PMember->expChain.chainTime > gettick() || PMember->expChain.chainTime == 0)
                        {
                            chainactive = true;
                            switch (PMember->expChain.chainNumber)
                            {
                                case 0:
                                    exp *= 1.0f;
                                    break;
                                case 1:
                                    exp *= 1.2f;
                                    break;
                                case 2:
                                    exp *= 1.25f;
                                    break;
                                case 3:
                                    exp *= 1.3f;
                                    break;
                                case 4:
                                    exp *= 1.4f;
                                    break;
                                case 5:
                                    exp *= 1.5f;
                                    break;
                                default:
                                    exp *= 1.55f;
                                    break;
                            }
                        }
                        else
                        {
                            if (PMember->GetMLevel() <= 10)
                            {
                                PMember->expChain.chainTime = gettick() + 50000;
                            }
                            else if (PMember->GetMLevel() <= 20)
                            {
                                PMember->expChain.chainTime = gettick() + 100000;
                            }
                            else if (PMember->GetMLevel() <= 30)
                            {
                                PMember->expChain.chainTime = gettick() + 150000;
                            }
                            else if (PMember->GetMLevel() <= 40)
                            {
                                PMember->expChain.chainTime = gettick() + 200000;
                            }
                            else if (PMember->GetMLevel() <= 50)
                            {
                                PMember->expChain.chainTime = gettick() + 250000;
                            }
                            else if (PMember->GetMLevel() <= 60)
                            {
                                PMember->expChain.chainTime = gettick() + 300000;
                            }
                            else
                            {
                                PMember->expChain.chainTime = gettick() + 360000;
                            }
                            PMember->expChain.chainNumber = 1;
                        }

                        if (chainactive && PMember->GetMLevel() <= 10)
                        {
                            switch (PMember->expChain.chainNumber)
                            {
                                case 0:
                                    PMember->expChain.chainTime = gettick() + 50000;
                                    break;
                                case 1:
                                    PMember->expChain.chainTime = gettick() + 40000;
                                    break;
                                case 2:
                                    PMember->expChain.chainTime = gettick() + 30000;
                                    break;
                                case 3:
                                    PMember->expChain.chainTime = gettick() + 20000;
                                    break;
                                case 4:
                                    PMember->expChain.chainTime = gettick() + 10000;
                                    break;
                                case 5:
                                    PMember->expChain.chainTime = gettick() + 6000;
                                    break;
                                default:
                                    PMember->expChain.chainTime = gettick() + 2000;
                                    break;
                            }
                        }
                        else if (chainactive && PMember->GetMLevel() <= 20)
                        {
                            switch (PMember->expChain.chainNumber)
                            {
                                case 0:
                                    PMember->expChain.chainTime = gettick() + 100000;
                                    break;
                                case 1:
                                    PMember->expChain.chainTime = gettick() + 80000;
                                    break;
                                case 2:
                                    PMember->expChain.chainTime = gettick() + 60000;
                                    break;
                                case 3:
                                    PMember->expChain.chainTime = gettick() + 40000;
                                    break;
                                case 4:
                                    PMember->expChain.chainTime = gettick() + 20000;
                                    break;
                                case 5:
                                    PMember->expChain.chainTime = gettick() + 8000;
                                    break;
                                default:
                                    PMember->expChain.chainTime = gettick() + 4000;
                                    break;
                            }
                        }
                        else if (chainactive && PMember->GetMLevel() <= 30)
                        {
                            switch (PMember->expChain.chainNumber)
                            {
                                case 0:
                                    PMember->expChain.chainTime = gettick() + 150000;
                                    break;
                                case 1:
                                    PMember->expChain.chainTime = gettick() + 120000;
                                    break;
                                case 2:
                                    PMember->expChain.chainTime = gettick() + 90000;
                                    break;
                                case 3:
                                    PMember->expChain.chainTime = gettick() + 60000;
                                    break;
                                case 4:
                                    PMember->expChain.chainTime = gettick() + 30000;
                                    break;
                                case 5:
                                    PMember->expChain.chainTime = gettick() + 10000;
                                    break;
                                default:
                                    PMember->expChain.chainTime = gettick() + 5000;
                                    break;
                            }
                        }
                        else if (chainactive && PMember->GetMLevel() <= 40)
                        {
                            switch (PMember->expChain.chainNumber)
                            {
                                case 0:
                                    PMember->expChain.chainTime = gettick() + 200000;
                                    break;
                                case 1:
                                    PMember->expChain.chainTime = gettick() + 160000;
                                    break;
                                case 2:
                                    PMember->expChain.chainTime = gettick() + 120000;
                                    break;
                                case 3:
                                    PMember->expChain.chainTime = gettick() + 80000;
                                    break;
                                case 4:
                                    PMember->expChain.chainTime = gettick() + 40000;
                                    break;
                                case 5:
                                    PMember->expChain.chainTime = gettick() + 40000;
                                    break;
                                default:
                                    PMember->expChain.chainTime = gettick() + 30000;
                                    break;
                            }
                        }
                        else if (chainactive && PMember->GetMLevel() <= 50)
                        {
                            switch (PMember->expChain.chainNumber)
                            {
                                case 0:
                                    PMember->expChain.chainTime = gettick() + 250000;
                                    break;
                                case 1:
                                    PMember->expChain.chainTime = gettick() + 200000;
                                    break;
                                case 2:
                                    PMember->expChain.chainTime = gettick() + 150000;
                                    break;
                                case 3:
                                    PMember->expChain.chainTime = gettick() + 100000;
                                    break;
                                case 4:
                                    PMember->expChain.chainTime = gettick() + 50000;
                                    break;
                                case 5:
                                    PMember->expChain.chainTime = gettick() + 50000;
                                    break;
                                default:
                                    PMember->expChain.chainTime = gettick() + 50000;
                                    break;
                            }
                        }
                        else if (chainactive && PMember->GetMLevel() <= 60)
                        {
                            switch (PMember->expChain.chainNumber)
                            {
                                case 0:
                                    PMember->expChain.chainTime = gettick() + 300000;
                                    break;
                                case 1:
                                    PMember->expChain.chainTime = gettick() + 240000;
                                    break;
                                case 2:
                                    PMember->expChain.chainTime = gettick() + 180000;
                                    break;
                                case 3:
                                    PMember->expChain.chainTime = gettick() + 120000;
                                    break;
                                case 4:
                                    PMember->expChain.chainTime = gettick() + 90000;
                                    break;
                                case 5:
                                    PMember->expChain.chainTime = gettick() + 60000;
                                    break;
                                default:
                                    PMember->expChain.chainTime = gettick() + 60000;
                                    break;
                            }
                        }
                        else if (chainactive)
                        {
                            switch (PMember->expChain.chainNumber)
                            {
                                case 0:
                                    PMember->expChain.chainTime = gettick() + 360000;
                                    break;
                                case 1:
                                    PMember->expChain.chainTime = gettick() + 300000;
                                    break;
                                case 2:
                                    PMember->expChain.chainTime = gettick() + 240000;
                                    break;
                                case 3:
                                    PMember->expChain.chainTime = gettick() + 165000;
                                    break;
                                case 4:
                                    PMember->expChain.chainTime = gettick() + 105000;
                                    break;
                                case 5:
                                    PMember->expChain.chainTime = gettick() + 60000;
                                    break;
                                default:
                                    PMember->expChain.chainTime = gettick() + 60000;
                                    break;
                            }
                        }
                    }
                    // pet or companion exp penalty needs to be added here
                    if (distance(PMember->loc.p, PMob->loc.p) > 100)
                    {
                        PMember->pushPacket<CMessageBasicPacket>(PMember, PMember, 0, 0, 37);
                        return;
                    }

                    exp = charutils::AddExpBonus(PMember, exp);

                    charutils::AddExperiencePoints(false, PMember, PMob, (uint32)exp, mobCheck, chainactive);
                }
            }
        });
        // clang-format on
    }

    /************************************************************************
     *                                                                       *
     *  Allocate capacity points                                             *
     *                                                                       *
     ************************************************************************/

    void DistributeCapacityPoints(CCharEntity* PChar, CMobEntity* PMob)
    {
        TracyZoneScoped;

        // TODO: Capacity Points cannot be gained in Abyssea or Reives.  In addition, Gates areas,
        //       Ra'Kaznar, Escha, and Reisenjima reduce party penalty for capacity points earned.
        ZONEID zone     = PChar->loc.zone->GetID();
        uint8  mobLevel = PMob->GetMLevel();

        PChar->ForAlliance([&PMob, &zone, &mobLevel](CBattleEntity* PPartyMember)
                           {
            CCharEntity* PMember = dynamic_cast<CCharEntity*>(PPartyMember);

            if (!PMember || PMember->isDead() || (PMember->loc.zone->GetID() != zone))
            {
                // Do not grant Capacity points if null, Dead, or in a different area
                return;
            }

            if (!hasKeyItem(PMember, 2544) || PMember->GetMLevel() < 99)
            {
                // Do not grant Capacity points without Job Breaker or Level 99
                return;
            }

            bool  chainActive = false;
            int16 levelDiff   = mobLevel - 99; // Passed previous 99 check, no need to calculate

            // Capacity Chains are only granted for Mobs level 100+
            // Ref: https://www.bg-wiki.com/ffxi/Job_Points
            float capacityPoints = 0;

            if (mobLevel > 99)
            {
                // Base Capacity Point formula derived from the table located at:
                // https://ffxiclopedia.fandom.com/wiki/Job_Points#Capacity_Points
                capacityPoints = 0.0089 * std::pow(levelDiff, 3) + 0.0533 * std::pow(levelDiff, 2) + 3.7439 * levelDiff + 89.7;

                if (PMember->capacityChain.chainTime > gettick() || PMember->capacityChain.chainTime == 0)
                {
                    chainActive = true;

                    // TODO: Needs verification, pulled from: https://www.bluegartr.com/threads/120445-Job-Points-discussion?p=6138288&viewfull=1#post6138288
                    // Assumption: Chain0 is no bonus, Chains 10+ capped at 1.5 value, f(chain) = 1 + 0.05 * chain
                    float chainModifier = std::min(1 + 0.05 * PMember->capacityChain.chainNumber, 1.5);
                    capacityPoints *= chainModifier;
                }
                else
                {
                    // TODO: Capacity Chain Timer is reduced after Chain 30
                    PMember->capacityChain.chainTime   = gettick() + 30000;
                    PMember->capacityChain.chainNumber = 1;
                }

                if (chainActive)
                {
                    PMember->capacityChain.chainTime = gettick() + 30000;
                }

                capacityPoints = AddCapacityBonus(PMember, capacityPoints);
                AddCapacityPoints(PMember, PMob, capacityPoints, levelDiff, chainActive);
            } });
    }

    /************************************************************************
     *                                                                       *
     *  Return adjusted Capacity point value based on bonuses                *
     *  Note: rawBonus uses whole number percentage values until returning   *
     *                                                                       *
     ************************************************************************/

    uint16 AddCapacityBonus(CCharEntity* PChar, uint16 capacityPoints)
    {
        TracyZoneScoped;

        float rawBonus = 0;

        // COMMITMENT from Capacity Bands

        if (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_COMMITMENT) && PChar->loc.zone->GetRegionID() != REGION_TYPE::ABYSSEA)
        {
            CStatusEffect* commitment = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_COMMITMENT);
            int16          percentage = commitment->GetPower();
            int16          cap        = commitment->GetSubPower();
            rawBonus += std::clamp<int32>(((capacityPoints * percentage) / 100), 0, cap);
            commitment->SetSubPower(cap -= rawBonus);

            if (cap <= 0)
            {
                PChar->StatusEffectContainer->DelStatusEffect(EFFECT_COMMITMENT);
            }
        }

        // Mod::CAPACITY_BONUS is currently used for JP Gifts, and can easily be used elsewhere
        // This value is stored as uint, as a whole number percentage value
        rawBonus += PChar->getMod(Mod::CAPACITY_BONUS);

        // Unity Concord Ranking: 2 * (Unity Ranking - 1)
        uint8 unity = PChar->profile.unity_leader;
        if (unity >= 1 && unity <= 11)
        {
            rawBonus += 2 * (roeutils::RoeSystem.unityLeaderRank[unity - 1] - 1);
        }

        // RoE Objectives
        for (auto const& recordValue : roeCapacityBonusRecords)
        {
            if (roeutils::GetEminenceRecordCompletion(PChar, recordValue.first))
            {
                rawBonus += recordValue.second;
            }
        }

        // RoV Key Items - Fuchsia, Puce, Ochre (30%)
        for (uint16 rovKeyItem = 2890; rovKeyItem <= 2892; rovKeyItem++)
        {
            if (hasKeyItem(PChar, rovKeyItem))
            {
                rawBonus += 30;
            }
        }

        capacityPoints *= 1.f + rawBonus / 100;
        return capacityPoints;
    }

    /************************************************************************
     *                                                                       *
     *  Add Capacity Points to an individual player                          *
     *                                                                       *
     ************************************************************************/

    void AddCapacityPoints(CCharEntity* PChar, CBaseEntity* PMob, uint32 capacityPoints, int16 levelDiff, bool isCapacityChain)
    {
        TracyZoneScoped;

        if (PChar->isDead())
        {
            return;
        }

        capacityPoints = (uint32)(capacityPoints * settings::get<float>("map.EXP_RATE"));

        if (capacityPoints > 0)
        {
            // Capacity Chains start at lv100 mobs
            if (levelDiff >= 1 && isCapacityChain)
            {
                if (PChar->capacityChain.chainNumber != 0)
                {
                    PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, capacityPoints, PChar->capacityChain.chainNumber, 735);
                }
                else
                {
                    PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, capacityPoints, 0, 718);
                }
                PChar->capacityChain.chainNumber++;
            }
            else
            {
                PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, capacityPoints, 0, 718);
            }

            // Add capacity points
            if (PChar->PJobPoints->AddCapacityPoints(capacityPoints))
            {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CMessageCombatPacket>(PChar, PMob, PChar->PJobPoints->GetJobPoints(), 0, 719));
            }
            PChar->pushPacket<CMenuJobPointsPacket>(PChar);

            if (PMob != PChar) // Only mob kills count for gain EXP records
            {
                roeutils::event(ROE_EXPGAIN, PChar, RoeDatagram("capacity", capacityPoints));
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Losing exp on death. retainPercent is the amount of exp to be        *
     *  saved on death, e.g. 0.05 = retain 5% of lost exp. A value of        *
     *  1 means no exp loss. A value of 0 means full exp loss.               *
     *                                                                       *
     ************************************************************************/

    void DelExperiencePoints(CCharEntity* PChar, float retainPercent, uint16 forcedXpLoss)
    {
        TracyZoneScoped;

        if (retainPercent > 1.0f || retainPercent < 0.0f)
        {
            ShowWarning("Invalid retainPercent value (%f) received.", retainPercent);
            return;
        }

        if (settings::get<uint8>("map.EXP_LOSS_LEVEL") > 99 || settings::get<uint8>("map.EXP_LOSS_LEVEL") < 1)
        {
            ShowWarning("Invalid EXP_LOSS_LEVEL setting value was obtained (%d).", settings::get<uint8>("map.EXP_LOSS_LEVEL"));
            return;
        }

        if (PChar->GetMLevel() < settings::get<uint8>("map.EXP_LOSS_LEVEL") && forcedXpLoss == 0)
        {
            return;
        }

        // MONs don't lose exp on death
        if (PChar->m_PMonstrosity != nullptr)
        {
            return;
        }

        uint8  mLevel  = (PChar->m_LevelRestriction != 0 && PChar->m_LevelRestriction < PChar->GetMLevel()) ? PChar->m_LevelRestriction : PChar->GetMLevel();
        uint16 exploss = mLevel <= 67 ? (GetExpNEXTLevel(mLevel) * 8) / 100 : 2400;

        if (forcedXpLoss > 0)
        {
            // Override normal XP loss with specified value.
            exploss = forcedXpLoss;
        }
        else
        {
            // Apply retention percent
            exploss = (uint16)(exploss * (1 - retainPercent));
            exploss = (uint16)(exploss * settings::get<float>("map.EXP_LOSS_RATE"));
        }

        // Save exp lost.
        PChar->setCharVar("expLost", exploss);

        // Handle deleveling
        if (PChar->jobs.exp[PChar->GetMJob()] < exploss)
        {
            if (PChar->jobs.job[PChar->GetMJob()] > 1)
            {
                // de-level!
                int32 lowerLevelMaxExp = GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()] - 1);
                exploss -= PChar->jobs.exp[PChar->GetMJob()];
                PChar->jobs.exp[PChar->GetMJob()] = std::max(0, lowerLevelMaxExp - exploss);
                PChar->jobs.job[PChar->GetMJob()] -= 1;

                if (PChar->m_LevelRestriction == 0 || PChar->jobs.job[PChar->GetMJob()] < PChar->m_LevelRestriction)
                {
                    PChar->SetMLevel(PChar->jobs.job[PChar->GetMJob()]);
                    PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);
                }

                jobpointutils::RefreshGiftMods(PChar);
                BuildingCharSkillsTable(PChar);
                CalculateStats(PChar);
                CheckValidEquipment(PChar);

                BuildingCharAbilityTable(PChar);
                BuildingCharTraitsTable(PChar);
                BuildingCharWeaponSkills(PChar);

                PChar->pushPacket<CCharJobsPacket>(PChar);
                PChar->pushPacket<CCharStatusPacket>(PChar);
                PChar->pushPacket<CCharSkillsPacket>(PChar);
                PChar->pushPacket<CCharRecastPacket>(PChar);
                PChar->pushPacket<CCharAbilitiesPacket>(PChar);
                PChar->pushPacket<CMenuMeritPacket>(PChar);
                PChar->pushPacket<CMonipulatorPacket1>(PChar);
                PChar->pushPacket<CMonipulatorPacket2>(PChar);
                PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
                PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
                PChar->pushPacket<CCharSyncPacket>(PChar);

                PChar->UpdateHealth();

                SaveCharStats(PChar);
                SaveCharJob(PChar, PChar->GetMJob());

                if (PChar->PParty != nullptr)
                {
                    if (PChar->PParty->GetSyncTarget() == PChar)
                    {
                        PChar->PParty->RefreshSync();
                    }
                    PChar->PParty->ReloadParty();
                }

                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CMessageCombatPacket>(PChar, PChar, PChar->jobs.job[PChar->GetMJob()], 0, 11));
                luautils::OnPlayerLevelDown(PChar);
                PChar->updatemask |= UPDATE_HP;
            }
            else
            {
                PChar->jobs.exp[PChar->GetMJob()] = 0;
            }
        }
        else
        {
            PChar->jobs.exp[PChar->GetMJob()] -= exploss;
        }

        SaveCharExp(PChar, PChar->GetMJob());
        PChar->pushPacket<CCharStatsPacket>(PChar);
    }

    /************************************************************************
     *                                                                       *
     *  Add experience points to the specified character                     *
     *                                                                       *
     ************************************************************************/

    void AddExperiencePoints(bool expFromRaise, CCharEntity* PChar, CBaseEntity* PMob, uint32 exp, EMobDifficulty mobCheck, bool isexpchain)
    {
        TracyZoneScoped;

        if (PChar->isDead())
        {
            return;
        }

        if (!expFromRaise)
        {
            exp = (uint32)(exp * settings::get<float>("map.EXP_RATE"));
        }
        uint16 currentExp  = PChar->jobs.exp[PChar->GetMJob()];
        bool   onLimitMode = false;

        // Incase player de-levels to 74 on the field
        if (PChar->MeritMode && PChar->jobs.job[PChar->GetMJob()] > 74 && !expFromRaise)
        {
            onLimitMode = true;
        }

        // we check if the player is level capped and max exp..
        if (PChar->jobs.job[PChar->GetMJob()] > 74 && PChar->jobs.job[PChar->GetMJob()] >= PChar->jobs.genkai &&
            PChar->jobs.exp[PChar->GetMJob()] == GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1)
        {
            onLimitMode = true;
        }

        // exp added from raise shouldn't display a message. Don't need a message for zero exp either
        if (!expFromRaise && exp > 0)
        {
            if (mobCheck >= EMobDifficulty::EvenMatch && isexpchain)
            {
                if (PChar->expChain.chainNumber != 0)
                {
                    if (onLimitMode)
                    {
                        PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, exp, PChar->expChain.chainNumber, 372);
                    }
                    else
                    {
                        PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, exp, PChar->expChain.chainNumber, 253);
                    }
                }
                else
                {
                    if (onLimitMode)
                    {
                        PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, exp, 0, 371);
                    }
                    else
                    {
                        PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, exp, 0, 8);
                    }
                }
                PChar->expChain.chainNumber++;
            }
            else
            {
                if (onLimitMode)
                {
                    PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, exp, 0, 371);
                }
                else
                {
                    PChar->pushPacket<CMessageCombatPacket>(PChar, PChar, exp, 0, 8);
                }
            }
        }

        if (onLimitMode)
        {
            // add limit points
            if (PChar->PMeritPoints->AddLimitPoints(exp))
            {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CMessageCombatPacket>(PChar, PMob, PChar->PMeritPoints->GetMeritPoints(), 0, 50));
            }
        }
        else
        {
            // add normal exp
            PChar->jobs.exp[PChar->GetMJob()] += exp;
        }

        if (!expFromRaise)
        {
            REGION_TYPE region = PChar->loc.zone->GetRegionID();

            // Should this user be awarded conquest points..
            if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET) && (region >= REGION_TYPE::RONFAURE && region <= REGION_TYPE::JEUNO))
            {
                // Add influence for the players region..
                conquest::AddConquestPoints(PChar, exp);
            }

            // Should this user be awarded imperial standing..
            if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION) && (region >= REGION_TYPE::WEST_AHT_URHGAN && region <= REGION_TYPE::ALZADAAL))
            {
                charutils::AddPoints(PChar, "imperial_standing", (int32)(exp * 0.1f));
                PChar->pushPacket<CConquestPacket>(PChar);
            }

            // Cruor Drops in Abyssea zones.
            uint16 Pzone = PChar->getZone();
            if (zoneutils::GetCurrentRegion(Pzone) == REGION_TYPE::ABYSSEA)
            {
                uint16 TextID = luautils::GetTextIDVariable(Pzone, "CRUOR_OBTAINED");
                // uint32 Total  = charutils::GetPoints(PChar, "cruor");
                // uint32 Cruor  = 0; // Need to work out how to do cruor chains, until then no cruor will drop unless this line is customized for non retail play.

                if (TextID == 0)
                {
                    ShowWarning("Failed to fetch Cruor Message ID for zone: %i", Pzone);
                }

                // TODO: Implement this once formula for Cruor attainment is implemented
                // if (Cruor >= 1)
                // {
                //     PChar->pushPacket<CMessageSpecialPacket>(PChar, TextID, Cruor, Total + Cruor, 0, 0);
                //     charutils::AddPoints(PChar, "cruor", Cruor);
                // }
            }
        }

        PChar->PAI->EventHandler.triggerListener("EXPERIENCE_POINTS", CLuaBaseEntity(PChar), CLuaBaseEntity(PMob), exp);

        // Player levels up
        if ((currentExp + exp) >= GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) && !onLimitMode)
        {
            if (PChar->jobs.job[PChar->GetMJob()] >= PChar->jobs.genkai)
            {
                PChar->jobs.exp[PChar->GetMJob()] = GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1;
                if (PChar->PParty && PChar->PParty->GetSyncTarget() == PChar)
                {
                    PChar->PParty->SetSyncTarget("", MsgStd::LevelSyncRemoveIneligibleExp);
                }
            }
            else
            {
                PChar->jobs.exp[PChar->GetMJob()] -= GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]);
                if (PChar->jobs.exp[PChar->GetMJob()] >= GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()] + 1))
                {
                    PChar->jobs.exp[PChar->GetMJob()] = GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()] + 1) - 1;
                }
                PChar->jobs.job[PChar->GetMJob()] += 1;

                if (PChar->m_LevelRestriction == 0 || PChar->m_LevelRestriction > PChar->GetMLevel())
                {
                    PChar->SetMLevel(PChar->jobs.job[PChar->GetMJob()]);
                    PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

                    jobpointutils::RefreshGiftMods(PChar);
                    BuildingCharSkillsTable(PChar);
                    CalculateStats(PChar);
                    BuildingCharAbilityTable(PChar);
                    BuildingCharTraitsTable(PChar);
                    BuildingCharWeaponSkills(PChar);
                    puppetutils::LoadAutomaton(PChar);
                }
                PChar->PLatentEffectContainer->CheckLatentsJobLevel();

                if (PChar->PParty != nullptr)
                {
                    if (PChar->PParty->GetSyncTarget() == PChar)
                    {
                        PChar->PParty->RefreshSync();
                    }
                    PChar->PParty->ReloadParty();
                }

                PChar->UpdateHealth();

                if (!expFromRaise)
                {
                    // Level up animation and message
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CMessageCombatPacket>(PChar, PMob, PChar->jobs.job[PChar->GetMJob()], 0, 9));
                    // Set HP and MP to max range
                    PChar->health.hp = PChar->GetMaxHP();
                    PChar->health.mp = PChar->GetMaxMP();
                }

                SaveCharStats(PChar);
                SaveCharJob(PChar, PChar->GetMJob());
                SaveCharExp(PChar, PChar->GetMJob());

                PChar->pushPacket<CCharJobsPacket>(PChar);
                PChar->pushPacket<CCharStatusPacket>(PChar);
                PChar->pushPacket<CCharSkillsPacket>(PChar);
                PChar->pushPacket<CCharRecastPacket>(PChar);
                PChar->pushPacket<CCharAbilitiesPacket>(PChar);
                PChar->pushPacket<CMenuMeritPacket>(PChar);
                PChar->pushPacket<CMonipulatorPacket1>(PChar);
                PChar->pushPacket<CMonipulatorPacket2>(PChar);
                PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
                PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
                PChar->pushPacket<CCharSyncPacket>(PChar);
                PChar->pushPacket<CCharStatsPacket>(PChar);

                luautils::OnPlayerLevelUp(PChar);
                roeutils::event(ROE_EVENT::ROE_LEVELUP, PChar, RoeDatagramList{});
                PChar->updatemask |= UPDATE_HP;
                return;
            }
        }

        SaveCharStats(PChar);
        SaveCharJob(PChar, PChar->GetMJob());
        SaveCharExp(PChar, PChar->GetMJob());
        PChar->pushPacket<CCharStatsPacket>(PChar);

        if (onLimitMode)
        {
            PChar->pushPacket<CMenuMeritPacket>(PChar);
            PChar->pushPacket<CMonipulatorPacket1>(PChar);
            PChar->pushPacket<CMonipulatorPacket2>(PChar);
        }

        if (PMob != PChar) // Only mob kills count for gain EXP records
        {
            roeutils::event(ROE_EXPGAIN, PChar, RoeDatagram("exp", exp));
        }
    }

    /************************************************************************
     *                                                                       *
     *  Establish a restriction of character level                           *
     *                                                                       *
     ************************************************************************/

    void SetLevelRestriction(CCharEntity* PChar, uint8 lvl)
    {
    }

    void SaveCharPosition(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars "
                            "SET "
                            "pos_rot = %u,"
                            "pos_x = %.3f,"
                            "pos_y = %.3f,"
                            "pos_z = %.3f,"
                            "boundary = %u "
                            "WHERE charid = %u";

        _sql->Query(Query, PChar->loc.p.rotation, PChar->loc.p.x, PChar->loc.p.y, PChar->loc.p.z, PChar->loc.boundary, PChar->id);
    }

    /* TODO: Move linkshell persistence here
    void SaveCharLinkshells(CCharEntity* PChar)
    {
        for (uint8 lsSlot = 16; lsSlot < 18; ++lsSlot)
        {
            if (PChar->equip[lsSlot] == 0)
            {
                sql->Query("DELETE FROM char_linkshells WHERE charid = %u AND lsslot = %u LIMIT 1", PChar->id, lsSlot);
            }
            else
            {
                const char* fmtQuery = "INSERT INTO char_linkshells SET charid = %u, lsslot = %u, location = %u, slot = %u ON DUPLICATE KEY UPDATE location = %u, slot = %u";
                sql->Query(fmtQuery, PChar->id, lsSlot, PChar->equipLoc[lsSlot], PChar->equip[lsSlot], PChar->equipLoc[lsSlot], PChar->equip[lsSlot]);
            }
        }
    }
    */

    void SaveQuestsList(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars "
                            "SET "
                            "quests = '%s' "
                            "WHERE charid = %u";

        char questslist[sizeof(PChar->m_questLog) * 2 + 1];
        _sql->EscapeStringLen(questslist, (const char*)PChar->m_questLog, sizeof(PChar->m_questLog));

        _sql->Query(Query, questslist, PChar->id);
    }

    void SaveFame(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE char_profile "
                            "SET "
                            "fame_sandoria = %u,"
                            "fame_bastok = %u,"
                            "fame_windurst = %u,"
                            "fame_norg = %u,"
                            "fame_jeuno = %u,"
                            "fame_aby_konschtat = %u,"
                            "fame_aby_tahrongi = %u,"
                            "fame_aby_latheine = %u,"
                            "fame_aby_misareaux = %u,"
                            "fame_aby_vunkerl = %u,"
                            "fame_aby_attohwa = %u,"
                            "fame_aby_altepa = %u,"
                            "fame_aby_grauberg = %u,"
                            "fame_aby_uleguerand = %u,"
                            "fame_adoulin = %u "
                            "WHERE charid = %u";

        _sql->Query(Query, PChar->profile.fame[0], PChar->profile.fame[1], PChar->profile.fame[2], PChar->profile.fame[3], PChar->profile.fame[4],
                    PChar->profile.fame[5], PChar->profile.fame[6], PChar->profile.fame[7], PChar->profile.fame[8], PChar->profile.fame[9],
                    PChar->profile.fame[10], PChar->profile.fame[11], PChar->profile.fame[12], PChar->profile.fame[13], PChar->profile.fame[14], PChar->id);
    }

    /************************************************************************
     *                                                                       *
     *  Save Character Missions                                              *
     *                                                                       *
     ************************************************************************/

    void SaveMissionsList(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars "
                            "LEFT JOIN char_profile USING(charid) "
                            "SET "
                            "missions = '%s',"
                            "assault = '%s',"
                            "campaign = '%s',"
                            "rank_points = %u,"
                            "rank_sandoria = %u,"
                            "rank_bastok = %u,"
                            "rank_windurst = %u "
                            "WHERE charid = %u";

        char missionslist[sizeof(PChar->m_missionLog) * 2 + 1];
        _sql->EscapeStringLen(missionslist, (const char*)PChar->m_missionLog, sizeof(PChar->m_missionLog));

        char assaultList[sizeof(PChar->m_assaultLog) * 2 + 1];
        _sql->EscapeStringLen(assaultList, (const char*)&PChar->m_assaultLog, sizeof(PChar->m_assaultLog));

        char campaignList[sizeof(PChar->m_campaignLog) * 2 + 1];
        _sql->EscapeStringLen(campaignList, (const char*)&PChar->m_campaignLog, sizeof(PChar->m_campaignLog));

        _sql->Query(Query, missionslist, assaultList, campaignList, PChar->profile.rankpoints, PChar->profile.rank[0], PChar->profile.rank[1],
                    PChar->profile.rank[2], PChar->id);
    }

    /************************************************************************
     *                                                                       *
     *  Save Eminence Records                                                *
     *                                                                       *
     ************************************************************************/

    void SaveEminenceData(CCharEntity* PChar)
    {
        TracyZoneScoped;

        if (!settings::get<bool>("main.ENABLE_ROE"))
        {
            return;
        }

        const char* Query = "UPDATE chars "
                            "SET "
                            "eminence = '%s' "
                            "WHERE charid = %u";

        char eminenceList[sizeof(PChar->m_eminenceLog) * 2 + 1];
        _sql->EscapeStringLen(eminenceList, (const char*)&PChar->m_eminenceLog, sizeof(PChar->m_eminenceLog));

        _sql->Query(Query, eminenceList, PChar->id);
        PChar->m_eminenceCache.lastWriteout = static_cast<uint32>(time(nullptr));
    }

    void SaveCharInventoryCapacity(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE char_storage "
                            "SET "
                            "inventory = %u,"
                            "safe = %u,"
                            "locker = %u,"
                            "satchel = %u,"
                            "sack = %u, "
                            "`case` = %u, "
                            "wardrobe = %u, "
                            "wardrobe2 = %u, "
                            "wardrobe3 = %u, "
                            "wardrobe4 = %u, "
                            "wardrobe5 = %u, "
                            "wardrobe6 = %u, "
                            "wardrobe7 = %u, "
                            "wardrobe8 = %u "
                            "WHERE charid = %u";

        _sql->Query(Query,
                    PChar->getStorage(LOC_INVENTORY)->GetSize(),
                    PChar->getStorage(LOC_MOGSAFE)->GetSize(),
                    PChar->getStorage(LOC_MOGLOCKER)->GetSize(),
                    PChar->getStorage(LOC_MOGSATCHEL)->GetSize(),
                    PChar->getStorage(LOC_MOGSACK)->GetSize(),
                    PChar->getStorage(LOC_MOGCASE)->GetSize(),
                    PChar->getStorage(LOC_WARDROBE)->GetSize(),
                    PChar->getStorage(LOC_WARDROBE2)->GetSize(),
                    PChar->getStorage(LOC_WARDROBE3)->GetSize(),
                    PChar->getStorage(LOC_WARDROBE4)->GetSize(),
                    PChar->getStorage(LOC_WARDROBE5)->GetSize(),
                    PChar->getStorage(LOC_WARDROBE6)->GetSize(),
                    PChar->getStorage(LOC_WARDROBE7)->GetSize(),
                    PChar->getStorage(LOC_WARDROBE8)->GetSize(),
                    PChar->id);
    }

    /************************************************************************
     *                                                                       *
     *  Save list of key items                                               *
     *                                                                       *
     ************************************************************************/

    void SaveKeyItems(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* fmtQuery = "UPDATE chars SET keyitems = '%s' WHERE charid = %u";

        char keyitems[sizeof(PChar->keys) * 2 + 1];
        _sql->EscapeStringLen(keyitems, (const char*)&PChar->keys, sizeof(PChar->keys));

        _sql->Query(fmtQuery, keyitems, PChar->id);
    }

    void SaveSpell(CCharEntity* PChar, uint16 spellID)
    {
        TracyZoneScoped;

        const char* Query = "INSERT IGNORE INTO char_spells "
                            "VALUES (%u, %u)";

        _sql->Query(Query, PChar->id, spellID);
    }

    void DeleteSpell(CCharEntity* PChar, uint16 spellID)
    {
        TracyZoneScoped;

        const char* Query = "DELETE FROM char_spells "
                            "WHERE charid = %u AND spellid = %u";

        _sql->Query(Query, PChar->id, spellID);
    }

    void SaveLearnedAbilities(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars SET "
                            "abilities = '%s', "
                            "weaponskills = '%s' "
                            "WHERE charid = %u";

        char abilities[sizeof(PChar->m_LearnedAbilities) * 2 + 1];
        char weaponskills[sizeof(PChar->m_LearnedWeaponskills) * 2 + 1];
        _sql->EscapeStringLen(abilities, (const char*)PChar->m_LearnedAbilities, sizeof(PChar->m_LearnedAbilities));
        _sql->EscapeStringLen(weaponskills, (const char*)&PChar->m_LearnedWeaponskills, sizeof(PChar->m_LearnedWeaponskills));

        _sql->Query(Query, abilities, weaponskills, PChar->id);
    }

    void SaveTitles(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars "
                            "LEFT JOIN char_stats USING(charid) "
                            "SET "
                            "titles = '%s',"
                            "title = %u "
                            "WHERE charid = %u";

        char titles[sizeof(PChar->m_TitleList) * 2 + 1];
        _sql->EscapeStringLen(titles, (const char*)PChar->m_TitleList, sizeof(PChar->m_TitleList));

        _sql->Query(Query, titles, PChar->profile.title, PChar->id);
    }

    void SaveZonesVisited(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* fmtQuery = "UPDATE chars SET zones = '%s' WHERE charid = %u";

        char zones[sizeof(PChar->m_ZonesList) * 2 + 1];
        _sql->EscapeStringLen(zones, (const char*)PChar->m_ZonesList, sizeof(PChar->m_ZonesList));

        _sql->Query(fmtQuery, zones, PChar->id);
    }

    void SaveCharEquip(CCharEntity* PChar)
    {
        TracyZoneScoped;

        for (uint8 i = 0; i < 18; ++i)
        {
            if (PChar->equip[i] == 0)
            {
                _sql->Query("DELETE FROM char_equip WHERE charid = %u AND  equipslotid = %u LIMIT 1", PChar->id, i);
            }
            else
            {
                const char* fmtQuery = "INSERT INTO char_equip SET charid = %u, equipslotid = %u , slotid  = %u, containerid = %u ON DUPLICATE KEY UPDATE "
                                       "slotid  = %u, containerid = %u";
                _sql->Query(fmtQuery, PChar->id, i, PChar->equip[i], PChar->equipLoc[i], PChar->equip[i], PChar->equipLoc[i]);
            }
        }
    }

    void SaveCharLook(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE char_look "
                            "SET head = %u, body = %u, hands = %u, legs = %u, feet = %u, main = %u, sub = %u, ranged = %u "
                            "WHERE charid = %u";

        look_t* look = (PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look);
        _sql->Query(Query, look->head, look->body, look->hands, look->legs, look->feet, look->main, look->sub, look->ranged, PChar->id);

        _sql->Query("UPDATE chars SET isstylelocked = %u WHERE charid = %u", PChar->getStyleLocked() ? 1 : 0, PChar->id);

        Query = "INSERT INTO char_style (charid, head, body, hands, legs, feet, main, sub, ranged) "
                "VALUES (%u, %u, %u, %u, %u, %u, %u, %u, %u) ON DUPLICATE KEY UPDATE "
                "charid = VALUES(charid), head = VALUES(head), body = VALUES(body), "
                "hands = VALUES(hands), legs = VALUES(legs), feet = VALUES(feet), "
                "main = VALUES(main), sub = VALUES(sub), ranged = VALUES(ranged)";

        _sql->Query(Query, PChar->id, PChar->styleItems[SLOT_HEAD], PChar->styleItems[SLOT_BODY], PChar->styleItems[SLOT_HANDS],
                    PChar->styleItems[SLOT_LEGS], PChar->styleItems[SLOT_FEET], PChar->styleItems[SLOT_MAIN], PChar->styleItems[SLOT_SUB],
                    PChar->styleItems[SLOT_RANGED]);
    }

    /************************************************************************
     *                                                                       *
     *  Save some of the current characteristics of the character            *
     *                                                                       *
     ************************************************************************/

    void SaveCharStats(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE char_stats "
                            "SET hp = %u, mp = %u, mhflag = %u, mjob = %u, sjob = %u, "
                            "pet_id = %u, pet_type = %u, pet_hp = %u, pet_mp = %u, pet_level = %u "
                            "WHERE charid = %u";

        _sql->Query(Query, PChar->health.hp, PChar->health.mp, PChar->profile.mhflag, PChar->GetMJob(), PChar->GetSJob(),
                    PChar->petZoningInfo.petID, static_cast<uint8>(PChar->petZoningInfo.petType), PChar->petZoningInfo.petHP, PChar->petZoningInfo.petMP, PChar->petZoningInfo.petLevel, PChar->id);

        // These two are jug only variables. We should probably move pet char stats into its own table, but in the meantime
        // we use charvars for jug specific things
        PChar->setCharVar("jugpet-spawn-time", static_cast<int32>(PChar->petZoningInfo.jugSpawnTime));
        PChar->setCharVar("jugpet-duration-seconds", static_cast<int32>(PChar->petZoningInfo.jugDuration));
    }

    /************************************************************************
     *                                                                       *
     *  Save the char's GM level                                             *
     *                                                                       *
     ************************************************************************/

    void SaveCharGMLevel(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE %s SET %s %u WHERE charid = %u";

        _sql->Query(Query, "chars", "gmlevel =", PChar->m_GMlevel, PChar->id);

        _sql->Query(Query, "char_flags", "gmModeEnabled =", PChar->visibleGmLevel >= 3 ? 1 : 0, PChar->id);
    }

    void SaveMentorFlag(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE %s SET %s %u WHERE charid = %u";

        _sql->Query(Query, "chars", "mentor =", PChar->m_mentorUnlocked, PChar->id);
    }

    void SavePlayerSettings(CCharEntity* PChar)
    {
        TracyZoneScoped;
        const char* Query = "UPDATE %s SET %s %llu WHERE charid = %u";

        uint32_t playerSettings = {};

        std::memcpy(&playerSettings, &PChar->playerConfig, sizeof(uint32_t));
        _sql->Query(Query, "chars", "settings =", playerSettings, PChar->id);
    }

    void SaveJobMasterDisplay(CCharEntity* PChar)
    {
        TracyZoneScoped;
        const char* Query = "UPDATE %s SET %s %u WHERE charid = %u";

        _sql->Query(Query, "chars", "job_master =", PChar->m_jobMasterDisplay, PChar->id);
    }

    void SaveChatFilterFlags(CCharEntity* PChar)
    {
        TracyZoneScoped;
        uint32_t    filters = {};
        const char* Query   = "UPDATE chars SET chatfilters_1 = %llu WHERE charid = %u";

        std::memcpy(&filters, &PChar->playerConfig.MessageFilter, sizeof(uint32_t));

        _sql->Query(Query, filters, PChar->id);
        Query = "UPDATE chars SET chatfilters_2 = %llu WHERE charid = %u";

        std::memcpy(&filters, &PChar->playerConfig.MessageFilter2, sizeof(uint32_t));
        _sql->Query(Query, filters, PChar->id);
    }

    /************************************************************************
     *                                                                       *
     *  Save the char's language preference                                  *
     *                                                                       *
     ************************************************************************/

    void SaveLanguages(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars SET languages = %u WHERE charid = %u";

        _sql->Query(Query, PChar->search.language, PChar->id);
    }

    /************************************************************************
     *                                                                       *
     *  Save character's nation changes                                      *
     *                                                                       *
     ************************************************************************/

    void SaveCharNation(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars "
                            "SET nation = %u "
                            "WHERE charid = %u";

        _sql->Query(Query, PChar->profile.nation, PChar->id);
    }

    /************************************************************************
     *                                                                       *
     *  Save character's current campaign allegiance                         *
     *                                                                       *
     ************************************************************************/

    void SaveCampaignAllegiance(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars "
                            "SET campaign_allegiance = %u "
                            "WHERE charid = %u";

        _sql->Query(Query, PChar->profile.campaign_allegiance, PChar->id);
    }

    /************************************************************************
     *                                                                       *
     *  Saves character's current moghancement                               *
     *                                                                       *
     ************************************************************************/

    void SaveCharMoghancement(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE chars "
                            "SET moghancement = %u "
                            "WHERE charid = %u";

        _sql->Query(Query, PChar->m_moghancementID, PChar->id);
    }

    /************************************************************************
     *                                                                       *
     *  Save the current levels of the character's jobs                      *
     *                                                                       *
     ************************************************************************/

    void SaveCharJob(CCharEntity* PChar, JOBTYPE job)
    {
        TracyZoneScoped;

        if (job == JOB_NON || job >= MAX_JOBTYPE)
        {
            ShowWarning("Attempt to save Invalid Job with JOBTYPE %d.", job);
            return;
        }

        // Monstrosity job and level data is handled elsewhere, bail out now
        if (job == JOB_MON)
        {
            return;
        }

        const char* fmtQuery = "";

        switch (job)
        {
            case JOB_WAR:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, war = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_MNK:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, mnk = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_WHM:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, whm = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_BLM:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, blm = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_RDM:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, rdm = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_THF:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, thf = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_PLD:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, pld = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_DRK:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, drk = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_BST:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, bst = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_BRD:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, brd = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_RNG:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, rng = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_SAM:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, sam = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_NIN:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, nin = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_DRG:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, drg = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_SMN:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, smn = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_BLU:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, blu = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_COR:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, cor = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_PUP:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, pup = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_DNC:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, dnc = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_SCH:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, sch = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_GEO:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, geo = %u WHERE charid = %u LIMIT 1";
                break;
            case JOB_RUN:
                fmtQuery = "UPDATE char_jobs SET unlocked = %u, run = %u WHERE charid = %u LIMIT 1";
                break;
            default:
                fmtQuery = "";
                break;
        }
        _sql->Query(fmtQuery, PChar->jobs.unlocked, PChar->jobs.job[job], PChar->id);
    }

    void SaveCharExp(CCharEntity* PChar, JOBTYPE job)
    {
        TracyZoneScoped;

        if (job == JOB_NON || job >= MAX_JOBTYPE)
        {
            ShowWarning("Attempt to save Char XP with invalid JOBTYPE %d.", job);
            return;
        }

        // Monstrosity exp data is handled elsewhere, bail out now
        if (job == JOB_MON)
        {
            return;
        }

        const char* Query = "";

        switch (job)
        {
            case JOB_WAR:
                Query = "UPDATE char_exp SET war = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_MNK:
                Query = "UPDATE char_exp SET mnk = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_WHM:
                Query = "UPDATE char_exp SET whm = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_BLM:
                Query = "UPDATE char_exp SET blm = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_RDM:
                Query = "UPDATE char_exp SET rdm = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_THF:
                Query = "UPDATE char_exp SET thf = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_PLD:
                Query = "UPDATE char_exp SET pld = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_DRK:
                Query = "UPDATE char_exp SET drk = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_BST:
                Query = "UPDATE char_exp SET bst = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_BRD:
                Query = "UPDATE char_exp SET brd = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_RNG:
                Query = "UPDATE char_exp SET rng = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_SAM:
                Query = "UPDATE char_exp SET sam = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_NIN:
                Query = "UPDATE char_exp SET nin = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_DRG:
                Query = "UPDATE char_exp SET drg = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_SMN:
                Query = "UPDATE char_exp SET smn = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_BLU:
                Query = "UPDATE char_exp SET blu = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_COR:
                Query = "UPDATE char_exp SET cor = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_PUP:
                Query = "UPDATE char_exp SET pup = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_DNC:
                Query = "UPDATE char_exp SET dnc = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_SCH:
                Query = "UPDATE char_exp SET sch = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_GEO:
                Query = "UPDATE char_exp SET geo = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            case JOB_RUN:
                Query = "UPDATE char_exp SET run = %u, merits = %u, limits = %u WHERE charid = %u";
                break;
            default:
                Query = "";
                break;
        }
        _sql->Query(Query, PChar->jobs.exp[job], PChar->PMeritPoints->GetMeritPoints(), PChar->PMeritPoints->GetLimitPoints(), PChar->id);
    }

    void SaveCharSkills(CCharEntity* PChar, uint8 SkillID)
    {
        TracyZoneScoped;

        if (SkillID >= MAX_SKILLTYPE)
        {
            ShowWarning("charutils::SaveCharSkills() - SkillID is greated than MAX_SKILLTYPE.");
            return;
        }

        const char* Query = "INSERT INTO char_skills "
                            "SET "
                            "charid = %u,"
                            "skillid = %u,"
                            "value = %u,"
                            "rank = %u "
                            "ON DUPLICATE KEY UPDATE value = %u, rank = %u";

        _sql->Query(Query, PChar->id, SkillID, PChar->RealSkills.skill[SkillID], PChar->RealSkills.rank[SkillID], PChar->RealSkills.skill[SkillID],
                    PChar->RealSkills.rank[SkillID]);
    }

    /************************************************************************
     *                                                                       *
     *  Save Teleports - (homepoints, outposts, maws, etc)                   *
     *                                                                       *
     ************************************************************************/

    void SaveTeleport(CCharEntity* PChar, TELEPORT_TYPE type)
    {
        TracyZoneScoped;

        const char* column = "";
        uint32      value  = 0;

        switch (type)
        {
            case TELEPORT_TYPE::OUTPOST_SANDY:
                column = "outpost_sandy";
                value  = PChar->teleport.outpostSandy;
                break;
            case TELEPORT_TYPE::OUTPOST_BASTOK:
                column = "outpost_bastok";
                value  = PChar->teleport.outpostBastok;
                break;
            case TELEPORT_TYPE::OUTPOST_WINDY:
                column = "outpost_windy";
                value  = PChar->teleport.outpostWindy;
                break;
            case TELEPORT_TYPE::RUNIC_PORTAL:
                column = "runic_portal";
                value  = PChar->teleport.runicPortal;
                break;
            case TELEPORT_TYPE::PAST_MAW:
                column = "maw";
                value  = PChar->teleport.pastMaw;
                break;
            case TELEPORT_TYPE::CAMPAIGN_SANDY:
                column = "campaign_sandy";
                value  = PChar->teleport.campaignSandy;
                break;
            case TELEPORT_TYPE::CAMPAIGN_BASTOK:
                column = "campaign_bastok";
                value  = PChar->teleport.campaignBastok;
                break;
            case TELEPORT_TYPE::CAMPAIGN_WINDY:
                column = "campaign_windy";
                value  = PChar->teleport.campaignWindy;
                break;
            case TELEPORT_TYPE::HOMEPOINT:
            {
                char buf[sizeof(PChar->teleport.homepoint) * 2 + 1];
                _sql->EscapeStringLen(buf, (const char*)&PChar->teleport.homepoint, sizeof(PChar->teleport.homepoint));
                const char* query = "UPDATE char_unlocks SET homepoints = '%s' WHERE charid = %u";
                _sql->Query(query, buf, PChar->id);
                return;
            }
            case TELEPORT_TYPE::SURVIVAL:
            {
                char buf[sizeof(PChar->teleport.survival) * 2 + 1];
                _sql->EscapeStringLen(buf, (const char*)&PChar->teleport.survival, sizeof(PChar->teleport.survival));
                const char* query = "UPDATE char_unlocks SET survivals = '%s' WHERE charid = %u";
                _sql->Query(query, buf, PChar->id);
                return;
            }
            case TELEPORT_TYPE::ABYSSEA_CONFLUX:
            {
                char buf[sizeof(PChar->teleport.abysseaConflux) * 2 + 1];
                _sql->EscapeStringLen(buf, (const char*)&PChar->teleport.abysseaConflux, sizeof(PChar->teleport.abysseaConflux));
                const char* query = "UPDATE char_unlocks SET abyssea_conflux = '%s' WHERE charid = %u";
                _sql->Query(query, buf, PChar->id);
                return;
            }
            case TELEPORT_TYPE::WAYPOINT:
            {
                char buf[sizeof(PChar->teleport.waypoints) * 2 + 1];
                _sql->EscapeStringLen(buf, (const char*)&PChar->teleport.waypoints, sizeof(PChar->teleport.waypoints));
                const char* query = "UPDATE char_unlocks SET waypoints = '%s' WHERE charid = %u";
                _sql->Query(query, buf, PChar->id);
                return;
            }
            case TELEPORT_TYPE::ESCHAN_PORTAL:
            {
                char buf[sizeof(PChar->teleport.eschanPortal) * 2 + 1];
                _sql->EscapeStringLen(buf, (const char*)&PChar->teleport.eschanPortal, sizeof(PChar->teleport.eschanPortal));
                const char* query = "UPDATE char_unlocks SET eschan_portals = '%s' WHERE charid = %u";
                _sql->Query(query, buf, PChar->id);
                return;
            }
            default:
                ShowError("charutils:SaveTeleport : Unknown type parameter.");
                return;
        }

        const char* query = "UPDATE char_unlocks SET %s = %u WHERE charid = %u";
        _sql->Query(query, column, value, PChar->id);
    }

    float AddExpBonus(CCharEntity* PChar, float exp)
    {
        TracyZoneScoped;

        int32 bonus = 0;
        if (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_DEDICATION) && PChar->loc.zone->GetRegionID() != REGION_TYPE::ABYSSEA)
        {
            CStatusEffect* dedication = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_DEDICATION);
            int16          percentage = dedication->GetPower();
            int16          cap        = dedication->GetSubPower();
            bonus += std::clamp<int32>((int32)((exp * percentage) / 100), 0, cap);
            dedication->SetSubPower(cap -= bonus);

            if (cap <= 0)
            {
                PChar->StatusEffectContainer->DelStatusEffect(EFFECT_DEDICATION);
            }
        }

        int16 rovBonus = 0;
        for (auto i = 2884; i <= 2889; ++i) // RHAPSODY KI are sequential, so start at WHITE and end at MAUVE, last 3 are CP
        {
            if (hasKeyItem(PChar, i))
            {
                rovBonus += 30;
            }
            else
            {
                break; // No need to check further as you can't get KI out of order, so break out.
            }
        }

        bonus += (int32)(exp * ((PChar->getMod(Mod::EXP_BONUS) + rovBonus) / 100.0f));

        if (bonus + (int32)exp < 0)
        {
            exp = 0;
        }
        else
        {
            exp = exp + bonus;
        }

        return exp;
    }

    bool hasMogLockerAccess(CCharEntity* PChar)
    {
        TracyZoneScoped;
        auto tstamp = static_cast<uint32>(PChar->getCharVar("mog-locker-expiry-timestamp"));
        if (CVanaTime::getInstance()->getVanaTime() < tstamp)
        {
            return true;
        }
        return false;
    }

    uint8 getQuestStatus(CCharEntity* PChar, uint8 log, uint8 quest)
    {
        uint8 current  = PChar->m_questLog[log].current[quest / 8] & (1 << (quest % 8));
        uint8 complete = PChar->m_questLog[log].complete[quest / 8] & (1 << (quest % 8));

        return (complete != 0 ? 2 : (current != 0 ? 1 : 0));
    }

    uint16 AvatarPerpetuationReduction(CCharEntity* PChar)
    {
        TracyZoneScoped;

        // REMEMBER:
        // Elements start at 0 and the 0th element is ELEMENT_NONE
        // Weather starts at 0 and the 0th weather is WEATHER_NONE
        // Days start at 0 and the 0th day is Firesday
        // Affinity starts at 0 and the 0th affinity is FIRE_AFFINITY
        // petElement and petElementIdx exist to bridge these gaps here!

        auto*   PPet             = static_cast<CPetEntity*>(PChar->PPet);
        ELEMENT petElement       = static_cast<ELEMENT>(PPet->m_Element);
        uint8   petElementIdx    = static_cast<uint8>(petElement) - 1;
        ELEMENT dayElement       = battleutils::GetDayElement();
        WEATHER weather          = battleutils::GetWeather(PChar, false);
        int16   perpReduction    = PChar->getMod(Mod::PERPETUATION_REDUCTION);
        int16   dayReduction     = PChar->getMod(Mod::DAY_REDUCTION);     // As seen on Summoner's Doublet (Depending On Day: Avatar perpetuation cost -3) etc.
        int16   weatherReduction = PChar->getMod(Mod::WEATHER_REDUCTION); // As seen on Summoner's Horn (Weather: Avatar perpetuation cost -3) etc.

        static const Mod strong[8] = { Mod::FIRE_AFFINITY_PERP, Mod::ICE_AFFINITY_PERP, Mod::WIND_AFFINITY_PERP, Mod::EARTH_AFFINITY_PERP,
                                       Mod::THUNDER_AFFINITY_PERP, Mod::WATER_AFFINITY_PERP, Mod::LIGHT_AFFINITY_PERP, Mod::DARK_AFFINITY_PERP };

        static const WEATHER weatherStrong[8] = { WEATHER_HOT_SPELL, WEATHER_SNOW, WEATHER_WIND, WEATHER_DUST_STORM,
                                                  WEATHER_THUNDER, WEATHER_RAIN, WEATHER_AURORAS, WEATHER_GLOOM };

        // If you wear a fire staff, you have +2 perp affinity reduction for fire, but -2 for ice as mods.
        perpReduction += PChar->getMod(strong[petElementIdx]);

        // Compare day element and pet element (both ELEMENT, both 0-based)
        if (dayElement == petElement)
        {
            perpReduction += dayReduction;
        }

        // TODO: Whats the deal with the +1 to weather result here?
        if (weather == weatherStrong[petElementIdx] || weather == weatherStrong[petElementIdx] + 1)
        {
            perpReduction += weatherReduction;
        }

        return static_cast<uint16>(perpReduction);
    }

    /************************************************************************
     *                                                                       *
     *  Record now as when the character has died and save it to the db.     *
     *                                                                       *
     ************************************************************************/

    void SaveDeathTime(CCharEntity* PChar)
    {
        TracyZoneScoped;

        const char* fmtQuery = "UPDATE char_stats SET death = %u WHERE charid = %u LIMIT 1";
        _sql->Query(fmtQuery, PChar->GetSecondsElapsedSinceDeath(), PChar->id);
    }

    void SavePlayTime(CCharEntity* PChar)
    {
        TracyZoneScoped;

        uint32 playtime = PChar->GetPlayTime();

        _sql->Query("UPDATE chars SET playtime = '%u' WHERE charid = '%u' LIMIT 1", playtime, PChar->id);

        // Removes new player icon if played for more than 240 hours
        if (PChar->isNewPlayer() && playtime >= 864000)
        {
            PChar->playerConfig.NewAdventurerOffFlg = true;
            PChar->updatemask |= UPDATE_HP;

            SavePlayerSettings(PChar);
        }
    }

    /************************************************************************
     *                                                                       *
     *  Checks which UnarmedItem to grant when SLOT_MAIN is empty.           *
     *                                                                       *
     ************************************************************************/

    void CheckUnarmedWeapon(CCharEntity* PChar)
    {
        TracyZoneScoped;

        CItem* PSubslot = PChar->getEquip(SLOT_SUB);

        // Main or sub job provides H2H skill, and sub slot is empty.
        if ((battleutils::GetSkillRank(SKILL_HAND_TO_HAND, PChar->GetMJob()) > 0 || battleutils::GetSkillRank(SKILL_HAND_TO_HAND, PChar->GetSJob()) > 0) &&
            (!PSubslot || !PSubslot->isType(ITEM_EQUIPMENT)))
        {
            PChar->m_Weapons[SLOT_MAIN] = itemutils::GetUnarmedH2HItem();
            PChar->look.main            = 21; // The secret to H2H animations.  setModelId for UnarmedH2H didn't work.
        }
        else
        {
            PChar->m_Weapons[SLOT_MAIN] = itemutils::GetUnarmedItem();
            PChar->look.main            = 0;
        }
        BuildingCharWeaponSkills(PChar);
    }

    bool CheckAbilityAddtype(CCharEntity* PChar, CAbility* PAbility)
    {
        if (PAbility->getAddType() & ADDTYPE_MERIT)
        {
            if (!PChar->PMeritPoints->GetMerit((MERIT_TYPE)PAbility->getMeritModID()))
            {
                ShowWarning("charutils::CheckAbilityAddtype: Attempt to add invalid Merit Ability (%d).", PAbility->getMeritModID());
                return false;
            }

            if (!(PChar->PMeritPoints->GetMerit((MERIT_TYPE)PAbility->getMeritModID())->count > 0))
            {
                return false;
            }
        }
        if (PAbility->getAddType() & ADDTYPE_ASTRAL_FLOW)
        {
            if (!PChar->StatusEffectContainer->HasStatusEffect(EFFECT_ASTRAL_FLOW))
            {
                return false;
            }
        }
        if (PAbility->getAddType() & ADDTYPE_LEARNED)
        {
            if (!hasLearnedAbility(PChar, PAbility->getID()))
            {
                return false;
            }
        }
        if (PAbility->getAddType() & ADDTYPE_LIGHT_ARTS)
        {
            if (!PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE }))
            {
                return false;
            }
        }
        if (PAbility->getAddType() & ADDTYPE_DARK_ARTS)
        {
            if (!PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_DARK_ARTS, EFFECT_ADDENDUM_BLACK }))
            {
                return false;
            }
        }
        if ((PAbility->getAddType() & (ADDTYPE_JUGPET | ADDTYPE_CHARMPET)) == (ADDTYPE_JUGPET | ADDTYPE_CHARMPET))
        {
            if (!PChar->PPet || !(PChar->PPet->objtype == TYPE_MOB ||
                                  (PChar->PPet->objtype == TYPE_PET && static_cast<CPetEntity*>(PChar->PPet)->getPetType() == PET_TYPE::JUG_PET)))
            {
                return false;
            }
        }
        if ((PAbility->getAddType() & (ADDTYPE_JUGPET | ADDTYPE_CHARMPET)) == ADDTYPE_JUGPET)
        {
            if (!PChar->PPet || PChar->PPet->objtype != TYPE_PET || static_cast<CPetEntity*>(PChar->PPet)->getPetType() != PET_TYPE::JUG_PET)
            {
                return false;
            }
        }
        if ((PAbility->getAddType() & (ADDTYPE_JUGPET | ADDTYPE_CHARMPET)) == ADDTYPE_CHARMPET)
        {
            if (!PChar->PPet || PChar->PPet->objtype != TYPE_MOB)
            {
                return false;
            }
        }
        if (PAbility->getAddType() & ADDTYPE_AVATAR)
        {
            if (!PChar->PPet || PChar->PPet->objtype != TYPE_PET || static_cast<CPetEntity*>(PChar->PPet)->getPetType() != PET_TYPE::AVATAR)
            {
                return false;
            }
        }
        if (PAbility->getAddType() & ADDTYPE_AUTOMATON)
        {
            if (!PChar->PPet || PChar->PPet->objtype != TYPE_PET || static_cast<CPetEntity*>(PChar->PPet)->getPetType() != PET_TYPE::AUTOMATON)
            {
                return false;
            }
        }
        return true;
    }

    void RemoveStratagems(CCharEntity* PChar, CSpell* PSpell)
    {
        if (PSpell->getSpellGroup() == SPELLGROUP_WHITE)
        {
            // rapture to be deleted in applicable scripts
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_PENURY);
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_CELERITY);
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_ENLIGHTENMENT);
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_ALTRUISM);
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_TRANQUILITY);
            if (PSpell->getAOE() == SPELLAOE_RADIAL_ACCE)
            {
                PChar->StatusEffectContainer->DelStatusEffect(EFFECT_ACCESSION);
            }
            if (PSpell->getSkillType() == SKILL_ENHANCING_MAGIC)
            {
                PChar->StatusEffectContainer->DelStatusEffect(EFFECT_PERPETUANCE);
            }
        }
        else if (PSpell->getSpellGroup() == SPELLGROUP_BLACK)
        {
            // ebullience to be deleted in applicable scripts
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_PARSIMONY);
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_ALACRITY);
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_ENLIGHTENMENT);
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_FOCALIZATION);
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_EQUANIMITY);
            if (PSpell->getAOE() == SPELLAOE_RADIAL_MANI)
            {
                PChar->StatusEffectContainer->DelStatusEffect(EFFECT_MANIFESTATION);
            }
        }
    }

    void RemoveAllEquipMods(CCharEntity* PChar)
    {
        for (uint8 slotID = 0; slotID < 16; ++slotID)
        {
            CItemEquipment* PItem = PChar->getEquip((SLOTTYPE)slotID);
            if (PItem)
            {
                PChar->delEquipModifiers(&PItem->modList, PItem->getReqLvl(), slotID);
                if (PItem->getReqLvl() <= PChar->GetMLevel())
                {
                    PChar->PLatentEffectContainer->DelLatentEffects(PItem->getReqLvl(), slotID);
                    PChar->PLatentEffectContainer->CheckLatentsEquip(slotID);
                }
            }
        }
    }

    void ApplyAllEquipMods(CCharEntity* PChar)
    {
        for (uint8 slotID = 0; slotID < 16; ++slotID)
        {
            CItemEquipment* PItem = PChar->getEquip((SLOTTYPE)slotID);
            if (PItem)
            {
                PChar->addEquipModifiers(&PItem->modList, PItem->getReqLvl(), slotID);
                if (PItem->getReqLvl() <= PChar->GetMLevel())
                {
                    PChar->PLatentEffectContainer->AddLatentEffects(PItem->latentList, PItem->getReqLvl(), slotID);
                    PChar->PLatentEffectContainer->CheckLatentsEquip(slotID);
                }
            }
        }
    }

    void ClearTempItems(CCharEntity* PChar)
    {
        TracyZoneScoped;

        CItemContainer* Temp = PChar->getStorage(LOC_TEMPITEMS);

        const char* Query = "DELETE FROM char_inventory WHERE charid = %u AND location = 3";

        if (_sql->Query(Query, PChar->id) != SQL_ERROR)
        {
            Temp->Clear();
        }
    }

    void ReloadParty(CCharEntity* PChar)
    {
        TracyZoneScoped;

        int ret = _sql->Query("SELECT partyid, allianceid, partyflag & %d FROM accounts_sessions s JOIN accounts_parties p ON "
                              "s.charid = p.charid WHERE p.charid = %u",
                              (PARTY_SECOND | PARTY_THIRD), PChar->id);
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            uint32 partyid     = _sql->GetUIntData(0);
            uint32 allianceid  = _sql->GetUIntData(1);
            uint32 partynumber = _sql->GetUIntData(2);

            // first, parties and alliances must be created or linked if the character's current party has changed
            // for example, joining a party from another server
            if (PChar->PParty)
            {
                if (PChar->PParty->GetPartyID() != partyid)
                {
                    PChar->PParty->SetPartyID(partyid);
                }
            }
            else
            {
                // find if party exists on this server already
                CParty* PParty = nullptr;
                zoneutils::ForEachZone([partyid, &PParty](CZone* PZone)
                                       { PZone->ForEachChar([partyid, &PParty](CCharEntity* PChar)
                                                            {
                        if (PChar->PParty && PChar->PParty->GetPartyID() == partyid)
                        {
                            PParty = PChar->PParty;
                        } }); });

                // create new party if it doesn't exist already
                if (!PParty)
                {
                    PParty = new CParty(partyid);
                }

                PParty->PushMember(PChar);
            }

            CBattleEntity* PSyncTarget = PChar->PParty->GetSyncTarget();
            if (PSyncTarget && PChar->getZone() == PSyncTarget->getZone() && !(PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC)) &&
                PSyncTarget->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC) &&
                PSyncTarget->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC)->GetDuration() == 0)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, PSyncTarget->GetMLevel(), 540);
                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_SYNC, EFFECT_LEVEL_SYNC, PSyncTarget->GetMLevel(), 0, 0), true);
                PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE);
            }

            if (allianceid != 0)
            {
                if (PChar->PParty->m_PAlliance)
                {
                    if (PChar->PParty->m_PAlliance->m_AllianceID != allianceid)
                    {
                        PChar->PParty->m_PAlliance->m_AllianceID = allianceid;
                    }
                }
                else
                {
                    // find if the alliance exists on this server already
                    // clang-format off
                    CAlliance* PAlliance = nullptr;
                    zoneutils::ForEachZone([allianceid, &PAlliance](CZone* PZone)
                    {
                        PZone->ForEachChar([allianceid, &PAlliance](CCharEntity* PChar)
                        {
                            if (PChar->PParty && PChar->PParty->m_PAlliance && PChar->PParty->m_PAlliance->m_AllianceID == allianceid)
                            {
                                PAlliance = PChar->PParty->m_PAlliance;
                            }
                        });
                    });
                    // clang-format on

                    // create new alliance if it doesn't exist on this server already
                    if (!PAlliance)
                    {
                        PAlliance = new CAlliance(allianceid);
                    }

                    PAlliance->pushParty(PChar->PParty, partynumber);
                }
            }
            else if (PChar->PParty->m_PAlliance)
            {
                PChar->PParty->m_PAlliance->delParty(PChar->PParty);
            }

            // once parties and alliances have been reassembled, reload the party/parties
            PChar->PParty->ReloadParty();
        }
        else
        {
            if (PChar->PParty)
            {
                PChar->PParty->DelMember(PChar);
            }
            PChar->ReloadPartyDec();
        }

        // Attempt to disband party if the last trust was just released
        // NOTE: Trusts are not counted as party members, so the current member count will be 1
        if (PChar->PParty && PChar->PParty->HasOnlyOneMember() && PChar->PTrusts.empty())
        {
            // Looks good so far, check OTHER processes to see if we should disband
            if (PChar->PParty->GetMemberCountAcrossAllProcesses() == 1)
            {
                PChar->PParty->DisbandParty();
                destroy(PChar->PParty);
            }
        }
    }

    bool IsAidBlocked(CCharEntity* PInitiator, CCharEntity* PTarget)
    {
        if (PTarget->getBlockingAid())
        {
            // clang-format off
            bool inAlliance = false;
            PTarget->ForAlliance([&PInitiator, &inAlliance](CBattleEntity* PEntity)
            {
                if (PEntity->id == PInitiator->id)
                {
                    inAlliance = true;
                }
            });
            // clang-format on

            if (!inAlliance)
            {
                return true;
            }
        }
        return false;
    }

    // char_points manipulation
    void AddPoints(CCharEntity* PChar, const char* type, int32 amount, int32 max)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE char_points SET %s = GREATEST(LEAST(%s+%d, %d), 0) WHERE charid = %u";

        _sql->Query(Query, type, type, amount, max, PChar->id);

        if (strcmp(type, "unity_accolades") == 0 && amount > 0)
        {
            float       evalPoints   = static_cast<float>(amount) / 1000;
            const char* rankingQuery = "UPDATE unity_system SET points_current = points_current+%f WHERE leader=%d";

            AddPoints(PChar, "current_accolades", amount, std::numeric_limits<int32>::max()); // Do not cap current_accolades
            _sql->Query(rankingQuery, evalPoints, PChar->profile.unity_leader);
            roeutils::UpdateUnityTrust(PChar, true);

            PChar->pushPacket<CCharStatsPacket>(PChar);
        }
        else if (strcmp(type, "spark_of_eminence") == 0)
        {
            PChar->pushPacket<CRoeSparkUpdatePacket>(PChar);
        }
    }

    void SetPoints(CCharEntity* PChar, const char* type, int32 amount)
    {
        TracyZoneScoped;

        const char* Query = "UPDATE char_points SET %s = %d WHERE charid = %u";

        _sql->Query(Query, type, amount, PChar->id);

        if (strcmp(type, "spark_of_eminence") == 0)
        {
            PChar->pushPacket<CRoeSparkUpdatePacket>(PChar);
        }
    }

    int32 GetPoints(CCharEntity* PChar, const char* type)
    {
        TracyZoneScoped;

        const char* Query = "SELECT %s FROM char_points WHERE charid = %u";

        int ret = _sql->Query(Query, type, PChar->id);

        if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS)
        {
            return _sql->GetIntData(0);
        }
        return 0;
    }

    void SetUnityLeader(CCharEntity* PChar, uint8 leaderID)
    {
        TracyZoneScoped;

        const char* leaderQuery = "UPDATE char_profile SET unity_leader=%d WHERE charid = %u";

        if (leaderID < 1 || leaderID > 11)
        {
            return;
        }

        PChar->profile.unity_leader = leaderID;
        if (PChar->PUnityChat)
        {
            unitychat::DelOnlineMember(PChar, PChar->PUnityChat->getLeader());
        }
        unitychat::AddOnlineMember(PChar, PChar->profile.unity_leader);
        _sql->Query(leaderQuery, PChar->profile.unity_leader, PChar->id);
    }

    std::string GetConquestPointsName(CCharEntity* PChar)
    {
        switch (PChar->profile.nation)
        {
            case 0:
                return "sandoria_cp";
            case 1:
                return "bastok_cp";
            case 2:
                return "windurst_cp";
            default:
                ShowError("Invalid nation received, returning nullptr.");
                return nullptr;
        }
    }

    void SendToZone(CCharEntity* PChar, uint8 type, uint64 ipp)
    {
        TracyZoneScoped;

        if (type == 2)
        {
            auto ip   = (uint32)ipp;
            auto port = (uint32)(ipp >> 32);
            _sql->Query("UPDATE accounts_sessions SET server_addr = %u, server_port = %u WHERE charid = %u",
                        ip, port, PChar->id);

            const char* Query = "UPDATE chars "
                                "SET "
                                "pos_zone = %u,"
                                "pos_prevzone = %u,"
                                "pos_rot = %u,"
                                "pos_x = %.3f,"
                                "pos_y = %.3f,"
                                "pos_z = %.3f,"
                                "moghouse = %u,"
                                "boundary = %u "
                                "WHERE charid = %u";

            _sql->Query(Query, PChar->loc.destination,
                        (PChar->m_moghouseID || PChar->loc.destination == PChar->getZone()) ? PChar->loc.prevzone : PChar->getZone(), PChar->loc.p.rotation,
                        PChar->loc.p.x, PChar->loc.p.y, PChar->loc.p.z, PChar->m_moghouseID, PChar->loc.boundary, PChar->id);
        }
        else
        {
            SaveCharPosition(PChar);
        }

        if (PChar->shouldPetPersistThroughZoning())
        {
            PChar->setPetZoningInfo();
        }
        else
        {
            PChar->resetPetZoningInfo();
        }

        // If player somehow gets zoned, force crit fail their synth
        if (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0)
        {
            charutils::forceSynthCritFail("SendToZone", PChar);
        }

        PChar->pushPacket<CServerIPPacket>(PChar, type, ipp);

        removeCharFromZone(PChar);
    }

    void ForceLogout(CCharEntity* PChar)
    {
        PChar->status = STATUS_TYPE::SHUTDOWN;
        charutils::SendToZone(PChar, 1, 0);
    }

    void ForceRezone(CCharEntity* PChar)
    {
        PChar->loc.destination = PChar->getZone();
        PChar->status          = STATUS_TYPE::DISAPPEAR;
        PChar->loc.boundary    = 0;

        PChar->clearPacketList();

        SendToZone(PChar, 2, zoneutils::GetZoneIPP(PChar->loc.destination));
    }

    void HomePoint(CCharEntity* PChar, bool resetHPMP)
    {
        TracyZoneScoped;

        // player initiated warp/warp 2 or otherwise
        if (resetHPMP)
        {
            // remove weakness on homepoint
            PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_WEAKNESS);
            PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_SYNC);

            PChar->SetDeathTimestamp(0);

            PChar->health.hp = PChar->GetMaxHP();
            PChar->health.mp = PChar->GetMaxMP();
        }

        PChar->loc.boundary    = 0;
        PChar->loc.p           = PChar->profile.home_point.p;
        PChar->loc.destination = PChar->profile.home_point.destination;

        PChar->status    = STATUS_TYPE::DISAPPEAR;
        PChar->animation = ANIMATION_NONE;
        PChar->updatemask |= UPDATE_HP;

        PChar->clearPacketList();
        SendToZone(PChar, 2, zoneutils::GetZoneIPP(PChar->loc.destination));
    }

    bool AddWeaponSkillPoints(CCharEntity* PChar, SLOTTYPE slotid, int wspoints)
    {
        TracyZoneScoped;

        CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[slotid]);

        if (PWeapon && PWeapon->isUnlockable() && !PWeapon->isUnlocked())
        {
            if (PWeapon->addWsPoints(wspoints))
            {
                // weapon is now broken
                PChar->PLatentEffectContainer->CheckLatentsWeaponBreak(slotid);
                PChar->pushPacket<CCharStatsPacket>(PChar);
            }
            char extra[sizeof(PWeapon->m_extra) * 2 + 1];
            _sql->EscapeStringLen(extra, (const char*)PWeapon->m_extra, sizeof(PWeapon->m_extra));

            const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u LIMIT 1";
            _sql->Query(Query, extra, PChar->id, PWeapon->getLocationID(), PWeapon->getSlotID());
            return true;
        }
        return false;
    }

    int32 GetCharVar(CCharEntity* PChar, std::string const& var)
    {
        if (PChar == nullptr)
        {
            return 0;
        }

        return PChar->getCharVar(var);
    }

    void SetCharVar(uint32 charId, std::string const& var, int32 value, uint32 expiry /* = 0 */)
    {
        if (auto player = zoneutils::GetChar(charId))
        {
            player->setCharVar(var, value, expiry);
            return;
        }

        PersistCharVar(charId, var, value, expiry);
        message::send_charvar_update(charId, var, value, expiry);
    }

    void SetCharVar(CCharEntity* PChar, std::string const& var, int32 value, uint32 expiry /* = 0 */)
    {
        if (PChar == nullptr)
        {
            return;
        }

        return PChar->setCharVar(var, value, expiry);
    }

    int32 ClearCharVarsWithPrefix(CCharEntity* PChar, std::string const& prefix)
    {
        if (PChar == nullptr)
        {
            return 0;
        }

        PChar->clearCharVarsWithPrefix(prefix);
        return 0;
    }

    int32 RemoveCharVarsWithTag(CCharEntity* PChar, std::string const& varsTag)
    {
        if (PChar == nullptr)
        {
            return 0;
        }

        PChar->clearCharVarsWithPrefix(fmt::sprintf("[%s]", varsTag));
        return 0;
    }

    void ClearCharVarFromAll(std::string const& varName, bool localOnly)
    {
        if (!localOnly)
        {
            _sql->Query("DELETE FROM char_vars WHERE varname = '%s'", varName);
        }

        // clang-format off
        zoneutils::ForEachZone([varName](CZone* PZone)
        {
            PZone->ForEachChar([varName](CCharEntity* PChar)
            {
                PChar->updateCharVarCache(varName, 0);
            });
        });
        // clang-format on
    }

    void IncrementCharVar(CCharEntity* PChar, std::string const& var, int32 value)
    {
        if (PChar == nullptr)
        {
            return;
        }

        const char* Query = "INSERT INTO char_vars SET charid = %u, varname = '%s', value = %i ON DUPLICATE KEY UPDATE value = value + %i";

        _sql->Query(Query, PChar->id, var, value, value);

        PChar->removeFromCharVarCache(var);
    }

    auto FetchCharVar(uint32 charId, std::string const& varName) -> std::pair<int32, uint32>
    {
        const char* fmtQuery = "SELECT value, expiry FROM char_vars WHERE charid = %u AND varname = '%s' LIMIT 1";

        int32 ret = _sql->Query(fmtQuery, charId, varName);

        int32  value  = 0;
        uint32 expiry = 0;
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            value  = _sql->GetIntData(0);
            expiry = _sql->GetUIntData(1);

            uint32 currentTimestamp = CVanaTime::getInstance()->getSysTime();

            if (expiry > 0 && expiry <= currentTimestamp)
            {
                value = 0;
                _sql->Query("DELETE FROM char_vars WHERE charid = %u AND varname = '%s'", charId, varName);
            }
        }

        return { value, expiry };
    }

    void PersistCharVar(uint32 charId, std::string const& var, int32 value, uint32 expiry /* = 0 */)
    {
        if (value == 0)
        {
            _sql->Query("DELETE FROM char_vars WHERE charid = %u AND varname = '%s' LIMIT 1", charId, var);
        }
        else
        {
            _sql->Query("INSERT INTO char_vars SET charid = %u, varname = '%s', value = %i, expiry = %d ON DUPLICATE KEY UPDATE value = %i, expiry = %i", charId, var, value, expiry, value, expiry);
        }
    }

    uint16 getWideScanRange(JOBTYPE job, uint8 level)
    {
        // Set Widescan range
        // Distances need verified, based current values off what we had in traits.sql and data at http://wiki.ffxiclopedia.org/wiki/Wide_Scan
        // NOTE: Widescan was formerly piggy backed onto traits (resist slow) but is not a real trait, any attempt to give it a trait will place a dot on
        // characters trait menu.

        // Limit to BST and RNG, and try to use old distance values for tiers
        if (job == JOB_RNG)
        {
            // Range for RNG >=80 needs verification.
            if (level >= 80)
            {
                return 350;
            }
            else if (level >= 60)
            {
                return 300;
            }
            else if (level >= 40)
            {
                return 250;
            }
            else if (level >= 20)
            {
                return 200;
            }
            else
            {
                return 150;
            }
        }
        else if (job == JOB_BST)
        {
            if (level >= 80)
            {
                return 300;
            }
            else if (level >= 60)
            {
                return 250;
            }
            else if (level >= 40)
            {
                return 200;
            }
            else if (level >= 20 || settings::get<bool>("map.ALL_JOBS_WIDESCAN"))
            {
                return 150;
            }
            else
            {
                return 50;
            }
        }

        // Default to base widescan if not RNG or BST
        if (settings::get<bool>("map.ALL_JOBS_WIDESCAN"))
        {
            return 150;
        }
        else
        {
            return 0;
        }
    }

    uint16 getWideScanRange(CCharEntity* PChar)
    {
        // Get maximum widescan range from main job or sub job
        return std::max(getWideScanRange(PChar->GetMJob(), PChar->GetMLevel()), getWideScanRange(PChar->GetSJob(), PChar->GetSLevel()));
    }

    void SendTimerPacket(CCharEntity* PChar, uint32 seconds)
    {
        PChar->pushPacket<CObjectiveUtilityPacket>(seconds);
    }

    void SendTimerPacket(CCharEntity* PChar, duration dur)
    {
        auto timeLimitSeconds = static_cast<uint32>(std::chrono::duration_cast<std::chrono::seconds>(dur).count());
        SendTimerPacket(PChar, timeLimitSeconds);
    }

    void SendClearTimerPacket(CCharEntity* PChar)
    {
        PChar->pushPacket<CObjectiveUtilityPacket>();
    }

    time_t getTraverserEpoch(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto fmtQuery = "SELECT unix_timestamp(traverser_start) FROM char_unlocks WHERE charid = %u";

        auto ret = _sql->Query(fmtQuery, PChar->id);
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            return _sql->GetUIntData(0);
        }

        return 0;
    }

    // TODO: Perhaps allow for optional argument to support GM Commands
    void setTraverserEpoch(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto fmtQuery = "UPDATE char_unlocks SET traverser_start = CURRENT_TIMESTAMP() WHERE charid = %u";

        _sql->Query(fmtQuery, PChar->id);
    }

    uint32 getClaimedTraverserStones(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto fmtQuery = "SELECT traverser_claimed FROM char_unlocks WHERE charid = %u";

        auto ret = _sql->Query(fmtQuery, PChar->id);
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            return _sql->GetUIntData(0);
        }

        return 0;
    }

    void addClaimedTraverserStones(CCharEntity* PChar, uint16 numStones)
    {
        TracyZoneScoped;

        auto fmtQuery = "UPDATE char_unlocks SET traverser_claimed = traverser_claimed + %u WHERE charid = %u";

        _sql->Query(fmtQuery, numStones, PChar->id);
    }

    void setClaimedTraverserStones(CCharEntity* PChar, uint16 stoneTotal)
    {
        TracyZoneScoped;

        auto fmtQuery = "UPDATE char_unlocks SET traverser_claimed = %u WHERE charid = %u";

        _sql->Query(fmtQuery, stoneTotal, PChar->id);
    }

    uint32 getAvailableTraverserStones(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto   fmtQuery         = "SELECT unix_timestamp(traverser_start), traverser_claimed FROM char_unlocks WHERE charid = %u";
        time_t traverserEpoch   = 0;
        uint32 traverserClaimed = 0;

        auto ret = _sql->Query(fmtQuery, PChar->id);
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            traverserEpoch   = _sql->GetUIntData(0);
            traverserClaimed = _sql->GetUIntData(1);
        }

        if (traverserEpoch == 0)
        {
            // Players cannot accrue Traverser Stones until the epoch has been set.  This is not possible
            // in quests, but is always displayed in player currencies.
            return 0;
        }

        // Handle reduction for Celerity Key Items
        uint8 stoneWaitHours = 20;
        for (int keyItem = 1385; keyItem <= 1387; ++keyItem)
        {
            if (hasKeyItem(PChar, keyItem))
            {
                stoneWaitHours -= 4;
            }
        }

        return floor((std::time(nullptr) - traverserEpoch) / (stoneWaitHours * 3600)) - traverserClaimed;
    }

    void ReadHistory(CCharEntity* PChar)
    {
        TracyZoneScoped;

        if (PChar == nullptr)
        {
            return;
        }

        auto fmtQuery = "SELECT "
                        "enemies_defeated, "  // 0
                        "times_knocked_out, " // 1
                        "mh_entrances, "      // 2
                        "joined_parties, "    // 3
                        "joined_alliances, "  // 4
                        "spells_cast, "       // 5
                        "abilities_used, "    // 6
                        "ws_used, "           // 7
                        "items_used, "        // 8
                        "chats_sent, "        // 9
                        "npc_interactions, "  // 10
                        "battles_fought, "    // 11
                        "gm_calls, "          // 12
                        "distance_travelled " // 13
                        "FROM char_history "
                        "WHERE charid = %u";

        auto ret = _sql->Query(fmtQuery, PChar->id);
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            PChar->m_charHistory.enemiesDefeated   = _sql->GetUIntData(0);
            PChar->m_charHistory.timesKnockedOut   = _sql->GetUIntData(1);
            PChar->m_charHistory.mhEntrances       = _sql->GetUIntData(2);
            PChar->m_charHistory.joinedParties     = _sql->GetUIntData(3);
            PChar->m_charHistory.joinedAlliances   = _sql->GetUIntData(4);
            PChar->m_charHistory.spellsCast        = _sql->GetUIntData(5);
            PChar->m_charHistory.abilitiesUsed     = _sql->GetUIntData(6);
            PChar->m_charHistory.wsUsed            = _sql->GetUIntData(7);
            PChar->m_charHistory.itemsUsed         = _sql->GetUIntData(8);
            PChar->m_charHistory.chatsSent         = _sql->GetUIntData(9);
            PChar->m_charHistory.npcInteractions   = _sql->GetUIntData(10);
            PChar->m_charHistory.battlesFought     = _sql->GetUIntData(11);
            PChar->m_charHistory.gmCalls           = _sql->GetUIntData(12);
            PChar->m_charHistory.distanceTravelled = _sql->GetUIntData(13);
        }
    }

    void WriteHistory(CCharEntity* PChar)
    {
        TracyZoneScoped;

        if (PChar == nullptr)
        {
            return;
        }

        // Replace will also handle insert if it doesn't exist
        auto fmtQuery = "REPLACE INTO char_history "
                        "(charid, enemies_defeated, times_knocked_out, mh_entrances, joined_parties, joined_alliances, spells_cast, "
                        "abilities_used, ws_used, items_used, chats_sent, npc_interactions, battles_fought, gm_calls, distance_travelled) "
                        "VALUES("
                        "%u, " // charid
                        "%u, " // 0 enemies_defeated
                        "%u, " // 1 times_knocked_out
                        "%u, " // 2 mh_entrances
                        "%u, " // 3 joined_parties
                        "%u, " // 4 joined_alliances
                        "%u, " // 5 spells_cast
                        "%u, " // 6 abilities_used
                        "%u, " // 7 ws_used
                        "%u, " // 8 items_used
                        "%u, " // 9 chats_sent
                        "%u, " // 10 npc_interactions
                        "%u, " // 11 battles_fought
                        "%u, " // 12 gm_calls
                        "%u"   // 13 distance_travelled
                        ")";

        auto ret = _sql->Query(fmtQuery,
                               PChar->id,
                               PChar->m_charHistory.enemiesDefeated,
                               PChar->m_charHistory.timesKnockedOut,
                               PChar->m_charHistory.mhEntrances,
                               PChar->m_charHistory.joinedParties,
                               PChar->m_charHistory.joinedAlliances,
                               PChar->m_charHistory.spellsCast,
                               PChar->m_charHistory.abilitiesUsed,
                               PChar->m_charHistory.wsUsed,
                               PChar->m_charHistory.itemsUsed,
                               PChar->m_charHistory.chatsSent,
                               PChar->m_charHistory.npcInteractions,
                               PChar->m_charHistory.battlesFought,
                               PChar->m_charHistory.gmCalls,
                               PChar->m_charHistory.distanceTravelled);

        if (ret == SQL_ERROR)
        {
            ShowError("Error writing char history for: '%s'", PChar->name.c_str());
        }
    }

    uint8 getMaxItemLevel(CCharEntity* PChar)
    {
        uint8 maxItemLevel = 0;

        for (uint8 slotID = 0; slotID < 16; ++slotID)
        {
            CItemEquipment* PItem = PChar->getEquip((SLOTTYPE)slotID);

            if (PItem && PItem->getILvl() > maxItemLevel)
            {
                maxItemLevel = PItem->getILvl();
            }
        }

        return maxItemLevel;
    }

    uint8 getItemLevelDifference(CCharEntity* PChar)
    {
        float itemLevelDiff = 0;
        uint8 highestItem   = 0;

        // Find the highest iLevel in weapons, this is 50% of the iLvl diff value
        for (uint8 slotID = 0; slotID < 4; ++slotID)
        {
            CItemEquipment* PItem = PChar->getEquip((SLOTTYPE)slotID);

            if (PItem && PItem->getILvl() > highestItem)
            {
                highestItem = PItem->getILvl();
            }
        }

        if (highestItem > 99)
        {
            itemLevelDiff += (highestItem - 99) / 2.f;
        }

        for (uint8 slotID = 4; slotID < 9; ++slotID)
        {
            CItemEquipment* PItem = PChar->getEquip((SLOTTYPE)slotID);

            if (PItem && PItem->getILvl() > 99)
            {
                itemLevelDiff += (PItem->getILvl() - 99) / 10.f;
            }
        }

        return floor(itemLevelDiff);
    }

    uint8 getMainhandItemLevel(CCharEntity* PChar)
    {
        CItemEquipment* PItem = PChar->getEquip(SLOTTYPE::SLOT_MAIN);

        if (PItem)
        {
            return PItem->getILvl();
        }

        return 0;
    }

    // Return Ranged Weapon Item Level; If ranged slot exists use that, else use Ammo
    uint8 getRangedItemLevel(CCharEntity* PChar)
    {
        CItemEquipment* PItem = PChar->getEquip(SLOTTYPE::SLOT_RANGED);
        if (PItem)
        {
            return PItem->getILvl();
        }

        PItem = PChar->getEquip(SLOTTYPE::SLOT_AMMO);
        if (PItem)
        {
            return PItem->getILvl();
        }

        return 0;
    }

    bool hasEntitySpawned(CCharEntity* PChar, CBaseEntity* entity)
    {
        SpawnIDList_t* spawnlist = nullptr;

        if (!entity)
        {
            return false;
        }

        if (entity->objtype == TYPE_MOB)
        {
            spawnlist = &PChar->SpawnMOBList;
        }
        else if (entity->objtype == TYPE_NPC)
        {
            spawnlist = &PChar->SpawnNPCList;
        }
        else if (entity->objtype == TYPE_PC)
        {
            spawnlist = &PChar->SpawnPCList;
        }
        else if (entity->objtype == TYPE_PET)
        {
            spawnlist = &PChar->SpawnPETList;
        }
        else if (entity->objtype == TYPE_TRUST)
        {
            spawnlist = &PChar->SpawnTRUSTList;
        }
        else
        {
            return false;
        }

        return spawnlist->find(entity->id) != spawnlist->end();
    }

    uint32 getCharIdFromName(std::string const& name)
    {
        TracyZoneScoped;

        auto ret = _sql->Query("SELECT charid FROM chars WHERE charname = '%s' LIMIT 1", name.c_str());
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            return _sql->GetUIntData(0);
        }
        return 0;
    }

    void forceSynthCritFail(const std::string& sourceFunction, CCharEntity* PChar)
    {
        // NOTE:
        // Supposed non-losable items are reportedly lost if this condition is met:
        // https://ffxiclopedia.fandom.com/wiki/Lu_Shang%27s_Fishing_Rod
        // The broken rod can never be lost in a normal failed synth. It will only be lost if the synth is
        // interrupted in some way, such as by being attacked or moving to another area (e.g. ship docking).

        ShowWarning("%s: %s attempting to zone in the middle of a synth, failing their synth!", sourceFunction, PChar->getName());
        PChar->setModifier(Mod::SYNTH_MATERIAL_LOSS, -1000); // Force crit fail
        synthutils::doSynthFail(PChar, true);

        PChar->CraftContainer->Clean(); // Clean to reset m_ItemCount to 0
    }

    void removeCharFromZone(CCharEntity* PChar)
    {
        map_session_data_t* PSession = nullptr;

        for (auto session : map_session_list)
        {
            if (session.second->charID == PChar->id)
            {
                PSession = session.second;
                break;
            }
        }

        // Store old blowfish, recalculate expected new blowfish
        if (PSession)
        {
            PSession->blowfish.status = BLOWFISH_PENDING_ZONE;
        }

        PChar->TradePending.clean();
        PChar->InvitePending.clean();

        PChar->WideScanTarget = std::nullopt;

        if (PChar->animation == ANIMATION_ATTACK)
        {
            PChar->animation = ANIMATION_NONE;
            PChar->updatemask |= UPDATE_HP;
        }

        if (!PChar->PTrusts.empty())
        {
            PChar->ClearTrusts();
        }

        if (PChar->status == STATUS_TYPE::SHUTDOWN)
        {
            if (PChar->PParty != nullptr)
            {
                if (PChar->PParty->m_PAlliance != nullptr)
                {
                    if (PChar->PParty->GetLeader() == PChar)
                    {
                        if (PChar->PParty->HasOnlyOneMember())
                        {
                            if (PChar->PParty->m_PAlliance->hasOnlyOneParty())
                            {
                                PChar->PParty->m_PAlliance->dissolveAlliance();
                            }
                            else
                            {
                                PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                            }
                        }
                        else
                        { // party leader logged off - will pass party lead
                            PChar->PParty->RemoveMember(PChar);
                        }
                    }
                    else
                    { // not party leader - just drop from party
                        PChar->PParty->RemoveMember(PChar);
                    }
                }
                else
                {
                    // normal party - just drop group
                    PChar->PParty->RemoveMember(PChar);
                }
            }

            if (PChar->shouldPetPersistThroughZoning())
            {
                PChar->setPetZoningInfo();
            }
            else
            {
                PChar->resetPetZoningInfo();
            }

            PSession->shuttingDown = 1;
            _sql->Query("UPDATE char_stats SET zoning = 0 WHERE charid = %u", PChar->id);
        }
        else
        {
            PSession->shuttingDown = 2;
            _sql->Query("UPDATE char_stats SET zoning = 1 WHERE charid = %u", PChar->id);
            charutils::CheckEquipLogic(PChar, SCRIPT_CHANGEZONE, PChar->getZone());
        }

        if (PChar->loc.zone != nullptr)
        {
            PChar->loc.zone->DecreaseZoneCounter(PChar);
        }

        PChar->StatusEffectContainer->SaveStatusEffects(PSession->shuttingDown == 1);
        PChar->PersistData();
        charutils::SavePlayTime(PChar);
        charutils::SaveCharStats(PChar);
        charutils::SaveCharExp(PChar, PChar->GetMJob());
        charutils::SaveEminenceData(PChar);

        PChar->status = STATUS_TYPE::DISAPPEAR;
    }

    bool isOrchestrionPlaced(CCharEntity* PChar)
    {
        for (auto safeContainerId : { LOC_MOGSAFE, LOC_MOGSAFE2 })
        {
            CItemContainer* PContainer = PChar->getStorage(safeContainerId);
            for (int slotIndex = 1; slotIndex <= PContainer->GetSize(); ++slotIndex)
            {
                CItem* PContainerItem = PContainer->GetItem(slotIndex);
                if (PContainerItem != nullptr && PContainerItem->isType(ITEM_FURNISHING))
                {
                    CItemFurnishing* PFurniture = static_cast<CItemFurnishing*>(PContainerItem);
                    if (PFurniture->isInstalled() && PFurniture->getID() == 426)
                    {
                        return true;
                    }
                }
            }
        }

        return false;
    }
}; // namespace charutils
