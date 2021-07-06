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

#include "../../common/utils.h"

#include <cmath>

#include "../grades.h"
#include "../items/item_weapon.h"
#include "../lua/luautils.h"
#include "../mob_modifier.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../packets/action.h"
#include "../spell.h"
#include "../status_effect_container.h"
#include "../trait.h"
#include "battleutils.h"
#include "mobutils.h"
#include "petutils.h"
#include "zoneutils.h"
#include <vector>

namespace mobutils
{
    ModsMap_t mobFamilyModsList;
    ModsMap_t mobPoolModsList;
    ModsMap_t mobSpawnModsList;

    /************************************************************************
     *                                                                       *
     *  Расчет базовой величины оружия монстров                              *
     *                                                                       *
     ************************************************************************/

    uint16 GetWeaponDamage(CMobEntity* PMob)
    {
        uint16 lvl   = PMob->GetMLevel();
        uint8  bonus = 0;

        if (lvl >= 75)
        {
            bonus = 3;
        }
        else if (lvl >= 60)
        {
            bonus = 2;
        }
        else if (lvl >= 50)
        {
            bonus = 1;
        }

        uint16 damage = lvl + bonus;

        damage = (uint16)(damage * PMob->m_dmgMult / 100.0f);

        if (PMob->getMobMod(MOBMOD_WEAPON_BONUS) != 0)
        {
            damage = (uint16)(damage * PMob->getMobMod(MOBMOD_WEAPON_BONUS) / 100.0f);
        }

        return damage;
    }

    uint16 GetMagicEvasion(CMobEntity* PMob)
    {
        uint8 mEvaRank = 3;

        return GetBase(PMob, mEvaRank);
    }

    uint16 GetEvasion(CMobEntity* PMob)
    {
        uint8 evaRank = PMob->evaRank;

        // Mob evasion is based on job
        // but occasionally war mobs
        // might have a different rank
        switch (PMob->GetMJob())
        {
            case JOB_THF:
            case JOB_NIN:
                evaRank = 1;
                break;
            case JOB_MNK:
            case JOB_DNC:
            case JOB_SAM:
            case JOB_PUP:
            case JOB_RUN:
                evaRank = 2;
                break;
            case JOB_RDM:
            case JOB_BRD:
            case JOB_GEO:
            case JOB_COR:
                evaRank = 4;
                break;
            case JOB_WHM:
            case JOB_SCH:
            case JOB_RNG:
            case JOB_SMN:
            case JOB_BLM:
                evaRank = 5;
                break;
            default:
                break;
        }

        return GetBase(PMob, evaRank);
    }

    /************************************************************************
     *                                                                       *
     *  Базовое значение для расчера характеристик                           *
     *  (на название не хватило фантазии)                                    *
     *                                                                       *
     ************************************************************************/

    uint16 GetBaseToRank(uint8 rank, uint16 lvl)
    {
        switch (rank)
        {
            case 1:
                return (5 + ((lvl - 1) * 50) / 100); // A
            case 2:
                return (4 + ((lvl - 1) * 45) / 100); // B
            case 3:
                return (4 + ((lvl - 1) * 40) / 100); // C
            case 4:
                return (3 + ((lvl - 1) * 35) / 100); // D
            case 5:
                return (3 + ((lvl - 1) * 30) / 100); // E
            case 6:
                return (2 + ((lvl - 1) * 25) / 100); // F
            case 7:
                return (2 + ((lvl - 1) * 20) / 100); // G
        }
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Базовое значение для расчерта защиты и уклонения                     *
     *  (на название не хватило фантазии)                                    *
     *                                                                       *
     ************************************************************************/

    uint16 GetBase(CMobEntity* PMob, uint8 rank)
    {
        uint8 lvl = PMob->GetMLevel();
        if (lvl > 50)
        {
            switch (rank)
            {
                case 1: // A
                    return (uint16)(153 + (lvl - 50) * 5.0f);
                case 2: // B
                    return (uint16)(147 + (lvl - 50) * 4.9f);
                case 3: // C
                    return (uint16)(136 + (lvl - 50) * 4.8f);
                case 4: // D
                    return (uint16)(126 + (lvl - 50) * 4.7f);
                case 5: // E
                    return (uint16)(116 + (lvl - 50) * 4.5f);
                case 6: // F
                    return (uint16)(106 + (lvl - 50) * 4.4f);
                case 7: // G
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

        ShowError("Mobutils::GetBase rank (%d) is out of bounds for mob (%u) \n", rank, PMob->id);
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Расчет атрибутов (характеристик) монстра                             *
     *                                                                       *
     ************************************************************************/

    void CalculateStats(CMobEntity* PMob)
    {
        // remove all to keep mods in sync
        PMob->StatusEffectContainer->KillAllStatusEffect();
        PMob->restoreModifiers();
        PMob->restoreMobModifiers();

        bool      isNM     = PMob->m_Type & MOBTYPE_NOTORIOUS;
        JOBTYPE   mJob     = PMob->GetMJob();
        JOBTYPE   sJob     = PMob->GetSJob();
        uint8     mLvl     = PMob->GetMLevel();
        ZONE_TYPE zoneType = PMob->loc.zone->GetType();

        if (PMob->HPmodifier == 0)
        {
            float hpScale = PMob->HPscale;

            if (PMob->getMobMod(MOBMOD_HP_SCALE) != 0)
            {
                hpScale = (float)PMob->getMobMod(MOBMOD_HP_SCALE) / 100.0f;
            }

            float growth    = 1.06f;
            float petGrowth = 0.75f;
            float base      = 18.0f;

            // give hp boost every 10 levels after 25
            // special boosts at 25 and 50
            if (mLvl > 75)
            {
                growth    = 1.28f;
                petGrowth = 1.03f;
            }
            else if (mLvl > 65)
            {
                growth    = 1.27f;
                petGrowth = 1.02f;
            }
            else if (mLvl > 55)
            {
                growth    = 1.25f;
                petGrowth = 0.99f;
            }
            else if (mLvl > 50)
            {
                growth    = 1.21f;
                petGrowth = 0.96f;
            }
            else if (mLvl > 45)
            {
                growth    = 1.17f;
                petGrowth = 0.95f;
            }
            else if (mLvl > 35)
            {
                growth    = 1.14f;
                petGrowth = 0.92f;
            }
            else if (mLvl > 25)
            {
                growth    = 1.1f;
                petGrowth = 0.82f;
            }

            // pets have lower health
            if (PMob->PMaster != nullptr)
            {
                growth = petGrowth;
            }

            PMob->health.maxhp = (int16)(base * pow(mLvl, growth) * hpScale);
        }
        else
        {
            PMob->health.maxhp = PMob->HPmodifier;
        }

        if (isNM)
        {
            PMob->health.maxhp = (int32)(PMob->health.maxhp * map_config.nm_hp_multiplier);
        }
        else
        {
            PMob->health.maxhp = (int32)(PMob->health.maxhp * map_config.mob_hp_multiplier);
        }

        bool hasMp = false;

        switch (mJob)
        {
            case JOB_PLD:
            case JOB_WHM:
            case JOB_BLM:
            case JOB_RDM:
            case JOB_DRK:
            case JOB_BLU:
            case JOB_SCH:
            case JOB_SMN:
                hasMp = true;
                break;
            default:
                break;
        }

        switch (sJob)
        {
            case JOB_PLD:
            case JOB_WHM:
            case JOB_BLM:
            case JOB_RDM:
            case JOB_DRK:
            case JOB_BLU:
            case JOB_SCH:
            case JOB_SMN:
                hasMp = true;
                break;
            default:
                break;
        }

        if (PMob->getMobMod(MOBMOD_MP_BASE))
        {
            hasMp = true;
        }

        if (hasMp)
        {
            float scale = PMob->MPscale;

            if (PMob->getMobMod(MOBMOD_MP_BASE))
            {
                scale = (float)PMob->getMobMod(MOBMOD_MP_BASE) / 100.0f;
            }

            if (PMob->MPmodifier == 0)
            {
                PMob->health.maxmp = (int16)(18.2 * pow(mLvl, 1.1075) * scale) + 10;
            }
            else
            {
                PMob->health.maxmp = PMob->MPmodifier;
            }

            if (isNM)
            {
                PMob->health.maxmp = (int32)(PMob->health.maxmp * map_config.nm_mp_multiplier);
            }
            else
            {
                PMob->health.maxmp = (int32)(PMob->health.maxmp * map_config.mob_mp_multiplier);
            }
        }

        PMob->UpdateHealth();

        PMob->health.tp = 0;
        PMob->health.hp = PMob->GetMaxHP();
        PMob->health.mp = PMob->GetMaxMP();

        ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(GetWeaponDamage(PMob));

        // reduce weapon delay of MNK
        if (PMob->GetMJob() == JOB_MNK)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->resetDelay();
        }

        // Deprecate MOBMOD_DUAL_WIELD later, replace if check with value from DB
        if (PMob->getMobMod(MOBMOD_DUAL_WIELD))
        {
            PMob->m_dualWield = true;
        }

        uint16 fSTR = GetBaseToRank(PMob->strRank, mLvl);
        uint16 fDEX = GetBaseToRank(PMob->dexRank, mLvl);
        uint16 fVIT = GetBaseToRank(PMob->vitRank, mLvl);
        uint16 fAGI = GetBaseToRank(PMob->agiRank, mLvl);
        uint16 fINT = GetBaseToRank(PMob->intRank, mLvl);
        uint16 fMND = GetBaseToRank(PMob->mndRank, mLvl);
        uint16 fCHR = GetBaseToRank(PMob->chrRank, mLvl);

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 2), mLvl);
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 3), mLvl);
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 4), mLvl);
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 5), mLvl);
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 6), mLvl);
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 7), mLvl);
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 8), mLvl);

        uint16 sSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 2), PMob->GetSLevel());
        uint16 sDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 3), PMob->GetSLevel());
        uint16 sVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 4), PMob->GetSLevel());
        uint16 sAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 5), PMob->GetSLevel());
        uint16 sINT = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 6), PMob->GetSLevel());
        uint16 sMND = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 7), PMob->GetSLevel());
        uint16 sCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 8), PMob->GetSLevel());

        // As per conversation with Jimmayus, all mobs at any level get bonus stats from subjobs.
        // From lvl 45 onwards, 1/2. Before lvl 30, 1/4. In between, the value gets progresively higher, from 1/4 at 30 to 1/2 at 44.
        // Im leaving that range at 1/3, for now.
        if (mLvl >= 45)
        {
            sSTR /= 2;
            sDEX /= 2;
            sAGI /= 2;
            sINT /= 2;
            sMND /= 2;
            sCHR /= 2;
            sVIT /= 2;
        }
        else if (mLvl < 45 && mLvl > 30)
        {
            sSTR /= 3;
            sDEX /= 3;
            sAGI /= 3;
            sINT /= 3;
            sMND /= 3;
            sCHR /= 3;
            sVIT /= 3;
        }
        else
        {
            sSTR /= 4;
            sDEX /= 4;
            sAGI /= 4;
            sINT /= 4;
            sMND /= 4;
            sCHR /= 4;
            sVIT /= 4;
        }

        PMob->stats.STR = fSTR + mSTR + sSTR;
        PMob->stats.DEX = fDEX + mDEX + sDEX;
        PMob->stats.VIT = fVIT + mVIT + sVIT;
        PMob->stats.AGI = fAGI + mAGI + sAGI;
        PMob->stats.INT = fINT + mINT + sINT;
        PMob->stats.MND = fMND + mMND + sMND;
        PMob->stats.CHR = fCHR + mCHR + sCHR;

        if (isNM)
        {
            PMob->stats.STR = (uint16)(PMob->stats.STR * map_config.nm_stat_multiplier);
            PMob->stats.DEX = (uint16)(PMob->stats.DEX * map_config.nm_stat_multiplier);
            PMob->stats.VIT = (uint16)(PMob->stats.VIT * map_config.nm_stat_multiplier);
            PMob->stats.AGI = (uint16)(PMob->stats.AGI * map_config.nm_stat_multiplier);
            PMob->stats.INT = (uint16)(PMob->stats.INT * map_config.nm_stat_multiplier);
            PMob->stats.MND = (uint16)(PMob->stats.MND * map_config.nm_stat_multiplier);
            PMob->stats.CHR = (uint16)(PMob->stats.CHR * map_config.nm_stat_multiplier);
        }
        else
        {
            PMob->stats.STR = (uint16)(PMob->stats.STR * map_config.mob_stat_multiplier);
            PMob->stats.DEX = (uint16)(PMob->stats.DEX * map_config.mob_stat_multiplier);
            PMob->stats.VIT = (uint16)(PMob->stats.VIT * map_config.mob_stat_multiplier);
            PMob->stats.AGI = (uint16)(PMob->stats.AGI * map_config.mob_stat_multiplier);
            PMob->stats.INT = (uint16)(PMob->stats.INT * map_config.mob_stat_multiplier);
            PMob->stats.MND = (uint16)(PMob->stats.MND * map_config.mob_stat_multiplier);
            PMob->stats.CHR = (uint16)(PMob->stats.CHR * map_config.mob_stat_multiplier);
        }

        // special case, give spell list to my pet
        if (PMob->getMobMod(MOBMOD_PET_SPELL_LIST) && PMob->PPet != nullptr)
        {
            // Stubborn_Dredvodd
            CMobEntity* PPet = (CMobEntity*)PMob->PPet;

            // give pet spell list
            PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(PMob->getMobMod(MOBMOD_PET_SPELL_LIST));
        }

        if (PMob->getMobMod(MOBMOD_SPELL_LIST))
        {
            PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(PMob->getMobMod(MOBMOD_SPELL_LIST));
        }

        // cap all stats for mLvl / job
        for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PMob->GetMJob(), mLvl > 99 ? 99 : mLvl);
            if (maxSkill != 0)
            {
                PMob->WorkingSkills.skill[i] = maxSkill;
            }
            else // if the mob is WAR/BLM and can cast spell
            {
                // set skill as high as main level, so their spells won't get resisted
                uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PMob->GetSJob(), mLvl > 99 ? 99 : mLvl);

                if (maxSubSkill != 0)
                {
                    PMob->WorkingSkills.skill[i] = maxSubSkill;
                }
            }
        }
        for (int i = SKILL_HAND_TO_HAND; i <= SKILL_STAFF; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill(3, mLvl > 99 ? 99 : mLvl);
            if (maxSkill != 0)
            {
                PMob->WorkingSkills.skill[i] = maxSkill;
            }
        }

        PMob->addModifier(Mod::DEF, GetBase(PMob, PMob->defRank));
        PMob->addModifier(Mod::EVA, GetEvasion(PMob));
        PMob->addModifier(Mod::ATT, GetBase(PMob, PMob->attRank));
        PMob->addModifier(Mod::ACC, GetBase(PMob, PMob->accRank));

        // natural magic evasion
        PMob->addModifier(Mod::MEVA, GetMagicEvasion(PMob));

        // add traits for sub and main
        battleutils::AddTraits(PMob, traits::GetTraits(mJob), mLvl);
        battleutils::AddTraits(PMob, traits::GetTraits(PMob->GetSJob()), PMob->GetSLevel());

        SetupJob(PMob);
        SetupRoaming(PMob);

        // All beastmen drop gil
        if (PMob->m_EcoSystem == ECOSYSTEM::BEASTMAN)
        {
            PMob->defaultMobMod(MOBMOD_GIL_BONUS, 100);
        }

        if (PMob->PMaster != nullptr)
        {
            SetupPetSkills(PMob);
        }

        PMob->m_Behaviour |= PMob->getMobMod(MOBMOD_BEHAVIOR);

        if (zoneType == ZONE_TYPE::DUNGEON)
        {
            SetupDungeonMob(PMob);
        }
        else if (zoneType == ZONE_TYPE::BATTLEFIELD || PMob->m_Type & MOBTYPE_BATTLEFIELD)
        {
            SetupBattlefieldMob(PMob);
        }
        else if (zoneType == ZONE_TYPE::DYNAMIS)
        {
            SetupDynamisMob(PMob);
        }
        else if (zoneType == ZONE_TYPE::LIMBUS)
        {
            SetupLimbusMob(PMob);
        }

        if (PMob->m_Type & MOBTYPE_NOTORIOUS)
        {
            SetupNMMob(PMob);
        }

        if (PMob->m_Type & MOBTYPE_EVENT)
        {
            SetupEventMob(PMob);
        }

        if (PMob->CanStealGil())
        {
            PMob->ResetGilPurse();
        }

        // Check for possible miss-setups
        if (PMob->getMobMod(MOBMOD_SPECIAL_SKILL) != 0 && PMob->getMobMod(MOBMOD_SPECIAL_COOL) == 0)
        {
            ShowError("Mobutils::CalculateStats Mob (%s, %d) with special skill but no cool down set!\n", PMob->GetName(), PMob->id);
        }

        if (PMob->SpellContainer->HasSpells() && PMob->getMobMod(MOBMOD_MAGIC_COOL) == 0)
        {
            ShowError("Mobutils::CalculateStats Mob (%s, %d) with magic but no cool down set!\n", PMob->GetName(), PMob->id);
        }

        if (PMob->m_Detects == 0)
        {
            ShowError("Mobutils::CalculateStats Mob (%s, %d, %d) has no detection methods!\n", PMob->GetName(), PMob->id, PMob->m_Family);
        }
    }

    void SetupJob(CMobEntity* PMob)
    {
        JOBTYPE mJob = PMob->GetMJob();
        JOBTYPE sJob = PMob->GetSJob();
        JOBTYPE job;

        if (grade::GetJobGrade(mJob, 1) > 0) // check if mainjob gives mp
        {
            job = mJob;
        }
        else // if mainjob had no MP, use subjob in switch cases.
        {
            job = sJob;
        }

        // This switch falls back to a subjob if a mainjob isn't matched, and is mainly magic stuff
        switch (job)
        {
            case JOB_BLM:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                PMob->defaultMobMod(MOBMOD_GA_CHANCE, 40);
                PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 15);
                PMob->defaultMobMod(MOBMOD_SEVERE_SPELL_CHANCE, 20);
                break;
            case JOB_PLD:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 7);
                break;
            case JOB_DRK:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 7);
                break;
            case JOB_WHM:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 10);
                break;
            case JOB_BRD:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                PMob->defaultMobMod(MOBMOD_GA_CHANCE, 25);
                PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 60);
                PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 10);
                break;
            case JOB_BLU:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                break;
            case JOB_RDM:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                PMob->defaultMobMod(MOBMOD_GA_CHANCE, 15);
                PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 40);
                PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 10);
                break;
            case JOB_SMN:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 70);
                PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 100); // SMN only has "buffs"
                break;
            case JOB_NIN:
                PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 9);
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 20);
                PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 7);
                break;
            default:
                break;
        }

        // This switch is mainjob only and contains mainly non magic related stuff
        switch (mJob)
        {
            case JOB_THF:
                // thfs drop more gil
                if (PMob->m_EcoSystem == ECOSYSTEM::BEASTMAN)
                {
                    // 50% bonus
                    PMob->defaultMobMod(MOBMOD_GIL_BONUS, 150);
                }
                break;
            case JOB_RNG:
                if ((PMob->m_Family >= 126 && PMob->m_Family <= 130) || PMob->m_Family == 328) // Gigas
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 658); // catapult only used while at range
                }
                else if (PMob->m_Family == 3) // Aern
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1388);
                }
                else
                {
                    // All other rangers
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 272);
                }

                PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 6);
                PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 12);
                PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 70);
                break;
            case JOB_NIN:
                if (PMob->m_Family == 3)
                {
                    // aern
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1388);
                    PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 12);
                }
                else if (PMob->m_Family != 335) // exclude NIN Maat
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 272);
                    PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 12);
                }

                PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 70);
                break;
            case JOB_BST:
                PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 70);
                PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1017);
                break;
            case JOB_PUP:
                PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1901);
                PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 720);
                break;
            case JOB_BLM:
                // We don't want to do the mages stand-back part from subjob, so we have it here
                PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 12);
                PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 70);
            default:
                break;
        }
    }

    void SetupRoaming(CMobEntity* PMob)
    {
        uint16 distance = 10;
        uint16 turns    = 1;
        uint16 cool     = 20;
        uint16 rate     = 15;

        switch (PMob->m_EcoSystem)
        {
            case ECOSYSTEM::BEASTMAN:
                distance = 20;
                turns    = 5;
                cool     = 45;
                break;
            default:
                break;
        }

        // default mob roaming mods
        PMob->defaultMobMod(MOBMOD_ROAM_DISTANCE, distance);
        PMob->defaultMobMod(MOBMOD_ROAM_TURNS, turns);
        PMob->defaultMobMod(MOBMOD_ROAM_COOL, cool);
        PMob->defaultMobMod(MOBMOD_ROAM_RATE, rate);

        if (PMob->m_roamFlags & ROAMFLAG_AMBUSH)
        {
            PMob->m_specialFlags |= SPECIALFLAG_HIDDEN;
            // always stay close to spawn
            PMob->m_maxRoamDistance = 2.0f;
            PMob->setMobMod(MOBMOD_ROAM_DISTANCE, 5);
            PMob->setMobMod(MOBMOD_ROAM_TURNS, 1);
        }
    }

    void SetupPetSkills(CMobEntity* PMob)
    {
        int16 skillListId = 0;
        // same mob can spawn as different families
        // can't set this from the database
        switch (PMob->m_Family)
        {
            case 383: // ifrit
                skillListId = 715;
                break;
            case 388: // titan
                skillListId = 716;
                break;
            case 384: // levi
                skillListId = 717;
                break;
            case 382: // garuda
                skillListId = 718;
                break;
            case 387: // shiva
                skillListId = 719;
                break;
            case 386: // ramuh
                skillListId = 720;
                break;
            case 379: // carbuncle
                skillListId = 721;
                break;
        }

        if (skillListId != 0)
        {
            PMob->setMobMod(MOBMOD_SKILL_LIST, skillListId);
        }
    }

    void SetupDynamisMob(CMobEntity* PMob)
    {
        // no gil drop and no mugging!
        PMob->setMobMod(MOBMOD_GIL_MAX, -1);
        PMob->setMobMod(MOBMOD_MUG_GIL, -1);

        // boost dynamis mobs weapon damage
        PMob->setMobMod(MOBMOD_WEAPON_BONUS, 135);
        ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(GetWeaponDamage(PMob));

        // job resist traits are much more powerful in dynamis
        // according to wiki
        for (auto&& PTrait : PMob->TraitList)
        {
            Mod type = PTrait->getMod();

            if (type >= Mod::SLEEPRES && type <= Mod::DEATHRES)
            {
                // give mob a total of x4 the regular rate
                PMob->addModifier(type, PTrait->getValue() * 3);
            }
        }
    }

    void SetupLimbusMob(CMobEntity* PMob)
    {
        PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);

        // Battlefield mobs don't drop gil
        PMob->setMobMod(MOBMOD_GIL_MAX, -1);
        PMob->setMobMod(MOBMOD_MUG_GIL, -1);
        PMob->setMobMod(MOBMOD_EXP_BONUS, -100);

        // never despawn
        PMob->SetDespawnTime(0s);
        PMob->setMobMod(MOBMOD_ALLI_HATE, 200);
    }

    void SetupBattlefieldMob(CMobEntity* PMob)
    {
        PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);

        // Battlefield mobs don't drop gil
        PMob->setMobMod(MOBMOD_GIL_MAX, -1);
        PMob->setMobMod(MOBMOD_MUG_GIL, -1);
        PMob->setMobMod(MOBMOD_EXP_BONUS, -100);

        // never despawn
        PMob->SetDespawnTime(0s);
        // do not roam around
        PMob->m_roamFlags |= ROAMFLAG_EVENT;
        PMob->m_maxRoamDistance = 0.5f;
        if ((PMob->m_bcnmID != 864) && (PMob->m_bcnmID != 704) && (PMob->m_bcnmID != 706))
        {
            // bcnmID 864 (desires of emptiness), 704 (darkness named), and 706 (waking dreams) don't superlink
            // force all mobs in same instance to superlink
            // plus one in case id is zero
            PMob->setMobMod(MOBMOD_SUPERLINK, PMob->m_battlefieldID);
        }
    }

    void SetupDungeonMob(CMobEntity* PMob)
    {
    }

    void SetupEventMob(CMobEntity* PMob)
    {
        // event mob types will always have custom roaming
        PMob->m_roamFlags |= ROAMFLAG_EVENT;
        PMob->m_maxRoamDistance = 0.5f; // always go back to spawn

        PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);
    }

    void SetupNMMob(CMobEntity* PMob)
    {
        JOBTYPE mJob = PMob->GetMJob();
        uint8   mLvl = PMob->GetMLevel();

        PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);

        // NMs cure earlier
        PMob->defaultMobMod(MOBMOD_HP_HEAL_CHANCE, 50);
        PMob->defaultMobMod(MOBMOD_HEAL_CHANCE, 40);

        // give a gil bonus if accurate value was not set
        if (PMob->getMobMod(MOBMOD_GIL_MAX) == 0)
        {
            PMob->defaultMobMod(MOBMOD_GIL_BONUS, 100);
        }

        if (mLvl >= 25)
        {
            if (mJob == JOB_WHM)
            {
                // whm nms have stronger regen effect
                PMob->addModifier(Mod::REGEN, mLvl / 4);
            }
        }
    }

    void RecalculateSpellContainer(CMobEntity* PMob)
    {
        // clear spell list
        PMob->SpellContainer->ClearSpells();

        // insert the rest of the spells
        for (std::vector<MobSpell_t>::iterator it = PMob->m_SpellListContainer->m_spellList.begin(); it != PMob->m_SpellListContainer->m_spellList.end(); ++it)
        {
            if (PMob->GetMLevel() >= (*it).min_level && PMob->GetMLevel() <= (*it).max_level)
            {
                PMob->SpellContainer->AddSpell((*it).spellId);
            }
        }
    }

    /* Gets the available spells for the specified monster.
     */
    void GetAvailableSpells(CMobEntity* PMob)
    {
        // make sure the mob actually has a spell list
        if (PMob->m_SpellListContainer == nullptr)
        {
            return;
        }

        // catch all non-defaulted spell chances
        PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
        PMob->defaultMobMod(MOBMOD_GA_CHANCE, 35);
        PMob->defaultMobMod(MOBMOD_NA_CHANCE, 40);
        PMob->defaultMobMod(MOBMOD_SEVERE_SPELL_CHANCE, 20);
        PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 35);
        PMob->defaultMobMod(MOBMOD_HEAL_CHANCE, 40);
        PMob->defaultMobMod(MOBMOD_HP_HEAL_CHANCE, 40);

        RecalculateSpellContainer(PMob);

        // make sure mob has mp to cast spells
        if (PMob->health.maxmp == 0 && PMob->SpellContainer != nullptr && PMob->SpellContainer->HasMPSpells())
        {
            ShowError("mobutils::CalculateStats Mob (%u) has no mp for casting spells!\n", PMob->id);
        }
    }

    void SetSpellList(CMobEntity* PMob, uint16 spellList)
    {
        PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(spellList);
        RecalculateSpellContainer(PMob);
    }

    void InitializeMob(CMobEntity* PMob, CZone* PZone)
    {
        // add special mob mods

        // this only has to be added once
        AddCustomMods(PMob);

        PMob->m_Immunity |= PMob->getMobMod(MOBMOD_IMMUNITY);

        PMob->defaultMobMod(MOBMOD_SKILL_LIST, PMob->m_MobSkillList);
        PMob->defaultMobMod(MOBMOD_LINK_RADIUS, 10);
        PMob->defaultMobMod(MOBMOD_TP_USE_CHANCE,
                            92); // 92 = 0.92% chance per 400ms tick (50% chance by 30 seconds) while mob HPP>25 and mob TP >=1000 but <3000
        PMob->defaultMobMod(MOBMOD_SIGHT_RANGE, (int16)CMobEntity::sight_range);
        PMob->defaultMobMod(MOBMOD_SOUND_RANGE, (int16)CMobEntity::sound_range);

        // Killer Effect
        switch (PMob->m_EcoSystem)
        {
            case ECOSYSTEM::AMORPH:
                PMob->addModifier(Mod::BIRD_KILLER, 5);
                break;
            case ECOSYSTEM::AQUAN:
                PMob->addModifier(Mod::AMORPH_KILLER, 5);
                break;
            case ECOSYSTEM::ARCANA:
                PMob->addModifier(Mod::UNDEAD_KILLER, 5);
                break;
            case ECOSYSTEM::BEAST:
                PMob->addModifier(Mod::LIZARD_KILLER, 5);
                break;
            case ECOSYSTEM::BIRD:
                PMob->addModifier(Mod::AQUAN_KILLER, 5);
                break;
            case ECOSYSTEM::DEMON:
                PMob->addModifier(Mod::DRAGON_KILLER, 5);
                break;
            case ECOSYSTEM::DRAGON:
                PMob->addModifier(Mod::DEMON_KILLER, 5);
                break;
            case ECOSYSTEM::LIZARD:
                PMob->addModifier(Mod::VERMIN_KILLER, 5);
                break;
            case ECOSYSTEM::LUMINION:
                PMob->addModifier(Mod::LUMORIAN_KILLER, 5);
                break;
            case ECOSYSTEM::LUMORIAN:
                PMob->addModifier(Mod::LUMINION_KILLER, 5);
                break;
            case ECOSYSTEM::PLANTOID:
                PMob->addModifier(Mod::BEAST_KILLER, 5);
                break;
            case ECOSYSTEM::UNDEAD:
                PMob->addModifier(Mod::ARCANA_KILLER, 5);
                break;
            case ECOSYSTEM::VERMIN:
                PMob->addModifier(Mod::PLANTOID_KILLER, 5);
                break;
            default:
                break;
        }

        if (PMob->m_maxLevel == 0 && PMob->m_minLevel == 0)
        {
            if (PMob->getZone() >= 1 && PMob->getZone() <= 252)
            {
                ShowError("Mob %s level is 0! zoneid %d, poolid %d\n", PMob->GetName(), PMob->getZone(), PMob->m_Pool);
            }
        }
    }

    /*
Loads up custom mob mods from mob_pool_mods and mob_family_mods table. This will allow you to customize
a mobs regen rate, magic defense, triple attack rate from a table instead of hardcoding it.

Usage:

    Evil weapons have a magic defense boost. So pop that into mob_family_mods table.
    Goblin Diggers have a vermin killer trait, so find its poolid and put it in mod_pool_mods table.

*/
    void LoadCustomMods()
    {
        // load family mods
        const char QueryFamilyMods[] = "SELECT familyid, modid, value, is_mob_mod FROM mob_family_mods;";

        int32 ret = Sql_Query(SqlHandle, QueryFamilyMods);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                ModsList_t* familyMods = GetMobFamilyMods(Sql_GetUIntData(SqlHandle, 0), true);

                CModifier* mod = new CModifier(static_cast<Mod>(Sql_GetUIntData(SqlHandle, 1)));
                mod->setModAmount(Sql_GetIntData(SqlHandle, 2));

                int8 isMobMod = Sql_GetIntData(SqlHandle, 3);
                if (isMobMod == 1)
                {
                    familyMods->mobMods.push_back(mod);
                }
                else
                {
                    familyMods->mods.push_back(mod);
                }
            }
        }

        // load pool mods
        const char QueryPoolMods[] = "SELECT poolid, modid, value, is_mob_mod FROM mob_pool_mods;";

        ret = Sql_Query(SqlHandle, QueryPoolMods);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                uint16      pool     = Sql_GetUIntData(SqlHandle, 0);
                ModsList_t* poolMods = GetMobPoolMods(pool, true);

                Mod id = static_cast<Mod>(Sql_GetUIntData(SqlHandle, 1));

                CModifier* mod = new CModifier(id);
                mod->setModAmount(Sql_GetUIntData(SqlHandle, 2));

                int8 isMobMod = Sql_GetIntData(SqlHandle, 3);
                if (isMobMod == 1)
                {
                    poolMods->mobMods.push_back(mod);
                }
                else
                {
                    poolMods->mods.push_back(mod);
                }
            }
        }

        // load spawn mods
        const char QuerySpawnMods[] = "SELECT mobid, modid, value, is_mob_mod FROM mob_spawn_mods;";

        ret = Sql_Query(SqlHandle, QuerySpawnMods);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                ModsList_t* spawnMods = GetMobSpawnMods(Sql_GetUIntData(SqlHandle, 0), true);

                CModifier* mod = new CModifier(static_cast<Mod>(Sql_GetUIntData(SqlHandle, 1)));
                mod->setModAmount(Sql_GetUIntData(SqlHandle, 2));

                int8 isMobMod = Sql_GetIntData(SqlHandle, 3);
                if (isMobMod == 1)
                {
                    spawnMods->mobMods.push_back(mod);
                }
                else
                {
                    spawnMods->mods.push_back(mod);
                }
            }
        }
    }

    ModsList_t* GetMobFamilyMods(uint16 familyId, bool create)
    {
        if (mobFamilyModsList[familyId])
        {
            return mobFamilyModsList[familyId];
        }

        if (create)
        {
            // create new one
            ModsList_t* mods = new ModsList_t;
            mods->id         = familyId;

            mobFamilyModsList[familyId] = mods;

            return mods;
        }

        return nullptr;
    }

    ModsList_t* GetMobPoolMods(uint32 poolId, bool create)
    {
        if (mobPoolModsList[poolId])
        {
            return mobPoolModsList[poolId];
        }

        if (create)
        {
            // create new one
            ModsList_t* mods = new ModsList_t;
            mods->id         = poolId;

            mobPoolModsList[poolId] = mods;

            return mods;
        }

        return nullptr;
    }

    ModsList_t* GetMobSpawnMods(uint32 mobId, bool create)
    {
        if (mobSpawnModsList[mobId])
        {
            return mobSpawnModsList[mobId];
        }

        if (create)
        {
            // create new one
            ModsList_t* mods = new ModsList_t;
            mods->id         = mobId;

            mobSpawnModsList[mobId] = mods;

            return mods;
        }

        return nullptr;
    }

    void AddCustomMods(CMobEntity* PMob)
    {
        // find my families custom mods
        ModsList_t* PFamilyMods = GetMobFamilyMods(PMob->m_Family);

        if (PFamilyMods != nullptr)
        {
            // add them
            for (auto& mod : PFamilyMods->mods)
            {
                PMob->addModifier(mod->getModID(), mod->getModAmount());
            }
            // TODO: don't store mobmods in a CModifier
            for (auto& mobMod : PFamilyMods->mobMods)
            {
                PMob->setMobMod(static_cast<uint16>(mobMod->getModID()), mobMod->getModAmount());
            }
        }

        // find my pools custom mods
        ModsList_t* PPoolMods = GetMobPoolMods(PMob->m_Pool);

        if (PPoolMods != nullptr)
        {
            // add them
            for (auto& mod : PPoolMods->mods)
            {
                PMob->addModifier(mod->getModID(), mod->getModAmount());
            }

            for (auto& mobMod : PPoolMods->mobMods)
            {
                PMob->setMobMod(static_cast<uint16>(mobMod->getModID()), mobMod->getModAmount());
            }
        }

        // find my pools custom mods
        ModsList_t* PSpawnMods = GetMobSpawnMods(PMob->id);

        if (PSpawnMods != nullptr)
        {
            // add them
            for (auto& mod : PSpawnMods->mods)
            {
                PMob->addModifier(mod->getModID(), mod->getModAmount());
            }

            for (auto& mobMod : PSpawnMods->mobMods)
            {
                PMob->setMobMod(static_cast<uint16>(mobMod->getModID()), mobMod->getModAmount());
            }
        }
    }

    CMobEntity* InstantiateAlly(uint32 groupid, uint16 zoneID, CInstance* instance)
    {
        const char* Query = "SELECT zoneid, mob_groups.name, packet_name, \
        respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, \
        modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, \
        systemid, mobsize, speed, \
        STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, ATT, ACC, \
        slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, \
        fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, \
        fire_res, ice_res, wind_res, earth_res, lightning_res, water_res, light_res, dark_res, \
        Element, mob_pools.familyid, name_prefix, entityFlags, animationsub, \
        (mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, mob_groups.poolid, \
        allegiance, namevis, aggro, mob_pools.skill_list_id, mob_pools.true_detection, mob_family_system.detects \
        FROM mob_groups INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid \
        INNER JOIN mob_resistances ON mob_pools.resist_id = mob_resistances.resist_id \
        INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyid \
        WHERE mob_groups.groupid = %u AND mob_groups.zoneid = %u";

        int32 ret = Sql_Query(SqlHandle, Query, groupid, zoneID);

        CMobEntity* PMob = nullptr;

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                PMob            = new CMobEntity;
                PMob->PInstance = instance;

                PMob->name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
                PMob->packetName.insert(0, (const char*)Sql_GetData(SqlHandle, 2));

                PMob->m_RespawnTime = Sql_GetUIntData(SqlHandle, 3) * 1000;
                PMob->m_SpawnType   = (SPAWNTYPE)Sql_GetUIntData(SqlHandle, 4);
                PMob->m_DropID      = Sql_GetUIntData(SqlHandle, 5);

                PMob->HPmodifier = (uint32)Sql_GetIntData(SqlHandle, 6);
                PMob->MPmodifier = (uint32)Sql_GetIntData(SqlHandle, 7);

                PMob->m_minLevel = (uint8)Sql_GetIntData(SqlHandle, 8);
                PMob->m_maxLevel = (uint8)Sql_GetIntData(SqlHandle, 9);

                memcpy(&PMob->look, Sql_GetData(SqlHandle, 10), 23);

                PMob->SetMJob(Sql_GetIntData(SqlHandle, 11));
                PMob->SetSJob(Sql_GetIntData(SqlHandle, 12));

                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(Sql_GetIntData(SqlHandle, 13));
                PMob->m_dmgMult = Sql_GetUIntData(SqlHandle, 14);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((Sql_GetIntData(SqlHandle, 15) * 1000) / 60);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((Sql_GetIntData(SqlHandle, 15) * 1000) / 60);

                PMob->m_Behaviour = (uint16)Sql_GetIntData(SqlHandle, 16);
                PMob->m_Link      = (uint8)Sql_GetIntData(SqlHandle, 17);
                PMob->m_Type      = (uint8)Sql_GetIntData(SqlHandle, 18);
                PMob->m_Immunity  = (IMMUNITY)Sql_GetIntData(SqlHandle, 19);
                PMob->m_EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlHandle, 20);
                PMob->m_ModelSize = (uint8)Sql_GetIntData(SqlHandle, 21);

                PMob->speed    = (uint8)Sql_GetIntData(SqlHandle, 22); // Overwrites baseentity.cpp's defined speed
                PMob->speedsub = (uint8)Sql_GetIntData(SqlHandle, 22); // Overwrites baseentity.cpp's defined speedsub

                PMob->strRank = (uint8)Sql_GetIntData(SqlHandle, 23);
                PMob->dexRank = (uint8)Sql_GetIntData(SqlHandle, 24);
                PMob->vitRank = (uint8)Sql_GetIntData(SqlHandle, 25);
                PMob->agiRank = (uint8)Sql_GetIntData(SqlHandle, 26);
                PMob->intRank = (uint8)Sql_GetIntData(SqlHandle, 27);
                PMob->mndRank = (uint8)Sql_GetIntData(SqlHandle, 28);
                PMob->chrRank = (uint8)Sql_GetIntData(SqlHandle, 29);
                PMob->evaRank = (uint8)Sql_GetIntData(SqlHandle, 30);
                PMob->defRank = (uint8)Sql_GetIntData(SqlHandle, 31);
                PMob->attRank = (uint8)Sql_GetIntData(SqlHandle, 32);
                PMob->accRank = (uint8)Sql_GetIntData(SqlHandle, 33);

                PMob->setModifier(Mod::SLASH_SDT, (uint16)(Sql_GetFloatData(SqlHandle, 34) * 1000));
                PMob->setModifier(Mod::PIERCE_SDT, (uint16)(Sql_GetFloatData(SqlHandle, 35) * 1000));
                PMob->setModifier(Mod::HTH_SDT, (uint16)(Sql_GetFloatData(SqlHandle, 36) * 1000));
                PMob->setModifier(Mod::IMPACT_SDT, (uint16)(Sql_GetFloatData(SqlHandle, 37) * 1000));

                PMob->setModifier(Mod::FIRE_SDT, (int16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -100));    // These are stored as floating percentages
                PMob->setModifier(Mod::ICE_SDT, (int16)((Sql_GetFloatData(SqlHandle, 39) - 1) * -100));     // and need to be adjusted into modifier units.
                PMob->setModifier(Mod::WIND_SDT, (int16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -100));    // Todo: make these work like the physical ones
                PMob->setModifier(Mod::EARTH_SDT, (int16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100));
                PMob->setModifier(Mod::THUNDER_SDT, (int16)((Sql_GetFloatData(SqlHandle, 42) - 1) * -100));
                PMob->setModifier(Mod::WATER_SDT, (int16)((Sql_GetFloatData(SqlHandle, 43) - 1) * -100));
                PMob->setModifier(Mod::LIGHT_SDT, (int16)((Sql_GetFloatData(SqlHandle, 44) - 1) * -100));
                PMob->setModifier(Mod::DARK_SDT, (int16)((Sql_GetFloatData(SqlHandle, 45) - 1) * -100));

                PMob->setModifier(Mod::FIRE_RES, (int16)(Sql_GetIntData(SqlHandle, 46)));    // These are stored as signed integers which
                PMob->setModifier(Mod::ICE_RES, (int16)(Sql_GetIntData(SqlHandle, 47)));     // is directly the modifier starting value.
                PMob->setModifier(Mod::WIND_RES, (int16)(Sql_GetIntData(SqlHandle, 48)));    // Positives signify increased resist chance.
                PMob->setModifier(Mod::EARTH_RES, (int16)(Sql_GetIntData(SqlHandle, 49)));
                PMob->setModifier(Mod::THUNDER_RES, (int16)(Sql_GetIntData(SqlHandle, 50)));
                PMob->setModifier(Mod::WATER_RES, (int16)(Sql_GetIntData(SqlHandle, 51)));
                PMob->setModifier(Mod::LIGHT_RES, (int16)(Sql_GetIntData(SqlHandle, 52)));
                PMob->setModifier(Mod::DARK_RES, (int16)(Sql_GetIntData(SqlHandle, 53)));

                PMob->m_Element     = (uint8)Sql_GetIntData(SqlHandle, 54);
                PMob->m_Family      = (uint16)Sql_GetIntData(SqlHandle, 55);
                PMob->m_name_prefix = (uint8)Sql_GetIntData(SqlHandle, 56);
                PMob->m_flags       = (uint32)Sql_GetIntData(SqlHandle, 57);

                // Special sub animation for Mob (yovra, jailer of love, phuabo)
                // yovra 1: en hauteur, 2: en bas, 3: en haut
                // phuabo 1: sous l'eau, 2: sort de l'eau, 3: rentre dans l'eau
                PMob->animationsub = (uint32)Sql_GetIntData(SqlHandle, 58);

                // Setup HP / MP Stat Percentage Boost
                PMob->HPscale = Sql_GetFloatData(SqlHandle, 59);
                PMob->MPscale = Sql_GetFloatData(SqlHandle, 60);

                // Check if we should be looking up scripts for this mob
                PMob->m_HasSpellScript = (uint8)Sql_GetIntData(SqlHandle, 61);

                PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(Sql_GetIntData(SqlHandle, 62));

                PMob->m_Pool = Sql_GetUIntData(SqlHandle, 63);

                PMob->allegiance      = static_cast<ALLEGIANCE_TYPE>(Sql_GetUIntData(SqlHandle, 64));
                PMob->namevis         = Sql_GetUIntData(SqlHandle, 65);
                PMob->m_Aggro         = Sql_GetUIntData(SqlHandle, 66);
                PMob->m_MobSkillList  = Sql_GetUIntData(SqlHandle, 67);
                PMob->m_TrueDetection = Sql_GetUIntData(SqlHandle, 68);
                PMob->m_Detects       = Sql_GetUIntData(SqlHandle, 69);

                // must be here first to define mobmods
                mobutils::InitializeMob(PMob, zoneutils::GetZone(zoneID));

                zoneutils::GetZone(zoneID)->InsertPET(PMob);

                luautils::OnEntityLoad(PMob);

                luautils::OnMobInitialize(PMob);
                luautils::ApplyMixins(PMob);
                luautils::ApplyZoneMixins(PMob);

                PMob->saveModifiers();
                PMob->saveMobModifiers();
            }
        }
        return PMob;
    }

    void WeaknessTrigger(CBaseEntity* PTarget, WeaknessType level)
    {
        uint16 animationID = 0;
        switch (level)
        {
            case WeaknessType::RED:
                animationID = 1806;
                break;
            case WeaknessType::YELLOW:
                animationID = 1807;
                break;
            case WeaknessType::BLUE:
                animationID = 1808;
                break;
            case WeaknessType::WHITE:
                animationID = 1946;
                break;
        }
        action_t action;
        action.actiontype      = ACTION_MOBABILITY_FINISH;
        action.id              = PTarget->id;
        actionList_t& list     = action.getNewActionList();
        list.ActionTargetID    = PTarget->id;
        actionTarget_t& target = list.getNewActionTarget();
        target.animation       = animationID;
        target.param           = 2582;
        PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE, new CActionPacket(action));
    }

}; // namespace mobutils
