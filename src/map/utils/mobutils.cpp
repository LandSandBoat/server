﻿/*
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

#include "common/utils.h"

#include <cmath>

#include "battlefield.h"
#include "battleutils.h"
#include "grades.h"
#include "items/item_weapon.h"
#include "lua/luautils.h"
#include "mob_modifier.h"
#include "mob_spell_container.h"
#include "mob_spell_list.h"
#include "mobutils.h"
#include "packets/action.h"
#include "petutils.h"
#include "spell.h"
#include "status_effect_container.h"
#include "trait.h"
#include "zone_entities.h"
#include "zoneutils.h"
#include <vector>

namespace mobutils
{
    ModsMap_t mobFamilyModsList;
    ModsMap_t mobPoolModsList;
    ModsMap_t mobSpawnModsList;

    /************************************************************************
     *                                                                       *
     *  Calculate mob base weapon damage                                     *
     *                                                                       *
     ************************************************************************/

    uint16 GetWeaponDamage(CMobEntity* PMob, uint16 slot)
    {
        uint16 lvl    = PMob->GetMLevel();
        int8   bonus  = 2;
        uint16 damage = 0;

        if (slot == SLOT_RANGED)
        {
            bonus = 5;
        }

        if (lvl == 1)
        {
            bonus = 0;
        }

        damage = lvl + bonus;

        damage = (uint16)(damage * PMob->m_dmgMult / 100.0f);

        if (PMob->getMobMod(MOBMOD_WEAPON_BONUS) != 0)
        {
            damage = (uint16)(damage + PMob->getMobMod(MOBMOD_WEAPON_BONUS)); // Add this mod to increase a mobs damage by a base amount
        }

        return damage;
    }

    // Gest base skill rankings for ACC/ATT/EVA/MEVA
    uint16 GetBaseSkill(CMobEntity* PMob, uint8 rank)
    {
        int8 mlvl = PMob->GetMLevel();

        switch (rank)
        {
            case 1:
                return battleutils::GetMaxSkill(SKILL_GREAT_AXE, JOB_WAR, mlvl); // A+ Skill (1)
            case 2:
                return battleutils::GetMaxSkill(SKILL_STAFF, JOB_WAR, mlvl); // B Skill (2)
            case 3:
                return battleutils::GetMaxSkill(SKILL_EVASION, JOB_WAR, mlvl); // C Skill (3)
            case 4:
                return battleutils::GetMaxSkill(SKILL_ARCHERY, JOB_WAR, mlvl); // D Skill (4)
            case 5:
                return battleutils::GetMaxSkill(SKILL_THROWING, JOB_MNK, mlvl); // E Skill (5)
        }

        ShowError("mobutils::GetBaseSkill rank (%d) is out of bounds for mob (%u) ", rank, PMob->id);
        return 0;
    }

    uint16 GetMagicEvasion(CMobEntity* PMob)
    {
        uint8 mEvaRank = PMob->evaRank;
        return GetBaseSkill(PMob, mEvaRank);
    }

    /************************************************************************
     *                                                                       *
     *  Base value for defense and evasion                                   *
     *                                                                       *
     ************************************************************************/

    uint16 GetBaseDefEva(CMobEntity* PMob, uint8 rank)
    {
        // See: https://w.atwiki.jp/studiogobli/pages/25.html
        // Enemy defense = [f(Lv, racial defense rank) + 8 + [VIT/2] + job characteristics] x racial characteristics
        // Enemy evasion = f(Lv, main job evasion skill rank) + [AGI/2] + job characteristics
        // The funcion f is below
        uint8 lvl = PMob->GetMLevel();

        if (lvl > 50)
        {
            switch (rank)
            {
                case 1: // A
                    return (uint16)std::floor(153 + (lvl - 50) * 5.0f);
                case 2: // B
                    return (uint16)std::floor(147 + (lvl - 50) * 4.9f);
                case 3: // C
                    return (uint16)std::floor(142 + (lvl - 50) * 4.8f);
                case 4: // D
                    return (uint16)std::floor(136 + (lvl - 50) * 4.7f);
                case 5: // E
                    return (uint16)std::floor(126 + (lvl - 50) * 4.5f);
            }
        }
        else
        {
            switch (rank)
            {
                case 1: // A
                    return (uint16)std::floor(6 + (lvl - 1) * 3.0f);
                case 2: // B
                    return (uint16)std::floor(5 + (lvl - 1) * 2.9f);
                case 3: // C
                    return (uint16)std::floor(5 + (lvl - 1) * 2.8f);
                case 4: // D
                    return (uint16)std::floor(4 + (lvl - 1) * 2.7f);
                case 5: // E
                    return (uint16)std::floor(4 + (lvl - 1) * 2.5f);
            }
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Base value for stat calculations                                     *
     *                                                                       *
     ************************************************************************/

    uint16 GetBaseToRank(uint8 rank, uint16 lvl)
    {
        switch (rank)
        {
            case 1:
                return 5 + ((lvl - 1) * 50) / 100; // A
            case 2:
                return 4 + ((lvl - 1) * 45) / 100; // B
            case 3:
                return 4 + ((lvl - 1) * 40) / 100; // C
            case 4:
                return 3 + ((lvl - 1) * 35) / 100; // D
            case 5:
                return 3 + ((lvl - 1) * 30) / 100; // E
            case 6:
                return 2 + ((lvl - 1) * 25) / 100; // F
            case 7:
                return 2 + ((lvl - 1) * 20) / 100; // G
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Calculation for subjob stats                                         *
     *                                                                       *
     ************************************************************************/
    uint16 GetSubJobStats(uint8 rank, uint16 level, uint16 stat)
    {
        // These ranks A through G are used by all known JP sources. Please note this is equivalent to the US usage of A+ through F
        // https://w.atwiki.jp/studiogobli/pages/27.html
        float sJobStat = 0;

        switch (rank)
        {
            case 1: // A
                if (level <= 30)
                    sJobStat = std::max((std::floor(stat / (4.0f - 0.225f * (level - 30)))), 2.0f);
                else if (level <= 40)
                    sJobStat = std::floor(stat / (3.25f - 0.073f * (level - 30)));
                else if (level <= 46)
                    sJobStat = std::floor(stat / (2.55f - 0.001f * (level - 41)));
                else
                    sJobStat = std::floor(stat / (2.7f - 0.001f * (level - 45)));
                break;

            case 2: // B
                if (level <= 30)
                    sJobStat = std::max((std::floor(stat / (3.1f - 0.075f * (level - 32)))), 2.0f);
                else if (level <= 40)
                    sJobStat = std::floor(stat / (3.1f - 0.075f * (level - 32)));
                else if (level <= 45)
                    sJobStat = std::floor(stat / (2.5f - 0.025f * (level - 40)));
                else
                    sJobStat = std::floor(stat / (2.35f - 0.04f * (level - 44)));
                break;

            case 3: // C
                if (level <= 30)
                    sJobStat = std::max((std::floor(stat / (4.5f - 0.15f * (level - 26)))), 2.0f);
                else if (level <= 40)
                    sJobStat = std::floor(stat / (3.28f - 0.001f * (level - 30)));
                else if (level <= 45)
                    sJobStat = std::floor(stat / (2.6f - 0.025f * (level - 40)));
                else
                    sJobStat = std::floor(stat / (2.1f - 0.2f * (level - 49)));
                break;

            case 4: // D
                if (level <= 30)
                    sJobStat = std::max((std::floor(stat / (5.0f - 0.05f * (level - 21)))), 1.0f);
                else if (level <= 40)
                    sJobStat = std::floor(stat / (3.2f - 0.001f * (level - 29)));
                else if (level <= 45)
                    sJobStat = std::floor(stat / (3.5f - 0.08f * (level - 32)));
                else
                    sJobStat = std::floor(stat / (3.25f - 0.045f * (level - 32)));
                break;

            case 5: // E
                if (level <= 30)
                    sJobStat = std::max((std::floor(stat / (3.8f - 0.1f * (level - 32)))), 1.0f);
                else if (level <= 40)
                    sJobStat = std::floor(stat / (3.8f - 0.15f * (level - 32)));
                else if (level <= 45)
                    sJobStat = std::floor(stat / (2.7f - 0.075f * (level - 40)));
                else
                    sJobStat = std::floor(stat / (2.7f - 0.05f * (level - 45)));
                break;

            case 6: // F
                if (level <= 30)
                    sJobStat = std::max((std::floor(stat / (4.0f - 0.15f * (level - 35)))), 1.0f);
                else if (level <= 40)
                    sJobStat = std::floor(stat / (4.0f - 0.15f * (level - 30)));
                else if (level <= 46)
                    sJobStat = std::floor(stat / (3.0f - 0.1125f * (level - 40)));
                else
                    sJobStat = std::floor(stat / (3.0f - 0.07f * (level - 40)));
                break;

            case 7: // G
                if (level <= 30)
                    sJobStat = std::max((std::floor(stat / (4.0f - 0.15f * (level - 35)))), 1.0f);
                else if (level <= 40)
                    sJobStat = std::floor(stat / (4.0f - 0.2f * (level - 31)));
                else if (level <= 46)
                    sJobStat = std::floor(stat / (2.5f - 0.09f * (level - 40)));
                else
                    sJobStat = std::floor(stat / 2);
                break;
            default:
                sJobStat = stat / 2;
                break;
        }
        return sJobStat;
    }

    /************************************************************************
     *                                                                       *
     *  Checks if the mob is in any Original/RoZ zone                        *
     *                                                                       *
     ************************************************************************/
    bool CheckSubJobZone(CMobEntity* PMob)
    {
        auto zoneId = PMob->getZone();
        if (zoneId != 0 && (zoneId == ZONE_WEST_RONFAURE || zoneId == ZONE_EAST_RONFAURE || zoneId == ZONE_LA_THEINE_PLATEAU || zoneId == ZONE_VALKURM_DUNES || zoneId == ZONE_JUGNER_FOREST || zoneId == ZONE_BATALLIA_DOWNS || zoneId == ZONE_NORTH_GUSTABERG || zoneId == ZONE_SOUTH_GUSTABERG || zoneId == ZONE_KONSCHTAT_HIGHLANDS || zoneId == ZONE_PASHHOW_MARSHLANDS || zoneId == ZONE_ROLANBERRY_FIELDS || zoneId == ZONE_BEAUCEDINE_GLACIER || zoneId == ZONE_XARCABARD || zoneId == ZONE_CAPE_TERIGGAN || zoneId == ZONE_EASTERN_ALTEPA_DESERT || zoneId == ZONE_WEST_SARUTABARUTA || zoneId == ZONE_EAST_SARUTABARUTA || zoneId == ZONE_TAHRONGI_CANYON || zoneId == ZONE_BUBURIMU_PENINSULA || zoneId == ZONE_MERIPHATAUD_MOUNTAINS || zoneId == ZONE_SAUROMUGUE_CHAMPAIGN || zoneId == ZONE_THE_SANCTUARY_OF_ZITAH || zoneId == ZONE_ROMAEVE || zoneId == ZONE_YUHTUNGA_JUNGLE || zoneId == ZONE_YHOATOR_JUNGLE || zoneId == ZONE_WESTERN_ALTEPA_DESERT || zoneId == ZONE_QUFIM_ISLAND || zoneId == ZONE_BEHEMOTHS_DOMINION || zoneId == ZONE_VALLEY_OF_SORROWS || zoneId == ZONE_HORLAIS_PEAK || zoneId == ZONE_GHELSBA_OUTPOST || zoneId == ZONE_FORT_GHELSBA || zoneId == ZONE_YUGHOTT_GROTTO || zoneId == ZONE_PALBOROUGH_MINES || zoneId == ZONE_WAUGHROON_SHRINE || zoneId == ZONE_GIDDEUS || zoneId == ZONE_BALGAS_DAIS || zoneId == ZONE_BEADEAUX || zoneId == ZONE_QULUN_DOME || zoneId == ZONE_DAVOI || zoneId == ZONE_MONASTIC_CAVERN || zoneId == ZONE_CASTLE_OZTROJA || zoneId == ZONE_ALTAR_ROOM || zoneId == ZONE_THE_BOYAHDA_TREE || zoneId == ZONE_DRAGONS_AERY || zoneId == ZONE_MIDDLE_DELKFUTTS_TOWER || zoneId == ZONE_UPPER_DELKFUTTS_TOWER || zoneId == ZONE_TEMPLE_OF_UGGALEPIH || zoneId == ZONE_DEN_OF_RANCOR || zoneId == ZONE_CASTLE_ZVAHL_BAILEYS || zoneId == ZONE_CASTLE_ZVAHL_KEEP || zoneId == ZONE_SACRIFICIAL_CHAMBER || zoneId == ZONE_THRONE_ROOM || zoneId == ZONE_RANGUEMONT_PASS || zoneId == ZONE_BOSTAUNIEUX_OUBLIETTE || zoneId == ZONE_CHAMBER_OF_ORACLES || zoneId == ZONE_TORAIMARAI_CANAL || zoneId == ZONE_FULL_MOON_FOUNTAIN || zoneId == ZONE_ZERUHN_MINES || zoneId == ZONE_KORROLOKA_TUNNEL || zoneId == ZONE_KUFTAL_TUNNEL || zoneId == ZONE_SEA_SERPENT_GROTTO || zoneId == ZONE_VELUGANNON_PALACE || zoneId == ZONE_THE_SHRINE_OF_RUAVITAU || zoneId == ZONE_STELLAR_FULCRUM || zoneId == ZONE_LALOFF_AMPHITHEATER || zoneId == ZONE_THE_CELESTIAL_NEXUS || zoneId == ZONE_LOWER_DELKFUTTS_TOWER || zoneId == ZONE_KING_RANPERRES_TOMB || zoneId == ZONE_DANGRUF_WADI || zoneId == ZONE_INNER_HORUTOTO_RUINS || zoneId == ZONE_ORDELLES_CAVES || zoneId == ZONE_OUTER_HORUTOTO_RUINS || zoneId == ZONE_THE_ELDIEME_NECROPOLIS || zoneId == ZONE_GUSGEN_MINES || zoneId == ZONE_CRAWLERS_NEST || zoneId == ZONE_MAZE_OF_SHAKHRAMI || zoneId == ZONE_GARLAIGE_CITADEL || zoneId == ZONE_CLOISTER_OF_GALES || zoneId == ZONE_CLOISTER_OF_STORMS || zoneId == ZONE_CLOISTER_OF_FROST || zoneId == ZONE_FEIYIN || zoneId == ZONE_IFRITS_CAULDRON || zoneId == ZONE_QUBIA_ARENA || zoneId == ZONE_CLOISTER_OF_FLAMES || zoneId == ZONE_QUICKSAND_CAVES || zoneId == ZONE_CLOISTER_OF_TREMORS || zoneId == ZONE_CLOISTER_OF_TIDES || zoneId == ZONE_GUSTAV_TUNNEL || zoneId == ZONE_LABYRINTH_OF_ONZOZO || zoneId == ZONE_SHIP_BOUND_FOR_SELBINA || zoneId == ZONE_SHIP_BOUND_FOR_MHAURA || zoneId == ZONE_SHIP_BOUND_FOR_SELBINA_PIRATES || zoneId == ZONE_SHIP_BOUND_FOR_MHAURA_PIRATES))
        {
            return true;
        }
        return false;
    }

    /************************************************************************
     *                                                                       *
     *  Calculate mob stats                                                  *
     *                                                                       *
     ************************************************************************/

    void CalculateMobStats(CMobEntity* PMob, bool recover)
    {
        // remove all to keep mods in sync
        PMob->StatusEffectContainer->KillAllStatusEffect();
        PMob->restoreModifiers();
        PMob->restoreMobModifiers();

        bool      isNM     = PMob->m_Type & MOBTYPE_NOTORIOUS;
        JOBTYPE   mJob     = PMob->GetMJob();
        JOBTYPE   sJob     = PMob->GetSJob();
        uint8     mLvl     = PMob->GetMLevel();
        uint8     sLvl     = PMob->GetSLevel();
        ZONE_TYPE zoneType = PMob->loc.zone->GetTypeMask();

        uint8 mJobGrade = 0; // main jobs grade
        uint8 sJobGrade = 0; // subjobs grade

        if (recover == true)
        {
            if (PMob->HPmodifier == 0)
            {
                uint32 mobHP = 1; // Set mob HP

                uint32 baseMobHP = 0; // Define base mobs hp
                uint32 sjHP      = 0; // Define base subjob hp

                mJobGrade = grade::GetJobGrade(mJob, 0); // main jobs grade
                sJobGrade = grade::GetJobGrade(sJob, 0); // subjobs grade

                uint8 base     = 0; // Column for base hp
                uint8 jobScale = 1; // Column for job scaling
                uint8 scaleX   = 2; // Column for modifier scale

                uint8 BaseHP     = grade::GetMobHPScale(mJobGrade, base);     // Main job base HP
                uint8 JobScale   = grade::GetMobHPScale(mJobGrade, jobScale); // Main job scaling
                uint8 ScaleXHP   = grade::GetMobHPScale(mJobGrade, scaleX);   // Main job modifier scale
                uint8 sjJobScale = grade::GetMobHPScale(sJobGrade, jobScale); // Sub job scaling
                uint8 sjScaleXHP = grade::GetMobHPScale(sJobGrade, scaleX);   // Sub job modifier scale

                uint8 RIgrade = std::min(mLvl, (uint8)5); // RI Grade
                uint8 RIbase  = 1;                        // Column for RI base

                uint8 RI = grade::GetMobRBI(RIgrade, RIbase); // Random Increment addition per grade vs. base

                uint8 mLvlIf    = (PMob->GetMLevel() > 5 ? 1 : 0);
                uint8 mLvlIf30  = (PMob->GetMLevel() > 30 ? 1 : 0);
                uint8 raceScale = 6;
                uint8 mLvlScale = 0;

                if (mLvl > 0)
                {
                    baseMobHP = BaseHP + (std::min(mLvl, (uint8)5) - 1) * (JobScale + raceScale - 1) + RI + mLvlIf * (std::min(mLvl, (uint8)30) - 5) * (2 * (JobScale + raceScale) + std::min(mLvl, (uint8)30) - 6) / 2 + mLvlIf30 * ((mLvl - 30) * (63 + ScaleXHP) + (mLvl - 31) * (JobScale + raceScale));
                }

                // 50+ = 1 hp sjstats
                if (mLvl > 49)
                {
                    mLvlScale = std::floor(mLvl);
                }
                // 40-49 = 3/4 hp sjstats
                else if (mLvl > 39)
                {
                    mLvlScale = std::floor(mLvl * 0.75);
                }
                // 31-39 = 1/2 hp sjstats
                else if (mLvl > 30)
                {
                    mLvlScale = std::floor(mLvl * 0.50);
                }
                // 25-30 = 1/4 hp sjstats
                else if (mLvl > 24)
                {
                    mLvlScale = std::floor(mLvl * 0.25);
                }
                // 1-24 = no hp sjstats
                else
                {
                    mLvlScale = 0;
                }

                sjHP = std::ceil((sjJobScale * (std::max((mLvlScale - 1), 0)) + (0.5 + 0.5 * sjScaleXHP) * (std::max(mLvlScale - 10, 0)) + std::max(mLvlScale - 30, 0) + std::max(mLvlScale - 50, 0) + std::max(mLvlScale - 70, 0)) / 2);

                // Orcs 5% more hp
                if ((PMob->m_Family == 189) || (PMob->m_Family == 190) || (PMob->m_Family == 334) || (PMob->m_Family == 407))
                {
                    mobHP = (baseMobHP + sjHP) * 1.05;
                }
                // Quadavs 5% less hp
                else if ((PMob->m_Family == 200) || (PMob->m_Family == 201) || (PMob->m_Family == 202) || (PMob->m_Family == 337) || (PMob->m_Family == 397) || (PMob->m_Family == 408))
                {
                    mobHP = (baseMobHP + sjHP) * .95;
                }
                // Manticore family has 50% more HP
                else if (PMob->m_Family == 179)
                {
                    mobHP = (baseMobHP + sjHP) * 1.5;
                }
                else
                {
                    mobHP = baseMobHP + sjHP;
                }

                if (PMob->PMaster != nullptr)
                {
                    mobHP *= 0.30f; // Retail captures have all pets at 30% of the mobs family of the same level
                }

                PMob->health.maxhp = (int16)(mobHP);
            }
            else
            {
                PMob->health.maxhp = PMob->HPmodifier;
            }

            if (isNM)
            {
                PMob->health.maxhp = (int32)(PMob->health.maxhp * settings::get<float>("map.NM_HP_MULTIPLIER"));
            }
            else
            {
                PMob->health.maxhp = (int32)(PMob->health.maxhp * settings::get<float>("map.MOB_HP_MULTIPLIER"));
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
                    PMob->health.maxmp = (int32)(PMob->health.maxmp * settings::get<float>("map.NM_MP_MULTIPLIER"));
                }
                else
                {
                    PMob->health.maxmp = (int32)(PMob->health.maxmp * settings::get<float>("map.MOB_MP_MULTIPLIER"));
                }
            }
        }

        ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(GetWeaponDamage(PMob, SLOT_MAIN));
        ((CItemWeapon*)PMob->m_Weapons[SLOT_RANGED])->setDamage(GetWeaponDamage(PMob, SLOT_RANGED));

        // reduce weapon delay of MNK
        if (PMob->GetMJob() == JOB_MNK)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->resetDelay();
        }

        // Deprecate MOBMOD_DUAL_WIELD later, replace if check with value from DB
        if (PMob->getMobMod(MOBMOD_DUAL_WIELD))
        {
            PMob->m_dualWield = true;
            // if mob is going to dualWield then need to have sub slot
            // assume it is the same damage as the main slot
            static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_SUB])->setDamage(GetWeaponDamage(PMob, SLOT_MAIN));
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

        uint16 sSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 2), sLvl);
        uint16 sDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 3), sLvl);
        uint16 sVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 4), sLvl);
        uint16 sAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 5), sLvl);
        uint16 sINT = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 6), sLvl);
        uint16 sMND = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 7), sLvl);
        uint16 sCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 8), sLvl);

        // Each subjob stat is determined by where the mob is located and what level the mob is.
        // Each rank has their own formula as shown in GetSubJobStats
        // Sub-level 50 monsters implemented in "Chains of Promathia" and onward (i.e. "Wings of the Goddess" as well) will use rank/2 at all levels.
        // Note: Subjob Level will ALWAYS = Main Job Level but we use sLvl so it makes it easier to know what stat we are calculating
        if (CheckSubJobZone(PMob) && (sLvl < 50))
        {
            sSTR = GetSubJobStats(grade::GetJobGrade(PMob->GetSJob(), 2), sLvl, sSTR);
            sDEX = GetSubJobStats(grade::GetJobGrade(PMob->GetSJob(), 3), sLvl, sDEX);
            sVIT = GetSubJobStats(grade::GetJobGrade(PMob->GetSJob(), 4), sLvl, sVIT);
            sAGI = GetSubJobStats(grade::GetJobGrade(PMob->GetSJob(), 5), sLvl, sAGI);
            sINT = GetSubJobStats(grade::GetJobGrade(PMob->GetSJob(), 6), sLvl, sINT);
            sMND = GetSubJobStats(grade::GetJobGrade(PMob->GetSJob(), 7), sLvl, sMND);
            sCHR = GetSubJobStats(grade::GetJobGrade(PMob->GetSJob(), 8), sLvl, sCHR);
        }
        else
        {
            sSTR /= 2;
            sDEX /= 2;
            sAGI /= 2;
            sINT /= 2;
            sMND /= 2;
            sCHR /= 2;
            sVIT /= 2;
        }

        // [stat] = floor[family Stat] + floor[main job Stat] + floor[sub job Stat]
        PMob->stats.STR = fSTR + mSTR + sSTR;
        PMob->stats.DEX = fDEX + mDEX + sDEX;
        PMob->stats.VIT = fVIT + mVIT + sVIT;
        PMob->stats.AGI = fAGI + mAGI + sAGI;
        PMob->stats.INT = fINT + mINT + sINT;
        PMob->stats.MND = fMND + mMND + sMND;
        PMob->stats.CHR = fCHR + mCHR + sCHR;

        auto statMultiplier = isNM ? settings::get<float>("map.NM_STAT_MULTIPLIER") : settings::get<float>("map.MOB_STAT_MULTIPLIER");
        PMob->stats.STR     = (uint16)(PMob->stats.STR * statMultiplier);
        PMob->stats.DEX     = (uint16)(PMob->stats.DEX * statMultiplier);
        PMob->stats.VIT     = (uint16)(PMob->stats.VIT * statMultiplier);
        PMob->stats.AGI     = (uint16)(PMob->stats.AGI * statMultiplier);
        PMob->stats.INT     = (uint16)(PMob->stats.INT * statMultiplier);
        PMob->stats.MND     = (uint16)(PMob->stats.MND * statMultiplier);
        PMob->stats.CHR     = (uint16)(PMob->stats.CHR * statMultiplier);

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

        PMob->addModifier(Mod::DEF, GetBaseDefEva(PMob, PMob->defRank)); // Base Defense for all mobs
        PMob->addModifier(Mod::EVA, GetBaseDefEva(PMob, PMob->evaRank)); // Base Evasion for all mobs
        PMob->addModifier(Mod::ATT, GetBaseSkill(PMob, PMob->attRank));  // Base Attack for all mobs is Rank A+ but pull from DB for specific cases
        PMob->addModifier(Mod::ACC, GetBaseSkill(PMob, PMob->accRank));  // Base Accuracy for all mobs is Rank A+ but pull from DB for specific cases
        PMob->addModifier(Mod::RATT, GetBaseSkill(PMob, PMob->attRank)); // Base Ranged Attack for all mobs is Rank A+ but pull from DB for specific cases
        PMob->addModifier(Mod::RACC, GetBaseSkill(PMob, PMob->accRank)); // Base Ranged Accuracy for all mobs is Rank A+ but pull from DB for specific cases

        // Known Base Parry for all mobs is Rank C
        // MOBMOD_CAN_PARRY uses the mod value as the rank, unknown if mobs in current retail or somewhere else have a different parry rank
        // Known mobs to have parry rating:
        // Dynamis beastmen mobs
        // Fantoccini (not yet coded)
        if (PMob->getMobMod(MOBMOD_CAN_PARRY) > 0)
        {
            PMob->WorkingSkills.skill[SKILL_PARRY] = GetBaseSkill(PMob, PMob->getMobMod(MOBMOD_CAN_PARRY));
        }

        // Assume base guard for MNK and PUP mobs is the same as parry (Rank C)
        if ((PMob->GetMJob() == JOB_MNK || PMob->GetMJob() == JOB_PUP) && PMob->getMobMod(MOBMOD_CANNOT_GUARD) == 0)
        {
            PMob->WorkingSkills.skill[SKILL_GUARD] = GetBaseSkill(PMob, 3);
        }

        // natural magic evasion
        PMob->addModifier(Mod::MEVA, GetMagicEvasion(PMob));

        // add traits for sub and main
        battleutils::AddTraits(PMob, traits::GetTraits(mJob), mLvl);
        battleutils::AddTraits(PMob, traits::GetTraits(PMob->GetSJob()), PMob->GetSLevel());

        // Max [HP/MP] Boost traits
        PMob->UpdateHealth();
        PMob->health.tp = 0;
        PMob->health.hp = PMob->GetMaxHP();
        PMob->health.mp = PMob->GetMaxMP();

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

        if (zoneType & ZONE_TYPE::DUNGEON)
        {
            SetupDungeonMob(PMob);
        }
        else if (PMob->m_Type & MOBTYPE_BATTLEFIELD)
        {
            SetupBattlefieldMob(PMob);
        }
        else if (zoneType & ZONE_TYPE::DYNAMIS)
        {
            SetupDynamisMob(PMob);
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
            ShowError("mobutils::CalculateMobStats Mob (%s, %d) with special skill but no cool down set!", PMob->getName(), PMob->id);
        }

        if (PMob->SpellContainer->HasSpells() && PMob->getMobMod(MOBMOD_MAGIC_COOL) == 0)
        {
            ShowError("mobutils::CalculateMobStats Mob (%s, %d) with magic but no cool down set!", PMob->getName(), PMob->id);
        }

        if (PMob->getMobMod(MOBMOD_DETECTION) == 0)
        {
            ShowError("mobutils::CalculateMobStats Mob (%s, %d, %d) has no detection methods!", PMob->getName(), PMob->id, PMob->m_Family);
        }
    }

    void SetupJob(CMobEntity* PMob)
    {
        JOBTYPE mJob = PMob->GetMJob();
        JOBTYPE sJob = PMob->GetSJob();
        JOBTYPE job{};

        if (grade::GetJobGrade(mJob, 1) > 0 || mJob == JOB_NIN) // check if mainjob gives mp or is NIN
        {
            job = mJob;
        }
        else // if mainjob had no MP (and isn't NIN), use subjob in switch cases.
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
            case JOB_BLU:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                break;
            case JOB_SCH:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                break;
            case JOB_GEO:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
                break;
            case JOB_RUN:
                PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
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
                else if (PMob->m_Family == 246) // Trolls
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1747); // Zarraqa only used while at range
                    PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 0);
                    PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 14);
                    PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 70);
                    break;
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

        if (PMob->m_EcoSystem == ECOSYSTEM::BEASTMAN)
        {
            distance = 20;
            turns    = 5;
            cool     = 45;
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

        if (PMob->m_roamFlags & ROAMFLAG_SCRIPTED)
        {
            PMob->setMobMod(MOBMOD_ROAM_RESET_FACING, 1);
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
        PMob->setMobMod(MOBMOD_WEAPON_BONUS, 30); // Add approximately 30 flat damage until proven otherwise (In-line with the 35% added previously)
        ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(GetWeaponDamage(PMob, SLOT_MAIN));
        ((CItemWeapon*)PMob->m_Weapons[SLOT_RANGED])->setDamage(GetWeaponDamage(PMob, SLOT_RANGED));

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

    void SetupBattlefieldMob(CMobEntity* PMob)
    {
        PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);

        // Battlefield mobs don't drop gil
        PMob->setMobMod(MOBMOD_GIL_MAX, -1);
        PMob->setMobMod(MOBMOD_MUG_GIL, -1);
        PMob->setMobMod(MOBMOD_EXP_BONUS, -100);

        // never despawn
        PMob->SetDespawnTime(0s);

        // Stop early if this is a new battlefield
        if (PMob->PBattlefield != nullptr)
        {
            return;
        }

        // do not roam around
        PMob->m_roamFlags |= ROAMFLAG_SCRIPTED;
        PMob->setMobMod(MOBMOD_ROAM_RESET_FACING, 1);
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
        // event mob types will always have scripted roaming (any mob can have it scripted, but these ALWAYS do)
        PMob->m_roamFlags |= ROAMFLAG_SCRIPTED;
        PMob->setMobMod(MOBMOD_ROAM_RESET_FACING, 1);
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
            ShowError("mobutils::GetAvailableSpells Mob (%u) has no mp for casting spells!", PMob->id);
        }
    }

    void SetSpellList(CMobEntity* PMob, uint16 spellList)
    {
        PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(spellList);
        RecalculateSpellContainer(PMob);
    }

    void InitializeMob(CMobEntity* PMob)
    {
        // add special mob mods

        PMob->m_Immunity |= PMob->getMobMod(MOBMOD_IMMUNITY);

        PMob->defaultMobMod(MOBMOD_SKILL_LIST, PMob->m_MobSkillList);
        PMob->defaultMobMod(MOBMOD_LINK_RADIUS, 10);
        PMob->defaultMobMod(MOBMOD_TP_USE_CHANCE,
                            92); // 92 = 0.92% chance per 400ms tick (50% chance by 30 seconds) while mob HPP>25 and mob TP >=1000 but <3000
        PMob->defaultMobMod(MOBMOD_SIGHT_RANGE, (int16)CMobEntity::sight_range);
        PMob->defaultMobMod(MOBMOD_SOUND_RANGE, (int16)CMobEntity::sound_range);
        PMob->defaultMobMod(MOBMOD_MAGIC_RANGE, (int16)CMobEntity::magic_range);

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
                PMob->addModifier(Mod::LUMINIAN_KILLER, 5);
                break;
            case ECOSYSTEM::LUMINIAN:
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
                ShowError("Mob %s level is 0! zoneid %d, poolid %d", PMob->getName(), PMob->getZone(), PMob->m_Pool);
            }
        }
    }

    /*
    Loads up mob mods from mob_pool_mods and mob_family_mods table. This will allow you to change
    a mobs regen rate, magic defense, triple attack rate from a table instead of hardcoding it.

    Usage:

        Evil weapons have a magic defense boost. So pop that into mob_family_mods table.
        Goblin Diggers have a vermin killer trait, so find its poolid and put it in mod_pool_mods table.
    */
    void LoadSqlModifiers()
    {
        // load family mods
        const char QueryFamilyMods[] = "SELECT familyid, modid, value, is_mob_mod FROM mob_family_mods";

        int32 ret = _sql->Query(QueryFamilyMods);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                ModsList_t* familyMods = GetMobFamilyMods(_sql->GetUIntData(0), true);

                CModifier* mod = new CModifier(static_cast<Mod>(_sql->GetUIntData(1)));
                mod->setModAmount(_sql->GetIntData(2));

                int8 isMobMod = _sql->GetIntData(3);
                if (isMobMod == 1)
                {
                    familyMods->mobMods.emplace_back(mod);
                }
                else
                {
                    familyMods->mods.emplace_back(mod);
                }
            }
        }

        // load pool mods
        const char QueryPoolMods[] = "SELECT poolid, modid, value, is_mob_mod FROM mob_pool_mods";

        ret = _sql->Query(QueryPoolMods);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16      pool     = _sql->GetUIntData(0);
                ModsList_t* poolMods = GetMobPoolMods(pool, true);

                Mod id = static_cast<Mod>(_sql->GetUIntData(1));

                CModifier* mod = new CModifier(id);
                mod->setModAmount(_sql->GetUIntData(2));

                int8 isMobMod = _sql->GetIntData(3);
                if (isMobMod == 1)
                {
                    poolMods->mobMods.emplace_back(mod);
                }
                else
                {
                    poolMods->mods.emplace_back(mod);
                }
            }
        }

        // load spawn mods
        const char QuerySpawnMods[] = "SELECT mobid, modid, value, is_mob_mod FROM mob_spawn_mods";

        ret = _sql->Query(QuerySpawnMods);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                ModsList_t* spawnMods = GetMobSpawnMods(_sql->GetUIntData(0), true);

                CModifier* mod = new CModifier(static_cast<Mod>(_sql->GetUIntData(1)));
                mod->setModAmount(_sql->GetUIntData(2));

                int8 isMobMod = _sql->GetIntData(3);
                if (isMobMod == 1)
                {
                    spawnMods->mobMods.emplace_back(mod);
                }
                else
                {
                    spawnMods->mods.emplace_back(mod);
                }
            }
        }
    }

    void Cleanup()
    {
        // Manually delete and clean up pointers
        for (auto spawnMod : mobSpawnModsList)
        {
            if (spawnMod.second)
            {
                for (auto mobMods : spawnMod.second->mobMods)
                {
                    destroy(mobMods);
                }

                for (auto mods : spawnMod.second->mods)
                {
                    destroy(mods);
                }
                destroy(spawnMod.second);
            }
        }
        mobSpawnModsList.clear();

        for (auto mobFamilyMods : mobFamilyModsList)
        {
            if (mobFamilyMods.second)
            {
                for (auto mobMods : mobFamilyMods.second->mobMods)
                {
                    destroy(mobMods);
                }

                for (auto mods : mobFamilyMods.second->mods)
                {
                    destroy(mods);
                }

                destroy(mobFamilyMods.second);
            }
        }
        mobFamilyModsList.clear();

        for (auto mobPoolMods : mobPoolModsList)
        {
            if (mobPoolMods.second)
            {
                for (auto mobMods : mobPoolMods.second->mobMods)
                {
                    destroy(mobMods);
                }

                for (auto mods : mobPoolMods.second->mods)
                {
                    destroy(mods);
                }
                destroy(mobPoolMods.second);
            }
        }
        mobPoolModsList.clear();
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

    void AddSqlModifiers(CMobEntity* PMob)
    {
        // find my families mods
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

        // find my pools mods
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

        // find my IDs mods
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
        ecosystemID, mobradius, speed, \
        STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, ATT, ACC, \
        slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, \
        magical_sdt, fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, \
        fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, \
        Element, mob_pools.familyid, name_prefix, entityFlags, animationsub, \
        (mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, mob_groups.poolid, \
        allegiance, namevis, aggro, mob_pools.skill_list_id, mob_pools.true_detection, mob_family_system.detects \
        FROM mob_groups INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid \
        INNER JOIN mob_resistances ON mob_pools.resist_id = mob_resistances.resist_id \
        INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyID \
        WHERE mob_groups.groupid = %u AND mob_groups.zoneid = %u";

        int32 ret = _sql->Query(Query, groupid, zoneID);

        CMobEntity* PMob = nullptr;

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            if (_sql->NextRow() == SQL_SUCCESS)
            {
                PMob            = new CMobEntity;
                PMob->PInstance = instance;

                PMob->name.insert(0, (const char*)_sql->GetData(1));
                PMob->packetName.insert(0, (const char*)_sql->GetData(2));

                PMob->m_RespawnTime = _sql->GetUIntData(3) * 1000;
                PMob->m_SpawnType   = (SPAWNTYPE)_sql->GetUIntData(4);
                PMob->m_DropID      = _sql->GetUIntData(5);

                PMob->HPmodifier = (uint32)_sql->GetIntData(6);
                PMob->MPmodifier = (uint32)_sql->GetIntData(7);

                PMob->m_minLevel = (uint8)_sql->GetIntData(8);
                PMob->m_maxLevel = (uint8)_sql->GetIntData(9);

                uint16 sqlModelID[10];
                memcpy(&sqlModelID, _sql->GetData(10), 20);
                PMob->look = look_t(sqlModelID);

                PMob->SetMJob(_sql->GetIntData(11));
                PMob->SetSJob(_sql->GetIntData(12));

                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(_sql->GetIntData(13));
                PMob->m_dmgMult = _sql->GetUIntData(14);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((_sql->GetIntData(15) * 1000) / 60);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((_sql->GetIntData(15) * 1000) / 60);

                PMob->m_Behaviour   = (uint16)_sql->GetIntData(16);
                PMob->m_Link        = (uint8)_sql->GetIntData(17);
                PMob->m_Type        = (uint8)_sql->GetIntData(18);
                PMob->m_Immunity    = (IMMUNITY)_sql->GetIntData(19);
                PMob->m_EcoSystem   = (ECOSYSTEM)_sql->GetIntData(20);
                PMob->m_ModelRadius = (float)_sql->GetIntData(21);

                PMob->speed    = (uint8)_sql->GetIntData(22); // Overwrites baseentity.cpp's defined speed
                PMob->speedsub = (uint8)_sql->GetIntData(22); // Overwrites baseentity.cpp's defined speedsub

                PMob->strRank = (uint8)_sql->GetIntData(23);
                PMob->dexRank = (uint8)_sql->GetIntData(24);
                PMob->vitRank = (uint8)_sql->GetIntData(25);
                PMob->agiRank = (uint8)_sql->GetIntData(26);
                PMob->intRank = (uint8)_sql->GetIntData(27);
                PMob->mndRank = (uint8)_sql->GetIntData(28);
                PMob->chrRank = (uint8)_sql->GetIntData(29);
                PMob->evaRank = (uint8)_sql->GetIntData(30);
                PMob->defRank = (uint8)_sql->GetIntData(31);
                PMob->attRank = (uint8)_sql->GetIntData(32);
                PMob->accRank = (uint8)_sql->GetIntData(33);

                PMob->setModifier(Mod::SLASH_SDT, (uint16)(_sql->GetFloatData(34) * 1000));
                PMob->setModifier(Mod::PIERCE_SDT, (uint16)(_sql->GetFloatData(35) * 1000));
                PMob->setModifier(Mod::HTH_SDT, (uint16)(_sql->GetFloatData(36) * 1000));
                PMob->setModifier(Mod::IMPACT_SDT, (uint16)(_sql->GetFloatData(37) * 1000));

                PMob->setModifier(Mod::UDMGMAGIC, (int16)_sql->GetIntData(38)); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

                PMob->setModifier(Mod::FIRE_SDT, (int16)_sql->GetIntData(39));    // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::ICE_SDT, (int16)_sql->GetIntData(40));     // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::WIND_SDT, (int16)_sql->GetIntData(41));    // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::EARTH_SDT, (int16)_sql->GetIntData(42));   // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::THUNDER_SDT, (int16)_sql->GetIntData(43)); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::WATER_SDT, (int16)_sql->GetIntData(44));   // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::LIGHT_SDT, (int16)_sql->GetIntData(45));   // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::DARK_SDT, (int16)_sql->GetIntData(46));    // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

                PMob->setModifier(Mod::FIRE_RES_RANK, (int8)(_sql->GetIntData(47)));
                PMob->setModifier(Mod::ICE_RES_RANK, (int8)(_sql->GetIntData(48)));
                PMob->setModifier(Mod::WIND_RES_RANK, (int8)(_sql->GetIntData(49)));
                PMob->setModifier(Mod::EARTH_RES_RANK, (int8)(_sql->GetIntData(50)));
                PMob->setModifier(Mod::THUNDER_RES_RANK, (int8)(_sql->GetIntData(51)));
                PMob->setModifier(Mod::WATER_RES_RANK, (int8)(_sql->GetIntData(52)));
                PMob->setModifier(Mod::LIGHT_RES_RANK, (int8)(_sql->GetIntData(53)));
                PMob->setModifier(Mod::DARK_RES_RANK, (int8)(_sql->GetIntData(54)));

                PMob->m_Element     = (uint8)_sql->GetIntData(55);
                PMob->m_Family      = (uint16)_sql->GetIntData(56);
                PMob->m_name_prefix = (uint8)_sql->GetIntData(57);
                PMob->m_flags       = (uint32)_sql->GetIntData(58);

                // Special sub animation for Mob (yovra, jailer of love, phuabo)
                // yovra 1: On top/in the sky, 2: , 3: On top/in the sky
                // phuabo 1: Underwater, 2: Out of the water, 3: Goes back underwater
                PMob->animationsub = (uint32)_sql->GetIntData(59);

                // Setup HP / MP Stat Percentage Boost
                PMob->HPscale = _sql->GetFloatData(60);
                PMob->MPscale = _sql->GetFloatData(61);

                // TODO: Remove me
                // Check if we should be looking up scripts for this mob
                // PMob->m_HasSpellScript = (uint8)sql->GetIntData(62);

                PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(_sql->GetIntData(63));

                PMob->m_Pool = _sql->GetUIntData(64);

                PMob->allegiance      = static_cast<ALLEGIANCE_TYPE>(_sql->GetUIntData(65));
                PMob->namevis         = _sql->GetUIntData(66);
                PMob->m_Aggro         = _sql->GetUIntData(67);
                PMob->m_MobSkillList  = _sql->GetUIntData(68);
                PMob->m_TrueDetection = _sql->GetUIntData(69);
                PMob->setMobMod(MOBMOD_DETECTION, _sql->GetUIntData(70));

                CZone* newZone = zoneutils::GetZone(zoneID);
                if (newZone)
                {
                    // Get dynamic targid
                    newZone->GetZoneEntities()->AssignDynamicTargIDandLongID(PMob);

                    // Insert ally into zone's mob list. TODO: Do we need to assign party for allies?
                    newZone->GetZoneEntities()->m_mobList[PMob->targid] = PMob;
                }
                else
                {
                    ShowError("Mobutils::InstantiateAlly failed to get zone from zoneutils::GetZone(zoneID)");
                }

                // Ensure dynamic targid is released on death
                PMob->m_bReleaseTargIDOnDisappear = true;

                // must be here first to define mobmods
                mobutils::InitializeMob(PMob);

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

    CMobEntity* InstantiateDynamicMob(uint32 groupid, uint16 groupZoneId, uint16 targetZoneId)
    {
        CMobEntity* PMob = new CMobEntity();

        const char* Query = "SELECT zoneid, mob_groups.name, packet_name, \
        respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, \
        modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, \
        ecosystemID, mobradius, speed, \
        STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, ATT, ACC, \
        slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, \
        magical_sdt, fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, \
        fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, \
        Element, mob_pools.familyid, name_prefix, entityFlags, animationsub, \
        (mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, mob_groups.poolid, \
        allegiance, namevis, aggro, mob_pools.skill_list_id, mob_pools.true_detection, mob_family_system.detects \
        FROM mob_groups INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid \
        INNER JOIN mob_resistances ON mob_pools.resist_id = mob_resistances.resist_id \
        INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyID \
        WHERE mob_groups.groupid = %u AND mob_groups.zoneid = %u";

        int32 ret = _sql->Query(Query, groupid, groupZoneId);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            if (_sql->NextRow() == SQL_SUCCESS)
            {
                PMob->name.insert(0, (const char*)_sql->GetData(1));
                PMob->packetName.insert(0, (const char*)_sql->GetData(2));

                PMob->m_RespawnTime = _sql->GetUIntData(3) * 1000;
                PMob->m_SpawnType   = (SPAWNTYPE)_sql->GetUIntData(4);
                PMob->m_DropID      = _sql->GetUIntData(5);

                PMob->HPmodifier = (uint32)_sql->GetIntData(6);
                PMob->MPmodifier = (uint32)_sql->GetIntData(7);

                PMob->m_minLevel = (uint8)_sql->GetIntData(8);
                PMob->m_maxLevel = (uint8)_sql->GetIntData(9);

                uint16 sqlModelID[10];
                memcpy(&sqlModelID, _sql->GetData(10), 20);
                PMob->look = look_t(sqlModelID);

                PMob->SetMJob(_sql->GetIntData(11));
                PMob->SetSJob(_sql->GetIntData(12));

                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(_sql->GetIntData(13));
                PMob->m_dmgMult = _sql->GetUIntData(14);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((_sql->GetIntData(15) * 1000) / 60);
                ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((_sql->GetIntData(15) * 1000) / 60);

                PMob->m_Behaviour   = (uint16)_sql->GetIntData(16);
                PMob->m_Link        = (uint8)_sql->GetIntData(17);
                PMob->m_Type        = (uint8)_sql->GetIntData(18);
                PMob->m_Immunity    = (IMMUNITY)_sql->GetIntData(19);
                PMob->m_EcoSystem   = (ECOSYSTEM)_sql->GetIntData(20);
                PMob->m_ModelRadius = (float)_sql->GetIntData(21);

                PMob->speed    = (uint8)_sql->GetIntData(22); // Overwrites baseentity.cpp's defined speed
                PMob->speedsub = (uint8)_sql->GetIntData(22); // Overwrites baseentity.cpp's defined speedsub

                PMob->strRank = (uint8)_sql->GetIntData(23);
                PMob->dexRank = (uint8)_sql->GetIntData(24);
                PMob->vitRank = (uint8)_sql->GetIntData(25);
                PMob->agiRank = (uint8)_sql->GetIntData(26);
                PMob->intRank = (uint8)_sql->GetIntData(27);
                PMob->mndRank = (uint8)_sql->GetIntData(28);
                PMob->chrRank = (uint8)_sql->GetIntData(29);
                PMob->evaRank = (uint8)_sql->GetIntData(30);
                PMob->defRank = (uint8)_sql->GetIntData(31);
                PMob->attRank = (uint8)_sql->GetIntData(32);
                PMob->accRank = (uint8)_sql->GetIntData(33);

                PMob->setModifier(Mod::SLASH_SDT, (uint16)(_sql->GetFloatData(34) * 1000));
                PMob->setModifier(Mod::PIERCE_SDT, (uint16)(_sql->GetFloatData(35) * 1000));
                PMob->setModifier(Mod::HTH_SDT, (uint16)(_sql->GetFloatData(36) * 1000));
                PMob->setModifier(Mod::IMPACT_SDT, (uint16)(_sql->GetFloatData(37) * 1000));

                PMob->setModifier(Mod::UDMGMAGIC, (int16)_sql->GetIntData(38)); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

                PMob->setModifier(Mod::FIRE_SDT, (int16)_sql->GetIntData(39));    // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::ICE_SDT, (int16)_sql->GetIntData(40));     // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::WIND_SDT, (int16)_sql->GetIntData(41));    // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::EARTH_SDT, (int16)_sql->GetIntData(42));   // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::THUNDER_SDT, (int16)_sql->GetIntData(43)); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::WATER_SDT, (int16)_sql->GetIntData(44));   // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::LIGHT_SDT, (int16)_sql->GetIntData(45));   // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
                PMob->setModifier(Mod::DARK_SDT, (int16)_sql->GetIntData(46));    // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

                PMob->setModifier(Mod::FIRE_RES_RANK, (int8)(_sql->GetIntData(47)));
                PMob->setModifier(Mod::ICE_RES_RANK, (int8)(_sql->GetIntData(48)));
                PMob->setModifier(Mod::WIND_RES_RANK, (int8)(_sql->GetIntData(49)));
                PMob->setModifier(Mod::EARTH_RES_RANK, (int8)(_sql->GetIntData(50)));
                PMob->setModifier(Mod::THUNDER_RES_RANK, (int8)(_sql->GetIntData(51)));
                PMob->setModifier(Mod::WATER_RES_RANK, (int8)(_sql->GetIntData(52)));
                PMob->setModifier(Mod::LIGHT_RES_RANK, (int8)(_sql->GetIntData(53)));
                PMob->setModifier(Mod::DARK_RES_RANK, (int8)(_sql->GetIntData(54)));

                PMob->m_Element     = (uint8)_sql->GetIntData(55);
                PMob->m_Family      = (uint16)_sql->GetIntData(56);
                PMob->m_name_prefix = (uint8)_sql->GetIntData(57);
                PMob->m_flags       = (uint32)_sql->GetIntData(58);

                PMob->animationsub = (uint32)_sql->GetIntData(59);

                // Setup HP / MP Stat Percentage Boost
                PMob->HPscale = _sql->GetFloatData(60);
                PMob->MPscale = _sql->GetFloatData(61);

                // TODO: Remove me
                // PMob->m_HasSpellScript = (uint8)sql->GetIntData(62);

                PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(_sql->GetIntData(63));

                PMob->m_Pool = _sql->GetUIntData(64);

                PMob->allegiance      = static_cast<ALLEGIANCE_TYPE>(_sql->GetUIntData(65));
                PMob->namevis         = _sql->GetUIntData(66);
                PMob->m_Aggro         = _sql->GetUIntData(67);
                PMob->m_MobSkillList  = _sql->GetUIntData(68);
                PMob->m_TrueDetection = _sql->GetUIntData(69);
                PMob->setMobMod(MOBMOD_DETECTION, _sql->GetUIntData(70));

                mobutils::InitializeMob(PMob);
                mobutils::AddSqlModifiers(PMob);
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
