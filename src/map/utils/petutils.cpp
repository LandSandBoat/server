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

#include "common/timer.h"
#include "common/utils.h"

#include <cmath>
#include <cstring>
#include <vector>

#include "ability.h"
#include "battleutils.h"
#include "charutils.h"
#include "enmity_container.h"
#include "entities/automatonentity.h"
#include "entities/mobentity.h"
#include "grades.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "map.h"
#include "mob_spell_list.h"
#include "notoriety_container.h"
#include "petutils.h"
#include "puppetutils.h"
#include "status_effect_container.h"
#include "zone_instance.h"
#include "zoneutils.h"

#include "ai/ai_container.h"
#include "ai/controllers/automaton_controller.h"
#include "ai/controllers/mob_controller.h"
#include "ai/controllers/pet_controller.h"
#include "ai/states/ability_state.h"

#include "mob_modifier.h"
#include "packets/char_abilities.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/entity_update.h"
#include "packets/message_standard.h"
#include "packets/pet_sync.h"

std::vector<Pet_t*> g_PPetList;

namespace petutils
{

    void LoadPetList()
    {
        FreePetList();

        const char* Query = "SELECT\
                pet_list.petid,\
                pet_list.name,\
                modelid,\
                minLevel,\
                maxLevel,\
                time,\
                mobradius,\
                ecosystemID,\
                mob_pools.familyid,\
                mob_pools.mJob,\
                mob_pools.sJob,\
                pet_list.element,\
                (mob_family_system.HP / 100),\
                (mob_family_system.MP / 100),\
                mob_family_system.speed,\
                mob_family_system.STR,\
                mob_family_system.DEX,\
                mob_family_system.VIT,\
                mob_family_system.AGI,\
                mob_family_system.INT,\
                mob_family_system.MND,\
                mob_family_system.CHR,\
                mob_family_system.DEF,\
                mob_family_system.ATT,\
                mob_family_system.ACC, \
                mob_family_system.EVA, \
                hasSpellScript, spellList, \
                slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, \
                magical_sdt, fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, \
                fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, \
                cmbDelay, name_prefix, mob_pools.skill_list_id, damageType \
                FROM pet_list, mob_pools, mob_resistances, mob_family_system \
                WHERE pet_list.poolid = mob_pools.poolid AND mob_resistances.resist_id = mob_pools.resist_id AND mob_pools.familyid = mob_family_system.familyID";

        if (_sql->Query(Query) != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                Pet_t* Pet = new Pet_t();

                Pet->PetID = (uint16)_sql->GetIntData(0);
                Pet->name.insert(0, (const char*)_sql->GetData(1));

                uint16 sqlModelID[10];
                std::memcpy(&sqlModelID, _sql->GetData(2), 20);
                Pet->look = look_t(sqlModelID);

                Pet->minLevel  = (uint8)_sql->GetIntData(3);
                Pet->maxLevel  = (uint8)_sql->GetIntData(4);
                Pet->time      = _sql->GetUIntData(5);
                Pet->radius    = _sql->GetUIntData(6);
                Pet->EcoSystem = (ECOSYSTEM)_sql->GetIntData(7);
                Pet->m_Family  = (uint16)_sql->GetIntData(8);
                Pet->mJob      = (uint8)_sql->GetIntData(9);
                Pet->sJob      = (uint8)_sql->GetIntData(10);
                Pet->m_Element = (uint8)_sql->GetIntData(11);

                Pet->HPscale = _sql->GetFloatData(12);
                Pet->MPscale = _sql->GetFloatData(13);

                Pet->speed = (uint8)_sql->GetIntData(14);

                Pet->strRank = (uint8)_sql->GetIntData(15);
                Pet->dexRank = (uint8)_sql->GetIntData(16);
                Pet->vitRank = (uint8)_sql->GetIntData(17);
                Pet->agiRank = (uint8)_sql->GetIntData(18);
                Pet->intRank = (uint8)_sql->GetIntData(19);
                Pet->mndRank = (uint8)_sql->GetIntData(20);
                Pet->chrRank = (uint8)_sql->GetIntData(21);
                Pet->defRank = (uint8)_sql->GetIntData(22);
                Pet->attRank = (uint8)_sql->GetIntData(23);
                Pet->accRank = (uint8)_sql->GetIntData(24);
                Pet->evaRank = (uint8)_sql->GetIntData(25);

                Pet->hasSpellScript = (bool)_sql->GetIntData(26);

                Pet->spellList = (uint8)_sql->GetIntData(27);

                // Specific Dmage Taken, as a %
                Pet->slash_sdt  = (uint16)(_sql->GetFloatData(28) * 1000);
                Pet->pierce_sdt = (uint16)(_sql->GetFloatData(29) * 1000);
                Pet->hth_sdt    = (uint16)(_sql->GetFloatData(30) * 1000);
                Pet->impact_sdt = (uint16)(_sql->GetFloatData(31) * 1000);

                Pet->magical_sdt = (int16)_sql->GetIntData(32); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

                Pet->fire_sdt    = (int16)_sql->GetIntData(33); // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
                Pet->ice_sdt     = (int16)_sql->GetIntData(34); // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
                Pet->wind_sdt    = (int16)_sql->GetIntData(35); // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
                Pet->earth_sdt   = (int16)_sql->GetIntData(36); // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
                Pet->thunder_sdt = (int16)_sql->GetIntData(37); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
                Pet->water_sdt   = (int16)_sql->GetIntData(38); // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
                Pet->light_sdt   = (int16)_sql->GetIntData(39); // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
                Pet->dark_sdt    = (int16)_sql->GetIntData(40); // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

                // resistances
                Pet->fire_res_rank    = (int8)_sql->GetIntData(41);
                Pet->ice_res_rank     = (int8)_sql->GetIntData(42);
                Pet->wind_res_rank    = (int8)_sql->GetIntData(43);
                Pet->earth_res_rank   = (int8)_sql->GetIntData(44);
                Pet->thunder_res_rank = (int8)_sql->GetIntData(45);
                Pet->water_res_rank   = (int8)_sql->GetIntData(46);
                Pet->light_res_rank   = (int8)_sql->GetIntData(47);
                Pet->dark_res_rank    = (int8)_sql->GetIntData(48);

                Pet->cmbDelay       = (uint16)_sql->GetIntData(49);
                Pet->name_prefix    = (uint8)_sql->GetUIntData(50);
                Pet->m_MobSkillList = (uint16)_sql->GetUIntData(51);
                Pet->m_dmgType      = (DAMAGE_TYPE)_sql->GetUIntData(52);

                g_PPetList.emplace_back(Pet);
            }
        }
    }

    void FreePetList()
    {
        while (!g_PPetList.empty())
        {
            destroy(*g_PPetList.begin());
            g_PPetList.erase(g_PPetList.begin());
        }
    }

    void AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget)
    {
        if (PMaster == nullptr || PMaster->PPet == nullptr || PTarget == nullptr)
        {
            ShowWarning("petutils::AttackTarget() - Null master, pet, or target passed to function.");
            return;
        }

        CBattleEntity* PPet = PMaster->PPet;

        if (!PPet->StatusEffectContainer->HasPreventActionEffect())
        {
            PPet->PAI->Engage(PTarget->targid);
        }
    }

    void RetreatToMaster(CBattleEntity* PMaster)
    {
        if (PMaster == nullptr || PMaster->PPet == nullptr)
        {
            ShowWarning("petutils::RetreatToMaster() - Null master or pet passed to function.");
            return;
        }

        CBattleEntity* PPet = PMaster->PPet;

        if (!PPet->StatusEffectContainer->HasPreventActionEffect())
        {
            PPet->PAI->Disengage();
        }
    }

    uint16 GetJugWeaponDamage(CPetEntity* PPet)
    {
        float MainLevel = PPet->GetMLevel();
        return (uint16)(MainLevel * (MainLevel < 40 ? 1.4 - MainLevel / 100 : 1));
    }
    uint16 GetJugBase(CPetEntity* PMob, uint8 rank)
    {
        uint8 lvl = PMob->GetMLevel();
        if (lvl > 50)
        {
            switch (rank)
            {
                case 1:
                    return (uint16)(153 + (lvl - 50) * 5.0f);
                case 2:
                    return (uint16)(147 + (lvl - 50) * 4.9f);
                case 3:
                    return (uint16)(136 + (lvl - 50) * 4.8f);
                case 4:
                    return (uint16)(126 + (lvl - 50) * 4.7f);
                case 5:
                    return (uint16)(116 + (lvl - 50) * 4.5f);
                case 6:
                    return (uint16)(106 + (lvl - 50) * 4.4f);
                case 7:
                    return (uint16)(96 + (lvl - 50) * 4.3f);
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
        return 0;
    }
    uint16 GetBaseToRank(uint8 rank, uint16 lvl)
    {
        switch (rank)
        {
            case 1:
                return (5 + ((lvl - 1) * 50) / 100);
            case 2:
                return (4 + ((lvl - 1) * 45) / 100);
            case 3:
                return (4 + ((lvl - 1) * 40) / 100);
            case 4:
                return (3 + ((lvl - 1) * 35) / 100);
            case 5:
                return (3 + ((lvl - 1) * 30) / 100);
            case 6:
                return (2 + ((lvl - 1) * 25) / 100);
            case 7:
                return (2 + ((lvl - 1) * 20) / 100);
        }
        return 0;
    }

    void LoadJugStats(CPetEntity* PMob, Pet_t* petStats)
    {
        // follows monster formulas but jugs have no subjob

        float growth = 1.0;
        uint8 lvl    = PMob->GetMLevel();

        // give hp boost every 10 levels after 25
        // special boosts at 25 and 50
        if (lvl > 75)
        {
            growth = 1.22f;
        }
        else if (lvl > 65)
        {
            growth = 1.20f;
        }
        else if (lvl > 55)
        {
            growth = 1.18f;
        }
        else if (lvl > 50)
        {
            growth = 1.16f;
        }
        else if (lvl > 45)
        {
            growth = 1.12f;
        }
        else if (lvl > 35)
        {
            growth = 1.09f;
        }
        else if (lvl > 25)
        {
            growth = 1.07f;
        }

        PMob->health.maxhp = (int16)(17.0 * pow(lvl, growth) * petStats->HPscale);

        switch (PMob->GetMJob())
        {
            case JOB_PLD:
            case JOB_WHM:
            case JOB_BLM:
            case JOB_RDM:
            case JOB_DRK:
            case JOB_BLU:
            case JOB_SCH:
                PMob->health.maxmp = (int16)(15.2 * pow(lvl, 1.1075) * petStats->MPscale);
                break;
            default:
                break;
        }

        PMob->baseSpeed      = petStats->speed;
        PMob->animationSpeed = petStats->speed;
        PMob->UpdateSpeed();

        PMob->UpdateHealth();
        PMob->health.tp = 0;
        PMob->health.hp = PMob->GetMaxHP();
        PMob->health.mp = PMob->GetMaxMP();

        PMob->setModifier(Mod::DEF, GetJugBase(PMob, petStats->defRank));
        PMob->setModifier(Mod::EVA, GetJugBase(PMob, petStats->evaRank));
        PMob->setModifier(Mod::ATT, GetJugBase(PMob, petStats->attRank));
        PMob->setModifier(Mod::ACC, GetJugBase(PMob, petStats->accRank));

        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setDamage(GetJugWeaponDamage(PMob));

        // reduce weapon delay of MNK
        if (PMob->GetMJob() == JOB_MNK)
        {
            static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->resetDelay();
        }

        uint16 fSTR = GetBaseToRank(petStats->strRank, PMob->GetMLevel());
        uint16 fDEX = GetBaseToRank(petStats->dexRank, PMob->GetMLevel());
        uint16 fVIT = GetBaseToRank(petStats->vitRank, PMob->GetMLevel());
        uint16 fAGI = GetBaseToRank(petStats->agiRank, PMob->GetMLevel());
        uint16 fINT = GetBaseToRank(petStats->intRank, PMob->GetMLevel());
        uint16 fMND = GetBaseToRank(petStats->mndRank, PMob->GetMLevel());
        uint16 fCHR = GetBaseToRank(petStats->chrRank, PMob->GetMLevel());

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 2), PMob->GetMLevel());
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 3), PMob->GetMLevel());
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 4), PMob->GetMLevel());
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 5), PMob->GetMLevel());
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 6), PMob->GetMLevel());
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 7), PMob->GetMLevel());
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 8), PMob->GetMLevel());

        PMob->stats.STR = (uint16)((fSTR + mSTR) * 0.9f);
        PMob->stats.DEX = (uint16)((fDEX + mDEX) * 0.9f);
        PMob->stats.VIT = (uint16)((fVIT + mVIT) * 0.9f);
        PMob->stats.AGI = (uint16)((fAGI + mAGI) * 0.9f);
        PMob->stats.INT = (uint16)((fINT + mINT) * 0.9f);
        PMob->stats.MND = (uint16)((fMND + mMND) * 0.9f);
        PMob->stats.CHR = (uint16)((fCHR + mCHR) * 0.9f);
    }

    void LoadAutomatonStats(CCharEntity* PMaster, CPetEntity* PPet, Pet_t* petStats, uint8 mlvl, JOBTYPE mjob, JOBTYPE sjob)
    {
        skills_t& tempSkills = PMaster->automatonInfo.automatonSkills;
        stats_t&  tempStats  = PMaster->automatonInfo.automatonStats;
        health_t& tempHealth = PMaster->automatonInfo.automatonHealth;

        tempSkills.automaton_melee  = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MELEE, mlvl), PMaster->GetSkill(SKILL_AUTOMATON_MELEE));
        tempSkills.automaton_ranged = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_RANGED, mlvl), PMaster->GetSkill(SKILL_AUTOMATON_RANGED));
        tempSkills.automaton_magic  = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MAGIC, mlvl), PMaster->GetSkill(SKILL_AUTOMATON_MAGIC));

        // Set capped flags
        for (int i = 22; i <= 24; ++i)
        {
            if ((tempSkills.skill[i] & 0x7FFF) == (puppetutils::getSkillCap(PMaster, (SKILLTYPE)i, mlvl)))
            {
                tempSkills.skill[i] |= 0x8000;
            }
        }

        // Share its magic skills to prevent needing separate spells or checks to see which skill to use
        uint16 amaSkill            = tempSkills.automaton_magic + PMaster->getMod(Mod::AUTO_MAGIC_SKILL);
        tempSkills.automaton_magic = amaSkill;
        tempSkills.healing         = amaSkill;
        tempSkills.enhancing       = amaSkill;
        tempSkills.enfeebling      = amaSkill;
        tempSkills.elemental       = amaSkill;
        tempSkills.dark            = amaSkill;

        int32 meritbonus = PMaster->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PMaster);

        // If skill rank is 0, merit bonus needs to be added to be displayed like retail does
        if (puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_RANGED, mlvl) == 0)
        {
            tempSkills.automaton_ranged = meritbonus + PMaster->getMod(Mod::AUTO_RANGED_SKILL);
        }

        if (puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MAGIC, mlvl) == 0)
        {
            auto modBonus = PMaster->getMod(Mod::AUTO_MAGIC_SKILL);

            tempSkills.automaton_magic = meritbonus + modBonus;
            tempSkills.healing         = meritbonus + modBonus;
            tempSkills.enhancing       = meritbonus + modBonus;
            tempSkills.enfeebling      = meritbonus + modBonus;
            tempSkills.elemental       = meritbonus + modBonus;
            tempSkills.dark            = meritbonus + modBonus;
        }

        // Declaration of variables needed for calculation.
        float raceStat          = 0; // Final HP for level based on race.
        float jobStat           = 0; // Final number of HP for the level based on the primary profession.
        float sJobStat          = 0; // Finite number of HP for the level based on the secondary profession.
        int32 bonusStat         = 0; // Bonus number of HP that is added under certain conditions.
        int32 baseValueColumn   = 0; // Number of the column with the base amount of HP
        int32 scaleTo60Column   = 1; // Column number with modifier up to level 60
        int32 scaleOver30Column = 2; // Column number with modifier after level 30
        int32 scaleOver60Column = 3; // Column number with modifier after level 60
        int32 scaleOver75Column = 4; // Column number with modifier after level 75
        int32 scaleOver60       = 2; // Column number with a modifier for calculating MP after level 60
        // int32 scaleOver75       = 3; // Column number with a modifier for calculating Stats after level 75

        uint8 grade = 0;

        // Calculate HP gain from main job
        int32 mainLevelOver30     = std::clamp(mlvl - 30, 0, 30); // Calculate condition +1HP every lvl after level 30
        int32 mainLevelUpTo60     = (mlvl < 60 ? mlvl - 1 : 59);  // First calculation mode up to level 60 (Used the same for MP)
        int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15); // Second calculation mode after level 60
        int32 mainLevelOver75     = (mlvl < 75 ? 0 : mlvl - 75);  // Third calculation mode after level 75

        // Calculate the bonus amount of HP
        int32 mainLevelOver10           = (mlvl < 10 ? 0 : mlvl - 10);  // +2HP on every level after 10
        int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10); // +2HP at each level between level 50 and 60
        int32 mainLevelOver60           = (mlvl < 60 ? 0 : mlvl - 60);

        // Calculate raceStat jobStat bonusStat sJobStat
        // Calculate by race

        grade = 4;

        raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                   (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                   (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // raceStat = (int32)(statScale[grade][baseValueColumn] + statScale[grade][scaleTo60Column] * (mlvl - 1));

        // Calculation by main job
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                  (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                  (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Calculate Bonus HP
        bonusStat        = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
        tempHealth.maxhp = (int32)((raceStat + jobStat + bonusStat + sJobStat) * petStats->HPscale);
        tempHealth.hp    = tempHealth.maxhp;

        // Start MP calculation
        raceStat = 0;
        jobStat  = 0;
        sJobStat = 0;

        // Calculate the MP for the race.
        grade = 4;

        // If the main job doesn't have an MP rating, calculate the racial bonus based on the level of the subjob's level (assuming it has an MP rating)
        if (!(grade::GetJobGrade(mjob, 1) == 0 && grade::GetJobGrade(sjob, 1) == 0))
        {
            // calculate normal racial bonus
            raceStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                       grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        // For the main profession
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                      grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        grade = grade::GetJobGrade(sjob, 1);
        if (grade > 0)
        {
            sJobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                       grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        tempHealth.maxmp = (int32)((raceStat + jobStat + sJobStat) * petStats->MPscale);
        tempHealth.mp    = tempHealth.maxmp;

        uint16 slvl = std::floor<uint16>(mlvl / 2);

        uint16 fSTR = GetBaseToRank(petStats->strRank, mlvl);
        uint16 fDEX = GetBaseToRank(petStats->dexRank, mlvl);
        uint16 fVIT = GetBaseToRank(petStats->vitRank, mlvl);
        uint16 fAGI = GetBaseToRank(petStats->agiRank, mlvl);
        uint16 fINT = GetBaseToRank(petStats->intRank, mlvl);
        uint16 fMND = GetBaseToRank(petStats->mndRank, mlvl);
        uint16 fCHR = GetBaseToRank(petStats->chrRank, mlvl);

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(mjob, 2), mlvl);
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(mjob, 3), mlvl);
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(mjob, 4), mlvl);
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(mjob, 5), mlvl);
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(mjob, 6), mlvl);
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(mjob, 7), mlvl);
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(mjob, 8), mlvl);

        uint16 sSTR = GetBaseToRank(grade::GetJobGrade(sjob, 2), slvl);
        uint16 sDEX = GetBaseToRank(grade::GetJobGrade(sjob, 3), slvl);
        uint16 sVIT = GetBaseToRank(grade::GetJobGrade(sjob, 4), slvl);
        uint16 sAGI = GetBaseToRank(grade::GetJobGrade(sjob, 5), slvl);
        uint16 sINT = GetBaseToRank(grade::GetJobGrade(sjob, 6), slvl);
        uint16 sMND = GetBaseToRank(grade::GetJobGrade(sjob, 7), slvl);
        uint16 sCHR = GetBaseToRank(grade::GetJobGrade(sjob, 8), slvl);

        tempStats.STR = fSTR + mSTR + sSTR;
        tempStats.DEX = fDEX + mDEX + sDEX;
        tempStats.VIT = fVIT + mVIT + sVIT;
        tempStats.AGI = fAGI + mAGI + sAGI;
        tempStats.INT = fINT + mINT + sINT;
        tempStats.MND = fMND + mMND + sMND;
        tempStats.CHR = fCHR + mCHR + sCHR;

        if (PPet)
        {
            CAutomatonEntity* PAutomaton = static_cast<CAutomatonEntity*>(PPet);

            PPet->WorkingSkills = tempSkills;
            PPet->stats         = tempStats;
            PPet->health        = tempHealth;

            PAutomaton->m_Equip = PMaster->automatonInfo.m_Equip;
            PPet->look          = PMaster->automatonInfo.automatonLook;
            PPet->name          = PMaster->automatonInfo.m_automatonName;
            PPet->look.size     = MODEL_AUTOMATON;

            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setSkillType(SKILL_AUTOMATON_MELEE);
            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (petStats->cmbDelay / 60.0f)))); // every pet should use this eventually
            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay((uint16)(floor(1000.0f * (petStats->cmbDelay / 60.0f))));
            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage((PPet->GetSkill(SKILL_AUTOMATON_MELEE) / 9) * 2 + 3);

            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setSkillType(SKILL_AUTOMATON_RANGED);
            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setDamage((PPet->GetSkill(SKILL_AUTOMATON_RANGED) / 9) * 2 + 3);
            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setDmgType(DAMAGE_TYPE::PIERCING);

            // Automatons are hard to interrupt
            PPet->addModifier(Mod::SPELLINTERRUPT, 85);

            switch (PAutomaton->getFrame())
            {
                default: // case FRAME_HARLEQUIN:
                    tempSkills.evasion = battleutils::GetMaxSkill(2, mlvl > 99 ? 99 : mlvl);
                    PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(10, mlvl > 99 ? 99 : mlvl));
                    break;
                case FRAME_VALOREDGE:
                    PPet->setModifier(Mod::SHIELDBLOCKRATE, 45);
                    PPet->setMobMod(MOBMOD_CAN_SHIELD_BLOCK, 1);
                    tempSkills.evasion = battleutils::GetMaxSkill(5, mlvl > 99 ? 99 : mlvl);
                    PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(5, mlvl > 99 ? 99 : mlvl));
                    break;
                case FRAME_SHARPSHOT:
                    tempSkills.evasion = battleutils::GetMaxSkill(1, mlvl > 99 ? 99 : mlvl);
                    PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(11, mlvl > 99 ? 99 : mlvl));
                    break;
                case FRAME_STORMWAKER:
                    tempSkills.evasion = battleutils::GetMaxSkill(10, mlvl > 99 ? 99 : mlvl);
                    PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(12, mlvl > 99 ? 99 : mlvl));
                    break;
            }

            // Add Job Point Stat Bonuses
            if (PMaster->GetMJob() == JOB_PUP)
            {
                PPet->addModifier(Mod::ATT, PMaster->getMod(Mod::PET_ATK_DEF));
                PPet->addModifier(Mod::DEF, PMaster->getMod(Mod::PET_ATK_DEF));
                PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
                PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
                PPet->addModifier(Mod::MATT, PMaster->getMod(Mod::PET_MAB_MDB));
                PPet->addModifier(Mod::MDEF, PMaster->getMod(Mod::PET_MAB_MDB));
                PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
                PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
            }
        }
    }

    void LoadAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        // Declaration of variables needed for calculation.
        float raceStat          = 0; // final HP for level based on race.
        float jobStat           = 0; // final number of HP for the level based on the primary profession.
        float sJobStat          = 0; // finite number of HP for the level based on the secondary profession.
        int32 bonusStat         = 0; // bonus number of HP that is added under certain conditions.
        int32 baseValueColumn   = 0; // number of the column with the base amount of HP
        int32 scaleTo60Column   = 1; // column number with modifier up to level 60
        int32 scaleOver30Column = 2; // column number with modifier after level 30
        int32 scaleOver60Column = 3; // column number with modifier after level 60
        int32 scaleOver75Column = 4; // column number with modifier after level 75
        int32 scaleOver60       = 2; // column number with a modifier for calculating MP after level 60
        int32 scaleOver75       = 3; // column number with a modifier for calculating Stats after level 75

        uint8 grade = 0;

        uint8   mlvl = PPet->GetMLevel();
        JOBTYPE mjob = PPet->GetMJob();
        uint8   race = 3; // Tarutaru - wait what??

        // Calculate HP gain from main job
        int32 mainLevelOver30     = std::clamp(mlvl - 30, 0, 30); // Calculate condition +1HP every lvl after level 30
        int32 mainLevelUpTo60     = (mlvl < 60 ? mlvl - 1 : 59);  // First calculation mode up to level 60 (Used the same for MP)
        int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15); // Second calculation mode after level 60
        int32 mainLevelOver75     = (mlvl < 75 ? 0 : mlvl - 75);  // Third calculation mode after level 75

        // Calculate the bonus amount of HP
        int32 mainLevelOver10           = (mlvl < 10 ? 0 : mlvl - 10);  // +2HP on every level after 10
        int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10); // +2HP at each level between level 50 and 60
        int32 mainLevelOver60           = (mlvl < 60 ? 0 : mlvl - 60);

        // Calculate raceStat jobStat bonusStat sJobStat
        // Calculate by race

        grade = grade::GetRaceGrades(race, 0);

        raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                   (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                   (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // raceStat = (int32)(statScale[grade][baseValueColumn] + statScale[grade][scaleTo60Column] * (mlvl - 1));

        // Bonus HP calculation
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                  (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                  (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Bonus HP calculation
        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
        if (PPet->m_PetID == PETID_ODIN || PPet->m_PetID == PETID_ALEXANDER)
        {
            bonusStat += 6800;
        }
        PPet->health.maxhp = (int16)(raceStat + jobStat + bonusStat + sJobStat);
        PPet->health.hp    = PPet->health.maxhp;

        // MP race calculation.
        raceStat = 0;
        jobStat  = 0;
        sJobStat = 0;
        grade    = grade::GetRaceGrades(race, 1);

        // If the main job does not have an MP rating, calculate the racial bonus based on the level of the subjob's level (assuming it has an MP rating)
        if (grade::GetJobGrade(mjob, 1) != 0)
        {
            raceStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                       grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        // For mainjob
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                      grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        PPet->health.maxmp = (int16)(raceStat + jobStat + sJobStat);
        PPet->health.mp    = PPet->health.maxmp;

        // add in evasion from skill
        int16 evaskill = PPet->GetSkill(SKILL_EVASION);
        int16 eva      = evaskill;
        if (evaskill > 200)
        { // Evasion skill is 0.9 evasion post-200
            eva = (int16)(200 + (evaskill - 200) * 0.9);
        }
        PPet->setModifier(Mod::EVA, eva);

        // Start of calculation of characteristics
        uint8 counter = 0;
        for (uint8 StatIndex = 2; StatIndex <= 8; ++StatIndex)
        {
            // calculation by race/family
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

            // calculation by profession
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

            jobStat = jobStat * 1.5f; // stats from subjob (assuming BLM/BLM for avatars)

            // Value output
            ref<uint16>(&PPet->stats, counter) = (uint16)(raceStat + jobStat);
            counter += 2;
        }
    }

    void CalculateAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID = PPet->m_PetID;

        // clang-format off
        auto maybePetData = std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
        // clang-format on

        if (maybePetData == g_PPetList.end())
        {
            ShowError(fmt::format("Could not look up pet data for id: {}", petID));
            return;
        }

        auto* PPetData = *maybePetData;

        uint8 mLvl = PMaster->GetMLevel();

        if (PMaster->GetMJob() == JOB_SMN)
        {
            mLvl += PMaster->getMod(Mod::AVATAR_LVL_BONUS);

            if (petID == PETID_CARBUNCLE)
            {
                mLvl += PMaster->getMod(Mod::CARBUNCLE_LVL_BONUS);
            }
            else if (petID == PETID_CAIT_SITH)
            {
                mLvl += PMaster->getMod(Mod::CAIT_SITH_LVL_BONUS);
            }
            PPet->SetMLevel(mLvl);
        }
        else if (PMaster->GetSJob() == JOB_SMN)
        {
            mLvl = PMaster->GetSLevel();

            PPet->SetMLevel(mLvl);
        }
        else
        { // should never happen
            ShowDebug("%s summoned an avatar but is not SMN main or SMN sub! Please report. ", PMaster->getName());
            PPet->SetMLevel(1);
        }

        LoadAvatarStats(PMaster, PPet); // follows PC calcs (w/o SJ)

        PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(PPetData->spellList);

        PPet->setModifier(Mod::DMGPHYS, -5000); //-50% PDT

        PPet->setModifier(Mod::CRIT_DMG_INCREASE, 8); // Avatars have Crit Att Bonus II for +8 crit dmg

        if (mLvl >= 70)
        {
            PPet->setModifier(Mod::MATT, 32);
        }
        else if (mLvl >= 50)
        {
            PPet->setModifier(Mod::MATT, 28);
        }
        else if (mLvl >= 30)
        {
            PPet->setModifier(Mod::MATT, 24);
        }
        else if (mLvl >= 10)
        {
            PPet->setModifier(Mod::MATT, 20);
        }
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (320.0f / 60.0f))));

        if (petID == PETID_FENRIR)
        {
            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0 * (280.0f / 60.0f))));
        }

        // In a 2014 update SE updated Avatar base damage
        // Based on testing this value appears to be Level now instead of Level * 0.74f
        uint16 weaponDamage = 1 + mLvl;
        if (petID == PETID_CARBUNCLE || petID == PETID_CAIT_SITH)
        {
            weaponDamage = static_cast<uint16>(floor(mLvl * 0.9f));
        }

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage(weaponDamage);
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay((uint16)(floor(1000.0f * (PPetData->cmbDelay / 60.0f))));
        // Set B+ weapon skill (assumed capped for level derp)
        // attack is madly high for avatars (roughly x2)
        PPet->setModifier(Mod::ATT, 2 * battleutils::GetMaxSkill(SKILL_CLUB, JOB_WHM, mLvl > 99 ? 99 : mLvl));
        PPet->setModifier(Mod::ACC, battleutils::GetMaxSkill(SKILL_CLUB, JOB_WHM, mLvl > 99 ? 99 : mLvl));
        // Set E evasion and def
        PPet->setModifier(Mod::EVA, battleutils::GetMaxSkill(SKILL_THROWING, JOB_WHM, mLvl > 99 ? 99 : mLvl));
        PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(SKILL_THROWING, JOB_WHM, mLvl > 99 ? 99 : mLvl));

        // cap all magic skills so they play nice with spell scripts
        for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PPet->GetMJob(), mLvl > 99 ? 99 : mLvl);
            if (maxSkill != 0)
            {
                PPet->WorkingSkills.skill[i] = maxSkill;
            }
            else // if the mob is WAR/BLM and can cast spell
            {
                // set skill as high as main level, so their spells won't get resisted
                uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PPet->GetSJob(), mLvl > 99 ? 99 : mLvl);

                if (maxSubSkill != 0)
                {
                    PPet->WorkingSkills.skill[i] = maxSubSkill;
                }
            }
        }

        if (PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
            PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ATTACK, PChar));
            PPet->addModifier(Mod::ATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ATTACK, PChar));
            PPet->addModifier(Mod::MACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ACCURACY, PChar));
            PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ACCURACY, PChar));

            PPet->addModifier(Mod::ACC, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_ACC_BONUS));
            PPet->addModifier(Mod::MACC, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_MAGIC_ACC_BONUS));
            PPet->addModifier(Mod::ATT, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_PHYS_ATK_BONUS) * 2);
            PPet->addModifier(Mod::MAGIC_DAMAGE, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_MAGIC_DMG_BONUS) * 5);
            PPet->addModifier(Mod::BP_DAMAGE, PChar->PJobPoints->GetJobPointValue(JP_BLOOD_PACT_DMG_BONUS) * 3);
        }

        // SMN Job Gift Bonuses, DRG and PUP handled in their respective functions
        if (PMaster->GetMJob() == JOB_SMN)
        {
            PPet->addModifier(Mod::ATT, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::DEF, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::MATT, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MDEF, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
            PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
        }

        PMaster->setModifier(Mod::AVATAR_PERPETUATION, PerpetuationCost(petID, mLvl));

        FinalizePetStatistics(PMaster, PPet);
    }

    void CalculateWyvernStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        // set the wyvern job based on master's SJ
        if (PMaster->GetSJob() != JOB_NON)
        {
            PPet->SetSJob(PMaster->GetSJob());
        }

        PPet->SetMJob(JOB_DRG);
        // https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#About_the_Wyvern
        uint8 mLvl = PMaster->GetMLevel();
        uint8 iLvl = std::clamp(charutils::getMainhandItemLevel(static_cast<CCharEntity*>(PMaster)) - 99, 0, 20);

        PPet->SetMLevel(mLvl + iLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));

        LoadAvatarStats(PMaster, PPet);                                                                               // follows PC calcs (w/o SJ)
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (320.0f / 60.0f)))); // 320 delay
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay((uint16)(floor(1000.0f * (320.0f / 60.0f))));
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage((uint16)(floor(mLvl / 2) + 3));
        // Set A+ weapon skill
        PPet->setModifier(Mod::ATT, battleutils::GetMaxSkill(SKILL_GREAT_AXE, JOB_WAR, mLvl > 99 ? 99 : mLvl));
        PPet->setModifier(Mod::ACC, battleutils::GetMaxSkill(SKILL_GREAT_AXE, JOB_WAR, mLvl > 99 ? 99 : mLvl));
        // Set D evasion and def
        PPet->setModifier(Mod::EVA, battleutils::GetMaxSkill(SKILL_HAND_TO_HAND, JOB_WAR, mLvl > 99 ? 99 : mLvl));
        PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(SKILL_HAND_TO_HAND, JOB_WAR, mLvl > 99 ? 99 : mLvl));

        // https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#Combat_Stats
        // innate -40 % DT, which does not contribute to the -50 % cap (this is a unique attribute to pets having a "higher" DT cap)
        // TODO: need "UDMG" modifier or equivalent
        PPet->setModifier(Mod::DMG, -4000);

        // innate + 40 subtle blow
        PPet->setModifier(Mod::SUBTLE_BLOW, 40);

        // Job Point: Wyvern Max HP
        if (PMaster->objtype == TYPE_PC)
        {
            uint8 jpValue = static_cast<CCharEntity*>(PMaster)->PJobPoints->GetJobPointValue(JP_WYVERN_MAX_HP_BONUS);
            if (jpValue > 0)
            {
                PPet->addModifier(Mod::HP, jpValue * 10);
            }

            if (PMaster->GetMJob() == JOBTYPE::JOB_DRG)
            {
                PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
                PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
                PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
                PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
            }
        }

        FinalizePetStatistics(PMaster, PPet);
    }

    void CalculateJugPetStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID = PPet->m_PetID;

        // clang-format off
        auto maybePetData = std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
        // clang-format on

        if (maybePetData == g_PPetList.end())
        {
            ShowError(fmt::format("Could not look up pet data for id: {}", petID));
            return;
        }

        auto* PPetData = *maybePetData;

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (240.0f / 60.0f))));
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay((uint16)(floor(1000.0f * (240.0f / 60.0f))));
        // Get the Jug pet cap level
        uint8 highestLvl = PPetData->maxLevel;

        // Increase the pet's level cal by the bonus given by BEAST AFFINITY merits.
        CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
        highestLvl += PChar->PMeritPoints->GetMeritValue(MERIT_BEAST_AFFINITY, PChar);

        // And cap it to the master's level or weapon ilvl, whichever is greater
        auto capLevel = std::max(PMaster->GetMLevel(), PMaster->m_Weapons[SLOT_MAIN]->getILvl());
        if (highestLvl > capLevel)
        {
            highestLvl = capLevel;
        }

        // Randomize: 0-2 lvls lower, less Monster Gloves(+1/+2) bonus
        highestLvl -= xirand::GetRandomNumber(3 - std::clamp<int16>(PChar->getMod(Mod::JUG_LEVEL_RANGE), 0, 2));

        PPet->SetMLevel(std::min(PPet->getSpawnLevel(), highestLvl));
        LoadJugStats(PPet, PPetData); // follow monster calcs (w/o SJ)

        FinalizePetStatistics(PMaster, PPet);
    }

    void CalculateAutomatonStats(CBattleEntity* PMaster, CBattleEntity* PPet)
    {
        CAutomatonEntity* PAutomaton = dynamic_cast<CAutomatonEntity*>(PPet);

        // TODO: should CBattleEntity be able to load a real automaton?
        if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(PMaster))
        {
            JOBTYPE mjob = JOBTYPE::JOB_NON;
            JOBTYPE sjob = JOBTYPE::JOB_NON;

            switch (PChar->getAutomatonFrame())
            {
                default: // case FRAME_HARLEQUIN:
                    mjob = JOB_WAR;
                    sjob = JOB_RDM;
                    break;
                case FRAME_VALOREDGE:
                    mjob = JOB_PLD;
                    sjob = JOB_WAR;
                    break;
                case FRAME_SHARPSHOT:
                    mjob = JOB_RNG;
                    sjob = JOB_PUP;
                    break;
                case FRAME_STORMWAKER:
                    mjob = JOB_RDM;
                    sjob = JOB_WHM;
                    break;
            }

            uint8 mainLevel = PMaster->GetMJob() == JOB_PUP ? PMaster->GetMLevel() + PMaster->getMod(Mod::AUTOMATON_LVL_BONUS) : PMaster->GetSLevel();

            uint32 petID = 0;
            if (PAutomaton)
            {
                petID = PAutomaton->m_PetID;
                // TEMP: should be MLevel when unsummoned, and PUP level when summoned
                PPet->SetMLevel(mainLevel);
                PPet->SetSLevel(mainLevel / 2); // Todo: SetSLevel() already reduces the level?
            }
            else
            {
                switch (PChar->getAutomatonFrame())
                {
                    case FRAME_VALOREDGE:
                        petID = PETID_VALOREDGEFRAME;
                        break;
                    case FRAME_SHARPSHOT:
                        petID = PETID_SHARPSHOTFRAME;
                        break;
                    case FRAME_STORMWAKER:
                        petID = PETID_STORMWAKERFRAME;
                        break;
                    case FRAME_HARLEQUIN:
                    default:
                        petID = PETID_HARLEQUINFRAME;
                        break;
                }
            }

            LoadAutomatonStats(PChar, PAutomaton, g_PPetList.at(petID), mainLevel, mjob, sjob); // temp

            if (PAutomaton)
            {
                if (PMaster->objtype == TYPE_PC)
                {
                    PPet->addModifier(Mod::ATTP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                    PPet->addModifier(Mod::DEFP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                    PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                    PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                    PPet->addModifier(Mod::RACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                    PPet->addModifier(Mod::EVA, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                    PPet->addModifier(Mod::MDEF, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                }

                FinalizePetStatistics(PMaster, PAutomaton);
            }
        }
    }

    void CalculateLuopanStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        PPet->SetMLevel(PMaster->GetMLevel());
        PPet->health.maxhp = (uint32)floor((250 * PPet->GetMLevel()) / 15);

        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_BOLSTER))
        {
            uint8 bolsterJPVal = dynamic_cast<CCharEntity*>(PMaster)->PJobPoints->GetJobPointValue(JP_BOLSTER_EFFECT);
            PPet->health.maxhp += (uint32)floor(PPet->health.maxhp * (0.03 * bolsterJPVal));
        }

        PPet->health.hp = PPet->health.maxhp;

        // This sets the correct visual size for the luopan as pets currently
        // do not make use of the entity flags in the database
        // TODO: make pets use entity flags
        PPet->m_flags = 0x0000008B;
        // Just sit, do nothing
        PPet->baseSpeed = 0;
        PPet->UpdateSpeed();

        FinalizePetStatistics(PMaster, PPet);
    }

    void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        // set C magic evasion
        PPet->setModifier(Mod::MEVA, battleutils::GetMaxSkill(SKILL_ELEMENTAL_MAGIC, JOB_RDM, PPet->GetMLevel() > 99 ? 99 : PPet->GetMLevel()));
        PPet->health.tp = 0;
        PMaster->applyPetModifiers(PPet);
        PPet->UpdateHealth();
        PPet->health.hp = PPet->GetMaxHP();
        PPet->health.mp = PPet->GetMaxMP();

        // Stout Servant - Can't really tie it ot a real mod since it applies to the pet
        if (CCharEntity* PCharMaster = dynamic_cast<CCharEntity*>(PMaster))
        {
            if (charutils::hasTrait(PCharMaster, TRAIT_STOUT_SERVANT))
            {
                for (CTrait* trait : PCharMaster->TraitList)
                {
                    if (trait->getID() == TRAIT_STOUT_SERVANT)
                    {
                        PPet->addModifier(Mod::DMG, -(trait->getValue() * 100));
                        break;
                    }
                }
            }
        }
    }

    void SetupPetWithMaster(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        // automaton gets theirs by attachment only
        if (PPet->getPetType() != PET_TYPE::AUTOMATON)
        {
            battleutils::AddTraits(PPet, traits::GetTraits(PPet->GetMJob()), PPet->GetMLevel());
            battleutils::AddTraits(PPet, traits::GetTraits(PPet->GetSJob()), PPet->GetSLevel());
        }

        if (auto* PMasterChar = dynamic_cast<CCharEntity*>(PMaster))
        {
            charutils::BuildingCharAbilityTable(PMasterChar);
            charutils::BuildingCharPetAbilityTable(PMasterChar, PPet, PPet->m_PetID);

            PMasterChar->pushPacket<CCharStatusPacket>(PMasterChar);
            PMasterChar->pushPacket<CPetSyncPacket>(PMasterChar);

            // check latents affected by pets
            PMasterChar->PLatentEffectContainer->CheckLatentsPetType();

            // clang-format off
            PMasterChar->ForParty([](CBattleEntity* PMember)
            {
                if (const auto* PMemberChar = dynamic_cast<CCharEntity*>(PMember))
                {
                    PMemberChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
                }
            });
            // clang-format on
        }

        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_DEBILITATION))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_DEBILITATION, EFFECT_DEBILITATION, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_DEBILITATION)->GetPower(), 0, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_DEBILITATION)->GetDuration()), true);
        }
        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_OMERTA))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_OMERTA, EFFECT_OMERTA, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_OMERTA)->GetPower(), 0, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_OMERTA)->GetDuration()), true);
        }
        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_IMPAIRMENT, EFFECT_IMPAIRMENT, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower(), 0, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetDuration()), true);
        }
    }

    void SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
    {
        if (PMaster->PPet != nullptr)
        {
            ShowWarning("Pet was not null for %s.", PMaster->getName());
            return;
        }

        LoadPet(PMaster, PetID, spawningFromZone);

        CPetEntity* PPet = dynamic_cast<CPetEntity*>(PMaster->PPet);
        if (PPet)
        {
            PPet->allegiance = PMaster->allegiance;
            PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

            PPet->PMaster = PMaster;
            PPet->setBattleID(PMaster->getBattleID());

            if (PMaster->PBattlefield)
            {
                PPet->PBattlefield = PMaster->PBattlefield;
            }

            if (PMaster->PInstance)
            {
                PPet->PInstance = PMaster->PInstance;
            }

            if (spawningFromZone)
            {
                PPet->spawnAnimation = SPAWN_ANIMATION::NORMAL; // Don't play special spawn animation on zone in
            }

            PMaster->loc.zone->InsertPET(PPet);

            PPet->Spawn();
            if (PMaster->objtype == TYPE_PC)
            {
                SetupPetWithMaster(PMaster, PPet);
            }

            // apply stats from previous zone if this pet is being transferred
            if (spawningFromZone)
            {
                PPet->loadPetZoningInfo();
            }
        }
        else if (PMaster->objtype == TYPE_PC)
        {
            static_cast<CCharEntity*>(PMaster)->resetPetZoningInfo();
        }
    }

    void SpawnMobPet(CBattleEntity* PMaster, uint32 PetID)
    {
        // this is ONLY used for mob smn elementals / avatars
        /*
        This should eventually be merged into one big spawn pet method.
        At the moment player pets and mob pets are totally different. We need a central place
        to manage pet families and spawn them.
        */

        // grab pet info
        Pet_t*      petData = g_PPetList.at(PetID);
        CMobEntity* PPet    = dynamic_cast<CMobEntity*>(PMaster->PPet);
        if (PPet)
        {
            PPet->look = petData->look;
            PPet->name = petData->name;
            PPet->SetMJob(petData->mJob);
            PPet->m_EcoSystem = petData->EcoSystem;
            PPet->m_Family    = petData->m_Family;
            PPet->m_Element   = petData->m_Element;
            PPet->HPscale     = petData->HPscale;
            PPet->MPscale     = petData->MPscale;

            PPet->allegiance = PMaster->allegiance;
            PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

            // TODO: Lets not do this here.
            if (PPet->m_EcoSystem == ECOSYSTEM::AVATAR || PPet->m_EcoSystem == ECOSYSTEM::ELEMENTAL)
            {
                // assuming elemental spawn
                PPet->setModifier(Mod::DMGPHYS, -5000); //-50% PDT
            }

            PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(petData->spellList);

            PPet->setModifier(Mod::SLASH_SDT, petData->slash_sdt);
            PPet->setModifier(Mod::PIERCE_SDT, petData->pierce_sdt);
            PPet->setModifier(Mod::HTH_SDT, petData->hth_sdt);
            PPet->setModifier(Mod::IMPACT_SDT, petData->impact_sdt);

            PPet->setModifier(Mod::UDMGMAGIC, petData->magical_sdt);

            PPet->setModifier(Mod::FIRE_SDT, petData->fire_sdt);
            PPet->setModifier(Mod::ICE_SDT, petData->ice_sdt);
            PPet->setModifier(Mod::WIND_SDT, petData->wind_sdt);
            PPet->setModifier(Mod::EARTH_SDT, petData->earth_sdt);
            PPet->setModifier(Mod::THUNDER_SDT, petData->thunder_sdt);
            PPet->setModifier(Mod::WATER_SDT, petData->water_sdt);
            PPet->setModifier(Mod::LIGHT_SDT, petData->light_sdt);
            PPet->setModifier(Mod::DARK_SDT, petData->dark_sdt);

            PPet->setModifier(Mod::FIRE_RES_RANK, petData->fire_res_rank);
            PPet->setModifier(Mod::ICE_RES_RANK, petData->ice_res_rank);
            PPet->setModifier(Mod::WIND_RES_RANK, petData->wind_res_rank);
            PPet->setModifier(Mod::EARTH_RES_RANK, petData->earth_res_rank);
            PPet->setModifier(Mod::THUNDER_RES_RANK, petData->thunder_res_rank);
            PPet->setModifier(Mod::WATER_RES_RANK, petData->water_res_rank);
            PPet->setModifier(Mod::LIGHT_RES_RANK, petData->light_res_rank);
            PPet->setModifier(Mod::DARK_RES_RANK, petData->dark_res_rank);
        }
    }

    void DetachPet(CBattleEntity* PMaster)
    {
        if (PMaster == nullptr)
        {
            ShowWarning("PMaster is null.");
            return;
        }

        if (PMaster->PPet == nullptr)
        {
            ShowWarning("Pet is null for %s.", PMaster->getName());
            return;
        }

        if (PMaster->objtype != TYPE_PC)
        {
            ShowWarning("Non-PC passed into function (%s)", PMaster->getName());
            return;
        }

        CBattleEntity* PPet  = PMaster->PPet;
        CCharEntity*   PChar = static_cast<CCharEntity*>(PMaster);

        if (PPet->objtype == TYPE_MOB)
        {
            CMobEntity* PMob = static_cast<CMobEntity*>(PPet);

            if (!PMob->isDead())
            {
                PMob->PAI->Disengage();

                // charm time is up, mob attacks player now
                if (PMob->PEnmityContainer->IsWithinEnmityRange(PMob->PMaster))
                {
                    PMob->PEnmityContainer->UpdateEnmity(PChar, 0, 0);
                    // need to set battle target to prevent mob enmity clear if in attack state when uncharming
                    PMob->SetBattleTargetID(PChar->targid);
                }
                else
                {
                    PMob->m_OwnerID.clean();
                    PMob->updatemask |= UPDATE_STATUS;
                }

                // dirty exp if not full
                PMob->m_giveExp = PMob->GetHPP() == 100;

                // master using leave command
                auto* state = dynamic_cast<CAbilityState*>(PMaster->PAI->GetCurrentState());
                if ((state && state->GetAbility()->getID() == ABILITY_LEAVE) || PChar->loc.zoning || PChar->isDead())
                {
                    PMob->PEnmityContainer->Clear();
                    PMob->SetBattleTargetID(0);
                    PMob->m_OwnerID.clean();
                    PMob->updatemask |= UPDATE_STATUS;
                }
            }
            else
            {
                PMob->m_OwnerID.clean();
                PMob->updatemask |= UPDATE_STATUS;
            }

            PMob->isCharmed  = false;
            PMob->allegiance = ALLEGIANCE_TYPE::MOB;
            PMob->charmTime  = time_point::min();
            PMob->PMaster    = nullptr;

            PMob->PAI->SetController(std::make_unique<CMobController>(PMob));

            // clear all enmity towards a charmed mob when it is released
            // use two loops to avoid modifying the container while iterating over it
            std::list<CMobEntity*> mobsToPacify;

            // first collect the mobs with hate towards the formerly charmed mob
            for (auto* entityWithEnmity : *PMob->PNotorietyContainer)
            {
                if (auto* mobToPacify = dynamic_cast<CMobEntity*>(entityWithEnmity))
                {
                    mobsToPacify.emplace_back(mobToPacify);
                }
            }
            // then remove the formerly charmed mob from those mobs enmity containers
            for (const auto* mobToPacify : mobsToPacify)
            {
                mobToPacify->PEnmityContainer->Clear(PMob->id);
            }
        }
        else if (PPet->objtype == TYPE_PET)
        {
            if (!PPet->isDead())
            {
                PPet->Die();
            }
            CPetEntity* PPetEnt = static_cast<CPetEntity*>(PPet);

            if (PPetEnt->getPetType() == PET_TYPE::AVATAR)
            {
                PMaster->setModifier(Mod::AVATAR_PERPETUATION, 0);
            }

            static_cast<CCharEntity*>(PMaster)->PLatentEffectContainer->CheckLatentsPetType();

            // clang-format off
            PMaster->ForParty([](CBattleEntity* PMember)
            {
                static_cast<CCharEntity*>(PMember)->PLatentEffectContainer->CheckLatentsPartyAvatar();
            });
            // clang-format on

            PPetEnt->PMaster = nullptr;
            PChar->removePetModifiers(PPetEnt);
            charutils::BuildingCharPetAbilityTable(PChar, PPetEnt, 0); // blank the pet commands
        }

        charutils::BuildingCharAbilityTable(PChar);
        PChar->PPet = nullptr;
        PChar->pushPacket<CCharStatusPacket>(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
        PChar->pushPacket<CPetSyncPacket>(PChar);
    }

    void DespawnPet(CBattleEntity* PMaster)
    {
        if (PMaster == nullptr)
        {
            ShowWarning("PMaster is null.");
            return;
        }

        if (PMaster->PPet == nullptr)
        {
            ShowWarning("Pet is null for %s.", PMaster->getName());
            return;
        }

        petutils::DetachPet(PMaster);
    }

    int16 PerpetuationCost(uint32 id, uint8 level)
    {
        int16 cost = 0;

        // Fire Spirit through Dark Spirit
        if (id <= PETID_DARKSPIRIT)
        {
            if (level < 19)
            {
                cost = 1;
            }
            else if (level < 38)
            {
                cost = 2;
            }
            else if (level < 57)
            {
                cost = 3;
            }
            else if (level < 75)
            {
                cost = 4;
            }
            else if (level < 81)
            {
                cost = 5;
            }
            else if (level < 91)
            {
                cost = 6;
            }
            else
            {
                cost = 7;
            }
        }
        else if (id == PETID_CARBUNCLE || id == PETID_CAIT_SITH)
        {
            if (level < 10)
            {
                cost = 1;
            }
            else if (level < 18)
            {
                cost = 2;
            }
            else if (level < 27)
            {
                cost = 3;
            }
            else if (level < 36)
            {
                cost = 4;
            }
            else if (level < 45)
            {
                cost = 5;
            }
            else if (level < 54)
            {
                cost = 6;
            }
            else if (level < 63)
            {
                cost = 7;
            }
            else if (level < 72)
            {
                cost = 8;
            }
            else if (level < 81)
            {
                cost = 9;
            }
            else if (level < 91)
            {
                cost = 10;
            }
            else
            {
                cost = 11;
            }
        }
        else if (id == PETID_FENRIR)
        {
            if (level < 8)
            {
                cost = 1;
            }
            else if (level < 15)
            {
                cost = 2;
            }
            else if (level < 22)
            {
                cost = 3;
            }
            else if (level < 30)
            {
                cost = 4;
            }
            else if (level < 37)
            {
                cost = 5;
            }
            else if (level < 45)
            {
                cost = 6;
            }
            else if (level < 51)
            {
                cost = 7;
            }
            else if (level < 59)
            {
                cost = 8;
            }
            else if (level < 66)
            {
                cost = 9;
            }
            else if (level < 73)
            {
                cost = 10;
            }
            else if (level < 81)
            {
                cost = 11;
            }
            else if (level < 91)
            {
                cost = 12;
            }
            else
            {
                cost = 13;
            }
        }
        // NOTE: This condition covers PETID_IFRIT through the below conditions
        else if (id <= PETID_DIABOLOS || id == PETID_SIREN)
        {
            if (level < 10)
            {
                cost = 3;
            }
            else if (level < 19)
            {
                cost = 4;
            }
            else if (level < 28)
            {
                cost = 5;
            }
            else if (level < 38)
            {
                cost = 6;
            }
            else if (level < 47)
            {
                cost = 7;
            }
            else if (level < 56)
            {
                cost = 8;
            }
            else if (level < 65)
            {
                cost = 9;
            }
            else if (level < 68)
            {
                cost = 10;
            }
            else if (level < 71)
            {
                cost = 11;
            }
            else if (level < 74)
            {
                cost = 12;
            }
            else if (level < 81)
            {
                cost = 13;
            }
            else if (level < 91)
            {
                cost = 14;
            }
            else
            {
                cost = 15;
            }
        }

        return cost;
    }

    /*
    Familiars a pet.
    */
    void Familiar(CBattleEntity* PPet)
    {
        /*
            Boost HP by 10%
            Increase charm duration up to 30 mins
            boost stats by 10%
            */

        // only increase time for charmed mobs
        if (PPet->objtype == TYPE_MOB && PPet->isCharmed)
        {
            // increase charm duration
            // 30 mins - 1-5 mins
            PPet->charmTime += 30min - std::chrono::milliseconds(xirand::GetRandomNumber(300000u));
        }

        float rate = 0.10f;

        // boost hp by 10%
        uint16 boost = (uint16)(PPet->health.maxhp * rate);

        PPet->health.maxhp += boost;
        PPet->health.hp += boost;
        PPet->UpdateHealth();

        // boost stats by 10%
        PPet->addModifier(Mod::ATTP, (int16)(rate * 100.0f));
        PPet->addModifier(Mod::ACC, (int16)(rate * 100.0f));
        PPet->addModifier(Mod::EVA, (int16)(rate * 100.0f));
        PPet->addModifier(Mod::DEFP, (int16)(rate * 100.0f));
    }

    void LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
    {
        if (PMaster == nullptr)
        {
            ShowWarning("PMaster is null.");
            return;
        }

        if (PetID >= MAX_PETID)
        {
            ShowWarning("PetID (%d) exceeds MAX_PETID", PetID);
            return;
        }

        // clang-format off
        auto maybePetData = std::find_if(g_PPetList.begin(), g_PPetList.end(), [PetID](Pet_t* t)
        {
            return t->PetID == PetID;
        });
        // clang-format on

        if (maybePetData == g_PPetList.end())
        {
            ShowError(fmt::format("Could not look up pet data for id: {}", PetID));
            return;
        }

        auto* PPetData = *maybePetData;

        if (PMaster->GetMJob() != JOB_DRG && PetID == PETID_WYVERN)
        {
            return;
        }

        if (PMaster->objtype == TYPE_PC)
        {
            static_cast<CCharEntity*>(PMaster)->petZoningInfo.petID = PetID;
        }

        PET_TYPE petType = PET_TYPE::JUG_PET;

        if (PetID <= PETID_CAIT_SITH || PetID == PETID_SIREN)
        {
            petType = PET_TYPE::AVATAR;
        }
        // TODO: move this out of modifying the global pet list
        else if (PetID == PETID_WYVERN)
        {
            petType = PET_TYPE::WYVERN;

            const char* Query = "SELECT\
                pet_name.name,\
                char_pet.wyvernid\
                FROM pet_name, char_pet\
                WHERE pet_name.id = char_pet.wyvernid AND \
                char_pet.charid = %u";

            if (_sql->Query(Query, PMaster->id) != SQL_ERROR && _sql->NumRows() != 0)
            {
                while (_sql->NextRow() == SQL_SUCCESS)
                {
                    uint16 wyvernid = (uint16)_sql->GetIntData(1);

                    if (wyvernid != 0)
                    {
                        PPetData->name.clear();
                        PPetData->name.insert(0, (const char*)_sql->GetData(0));
                    }
                }
            }
        }
        else if (PetID == PETID_CHOCOBO)
        {
            petType = PET_TYPE::CHOCOBO;

            const char* Query = "SELECT\
                char_pet.chocoboid\
                FROM char_pet\
                char_pet.charid = %u";

            if (_sql->Query(Query, PMaster->id) != SQL_ERROR && _sql->NumRows() != 0)
            {
                while (_sql->NextRow() == SQL_SUCCESS)
                {
                    uint32 chocoboid = (uint32)_sql->GetIntData(0);

                    if (chocoboid != 0)
                    {
                        uint16 chocoboname1 = chocoboid & 0x0000FFFF;
                        uint16 chocoboname2 = chocoboid >>= 16;

                        PPetData->name.clear();

                        Query = "SELECT\
                            pet_name.name\
                            FROM pet_name\
                            WHERE pet_name.id = %u OR pet_name.id = %u";

                        if (_sql->Query(Query, chocoboname1, chocoboname2) != SQL_ERROR && _sql->NumRows() != 0)
                        {
                            while (_sql->NextRow() == SQL_SUCCESS)
                            {
                                if (chocoboname1 != 0 && chocoboname2 != 0)
                                {
                                    PPetData->name.insert(0, (const char*)_sql->GetData(0));
                                }
                            }
                        }
                    }
                }
            }
        }
        else if (PetID == PETID_HARLEQUINFRAME || PetID == PETID_VALOREDGEFRAME || PetID == PETID_SHARPSHOTFRAME || PetID == PETID_STORMWAKERFRAME)
        {
            petType = PET_TYPE::AUTOMATON;
        }
        else if (PetID == PETID_LUOPAN)
        {
            petType = PET_TYPE::LUOPAN;
        }

        if (settings::get<bool>("map.DESPAWN_JUGPETS_BELOW_MINIMUM_LEVEL"))
        {
            // Don't spawn jugpet if min level is above master's level
            if (petType == PET_TYPE::JUG_PET && PMaster->loc.zone)
            {
                uint8 levelRestriction = PMaster->loc.zone->getLevelRestriction();
                if (levelRestriction != 0 && (PMaster->loc.zone->getLevelRestriction() < PPetData->minLevel))
                {
                    return;
                }
            }
        }

        CPetEntity* PPet = nullptr;
        if (petType == PET_TYPE::AUTOMATON && PMaster->objtype == TYPE_PC)
        {
            PPet = new CAutomatonEntity();
        }
        else
        {
            PPet = new CPetEntity(petType);
            PPet->saveModifiers();
        }

        PPet->loc = PMaster->loc;

        if (petType == PET_TYPE::LUOPAN)
        {
            // spawn the luopan at the targets position with offsets from the action packet
            // this is calculated in the action packet to avoid incorrect placement after casting
            // m_ActionOffsetPos is a combination of targets pos + action offset pos
            PPet->loc.p = dynamic_cast<CCharEntity*>(PMaster)->m_ActionOffsetPos;
        }
        else
        {
            // spawn me randomly around master
            PPet->loc.p = nearPosition(PMaster->loc.p, CPetController::PetRoamDistance, (float)M_PI);
        }

        if (petType != PET_TYPE::AUTOMATON)
        {
            PPet->look = PPetData->look;
            PPet->name = PPetData->name;
        }

        PPet->m_name_prefix  = PPetData->name_prefix;
        PPet->m_Family       = PPetData->m_Family;
        PPet->m_MobSkillList = PPetData->m_MobSkillList;
        PPet->SetMJob(PPetData->mJob);
        PPet->m_Element = PPetData->m_Element;
        PPet->m_PetID   = PPetData->PetID;

        if (PPet->getPetType() == PET_TYPE::AVATAR)
        {
            CalculateAvatarStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PET_TYPE::JUG_PET)
        {
            uint8 spawnLevel = static_cast<CCharEntity*>(PMaster)->petZoningInfo.petLevel;
            PPet->setSpawnLevel(spawnLevel > 0 ? spawnLevel : UINT8_MAX);
            PPet->setJugDuration(PPetData->time);
            CalculateJugPetStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PET_TYPE::WYVERN)
        {
            CalculateWyvernStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PET_TYPE::AUTOMATON && PMaster->objtype == TYPE_PC)
        {
            puppetutils::LoadAutomaton(static_cast<CCharEntity*>(PMaster));

            CalculateAutomatonStats(PMaster, PPet);

            puppetutils::EquipAttachments(static_cast<CAutomatonEntity*>(PPet));

            PPet->PAI->SetController(std::make_unique<CAutomatonController>(static_cast<CAutomatonEntity*>(PPet)));
        }
        else if (PPet->getPetType() == PET_TYPE::LUOPAN && PMaster->objtype == TYPE_PC)
        {
            CalculateLuopanStats(PMaster, PPet);
        }

        PPet->setSpawnLevel(PPet->GetMLevel());
        PPet->status        = STATUS_TYPE::NORMAL;
        PPet->m_ModelRadius = PPetData->radius;
        PPet->m_EcoSystem   = PPetData->EcoSystem;
        // set the damage type of the pet
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDmgType(PPetData->m_dmgType);

        PMaster->PPet = PPet;
    }

    bool CheckPetModType(CBattleEntity* PPet, PetModType petmod)
    {
        if (petmod == PetModType::All)
        {
            return true;
        }

        if (auto* PPetEntity = dynamic_cast<CPetEntity*>(PPet))
        {
            if (petmod == PetModType::Avatar && PPetEntity->getPetType() == PET_TYPE::AVATAR)
            {
                return true;
            }
            if (petmod == PetModType::Wyvern && PPetEntity->getPetType() == PET_TYPE::WYVERN)
            {
                return true;
            }
            if (petmod >= PetModType::Automaton && petmod <= PetModType::Stormwaker && PPetEntity->getPetType() == PET_TYPE::AUTOMATON)
            {
                if (petmod == PetModType::Automaton || (uint16)petmod + 28 == (uint16) static_cast<CAutomatonEntity*>(PPetEntity)->getFrame())
                {
                    return true;
                }
            }
            if (petmod == PetModType::Luopan && PPetEntity->getPetType() == PET_TYPE::LUOPAN)
            {
                return true;
            }
        }
        else
        {
            return true;
        }
        return false;
    }

    Pet_t* GetPetInfo(uint32 PetID)
    {
        for (Pet_t* info : g_PPetList)
        {
            if (info->PetID == PetID)
                return info;
        }

        return nullptr;
    }

}; // namespace petutils
