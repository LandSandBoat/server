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

#include "mobutils.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/utils.h"

#include "action/action.h"
#include "battlefield.h"
#include "battleutils.h"
#include "grades.h"
#include "items/item_weapon.h"
#include "lua/luautils.h"
#include "map_engine.h"
#include "mob_modifier.h"
#include "mob_spell_container.h"
#include "mob_spell_list.h"
#include "packets/s2c/0x028_battle2.h"
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
    // https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?pli=1&gid=1743955268#gid=1743955268
    // Basic base damage formulas for reference:
    // Normal Mobs(Non H2H): (Level * Multiplier) + Offset
    // Normal MNK mobs     : (Level * Multiplier(Default: 1.0000)) + Offset (Auto attacks get a penalty multiplier)
    // "Special" MNK mobs  : (Level + Offset) * Multiplier(1.6667) (Auto attacks get a penalty multiplier)

    auto   mobZoneId      = PMob->getZone();
    uint16 mobLvl         = PMob->GetMLevel();
    int8   offset         = 0;
    int8   rangedOffset   = 0;
    float  multiplier     = PMob->m_dmgMult / 100.0f;
    int32  damage         = mobLvl;
    int16  damageModifers = 0;

    // Zones from base game/expansions have different base offsets, multipliers, etc.
    REGION_TYPE regionID = PMob->loc.zone->GetRegionID();

    switch (regionID)
    {
        // Vanilla, ROTZ, COP Regions
        case REGION_TYPE::RONFAURE:
        case REGION_TYPE::ZULKHEIM:
        case REGION_TYPE::NORVALLEN:
        case REGION_TYPE::GUSTABERG:
        case REGION_TYPE::DERFLAND:
        case REGION_TYPE::SARUTABARUTA:
        case REGION_TYPE::KOLSHUSHU:
        case REGION_TYPE::ARAGONEU:
        case REGION_TYPE::FAUREGANDI:
        case REGION_TYPE::VALDEAUNIA:
        case REGION_TYPE::QUFIMISLAND:
        case REGION_TYPE::LITELOR:
        case REGION_TYPE::KUZOTZ:
        case REGION_TYPE::VOLLBOW:
        case REGION_TYPE::ELSHIMO_LOWLANDS:
        case REGION_TYPE::ELSHIMO_UPLANDS:
        case REGION_TYPE::TULIA:
        case REGION_TYPE::MOVALPOLOS:
        case REGION_TYPE::TAVNAZIA:
        case REGION_TYPE::SANDORIA:
        case REGION_TYPE::BASTOK:
        case REGION_TYPE::WINDURST:
        case REGION_TYPE::JEUNO:
        case REGION_TYPE::DYNAMIS:
        case REGION_TYPE::TAVNAZIAN_MARQ:
        case REGION_TYPE::PROMYVION:
        case REGION_TYPE::LUMORIA:
        case REGION_TYPE::LIMBUS:
            offset       = 2;
            rangedOffset = 5;
            break;
        // TOAU Regions
        case REGION_TYPE::WEST_AHT_URHGAN:
        case REGION_TYPE::MAMOOL_JA_SAVAGE:
        case REGION_TYPE::HALVUNG:
        case REGION_TYPE::ARRAPAGO:
        case REGION_TYPE::ALZADAAL:
            offset       = 10;
            rangedOffset = 12;
            break;

        // WOTG Regions
        case REGION_TYPE::RONFAURE_FRONT:
        case REGION_TYPE::NORVALLEN_FRONT:
        case REGION_TYPE::GUSTABERG_FRONT:
        case REGION_TYPE::DERFLAND_FRONT:
        case REGION_TYPE::SARUTA_FRONT:
        case REGION_TYPE::ARAGONEAU_FRONT:
        case REGION_TYPE::FAUREGANDI_FRONT:
        case REGION_TYPE::VALDEAUNIA_FRONT:
            offset       = 11;
            rangedOffset = 13;
            break;

        // Other
        case REGION_TYPE::ABYSSEA:
        case REGION_TYPE::THE_THRESHOLD:
        case REGION_TYPE::ABDHALJS: // TODO: Need data for ABDHALJS zones.
            offset       = 11;
            rangedOffset = 13;
            break;

        // SOA Regions
        case REGION_TYPE::ADOULIN_ISLANDS:
        case REGION_TYPE::EAST_ULBUKA:
            offset       = 11; // TODO: Need more data for Lvl 100+ mobs.
            rangedOffset = 13;
            break;

        // Default Fallback
        default:
            offset       = 2;
            rangedOffset = 5;
            break;
    }

    offset += PMob->getMobMod(MOBMOD_DAMAGE_OFFSET);

    if (slot == SLOT_RANGED)
    {
        offset = rangedOffset;
        offset += PMob->getMobMod(MOBMOD_RANGED_DAMAGE_OFFSET);
    }

    // Normal mobs in beginner zones have the offset lowered by 1.
    // Excluded NMs for now for things like Voidwatch Mobs.
    if (mobZoneId != 0 && PMob->m_Type != MOBTYPE_NOTORIOUS && (mobZoneId == ZONE_WEST_RONFAURE || mobZoneId == ZONE_EAST_RONFAURE || mobZoneId == ZONE_NORTH_GUSTABERG || mobZoneId == ZONE_SOUTH_GUSTABERG || mobZoneId == ZONE_WEST_SARUTABARUTA || mobZoneId == ZONE_EAST_SARUTABARUTA))
    {
        offset -= 1;
    }

    // Clamp to 0 for edge cases that might cause the offset go negative.
    if (offset < 0)
    {
        offset = 0;
    }

    // Add this mod to increase a mobs damage by a base amount
    if (PMob->getMobMod(MOBMOD_WEAPON_BONUS) != 0)
    {
        damageModifers = PMob->getMobMod(MOBMOD_WEAPON_BONUS);
    }

    // Add damage mods to the appropriate slot's base damage if the mob has them.
    if (slot == SLOT_MAIN)
    {
        damageModifers += PMob->getMod(Mod::MAIN_DMG_RATING);
    }
    else if (slot == SLOT_SUB)
    {
        damageModifers += PMob->getMod(Mod::SUB_DMG_RATING);
    }
    else if (slot == SLOT_RANGED)
    {
        damageModifers += PMob->getMod(Mod::RANGED_DMG_RATING);
    }

    damage += damageModifers;

    if (PMob->getMobMod(MOBMOD_BASE_DAMAGE_MULTIPLIER) != 0)
    {
        multiplier = PMob->getMobMod(MOBMOD_BASE_DAMAGE_MULTIPLIER) / 100.0f;
    }

    damage = (damage + offset) * multiplier;

    damage = std::clamp<int32>(damage, 1, 65535);

    return static_cast<uint16>(damage);
}

// Get base skill rankings for ACC/ATT/EVA/MEVA
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
    uint8 mlvl = std::min<uint8>(PMob->GetMLevel(), 99);

    // Assume trusts have G rank meva like players
    if (PMob->objtype == TYPE_TRUST)
    {
        return battleutils::GetMaxSkill(12, mlvl);
    }

    // Mobs have rank C magic evasion
    return battleutils::GetMaxSkill(7, mlvl);
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
            {
                sJobStat = std::max((std::floor(stat / (4.0f - 0.225f * (level - 30)))), 2.0f);
            }
            else if (level <= 40)
            {
                sJobStat = std::floor(stat / (3.25f - 0.073f * (level - 30)));
            }
            else if (level <= 46)
            {
                sJobStat = std::floor(stat / (2.55f - 0.001f * (level - 41)));
            }
            else
            {
                sJobStat = std::floor(stat / (2.7f - 0.001f * (level - 45)));
            }
            break;

        case 2: // B
            if (level <= 30)
            {
                sJobStat = std::max((std::floor(stat / (3.1f - 0.075f * (level - 32)))), 2.0f);
            }
            else if (level <= 40)
            {
                sJobStat = std::floor(stat / (3.1f - 0.075f * (level - 32)));
            }
            else if (level <= 45)
            {
                sJobStat = std::floor(stat / (2.5f - 0.025f * (level - 40)));
            }
            else
            {
                sJobStat = std::floor(stat / (2.35f - 0.04f * (level - 44)));
            }
            break;

        case 3: // C
            if (level <= 30)
            {
                sJobStat = std::max((std::floor(stat / (4.5f - 0.15f * (level - 26)))), 2.0f);
            }
            else if (level <= 40)
            {
                sJobStat = std::floor(stat / (3.28f - 0.001f * (level - 30)));
            }
            else if (level <= 45)
            {
                sJobStat = std::floor(stat / (2.6f - 0.025f * (level - 40)));
            }
            else
            {
                sJobStat = std::floor(stat / (2.1f - 0.2f * (level - 49)));
            }
            break;

        case 4: // D
            if (level <= 30)
            {
                sJobStat = std::max((std::floor(stat / (5.0f - 0.05f * (level - 21)))), 1.0f);
            }
            else if (level <= 40)
            {
                sJobStat = std::floor(stat / (3.2f - 0.001f * (level - 29)));
            }
            else if (level <= 45)
            {
                sJobStat = std::floor(stat / (3.5f - 0.08f * (level - 32)));
            }
            else
            {
                sJobStat = std::floor(stat / (3.25f - 0.045f * (level - 32)));
            }
            break;

        case 5: // E
            if (level <= 30)
            {
                sJobStat = std::max((std::floor(stat / (3.8f - 0.1f * (level - 32)))), 1.0f);
            }
            else if (level <= 40)
            {
                sJobStat = std::floor(stat / (3.8f - 0.15f * (level - 32)));
            }
            else if (level <= 45)
            {
                sJobStat = std::floor(stat / (2.7f - 0.075f * (level - 40)));
            }
            else
            {
                sJobStat = std::floor(stat / (2.7f - 0.05f * (level - 45)));
            }
            break;

        case 6: // F
            if (level <= 30)
            {
                sJobStat = std::max((std::floor(stat / (4.0f - 0.15f * (level - 35)))), 1.0f);
            }
            else if (level <= 40)
            {
                sJobStat = std::floor(stat / (4.0f - 0.15f * (level - 30)));
            }
            else if (level <= 46)
            {
                sJobStat = std::floor(stat / (3.0f - 0.1125f * (level - 40)));
            }
            else
            {
                sJobStat = std::floor(stat / (3.0f - 0.07f * (level - 40)));
            }
            break;

        case 7: // G
            if (level <= 30)
            {
                sJobStat = std::max((std::floor(stat / (4.0f - 0.15f * (level - 35)))), 1.0f);
            }
            else if (level <= 40)
            {
                sJobStat = std::floor(stat / (4.0f - 0.2f * (level - 31)));
            }
            else if (level <= 46)
            {
                sJobStat = std::floor(stat / (2.5f - 0.09f * (level - 40)));
            }
            else
            {
                sJobStat = std::floor(stat / 2);
            }
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
    if (zoneId != 0 && (zoneId == ZONE_WEST_RONFAURE ||
                        zoneId == ZONE_EAST_RONFAURE ||
                        zoneId == ZONE_LA_THEINE_PLATEAU ||
                        zoneId == ZONE_VALKURM_DUNES ||
                        zoneId == ZONE_JUGNER_FOREST ||
                        zoneId == ZONE_BATALLIA_DOWNS ||
                        zoneId == ZONE_NORTH_GUSTABERG ||
                        zoneId == ZONE_SOUTH_GUSTABERG ||
                        zoneId == ZONE_KONSCHTAT_HIGHLANDS ||
                        zoneId == ZONE_PASHHOW_MARSHLANDS ||
                        zoneId == ZONE_ROLANBERRY_FIELDS ||
                        zoneId == ZONE_BEAUCEDINE_GLACIER ||
                        zoneId == ZONE_XARCABARD ||
                        zoneId == ZONE_CAPE_TERIGGAN ||
                        zoneId == ZONE_EASTERN_ALTEPA_DESERT ||
                        zoneId == ZONE_WEST_SARUTABARUTA ||
                        zoneId == ZONE_EAST_SARUTABARUTA ||
                        zoneId == ZONE_TAHRONGI_CANYON ||
                        zoneId == ZONE_BUBURIMU_PENINSULA ||
                        zoneId == ZONE_MERIPHATAUD_MOUNTAINS ||
                        zoneId == ZONE_SAUROMUGUE_CHAMPAIGN ||
                        zoneId == ZONE_THE_SANCTUARY_OF_ZITAH ||
                        zoneId == ZONE_ROMAEVE ||
                        zoneId == ZONE_YUHTUNGA_JUNGLE ||
                        zoneId == ZONE_YHOATOR_JUNGLE ||
                        zoneId == ZONE_WESTERN_ALTEPA_DESERT ||
                        zoneId == ZONE_QUFIM_ISLAND ||
                        zoneId == ZONE_BEHEMOTHS_DOMINION ||
                        zoneId == ZONE_VALLEY_OF_SORROWS ||
                        zoneId == ZONE_HORLAIS_PEAK ||
                        zoneId == ZONE_GHELSBA_OUTPOST ||
                        zoneId == ZONE_FORT_GHELSBA ||
                        zoneId == ZONE_YUGHOTT_GROTTO ||
                        zoneId == ZONE_PALBOROUGH_MINES ||
                        zoneId == ZONE_WAUGHROON_SHRINE ||
                        zoneId == ZONE_GIDDEUS ||
                        zoneId == ZONE_BALGAS_DAIS ||
                        zoneId == ZONE_BEADEAUX ||
                        zoneId == ZONE_QULUN_DOME ||
                        zoneId == ZONE_DAVOI ||
                        zoneId == ZONE_MONASTIC_CAVERN ||
                        zoneId == ZONE_CASTLE_OZTROJA ||
                        zoneId == ZONE_ALTAR_ROOM ||
                        zoneId == ZONE_THE_BOYAHDA_TREE ||
                        zoneId == ZONE_DRAGONS_AERY ||
                        zoneId == ZONE_MIDDLE_DELKFUTTS_TOWER ||
                        zoneId == ZONE_UPPER_DELKFUTTS_TOWER ||
                        zoneId == ZONE_TEMPLE_OF_UGGALEPIH ||
                        zoneId == ZONE_DEN_OF_RANCOR ||
                        zoneId == ZONE_CASTLE_ZVAHL_BAILEYS ||
                        zoneId == ZONE_CASTLE_ZVAHL_KEEP ||
                        zoneId == ZONE_SACRIFICIAL_CHAMBER ||
                        zoneId == ZONE_THRONE_ROOM ||
                        zoneId == ZONE_RANGUEMONT_PASS ||
                        zoneId == ZONE_BOSTAUNIEUX_OUBLIETTE ||
                        zoneId == ZONE_CHAMBER_OF_ORACLES ||
                        zoneId == ZONE_TORAIMARAI_CANAL ||
                        zoneId == ZONE_FULL_MOON_FOUNTAIN ||
                        zoneId == ZONE_ZERUHN_MINES ||
                        zoneId == ZONE_KORROLOKA_TUNNEL ||
                        zoneId == ZONE_KUFTAL_TUNNEL ||
                        zoneId == ZONE_SEA_SERPENT_GROTTO ||
                        zoneId == ZONE_VELUGANNON_PALACE ||
                        zoneId == ZONE_THE_SHRINE_OF_RUAVITAU ||
                        zoneId == ZONE_STELLAR_FULCRUM ||
                        zoneId == ZONE_LALOFF_AMPHITHEATER ||
                        zoneId == ZONE_THE_CELESTIAL_NEXUS ||
                        zoneId == ZONE_LOWER_DELKFUTTS_TOWER ||
                        zoneId == ZONE_KING_RANPERRES_TOMB ||
                        zoneId == ZONE_DANGRUF_WADI ||
                        zoneId == ZONE_INNER_HORUTOTO_RUINS ||
                        zoneId == ZONE_ORDELLES_CAVES ||
                        zoneId == ZONE_OUTER_HORUTOTO_RUINS ||
                        zoneId == ZONE_THE_ELDIEME_NECROPOLIS ||
                        zoneId == ZONE_GUSGEN_MINES ||
                        zoneId == ZONE_CRAWLERS_NEST ||
                        zoneId == ZONE_MAZE_OF_SHAKHRAMI ||
                        zoneId == ZONE_GARLAIGE_CITADEL ||
                        zoneId == ZONE_CLOISTER_OF_GALES ||
                        zoneId == ZONE_CLOISTER_OF_STORMS ||
                        zoneId == ZONE_CLOISTER_OF_FROST ||
                        zoneId == ZONE_FEIYIN ||
                        zoneId == ZONE_IFRITS_CAULDRON ||
                        zoneId == ZONE_QUBIA_ARENA ||
                        zoneId == ZONE_CLOISTER_OF_FLAMES ||
                        zoneId == ZONE_QUICKSAND_CAVES ||
                        zoneId == ZONE_CLOISTER_OF_TREMORS ||
                        zoneId == ZONE_CLOISTER_OF_TIDES ||
                        zoneId == ZONE_GUSTAV_TUNNEL ||
                        zoneId == ZONE_LABYRINTH_OF_ONZOZO ||
                        zoneId == ZONE_SHIP_BOUND_FOR_SELBINA ||
                        zoneId == ZONE_SHIP_BOUND_FOR_MHAURA ||
                        zoneId == ZONE_SHIP_BOUND_FOR_SELBINA_PIRATES ||
                        zoneId == ZONE_SHIP_BOUND_FOR_MHAURA_PIRATES))
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
            if ((PMob->m_Family == 189) || (PMob->m_Family == 190))
            {
                mobHP = (baseMobHP + sjHP) * 1.05;
            }
            // Quadavs 5% less hp
            else if (PMob->m_Family == 202)
            {
                mobHP = (baseMobHP + sjHP) * 0.95;
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

    PMob->addModifier(Mod::DEF, GetBaseDefEva(PMob, PMob->defRank));                         // Base Defense for all mobs
    PMob->addModifier(Mod::EVA, GetBaseDefEva(PMob, JobSkillRankToBaseEvaRank(mJob, sJob))); // Evasion is based off the highest job rank. // TODO: add family bonuses (colibri has static evasion+ porrogos have % boost.)
    PMob->addModifier(Mod::ATT, GetBaseSkill(PMob, PMob->attRank));                          // Base Attack for all mobs is Rank A+ but pull from DB for specific cases
    PMob->addModifier(Mod::ACC, GetBaseSkill(PMob, PMob->accRank));                          // Base Accuracy for all mobs is Rank A+ but pull from DB for specific cases
    PMob->addModifier(Mod::RATT, GetBaseSkill(PMob, PMob->attRank));                         // Base Ranged Attack for all mobs is Rank A+ but pull from DB for specific cases
    PMob->addModifier(Mod::RACC, GetBaseSkill(PMob, PMob->accRank));                         // Base Ranged Accuracy for all mobs is Rank A+ but pull from DB for specific cases

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

    PMob->m_Behavior |= PMob->getMobMod(MOBMOD_BEHAVIOR);

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

    if (zoneType & ZONE_TYPE::INSTANCED)
    {
        SetupDungeonInstanceMob(PMob);
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
            if (PMob->m_Family == 126) // Gigas
            {
                PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 658); // Catapult only used while at range
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

uint8 JobSkillRankToBaseEvaRank(JOBTYPE mjob, JOBTYPE sjob)
{
    // Pick the best rank between the two jobs
    // Lower is better
    uint8 mainEvasionSkillRank = battleutils::GetSkillRank(SKILL_EVASION, mjob);
    uint8 subEvasionSkillRank  = battleutils::GetSkillRank(SKILL_EVASION, sjob);

    switch (std::min(mainEvasionSkillRank, subEvasionSkillRank))
    {
        case 1:
        case 2:
            return 1; // A, A+; A- doesnt exist anymore
        case 3:
        case 4:
        case 5:
            return 2; // B+, B, B-
        case 6:
        case 7:
        case 8:
            return 3; // C+, C, C-
        case 9:
            return 4; // D
        case 10:
            return 5; // E
        default:
            ShowError("JobSkillRankToBaseEvaRank: rank not implemented. Job SKILL_EVASION rank is likely not valid or no longer exists (A- rank in particular.)");
    }

    return 3; // Give them C rank as a fallback.
};

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

void SetupDungeonInstanceMob(CMobEntity* PMob)
{
    PMob->setMobMod(MOBMOD_GIL_MAX, 0);
    PMob->setMobMod(MOBMOD_MUG_GIL, 0);
    PMob->loc.p = PMob->m_SpawnPoint;
    // never despawn
    PMob->SetDespawnTime(0s);
    PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);
    // Salvage and Nyzul
    if (PMob->getZone() >= ZONE_ZHAYOLM_REMNANTS && PMob->getZone() <= ZONE_NYZUL_ISLE)
    {
        // Salvage and Nyzul mobs can not be charmed
        PMob->setMobMod(MOBMOD_CHARMABLE, 0);
        if (PMob->getZone() != ZONE_NYZUL_ISLE)
        {
            PMob->setMobMod(MOBMOD_CHECK_AS_NM, 1);
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
    PMob->defaultMobMod(MOBMOD_SKILL_LIST, PMob->m_MobSkillList);
    PMob->defaultMobMod(MOBMOD_LINK_RADIUS, 10);
    PMob->defaultMobMod(MOBMOD_TP_USE_CHANCE,
                        92); // 92 = 0.92% chance per 400ms tick (50% chance by 30 seconds) while mob HPP>25 and mob TP >=1000 but <3000
    PMob->defaultMobMod(MOBMOD_SIGHT_RANGE, (int16)CMobEntity::sight_range);
    PMob->defaultMobMod(MOBMOD_SOUND_RANGE, (int16)CMobEntity::sound_range);
    PMob->defaultMobMod(MOBMOD_MAGIC_RANGE, (int16)CMobEntity::magic_range);

    battleutils::addEcosystemKillerEffects(PMob);

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
    auto rset = db::preparedStmt("SELECT familyid, modid, value, is_mob_mod "
                                 "FROM mob_family_mods");
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        ModsList_t* familyMods = GetMobFamilyMods(rset->get<uint16>("familyid"), true);

        auto* mod = new CModifier(rset->get<Mod>("modid"));
        mod->setModAmount(rset->get<int16>("value"));

        if (rset->get<bool>("is_mob_mod"))
        {
            familyMods->mobMods.emplace_back(mod);
        }
        else
        {
            familyMods->mods.emplace_back(mod);
        }
    }

    // load pool mods
    rset = db::preparedStmt("SELECT poolid, modid, value, is_mob_mod "
                            "FROM mob_pool_mods");
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto  pool     = rset->get<uint16>("poolid");
        ModsList_t* poolMods = GetMobPoolMods(pool, true);

        const auto id = rset->get<Mod>("modid");

        auto* mod = new CModifier(id);
        mod->setModAmount(rset->get<int16>("value"));

        if (rset->get<bool>("is_mob_mod"))
        {
            poolMods->mobMods.emplace_back(mod);
        }
        else
        {
            poolMods->mods.emplace_back(mod);
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

auto InstantiateAlly(uint32 groupid, uint16 zoneID, CInstance* instance) -> CMobEntity*
{
    CMobEntity* PMob = nullptr;

    const auto rset = db::preparedStmt("SELECT zoneid, mob_groups.name, packet_name, respawntime, "
                                       "spawntype, dropid, mob_groups.HP, mob_groups.MP, "
                                       "minLevel, maxLevel, modelid, mJob, "
                                       "sJob, cmbSkill, cmbDmgMult, cmbDelay, "
                                       "behavior, links, mobType, immunity, "
                                       "ecosystemID, speed, STR, "
                                       "DEX, VIT, AGI, `INT`, "
                                       "MND, CHR, EVA, DEF, "
                                       "ATT, ACC, slash_sdt, pierce_sdt, "
                                       "h2h_sdt, impact_sdt, magical_sdt, "
                                       "fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, "
                                       "fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, "
                                       "paralyze_res_rank, bind_res_rank, silence_res_rank, slow_res_rank, poison_res_rank, light_sleep_res_rank, dark_sleep_res_rank, blind_res_rank, "
                                       "Element, "
                                       "mob_pools.familyid, name_prefix, entityFlags, animationsub, "
                                       "(mob_family_system.HP / 100) AS hp_scale, (mob_family_system.MP / 100) AS mp_scale, hasSpellScript, spellList, "
                                       "mob_groups.poolid, allegiance, namevis, aggro, "
                                       "mob_pools.skill_list_id, mob_pools.true_detection, mob_family_system.detects, "
                                       "mob_pools.modelSize, mob_pools.modelHitboxSize "
                                       "FROM mob_groups INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid "
                                       "INNER JOIN mob_resistances ON mob_pools.resist_id = mob_resistances.resist_id "
                                       "INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyID "
                                       "WHERE mob_groups.groupid = ? AND mob_groups.zoneid = ?",
                                       groupid,
                                       zoneID);
    FOR_DB_SINGLE_RESULT(rset)
    {
        PMob            = new CMobEntity();
        PMob->PInstance = instance;

        PMob->name.insert(0, rset->get<std::string>("name"));
        PMob->packetName.insert(0, rset->get<std::string>("packet_name"));

        PMob->m_RespawnTime = std::chrono::seconds(rset->get<uint32>("respawntime"));
        PMob->m_SpawnType   = rset->get<SPAWNTYPE>("spawntype");
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
        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setSkillType(rset->get<uint8>("cmbSkill"));
        PMob->m_dmgMult = rset->get<uint16>("cmbDmgMult");
        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setDelay((rset->get<uint16>("cmbDelay") * 1000) / 60);
        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((rset->get<uint16>("cmbDelay") * 1000) / 60);

        PMob->m_Behavior  = rset->get<uint16>("behavior");
        PMob->m_Link      = rset->get<uint8>("links");
        PMob->m_Type      = rset->get<uint8>("mobType");
        PMob->m_Immunity  = rset->get<IMMUNITY>("immunity");
        PMob->m_EcoSystem = rset->get<ECOSYSTEM>("ecosystemID");

        PMob->baseSpeed      = rset->get<uint8>("speed"); // Overwrites baseentity.cpp's defined baseSpeed
        PMob->animationSpeed = rset->get<uint8>("speed"); // Overwrites baseentity.cpp's defined animationSpeed
        PMob->UpdateSpeed();

        PMob->strRank = rset->get<uint8>("STR");
        PMob->dexRank = rset->get<uint8>("DEX");
        PMob->vitRank = rset->get<uint8>("VIT");
        PMob->agiRank = rset->get<uint8>("AGI");
        PMob->intRank = rset->get<uint8>("INT");
        PMob->mndRank = rset->get<uint8>("MND");
        PMob->chrRank = rset->get<uint8>("CHR");
        PMob->evaRank = rset->get<uint8>("EVA");
        PMob->defRank = rset->get<uint8>("DEF");
        PMob->attRank = rset->get<uint8>("ATT");
        PMob->accRank = rset->get<uint8>("ACC");

        PMob->setModifier(Mod::SLASH_SDT, rset->get<int16>("slash_sdt"));
        PMob->setModifier(Mod::PIERCE_SDT, rset->get<int16>("pierce_sdt"));
        PMob->setModifier(Mod::HTH_SDT, rset->get<int16>("h2h_sdt"));
        PMob->setModifier(Mod::IMPACT_SDT, rset->get<int16>("impact_sdt"));

        PMob->setModifier(Mod::UDMGMAGIC, rset->get<int16>("magical_sdt")); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

        PMob->setModifier(Mod::FIRE_SDT, rset->get<int16>("fire_sdt"));         // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::ICE_SDT, rset->get<int16>("ice_sdt"));           // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::WIND_SDT, rset->get<int16>("wind_sdt"));         // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::EARTH_SDT, rset->get<int16>("earth_sdt"));       // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::THUNDER_SDT, rset->get<int16>("lightning_sdt")); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::WATER_SDT, rset->get<int16>("water_sdt"));       // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::LIGHT_SDT, rset->get<int16>("light_sdt"));       // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::DARK_SDT, rset->get<int16>("dark_sdt"));         // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

        PMob->setModifier(Mod::FIRE_RES_RANK, rset->get<int8>("fire_res_rank"));
        PMob->setModifier(Mod::ICE_RES_RANK, rset->get<int8>("ice_res_rank"));
        PMob->setModifier(Mod::WIND_RES_RANK, rset->get<int8>("wind_res_rank"));
        PMob->setModifier(Mod::EARTH_RES_RANK, rset->get<int8>("earth_res_rank"));
        PMob->setModifier(Mod::THUNDER_RES_RANK, rset->get<int8>("lightning_res_rank"));
        PMob->setModifier(Mod::WATER_RES_RANK, rset->get<int8>("water_res_rank"));
        PMob->setModifier(Mod::LIGHT_RES_RANK, rset->get<int8>("light_res_rank"));
        PMob->setModifier(Mod::DARK_RES_RANK, rset->get<int8>("dark_res_rank"));

        PMob->setModifier(Mod::PARALYZE_RES_RANK, rset->get<int8>("paralyze_res_rank"));
        PMob->setModifier(Mod::BIND_RES_RANK, rset->get<int8>("bind_res_rank"));
        PMob->setModifier(Mod::SILENCE_RES_RANK, rset->get<int8>("silence_res_rank"));
        PMob->setModifier(Mod::SLOW_RES_RANK, rset->get<int8>("slow_res_rank"));
        PMob->setModifier(Mod::POISON_RES_RANK, rset->get<int8>("poison_res_rank"));
        PMob->setModifier(Mod::LIGHT_SLEEP_RES_RANK, rset->get<int8>("light_sleep_res_rank"));
        PMob->setModifier(Mod::DARK_SLEEP_RES_RANK, rset->get<int8>("dark_sleep_res_rank"));
        PMob->setModifier(Mod::BLIND_RES_RANK, rset->get<int8>("blind_res_rank"));

        PMob->m_Element     = rset->get<uint8>("Element");
        PMob->m_Family      = rset->get<uint16>("familyid");
        PMob->m_name_prefix = rset->get<uint8>("name_prefix");
        PMob->m_flags       = rset->get<uint32>("entityFlags");

        // Special sub animation for Mob (yovra, jailer of love, phuabo)
        // yovra 1: On top/in the sky, 2: , 3: On top/in the sky
        // phuabo 1: Underwater, 2: Out of the water, 3: Goes back underwater
        PMob->animationsub = rset->get<uint32>("animationsub");

        // Setup HP / MP Stat Percentage Boost
        PMob->HPscale = rset->get<float>("hp_scale");
        PMob->MPscale = rset->get<float>("mp_scale");

        PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(rset->get<uint16>("spellList"));

        PMob->m_Pool = rset->get<uint32>("poolid");

        PMob->allegiance      = rset->get<ALLEGIANCE_TYPE>("allegiance");
        PMob->namevis         = rset->get<uint8>("namevis");
        PMob->modelHitboxSize = std::max<float>(0.0f, rset->getOrDefault<float>("modelHitboxSize", 0) / 10.f);
        PMob->modelSize       = rset->getOrDefault<uint8>("modelSize", 0);
        PMob->m_Aggro         = rset->get<bool>("aggro");
        PMob->m_MobSkillList  = rset->get<uint16>("skill_list_id");
        PMob->m_TrueDetection = rset->get<bool>("true_detection");
        PMob->setMobMod(MOBMOD_DETECTION, rset->get<int16>("detects"));

        if (CZone* PZone = zoneutils::GetZone(zoneID))
        {
            PZone->GetZoneEntities()->AssignDynamicTargIDandLongID(PMob);
            PZone->GetZoneEntities()->InsertMOB(PMob);
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
        if (CZone* PZone = zoneutils::GetZone(zoneID))
        {
            PZone->FindPartyForMob(PMob);
        }
        luautils::ApplyMixins(PMob);
        luautils::ApplyZoneMixins(PMob);

        PMob->saveModifiers();
        PMob->saveMobModifiers();
    }

    return PMob;
}

auto InstantiateDynamicMob(uint32 groupid, uint16 groupZoneId, uint16 targetZoneId) -> CMobEntity*
{
    auto* PMob = new CMobEntity();

    const auto rset = db::preparedStmt("SELECT zoneid, mob_groups.name, packet_name, respawntime, "
                                       "spawntype, dropid, mob_groups.HP, mob_groups.MP, "
                                       "minLevel, maxLevel, modelid, mJob, "
                                       "sJob, cmbSkill, cmbDmgMult, cmbDelay, "
                                       "behavior, links, mobType, immunity, "
                                       "ecosystemID, speed, STR, "
                                       "DEX, VIT, AGI, `INT`, "
                                       "MND, CHR, EVA, DEF, "
                                       "ATT, ACC, slash_sdt, pierce_sdt, "
                                       "h2h_sdt, impact_sdt, magical_sdt, fire_sdt, "
                                       "ice_sdt, wind_sdt, earth_sdt, lightning_sdt, "
                                       "water_sdt, light_sdt, dark_sdt, fire_res_rank, "
                                       "ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, "
                                       "water_res_rank, light_res_rank, dark_res_rank, Element, "
                                       "mob_pools.familyid, name_prefix, entityFlags, animationsub, "
                                       "(mob_family_system.HP / 100) AS hp_scale, (mob_family_system.MP / 100) AS mp_scale, hasSpellScript, spellList, "
                                       "mob_groups.poolid, allegiance, namevis, aggro, "
                                       "mob_pools.modelSize, mob_pools.modelHitboxSize, "
                                       "mob_pools.skill_list_id, mob_pools.true_detection, mob_family_system.detects "
                                       "FROM mob_groups INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid "
                                       "INNER JOIN mob_resistances ON mob_pools.resist_id = mob_resistances.resist_id "
                                       "INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyID "
                                       "WHERE mob_groups.groupid = ? AND mob_groups.zoneid = ?",
                                       groupid,
                                       groupZoneId);
    FOR_DB_SINGLE_RESULT(rset)
    {
        PMob->name.insert(0, rset->get<std::string>("name"));
        PMob->packetName.insert(0, rset->get<std::string>("packet_name"));

        PMob->m_RespawnTime = std::chrono::seconds(rset->get<uint32>("respawntime"));
        PMob->m_SpawnType   = rset->get<SPAWNTYPE>("spawntype");
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
        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setSkillType(rset->get<uint8>("cmbSkill"));
        PMob->m_dmgMult = rset->get<uint16>("cmbDmgMult");
        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setDelay((rset->get<uint16>("cmbDelay") * 1000) / 60);
        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((rset->get<uint16>("cmbDelay") * 1000) / 60);

        PMob->m_Behavior  = rset->get<uint16>("behavior");
        PMob->m_Link      = rset->get<uint8>("links");
        PMob->m_Type      = rset->get<uint8>("mobType");
        PMob->m_Immunity  = rset->get<IMMUNITY>("immunity");
        PMob->m_EcoSystem = rset->get<ECOSYSTEM>("ecosystemID");

        PMob->baseSpeed      = rset->get<uint8>("speed"); // Overwrites baseentity.cpp's defined baseSpeed
        PMob->animationSpeed = rset->get<uint8>("speed"); // Overwrites baseentity.cpp's defined animationSpeed
        PMob->UpdateSpeed();

        PMob->strRank = rset->get<uint8>("STR");
        PMob->dexRank = rset->get<uint8>("DEX");
        PMob->vitRank = rset->get<uint8>("VIT");
        PMob->agiRank = rset->get<uint8>("AGI");
        PMob->intRank = rset->get<uint8>("INT");
        PMob->mndRank = rset->get<uint8>("MND");
        PMob->chrRank = rset->get<uint8>("CHR");
        PMob->evaRank = rset->get<uint8>("EVA");
        PMob->defRank = rset->get<uint8>("DEF");
        PMob->attRank = rset->get<uint8>("ATT");
        PMob->accRank = rset->get<uint8>("ACC");

        PMob->setModifier(Mod::SLASH_SDT, rset->get<int16>("slash_sdt"));
        PMob->setModifier(Mod::PIERCE_SDT, rset->get<int16>("pierce_sdt"));
        PMob->setModifier(Mod::HTH_SDT, rset->get<int16>("h2h_sdt"));
        PMob->setModifier(Mod::IMPACT_SDT, rset->get<int16>("impact_sdt"));

        PMob->setModifier(Mod::UDMGMAGIC, rset->get<int16>("magical_sdt")); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

        PMob->setModifier(Mod::FIRE_SDT, rset->get<int16>("fire_sdt"));         // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::ICE_SDT, rset->get<int16>("ice_sdt"));           // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::WIND_SDT, rset->get<int16>("wind_sdt"));         // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::EARTH_SDT, rset->get<int16>("earth_sdt"));       // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::THUNDER_SDT, rset->get<int16>("lightning_sdt")); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::WATER_SDT, rset->get<int16>("water_sdt"));       // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::LIGHT_SDT, rset->get<int16>("light_sdt"));       // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
        PMob->setModifier(Mod::DARK_SDT, rset->get<int16>("dark_sdt"));         // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

        PMob->setModifier(Mod::FIRE_RES_RANK, rset->get<int8>("fire_res_rank"));
        PMob->setModifier(Mod::ICE_RES_RANK, rset->get<int8>("ice_res_rank"));
        PMob->setModifier(Mod::WIND_RES_RANK, rset->get<int8>("wind_res_rank"));
        PMob->setModifier(Mod::EARTH_RES_RANK, rset->get<int8>("earth_res_rank"));
        PMob->setModifier(Mod::THUNDER_RES_RANK, rset->get<int8>("lightning_res_rank"));
        PMob->setModifier(Mod::WATER_RES_RANK, rset->get<int8>("water_res_rank"));
        PMob->setModifier(Mod::LIGHT_RES_RANK, rset->get<int8>("light_res_rank"));
        PMob->setModifier(Mod::DARK_RES_RANK, rset->get<int8>("dark_res_rank"));

        PMob->m_Element     = rset->get<uint8>("Element");
        PMob->m_Family      = rset->get<uint16>("familyid");
        PMob->m_name_prefix = rset->get<uint8>("name_prefix");
        PMob->m_flags       = rset->get<uint32>("entityFlags");

        PMob->animationsub = rset->get<uint32>("animationsub");

        // Setup HP / MP Stat Percentage Boost
        PMob->HPscale = rset->get<float>("hp_scale");
        PMob->MPscale = rset->get<float>("mp_scale");

        PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(rset->get<uint16>("spellList"));

        PMob->m_Pool = rset->get<uint32>("poolid");

        PMob->allegiance      = rset->get<ALLEGIANCE_TYPE>("allegiance");
        PMob->namevis         = rset->get<uint8>("namevis");
        PMob->modelHitboxSize = std::max<float>(0.0f, rset->getOrDefault<float>("modelHitboxSize", 0) / 10.f);
        PMob->modelSize       = rset->getOrDefault<uint8>("modelSize", 0);
        PMob->m_Aggro         = rset->get<bool>("aggro");
        PMob->m_MobSkillList  = rset->get<uint16>("skill_list_id");
        PMob->m_TrueDetection = rset->get<bool>("true_detection");
        PMob->setMobMod(MOBMOD_DETECTION, rset->get<int16>("detects"));

        mobutils::InitializeMob(PMob);
        mobutils::AddSqlModifiers(PMob);
    }

    return PMob;
}

void WeaknessTrigger(CBaseEntity* PTarget, WeaknessType level)
{
    ActionAnimation animationID = ActionAnimation::None;
    switch (level)
    {
        case WeaknessType::RED:
            animationID = ActionAnimation::RedTrigger;
            break;
        case WeaknessType::YELLOW:
            animationID = ActionAnimation::YellowTrigger;
            break;
        case WeaknessType::BLUE:
            animationID = ActionAnimation::BlueTrigger;
            break;
        case WeaknessType::WHITE:
            animationID = ActionAnimation::WhiteTrigger;
            break;
    }
    // TODO: Weakness Triggers are actually MAGIC_SCHEDULOR + Terror flag...
    action_t action{
        .actorId    = PTarget->id,
        .actiontype = ActionCategory::MobSkillFinish,
        .targets    = {
            {
                   .actorId = PTarget->id,
                   .results = {
                    {
                           .animation = animationID,
                           .param     = 2582,
                    },
                },
            },
        },
    };

    PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
}

}; // namespace mobutils
