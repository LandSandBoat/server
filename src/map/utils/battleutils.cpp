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

#include "../../common/timer.h"
#include "../../common/utils.h"

#include <math.h>
#include <string.h>
#include <algorithm>
#include <unordered_map>
#include <array>

#include "../packets/char.h"
#include "../packets/char_health.h"
#include "../packets/char_update.h"
#include "../packets/entity_update.h"
#include "../packets/message_basic.h"
#include "../packets/inventory_finish.h"

#include "../lua/luautils.h"

#include "../ability.h"
#include "../modifier.h"
#include "../status_effect_container.h"
#include "charutils.h"
#include "battleutils.h"
#include "attackutils.h"
#include "../attack.h"
#include "../map.h"
#include "../party.h"
#include "../alliance.h"
#include "../mob_modifier.h"
#include "../recast_container.h"
#include "../spell.h"
#include "../trait.h"
#include "../weapon_skill.h"
#include "../mobskill.h"
#include "../entities/battleentity.h"
#include "../entities/mobentity.h"
#include "../entities/petentity.h"
#include "../entities/trustentity.h"
#include "../enmity_container.h"
#include "../items.h"
#include "../item_container.h"
#include "../items/item_weapon.h"
#include "../packets/pet_sync.h"
#include "../packets/char_sync.h"
#include "../packets/position.h"
#include "../packets/lock_on.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/pet_controller.h"
#include "../ai/controllers/player_controller.h"
#include "../ai/controllers/player_charm_controller.h"
#include "../ai/states/magic_state.h"
#include "../utils/petutils.h"
#include "zoneutils.h"


/************************************************************************
*   lists used in battleutils                                           *
************************************************************************/

std::array<std::array<uint16, 14>, 100> g_SkillTable;
std::array<std::array<uint8, MAX_JOBTYPE>, MAX_SKILLTYPE> g_SkillRanks;
std::array<std::array<uint16, MAX_SKILLCHAIN_COUNT + 1>, MAX_SKILLCHAIN_LEVEL + 1> g_SkillChainDamageModifiers;

std::array<CWeaponSkill*, MAX_WEAPONSKILL_ID> g_PWeaponSkillList;           // Holds all Weapon skills
std::array<CMobSkill*, MAX_MOBSKILL_ID> g_PMobSkillList;                   // List of mob skills

std::array<std::list<CWeaponSkill*>, MAX_SKILLTYPE> g_PWeaponSkillsList;
std::unordered_map<uint16, std::vector<uint16>>  g_PMobSkillLists;  // List of mob skills defined from mob_skill_lists.sql

/************************************************************************
*  battleutils                                                          *
************************************************************************/

namespace battleutils
{

    /************************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    void LoadSkillTable()
    {
        const char* fmtQuery = "SELECT r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13 \
                            FROM skill_caps \
                            ORDER BY level \
                            LIMIT 100";

        int32 ret = Sql_Query(SqlHandle, fmtQuery);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            for (uint32 x = 0; x < 100 && Sql_NextRow(SqlHandle) == SQL_SUCCESS; ++x)
            {
                for (uint32 y = 0; y < 14; ++y)
                {
                    g_SkillTable[x][y] = (uint16)Sql_GetIntData(SqlHandle, y);
                }
            }
        }

        fmtQuery = "SELECT skillid,war,mnk,whm,blm,rdm,thf,pld,drk,bst,brd,rng,sam,nin,drg,smn,blu,cor,pup,dnc,sch,geo,run \
                FROM skill_ranks \
                LIMIT 64";

        ret = Sql_Query(SqlHandle, fmtQuery);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            for (uint32 x = 0; x < MAX_SKILLTYPE && Sql_NextRow(SqlHandle) == SQL_SUCCESS; ++x)
            {
                auto SkillID = std::clamp<uint8>(Sql_GetIntData(SqlHandle, 0), 0, MAX_SKILLTYPE - 1);

                for (uint32 y = 1; y < MAX_JOBTYPE; ++y)
                {
                    g_SkillRanks[SkillID][y] = std::clamp<uint8>(Sql_GetIntData(SqlHandle, y), 0, 11);
                }
            }
        }
    }

    /************************************************************************
    *  Load Weapon Skills from database                                     *
    ************************************************************************/

    void LoadWeaponSkillsList()
    {
        const char* fmtQuery = "SELECT weaponskillid, name, jobs, type, skilllevel, element, animation, "
                            "animationTime, `range`, aoe, primary_sc, secondary_sc, tertiary_sc, main_only, unlock_id "
                            "FROM weapon_skills "
                            "WHERE weaponskillid < %u "
                            "ORDER BY type, skilllevel ASC";

        int32 ret = Sql_Query(SqlHandle, fmtQuery, MAX_WEAPONSKILL_ID);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                CWeaponSkill* PWeaponSkill = new CWeaponSkill(Sql_GetIntData(SqlHandle, 0));

                PWeaponSkill->setName(Sql_GetData(SqlHandle, 1));
                PWeaponSkill->setJob(Sql_GetData(SqlHandle, 2));
                PWeaponSkill->setType(Sql_GetIntData(SqlHandle, 3));
                PWeaponSkill->setSkillLevel(Sql_GetIntData(SqlHandle, 4));
                PWeaponSkill->setElement(Sql_GetIntData(SqlHandle, 5));
                PWeaponSkill->setAnimationId(Sql_GetIntData(SqlHandle, 6));
                PWeaponSkill->setAnimationTime(std::chrono::milliseconds(Sql_GetUIntData(SqlHandle, 7)));
                PWeaponSkill->setRange(Sql_GetIntData(SqlHandle, 8));
                PWeaponSkill->setAoe(Sql_GetIntData(SqlHandle, 9));
                PWeaponSkill->setPrimarySkillchain(Sql_GetIntData(SqlHandle, 10));
                PWeaponSkill->setSecondarySkillchain(Sql_GetIntData(SqlHandle, 11));
                PWeaponSkill->setTertiarySkillchain(Sql_GetIntData(SqlHandle, 12));
                PWeaponSkill->setMainOnly(Sql_GetIntData(SqlHandle, 13));
                PWeaponSkill->setUnlockId(Sql_GetIntData(SqlHandle, 14));

                g_PWeaponSkillList[PWeaponSkill->getID()] = PWeaponSkill;
                g_PWeaponSkillsList[PWeaponSkill->getType()].push_back(PWeaponSkill);
            }
        }
    }


    /************************************************************************
    *                                                                       *
    *  Load Mob Skills from database                                        *
    *                                                                       *
    ************************************************************************/

    void LoadMobSkillsList()
    {

        // Load all mob skills
        const char* specialQuery = "SELECT mob_skill_id, mob_anim_id, mob_skill_name, \
        mob_skill_aoe, mob_skill_distance, mob_anim_time, mob_prepare_time, \
        mob_valid_targets, mob_skill_flag, mob_skill_param, knockback, primary_sc, secondary_sc, tertiary_sc \
        FROM mob_skills;";

        int32 ret = Sql_Query(SqlHandle, specialQuery);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                CMobSkill* PMobSkill = new CMobSkill(Sql_GetIntData(SqlHandle, 0));
                PMobSkill->setAnimationID(Sql_GetIntData(SqlHandle, 1));
                PMobSkill->setName(Sql_GetData(SqlHandle, 2));
                PMobSkill->setAoe(Sql_GetIntData(SqlHandle, 3));
                PMobSkill->setDistance(Sql_GetFloatData(SqlHandle, 4));
                PMobSkill->setAnimationTime(Sql_GetIntData(SqlHandle, 5));
                PMobSkill->setActivationTime(Sql_GetIntData(SqlHandle, 6));
                PMobSkill->setValidTargets(Sql_GetIntData(SqlHandle, 7));
                PMobSkill->setFlag(Sql_GetIntData(SqlHandle, 8));
                PMobSkill->setParam(Sql_GetIntData(SqlHandle, 9));
                PMobSkill->setKnockback(Sql_GetUIntData(SqlHandle, 10));
                PMobSkill->setPrimarySkillchain(Sql_GetUIntData(SqlHandle, 11));
                PMobSkill->setSecondarySkillchain(Sql_GetUIntData(SqlHandle, 12));
                PMobSkill->setTertiarySkillchain(Sql_GetUIntData(SqlHandle, 13));
                PMobSkill->setMsg(185); //standard damage message. Scripters will change this.
                g_PMobSkillList[PMobSkill->getID()] = PMobSkill;
            }
        }

        const char* fmtQuery = "SELECT skill_list_id, mob_skill_id \
        FROM mob_skill_lists;";

        ret = Sql_Query(SqlHandle, fmtQuery);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                int16 skillListId = Sql_GetIntData(SqlHandle, 0);

                uint16 skillId = Sql_GetIntData(SqlHandle, 1);

                g_PMobSkillLists[skillListId].push_back(skillId);
            }
        }
    }

    void LoadSkillChainDamageModifiers()
    {
        const char* fmtQuery = "SELECT chain_level, chain_count, initial_modifier, magic_burst_modifier \
                           FROM skillchain_damage_modifiers \
                           ORDER BY chain_level, chain_count";

        int32 ret = Sql_Query(SqlHandle, fmtQuery);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            for (uint32 x = 0; Sql_NextRow(SqlHandle) == SQL_SUCCESS; ++x)
            {
                uint16 level = (uint16)Sql_GetIntData(SqlHandle, 0);
                uint16 count = (uint16)Sql_GetIntData(SqlHandle, 1);
                uint16 value = (uint16)Sql_GetIntData(SqlHandle, 2);
                g_SkillChainDamageModifiers[level][count] = value;
            }
        }

        return;
    }

    /************************************************************************
    *  Clear Weapon Skills List                                             *
    ************************************************************************/

    void FreeWeaponSkillsList()
    {
        for (int32 SkillId = 0; SkillId < MAX_WEAPONSKILL_ID; ++SkillId)
        {
            delete g_PWeaponSkillList[SkillId];
            g_PWeaponSkillList[SkillId] = nullptr;

        }
    }

    /************************************************************************
    *  Clear Mob Skills List                                                *
    ************************************************************************/
    void FreeMobSkillList()
    {
        for (auto& mobskill : g_PMobSkillList)
        {
            delete mobskill;
            mobskill = nullptr;
        }
    }

    /************************************************************************
    *   Get Skill Rank By SkillId and JobId                                 *
    ************************************************************************/

    uint8 GetSkillRank(SKILLTYPE SkillID, JOBTYPE JobID)
    {
        return g_SkillRanks[SkillID][JobID];
    }

    /************************************************************************
    *   Return Max Skill by SkillType, JobType, and level                   *
    ************************************************************************/

    uint16 GetMaxSkill(SKILLTYPE SkillID, JOBTYPE JobID, uint8 level)
    {
        return g_SkillTable[level][g_SkillRanks[SkillID][JobID]];
    }

    uint16 GetMaxSkill(uint8 rank, uint8 level)
    {
        return g_SkillTable[level][rank];
    }

    bool isValidSelfTargetWeaponskill(int wsid) {
        switch (wsid) {
            case 163: //starlight
            case 164: //moonlight
            case 173: //dagan
            case 190: //myrkr
                return true;
        }
        return false;
    }

    bool CanUseWeaponskill(CCharEntity* PChar, CWeaponSkill* PSkill)
    {
        if ((((PSkill->getSkillLevel() > 0 && PChar->GetSkill(PSkill->getType()) >= PSkill->getSkillLevel() &&
            (PSkill->getUnlockId() == 0 || charutils::hasLearnedWeaponskill(PChar, PSkill->getUnlockId()))) ||
            (PSkill->getSkillLevel() == 0 && (PSkill->getUnlockId() == 0 || charutils::hasLearnedWeaponskill(PChar, PSkill->getUnlockId())))) &&
            (PSkill->getJob(PChar->GetMJob()) > 0 || (PSkill->getJob(PChar->GetSJob()) > 0 && !PSkill->mainOnly()))))
        {
            return true;
        }
        return false;
    }

    /************************************************************************
    *                                                                       *
    *  Get Enmity Modifier                                                  *
    *                                                                       *
    ************************************************************************/

    int16 GetEnmityModDamage(int16 level)
    {
        return level * 31 / 50 + 6;
    }

    int16 GetEnmityModCure(int16 level)
    {
        if (level <= 10)
            return level + 10;
        else if (level <= 50)
            return 20 + (level - 10) / 2;

        return (int16)(40 + (level - 50) * 0.6);
    }

    /************************************************************************
    *                                                                       *
    *  Get Weapon Skill by ID                                               *
    *                                                                       *
    ************************************************************************/

    CWeaponSkill* GetWeaponSkill(uint16 WSkillID)
    {
        TPZ_DEBUG_BREAK_IF(WSkillID >= MAX_WEAPONSKILL_ID);
        if (WSkillID >= MAX_WEAPONSKILL_ID)
        {
            return nullptr;
        }

        return g_PWeaponSkillList[WSkillID];
    }

    /************************************************************************
    *                                                                       *
    * Get List of Weapon Skills from skill type                             *
    *                                                                       *
    ************************************************************************/

    const std::list<CWeaponSkill*>& GetWeaponSkills(uint8 skill)
    {
        TPZ_DEBUG_BREAK_IF(skill >= MAX_SKILLTYPE);

        return g_PWeaponSkillsList[skill];
    }

    /************************************************************************
    *                                                                       *
    *  Get Mob Skill by Id                                                  *
    *                                                                       *
    ************************************************************************/

    CMobSkill* GetMobSkill(uint16 SkillID)
    {
        if (SkillID < g_PMobSkillList.size())
        {
            return g_PMobSkillList[SkillID];
        }
        else
        {
            return nullptr;
        }
    }

    /************************************************************************
    *                                                                       *
    *  Get Mob Skills by list id                                          *
    *                                                                       *
    ************************************************************************/

    const std::vector<uint16>& GetMobSkillList(uint16 ListID)
    {
        return g_PMobSkillLists[ListID];
    }

    int32 CalculateEnspellDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 Tier, uint8 element) {
        int32 damage = 0;

        //Tier 1 enspells have their damaged pre-calculated AT CAST TIME and is stored in Mod::ENSPELL_DMG
        if (Tier == 1)
        {
            damage = PAttacker->getMod(Mod::ENSPELL_DMG) + PAttacker->getMod(Mod::ENSPELL_DMG_BONUS);
            auto PChar = dynamic_cast<CCharEntity *>(PAttacker);
            if (PChar)
                damage += PChar->PMeritPoints->GetMeritValue(MERIT_ENSPELL_DAMAGE, PChar);
        }
        else if (Tier == 2)
        {
            //Tier 2 enspells calculate the damage on each hit and increment the potency in Mod::ENSPELL_DMG per hit
            uint16 skill = PAttacker->GetSkill(SKILL_ENHANCING_MAGIC);
            uint16 cap = 3 + ((6 * skill) / 100);
            if (skill > 200) {
                cap = 5 + ((5 * skill) / 100);
            }
            cap *= 2;

            if (PAttacker->getMod(Mod::ENSPELL_DMG) > cap)
            {
                PAttacker->setModifier(Mod::ENSPELL_DMG, cap);
                damage = cap;
            }
            else if (PAttacker->getMod(Mod::ENSPELL_DMG) == cap)
            {
                damage = cap;
            }
            else if (PAttacker->getMod(Mod::ENSPELL_DMG) < cap)
            {
                PAttacker->addModifier(Mod::ENSPELL_DMG, 1);
                damage = PAttacker->getMod(Mod::ENSPELL_DMG) - 1;
            }
            damage += PAttacker->getMod(Mod::ENSPELL_DMG_BONUS);

            auto PChar = dynamic_cast<CCharEntity *>(PAttacker);
            if (PChar)
                damage += PChar->PMeritPoints->GetMeritValue(MERIT_ENSPELL_DAMAGE, PChar) * 2;
        }
        else if (Tier == 3) //enlight or endark
        {
            damage = PAttacker->getMod(Mod::ENSPELL_DMG);

            if (damage > 1)
                PAttacker->delModifier(Mod::ENSPELL_DMG, 1);
            else
            {
                if (element == 7)
                    PAttacker->StatusEffectContainer->DelStatusEffect(EFFECT_ENDARK);
                else
                    PAttacker->StatusEffectContainer->DelStatusEffect(EFFECT_ENLIGHT);
            }

            damage += PAttacker->getMod(Mod::ENSPELL_DMG_BONUS);
        }

        //matching day 10% bonus, matching weather 10% or 25% for double weather
        float dBonus = 1.0;
        float resist = 1.0;
        uint32 WeekDay = CVanaTime::getInstance()->getWeekday();
        WEATHER weather = GetWeather(PAttacker, false);

        DAYTYPE strongDay[8] = { FIRESDAY, EARTHSDAY, WATERSDAY, WINDSDAY, ICEDAY, LIGHTNINGDAY, LIGHTSDAY, DARKSDAY };
        DAYTYPE weakDay[8] = { WATERSDAY, WINDSDAY, LIGHTNINGDAY, ICEDAY, FIRESDAY, EARTHSDAY, DARKSDAY, LIGHTSDAY };
        WEATHER strongWeatherSingle[8] = { WEATHER_HOT_SPELL, WEATHER_DUST_STORM, WEATHER_RAIN, WEATHER_WIND, WEATHER_SNOW, WEATHER_THUNDER, WEATHER_AURORAS, WEATHER_GLOOM };
        WEATHER strongWeatherDouble[8] = { WEATHER_HEAT_WAVE, WEATHER_SAND_STORM, WEATHER_SQUALL, WEATHER_GALES, WEATHER_BLIZZARDS, WEATHER_THUNDERSTORMS, WEATHER_STELLAR_GLARE, WEATHER_DARKNESS };
        WEATHER weakWeatherSingle[8] = { WEATHER_RAIN, WEATHER_WIND, WEATHER_THUNDER, WEATHER_SNOW, WEATHER_HOT_SPELL, WEATHER_DUST_STORM, WEATHER_GLOOM, WEATHER_AURORAS };
        WEATHER weakWeatherDouble[8] = { WEATHER_SQUALL, WEATHER_GALES, WEATHER_THUNDERSTORMS, WEATHER_BLIZZARDS, WEATHER_HEAT_WAVE, WEATHER_SAND_STORM, WEATHER_DARKNESS, WEATHER_STELLAR_GLARE };
        uint32 obi[8] = { 15435, 15438, 15440, 15437, 15436, 15439, 15441, 15442 };
        Mod resistarray[8] = { Mod::FIRERES, Mod::EARTHRES, Mod::WATERRES, Mod::WINDRES, Mod::ICERES, Mod::THUNDERRES, Mod::LIGHTRES, Mod::DARKRES };
        bool obiBonus = false;

        double half = (double)(PDefender->getMod(resistarray[element])) / 100;
        double quart = pow(half, 2);
        double eighth = pow(half, 3);
        double sixteenth = pow(half, 4);
        double resvar = tpzrand::GetRandomNumber(1.);

        // Determine resist based on which thresholds have been crossed.
        if (resvar <= sixteenth)
            resist = 0.0625f;
        else if (resvar <= eighth)
            resist = 0.125f;
        else if (resvar <= quart)
            resist = 0.25f;
        else if (resvar <= half)
            resist = 0.5f;

        if (PAttacker->objtype == TYPE_PC)
        {
            CItemEquipment* waist = ((CCharEntity*)PAttacker)->getEquip(SLOT_WAIST);
            if (waist && waist->getID() == obi[element])
            {
                obiBonus = true;
            }
        }
        else
        {
            // mobs random multiplier
            dBonus += tpzrand::GetRandomNumber(100) / 1000.0f;
        }
        if (WeekDay == strongDay[element] && (obiBonus || tpzrand::GetRandomNumber(100) < 33))
            dBonus += 0.1f;
        else if (WeekDay == weakDay[element] && (obiBonus || tpzrand::GetRandomNumber(100) < 33))
            dBonus -= 0.1f;
        if (weather == strongWeatherSingle[element] && (obiBonus || tpzrand::GetRandomNumber(100) < 33))
            dBonus += 0.1f;
        else if (weather == strongWeatherDouble[element] && (obiBonus || tpzrand::GetRandomNumber(100) < 33))
            dBonus += 0.25f;
        else if (weather == weakWeatherSingle[element] && (obiBonus || tpzrand::GetRandomNumber(100) < 33))
            dBonus -= 0.1f;
        else if (weather == weakWeatherDouble[element] && (obiBonus || tpzrand::GetRandomNumber(100) < 33))
            dBonus -= 0.25f;

        damage = (int32)(damage * resist);
        damage = (int32)(damage * dBonus);
        damage = MagicDmgTaken(PDefender, damage, (ELEMENT)(element + 1));

        if (damage > 0)
        {
            damage = std::max(damage - PDefender->getMod(Mod::PHALANX), 0);
            damage = HandleStoneskin(PDefender, damage);
        }
        damage = std::clamp(damage, -99999, 99999);

        return damage;
    }

    /************************************************************************
    *                                                                       *
    *  Calculates Spike Damage                                              *
    *                                                                       *
    ************************************************************************/

    uint16 CalculateSpikeDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, uint16 damageTaken)
    {
        uint16 damage = Action->spikesParam;
        // int16 intStat = PDefender->INT();
        // int16 mattStat = PDefender->getMod(Mod::MATT);

        switch (Action->spikesEffect)
        {
            case SPIKE_DREAD:
                // drain same as damage taken
                damage = damageTaken;
                break;
            default:
                break;
        }

        return damage;
    }

    bool HandleSpikesDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, int32 damage)
    {
        Action->spikesEffect = (SUBEFFECT)PDefender->getMod(Mod::SPIKES);
        Action->spikesMessage = 44;
        Action->spikesParam = std::max<int16>(PDefender->getMod(Mod::SPIKES_DMG), 0);

        // Handle Retaliation
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_RETALIATION) && PDefender->PAI->IsEngaged()
            && battleutils::GetHitRate(PDefender, PAttacker) / 2 > tpzrand::GetRandomNumber(100)
            && isFaceing(PDefender->loc.p, PAttacker->loc.p, 40))
        {
            // Retaliation rate is based on player acc vs mob evasion. Missed retaliations do not even display in log.
            // Other theories exist but were not proven or reliably tested (I have to assume too many things to even consider JP translations about weapon delay), this at least has data to back it up.
            // https://web.archive.org/web/20141228105335/http://www.bluegartr.com/threads/120193-Retaliation-Testing?s=7a6221e10ffdfaa6a7f5e8f0387f787d&p=4620727&viewfull=1#post4620727
            Action->reaction = REACTION_HIT;
            Action->spikesEffect = SUBEFFECT_COUNTER;

            if (battleutils::IsAbsorbByShadow(PAttacker)) // Struck a shadow
            {
                Action->spikesMessage = 535;
            }
            else // Struck the target
            {
                if (PDefender->objtype == TYPE_PC)
                {
                    // Check for skillup
                    uint8 skilltype = 0;
                    if (auto weapon = dynamic_cast<CItemWeapon*>(PDefender->m_Weapons[SLOT_MAIN]))
                    {
                        skilltype = weapon->getSkillType();
                    }
                    charutils::TrySkillUP((CCharEntity*)PDefender, (SKILLTYPE)skilltype, PAttacker->GetMLevel());
                }

                // Check if crit
                bool crit = battleutils::GetCritHitRate(PDefender, PAttacker, true) > tpzrand::GetRandomNumber(100);

                // Dmg math.
                float DamageRatio = GetDamageRatio(PDefender, PAttacker, crit, 0.f);
                uint16 dmg = (uint32)((PDefender->GetMainWeaponDmg() + battleutils::GetFSTR(PDefender, PAttacker, SLOT_MAIN)) * DamageRatio);
                dmg = attackutils::CheckForDamageMultiplier(((CCharEntity*)PDefender), dynamic_cast<CItemWeapon*>(PDefender->m_Weapons[SLOT_MAIN]), dmg, PHYSICAL_ATTACK_TYPE::NORMAL, SLOT_MAIN);
                uint16 bonus = dmg * (PDefender->getMod(Mod::RETALIATION) / 100);
                dmg = dmg + bonus;

                // FINISH HIM! dun dun dun
                // TP and stoneskin are handled inside TakePhysicalDamage
                Action->spikesMessage = 536;
                Action->spikesParam = battleutils::TakePhysicalDamage(PDefender, PAttacker, PHYSICAL_ATTACK_TYPE::NORMAL, dmg, false, SLOT_MAIN, 1, nullptr, true, true, true);
            }
        }

        // Handle spikes from spells or auto-spikes (scripted) effects
        else if (Action->spikesEffect > 0)
        {
            // check if spikes are handled in mobs script
            if (PDefender->objtype == TYPE_MOB && ((CMobEntity*)PDefender)->getMobMod(MOBMOD_AUTO_SPIKES) > 0)
            {
                luautils::OnSpikesDamage(PDefender, PAttacker, Action, Action->spikesParam);
            }

            // calculate damage
            Action->spikesParam = HandleStoneskin(PAttacker, CalculateSpikeDamage(PAttacker, PDefender, Action, (uint16)(abs(damage))));

            switch (Action->spikesEffect)
            {
                case SPIKE_BLAZE:
                case SPIKE_ICE:
                case SPIKE_SHOCK:
                    PAttacker->takeDamage(Action->spikesParam, PDefender, ATTACK_MAGICAL, GetSpikesDamageType(Action->spikesEffect));
                    break;

                case SPIKE_DREAD:
                    if (PAttacker->m_EcoSystem == SYSTEM_UNDEAD)
                    {
                        // is undead no effect
                        Action->spikesEffect = (SUBEFFECT)0;
                        return false;
                    }
                    else
                    {
                        Action->addEffectMessage = 132;

                        if (PDefender->isAlive())
                        {
                            auto PEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_DREAD_SPIKES);
                            if (PEffect)
                            {
                                // Subpower is the remaining damage that can be drained. When it reaches 0 the effect ends
                                int remainingDrain = PEffect->GetSubPower();
                                if (remainingDrain - Action->spikesParam <= 0)
                                {
                                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_DREAD_SPIKES);
                                }
                                else
                                {
                                    PEffect->SetSubPower(remainingDrain - Action->spikesParam);
                                }
                            }
                            PDefender->addHP(Action->spikesParam);
                        }
                        PAttacker->takeDamage(Action->spikesParam, PDefender, ATTACK_MAGICAL, DAMAGE_DARK);
                    }
                    break;

                case SPIKE_REPRISAL:
                    if (Action->reaction == REACTION_BLOCK)
                    {
                        PAttacker->takeDamage(Action->spikesParam, PDefender, ATTACK_MAGICAL, DAMAGE_LIGHT);
                        auto PEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_REPRISAL);
                        if (PEffect)
                        {
                            // Subpower is the remaining damage that can be reflected. When it reaches 0 the effect ends
                            int remainingReflect = PEffect->GetSubPower();
                            if (remainingReflect - Action->spikesParam <= 0)
                            {
                                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_REPRISAL);
                            }
                            else
                            {
                                PEffect->SetSubPower(remainingReflect - Action->spikesParam);
                            }
                        }
                    }
                    else
                    {
                        // only works on shield blocks
                        Action->spikesEffect = (SUBEFFECT)0;
                        return false;
                    }
                    break;

                default:
                    break;
            }

            // Check for status effect proc. Todo: move to scripts soon™ after item additionalEffect refactor Teo is working on
            HandleSpikesStatusEffect(PAttacker, PDefender, Action);

            battleutils::DirtyExp(PAttacker, PDefender);
            if (PAttacker->isDead())
            {
                battleutils::ClaimMob(PAttacker, PDefender);
            }
            return true;
        }

        // Deal with spikesEffect effect gear
        else if (PDefender->getMod(Mod::ITEM_SPIKES_TYPE) > 0)
        {
            if (PDefender->objtype == TYPE_PC)
            {
                CCharEntity* PCharDef = (CCharEntity*)PDefender;

                for (auto&& slot : {SLOT_SUB, SLOT_BODY, SLOT_LEGS, SLOT_HEAD, SLOT_HANDS, SLOT_FEET})
                {
                    CItemEquipment* PItem = PCharDef->getEquip(slot);
                    if (PItem)
                    {
                        uint8 chance;

                        Action->spikesEffect = (SUBEFFECT)0;
                        auto spikes_type = battleutils::GetScaledItemModifier(PDefender, PItem, Mod::ITEM_SPIKES_TYPE);
                        if (spikes_type > 0 && spikes_type < 7)
                        {
                            Action->spikesEffect = (SUBEFFECT)spikes_type;
                        }

                        Action->spikesParam = battleutils::GetScaledItemModifier(PDefender, PItem, Mod::ITEM_SPIKES_DMG);
                        chance = battleutils::GetScaledItemModifier(PDefender, PItem, Mod::ITEM_SPIKES_CHANCE);

                        if (((CMobEntity*)PDefender)->m_HiPCLvl < PAttacker->GetMLevel())
                        {
                            ((CMobEntity*)PDefender)->m_HiPCLvl = PAttacker->GetMLevel();
                        }
                        if (Action->spikesEffect && HandleSpikesEquip(PAttacker, PDefender, Action, (uint8)Action->spikesParam, Action->spikesEffect, chance))
                            return true;
                    }
                }
            }
        }
        else if (Action->spikesEffect == 0)
        {
            Action->spikesParam = 0;
            Action->spikesMessage = 0;
        }
        return false;
    }

    bool HandleSpikesEquip(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, uint8 damage, SUBEFFECT spikesType, uint8 chance)
    {
        int lvlDiff = std::clamp((PDefender->GetMLevel() - PAttacker->GetMLevel()), -5, 5) * 2;

        if (tpzrand::GetRandomNumber(100) < chance + lvlDiff)
        {
            // spikes landed
            if (spikesType == SUBEFFECT_CURSE_SPIKES)
            {
                Action->spikesMessage = 0; // log says nothing?
                Action->spikesParam = EFFECT_CURSE;
            }
            else
            {
                auto ratio = std::clamp<uint8>(damage / 4, 1, 255);
                Action->spikesParam = HandleStoneskin(PAttacker, damage - tpzrand::GetRandomNumber<uint16>(ratio) + tpzrand::GetRandomNumber<uint16>(ratio));
                PAttacker->takeDamage(Action->spikesParam, PDefender, ATTACK_MAGICAL, GetSpikesDamageType(spikesType));
            }

            // Temp till moved to script.
            HandleSpikesStatusEffect(PAttacker, PDefender, Action);

            return true;
        }

        return false;
    }

    void HandleSpikesStatusEffect(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action)
    {
        int lvlDiff = 0;
        if (PDefender)
        {
            lvlDiff = std::clamp((PDefender->GetMLevel() - PAttacker->GetMLevel()), -5, 5) * 2;
        }

        switch (Action->spikesEffect)
        {
            case SUBEFFECT_CURSE_SPIKES:
            {
                if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE) == false)
                {
                    PAttacker->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_CURSE, EFFECT_CURSE, 15, 0, 180));
                }
                break;
            }
            case SUBEFFECT_ICE_SPIKES:
            {
                if (tpzrand::GetRandomNumber(100) < 20 + lvlDiff && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_PARALYSIS) == false)
                {
                    PAttacker->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_PARALYSIS, EFFECT_PARALYSIS, 20, 0, 30));
                }
                break;
            }
            case SUBEFFECT_SHOCK_SPIKES:
            {
                if (tpzrand::GetRandomNumber(100) < 30 + lvlDiff && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_STUN) == false)
                {
                    PAttacker->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_STUN, EFFECT_STUN, 1, 0, 3));
                }
                break;
            }
            default:
                break;
        }
    }

    /************************************************************************
    *                                                                       *
    *  Handles Enspell effect and damage                                    *
    *                                                                       *
    ************************************************************************/

    void HandleEnspell(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, bool isFirstSwing, CItemWeapon* weapon, int32 finaldamage)
    {
        CCharEntity* PChar = nullptr;

        if (PAttacker->objtype == TYPE_PC)
        {
            PChar = (CCharEntity*)PAttacker;
        }

        Action->additionalEffect = SUBEFFECT_NONE;
        Action->addEffectMessage = 0;
        Action->addEffectParam = 0;

        EFFECT previous_daze = EFFECT_NONE;
        uint16 previous_daze_power = 0;
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_SAMBA))
        {
            previous_daze = EFFECT_DRAIN_DAZE;
            previous_daze_power = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_DRAIN_SAMBA)->GetPower();
        }
        else if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_SAMBA))
        {
            previous_daze = EFFECT_ASPIR_DAZE;
            previous_daze_power = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_ASPIR_SAMBA)->GetPower();
        }
        else if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_SAMBA))
        {
            previous_daze = EFFECT_HASTE_DAZE;
            previous_daze_power = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_HASTE_SAMBA)->GetPower();
        }
        if (previous_daze != EFFECT_NONE)
        {
            if (PAttacker->PParty != nullptr)
            {
                for (uint8 i = 0; i < PAttacker->PParty->members.size(); i++)
                {
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_DRAIN_DAZE, PAttacker->PParty->members[i]->id);
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_HASTE_DAZE, PAttacker->PParty->members[i]->id);
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_ASPIR_DAZE, PAttacker->PParty->members[i]->id);
                }
            }
            else
            {
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_DRAIN_DAZE, PAttacker->id);
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_HASTE_DAZE, PAttacker->id);
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_ASPIR_DAZE, PAttacker->id);
            }
            if ((PDefender->m_EcoSystem != SYSTEM_UNDEAD) || (previous_daze == EFFECT_HASTE_DAZE))
            {
                PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(previous_daze,
                    0, previous_daze_power,
                    0, 10, PAttacker->id), true);
            }
        }

        // Enspell overwrites weapon effects
        if (PAttacker->getMod(Mod::ENSPELL) > 0 && (PAttacker->getMod(Mod::ENSPELL_CHANCE) == 0 ||
            PAttacker->getMod(Mod::ENSPELL_CHANCE) > tpzrand::GetRandomNumber(100)))
        {
            SUBEFFECT subeffects[8] = { SUBEFFECT_LIGHT_DAMAGE, SUBEFFECT_DARKNESS_DAMAGE, SUBEFFECT_FIRE_DAMAGE, SUBEFFECT_EARTH_DAMAGE,
                SUBEFFECT_WATER_DAMAGE, SUBEFFECT_WIND_DAMAGE, SUBEFFECT_ICE_DAMAGE, SUBEFFECT_LIGHTNING_DAMAGE };
            int16 enspell = PAttacker->getMod(Mod::ENSPELL);

            if (enspell > 0 && enspell <= 6)
            {
                Action->additionalEffect = subeffects[enspell + 1];
                Action->addEffectMessage = 163;
                Action->addEffectParam = CalculateEnspellDamage(PAttacker, PDefender, 1, enspell - 1);

                if (Action->addEffectParam < 0)
                {
                    Action->addEffectParam = -Action->addEffectParam;
                    Action->addEffectMessage = 384;
                }

                PDefender->takeDamage(Action->addEffectParam, PAttacker, ATTACK_MAGICAL, GetEnspellDamageType((ENSPELL)enspell));
            }
            else if (enspell > 8 && enspell <= 14 && isFirstSwing)
            {
                Action->additionalEffect = subeffects[enspell - 7];
                Action->addEffectMessage = 163;
                Action->addEffectParam = CalculateEnspellDamage(PAttacker, PDefender, 2, enspell - 9);

                if (Action->addEffectParam < 0)
                {
                    Action->addEffectParam = -Action->addEffectParam;
                    Action->addEffectMessage = 384;
                }

                PDefender->takeDamage(Action->addEffectParam, PAttacker, ATTACK_MAGICAL, GetEnspellDamageType((ENSPELL)enspell));
            }
            else if (enspell > 6 && enspell <= 8)
            {
                Action->additionalEffect = subeffects[enspell - 7];
                Action->addEffectMessage = 163;
                Action->addEffectParam = CalculateEnspellDamage(PAttacker, PDefender, 3, enspell - 1);

                if (Action->addEffectParam < 0)
                {
                    Action->addEffectParam = -Action->addEffectParam;
                    Action->addEffectMessage = 384;
                }

                PDefender->takeDamage(Action->addEffectParam, PAttacker, ATTACK_MAGICAL, GetEnspellDamageType((ENSPELL)enspell));
            }
            else if (enspell == ENSPELL_BLOOD_WEAPON)
            {
                Action->additionalEffect = SUBEFFECT_HP_DRAIN;
                Action->addEffectMessage = 161;

                Action->addEffectParam = PAttacker->addHP(Action->param);

                if (PChar != nullptr) {
                    PChar->updatemask |= UPDATE_HP;
                }
            }
            else if (enspell == ENSPELL_AUSPICE && isFirstSwing) {
                Action->additionalEffect = SUBEFFECT_LIGHT_DAMAGE;
                Action->addEffectMessage = 163;
                Action->addEffectParam = CalculateEnspellDamage(PAttacker, PDefender, 2, 7);

                if (Action->addEffectParam < 0)
                {
                    Action->addEffectParam = -Action->addEffectParam;
                    Action->addEffectMessage = 384;
                }

                PDefender->takeDamage(Action->addEffectParam, PAttacker, ATTACK_MAGICAL, GetEnspellDamageType((ENSPELL)enspell));
            }
        }
        //check weapon for additional effects
        else if (PAttacker->objtype == TYPE_PC && battleutils::GetScaledItemModifier(PAttacker, weapon, Mod::ADDITIONAL_EFFECT) > 0 &&
            luautils::OnAdditionalEffect(PAttacker, PDefender, weapon, Action, finaldamage) == 0 && Action->additionalEffect)
        {
            if (Action->addEffectMessage == 163 && Action->addEffectParam < 0)
            {
                Action->addEffectMessage = 384;
            }
        }
        //check script for grip if main failed
        else if (PAttacker->objtype == TYPE_PC && static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_SUB) &&
            weapon == PAttacker->m_Weapons[SLOT_MAIN] && static_cast<CItemWeapon*>(static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_SUB))->getSkillType() == SKILL_NONE &&
            battleutils::GetScaledItemModifier(PAttacker, static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_SUB), Mod::ADDITIONAL_EFFECT) > 0 &&
            luautils::OnAdditionalEffect(PAttacker, PDefender, static_cast<CItemWeapon*>(static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_SUB)), Action, finaldamage) == 0 && Action->additionalEffect)
        {
            if (Action->addEffectMessage == 163 && Action->addEffectParam < 0)
            {
                Action->addEffectMessage = 384;
            }
        }
        else if (PAttacker->objtype == TYPE_MOB && ((CMobEntity*)PAttacker)->getMobMod(MOBMOD_ADD_EFFECT) > 0)
        {
            luautils::OnAdditionalEffect(PAttacker, PDefender, weapon, Action, finaldamage);
            if (Action->addEffectMessage == 163 && Action->addEffectParam < 0)
            {
                Action->addEffectMessage = 384;
            }
        }
        else if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_DAZE) ||
            PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_DAZE) ||
            PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_DAZE))
        {
            // Generic drain for anyone able to do melee damage to a dazed target
            // TODO: ignore dazes from dancers outside party
            int16 delay = PAttacker->GetWeaponDelay(false) / 10;

            if (PAttacker->PMaster == nullptr || PAttacker->objtype == TYPE_TRUST)
            {
                // TODO: All of this is very ugly, but is fairly fragile, be careful refactoring!
                EFFECT daze = EFFECT_NONE;
                uint16 power = 0;
                if (PAttacker->objtype == TYPE_PC && PAttacker->PParty != nullptr)
                {
                    for (uint8 i = 0; i < PAttacker->PParty->members.size(); i++)
                    {
                        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_DAZE, PAttacker->PParty->members[i]->id))
                        {
                            daze = EFFECT_DRAIN_DAZE;
                            power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_DRAIN_DAZE, PAttacker->PParty->members[i]->id)->GetPower();
                            break;
                        }
                        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_DAZE, PAttacker->PParty->members[i]->id))
                        {
                            daze = EFFECT_HASTE_DAZE;
                            power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_HASTE_DAZE, PAttacker->PParty->members[i]->id)->GetPower();
                            break;
                        }
                        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_DAZE, PAttacker->PParty->members[i]->id))
                        {
                            daze = EFFECT_ASPIR_DAZE;
                            power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_ASPIR_DAZE, PAttacker->PParty->members[i]->id)->GetPower();
                            break;
                        }
                    }
                }
                else if (PAttacker->objtype == TYPE_TRUST && PAttacker->PMaster)
                {
                    static_cast<CCharEntity*>(PAttacker->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (daze == EFFECT_NONE && PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_DAZE, PMember->id))
                        {
                            daze = EFFECT_DRAIN_DAZE;
                            power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_DRAIN_DAZE, PMember->id)->GetPower();
                        }
                        if (daze == EFFECT_NONE && PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_DAZE, PMember->id))
                        {
                            daze = EFFECT_DRAIN_DAZE;
                            power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_DRAIN_DAZE, PMember->id)->GetPower();
                        }
                        if (daze == EFFECT_NONE && PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_DAZE, PMember->id))
                        {
                            daze = EFFECT_DRAIN_DAZE;
                            power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_ASPIR_DAZE, PMember->id)->GetPower();
                        }
                    });
                }
                else
                {
                    if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_DAZE, PAttacker->id))
                    {
                        daze = EFFECT_DRAIN_DAZE;
                        power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_DRAIN_DAZE, PAttacker->id)->GetPower();
                    }
                    if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_DAZE, PAttacker->id))
                    {
                        daze = EFFECT_HASTE_DAZE;
                        power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_HASTE_DAZE, PAttacker->id)->GetPower();
                    }
                    if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_DAZE, PAttacker->id))
                    {
                        daze = EFFECT_ASPIR_DAZE;
                        power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_ASPIR_DAZE, PAttacker->id)->GetPower();
                    }
                }

                if (daze == EFFECT_DRAIN_DAZE)
                {
                    uint16 multiplier = (uint16)(3 + (5.5f * power - 1));
                    int8 Samba = tpzrand::GetRandomNumber(1, (delay * multiplier) / 100 + 1);

                    // vary damage based on lvl diff
                    int8 lvlDiff = (PDefender->GetMLevel() - PAttacker->GetMLevel()) / 2;

                    if (lvlDiff < -5) {
                        lvlDiff = -5;
                    }

                    Samba -= lvlDiff;

                    if (Samba > (finaldamage / 2)) {
                        Samba = finaldamage / 2;
                    }

                    if (finaldamage <= 2) {
                        Samba = 0;
                    }

                    if (Samba < 0)
                    {
                        Samba = 0;
                    }

                    Action->additionalEffect = SUBEFFECT_HP_DRAIN;
                    Action->addEffectMessage = 161;
                    Action->addEffectParam = Samba;

                    PAttacker->addHP(Samba);    // does not do any additional drain to targets HP, only a portion of it
                    if (PChar != nullptr) {
                        PChar->updatemask |= UPDATE_HP;
                    }
                }
                else if (daze == EFFECT_ASPIR_DAZE)
                {
                    uint16 multiplier = 1 + (2 * power - 1);
                    int8 Samba = tpzrand::GetRandomNumber(1, (delay * multiplier) / 100 + 1);

                    if (Samba >= finaldamage / 4) { Samba = finaldamage / 4; }

                    if (finaldamage <= 2) { Samba = 0; }

                    if (Samba < 0) { Samba = 0; }

                    Action->additionalEffect = SUBEFFECT_MP_DRAIN;
                    Action->addEffectMessage = 162;

                    int16 mpDrained = PDefender->addMP(-Samba);

                    PAttacker->addMP(mpDrained);
                    Action->addEffectParam = mpDrained;

                    if (PChar != nullptr) {
                        PChar->updatemask |= UPDATE_HP;
                    }
                }
                else if (daze == EFFECT_HASTE_DAZE)
                {
                    Action->additionalEffect = SUBEFFECT_HASTE;
                    // Ability haste added in scripts\globals\effects\haste_samba_haste_effect.lua
                    PAttacker->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HASTE_SAMBA_HASTE, 0, power, 0, 10));
                    // Status effect removed in CAttackRound constructor (i.e. after next attack round is calculated)
                }
            }
        }
    }

    /************************************************************************
    *                                                                       *
    *  Handles Ranged weapon's additional effects (e.g. Bolts)              *
    *                                                                       *
    ************************************************************************/

    // TODO: remove function, move additional effects into items script files (deleting from switch as they get done)
    void HandleRangedAdditionalEffect(CCharEntity* PAttacker, CBattleEntity* PDefender, apAction_t* Action) {
        /*  CItemWeapon* PAmmo = (CItemWeapon*)PAttacker->getStorage(LOC_INVENTORY)->GetItem(PAttacker->equip[SLOT_AMMO]);
            //add effects dont have 100% proc, presume level dependant. 95% chance but -5% for each level diff.
            //capped at 5% proc when mob is 18 (!!!) levels higher than you.
            uint8 chance = 95;
            if(PDefender->GetMLevel() > PAttacker->GetMLevel()){
                chance -= 5*(PDefender->GetMLevel() - PAttacker->GetMLevel());
                chance = std::clamp(chance,5,95);
            }
            if (WELL512::WELL512::GetRandomNumber(100) >= chance || PAmmo == nullptr){ return; }

            switch(PAmmo->getID()){
            case 18700:{ //Wind Arrow
            //damage doesn't exceed ~67 unless wearing wind staff/iceday/weather
            //there isn't a formula, but INT affects damage, so this is guesstimated. It seems to be level
            //invarient since its used on harder monsters for damage occasionally. Assuming the modifier
            //is simply AGI with a degree of randomisation

                    Action->additionalEffect = SUBEFFECT_WIND_DAMAGE;
                    Action->addEffectMessage = 163;

                    //calculate damage
                    uint8 damage = (PAttacker->AGI() - PDefender->AGI())/2;
                    damage = std::clamp(damage,0,50);
                    damage += 10; //10~60
                    damage += WELL512::GetRandomNumber(8); //10~67 randomised
                    damage += (float)damage * ((float)PDefender->getMod(Mod::WINDRES)/-100);

                    damage = HandleStoneskin(PDefender, damage);
                    //set damage TODO: handle resi st/staff/day
                    Action->addEffectParam = damage;
                    PDefender->takeDamage(damage, PAttacker);
                }
                break;
            case 18699:{ //Earth Arrow
            //damage doesn't exceed ~67 unless wearing Earth staff/earthsday/weather
            //there isn't a formula, but VIT affects damage, so this is guesstimated. It seems to be level
            //invarient since its used on harder monsters for damage occasionally. Assuming the modifier
            //is simply VIT with a degree of randomisation

                    Action->additionalEffect = SUBEFFECT_EARTH_DAMAGE;
                    Action->addEffectMessage = 163;

                    //calculate damage
                    uint8 damage = (PAttacker->VIT() - PDefender->VIT())/2;
                    damage = std::clamp(damage,0,50);
                    damage += 10; //10~60
                    damage += WELL512::GetRandomNumber(8); //10~67 randomised
                    //set damage TODO: handle resist/staff/day

                    damage += (float)damage * ((float)PDefender->getMod(Mod::EARTHRES)/-100);
                    damage = HandleStoneskin(PDefender, damage);
                    Action->addEffectParam  = damage;
                    PDefender->takeDamage(damage, PAttacker);
                }
                break;
            case 18698:{ //Water Arrow
            //damage doesn't exceed ~67 unless wearing light staff/iceday/weather
            //there isn't a formula, but INT affects damage, so this is guesstimated. It seems to be level
            //invarient since its used on harder monsters for damage occasionally. Assuming the modifier
            //is simply MND with a degree of randomisation

                    Action->additionalEffect = SUBEFFECT_WATER_DAMAGE;
                    Action->addEffectMessage = 163;

                    //calculate damage
                    uint8 damage = (PAttacker->MND() - PDefender->MND())/2;
                    damage = std::clamp(damage,0,50);
                    damage += 10; //10~60
                    damage += WELL512::GetRandomNumber(8); //10~67 randomised
                    //set damage TODO: handle resist/staff/day
                    damage += (float)damage * ((float)PDefender->getMod(Mod::WATERRES)/-100);
                    damage = HandleStoneskin(PDefender, damage);
                    Action->addEffectParam  = damage;
                    PDefender->takeDamage(damage, PAttacker);
                }
                break;
            case 18153:{ //Holy Bolt
            //damage doesn't exceed ~67 unless wearing light staff/lightsday/weather
            //there isn't a formula, but MND affects damage, so this is guesstimated. It seems to be level
            //invarient since its used on harder monsters for damage occasionally. Assuming the modifier
            //is simply MND with a degree of randomisation

                    Action->additionalEffect = SUBEFFECT_LIGHT_DAMAGE;
                    Action->addEffectMessage = 163;

                    //calculate damage
                    uint8 damage = (PAttacker->MND() - PDefender->MND())/2;
                    damage = std::clamp(damage,0,50);
                    damage += 10; //10~60
                    damage += WELL512::GetRandomNumber(8); //10~67 randomised
                    //set damage TODO: handle resist/staff/day
                    damage += (float)damage * ((float)PDefender->getMod(Mod::LIGHTRES)/-100);
                    damage = HandleStoneskin(PDefender, damage);
                    Action->addEffectParam  = damage;
                    PDefender->takeDamage(damage, PAttacker);
                }
                break;
            case 17324:{ //Lightning Arrow
            //damage doesn't exceed ~67
            //there isn't a formula. It seems to be level
            //invarient since its used on harder monsters for damage occasionally. Assuming the modifier
            //is simply DEX with a degree of randomisation

                    Action->additionalEffect = SUBEFFECT_LIGHTNING_DAMAGE;
                    Action->addEffectMessage = 163;

                    //calculate damage
                    uint8 damage = (PAttacker->DEX() - PDefender->DEX())/2;
                    damage = std::clamp(damage,0,50);
                    damage += 10; //10~60
                    damage += WELL512::GetRandomNumber(8); //10~67 randomised
                    //set damage TODO: handle resist/staff/day
                    damage += (float)damage * ((float)PDefender->getMod(Mod::THUNDERRES)/-100);
                    damage = HandleStoneskin(PDefender, damage);
                    Action->addEffectParam  = damage;
                    PDefender->takeDamage(damage, PAttacker);
                }
                break;
            case 17323:{ //Ice Arrow
            //damage doesn't exceed ~67 unless wearing ice staff/iceday/weather
            //there isn't a formula, but INT affects damage, so this is guesstimated. It seems to be level
            //invarient since its used on harder monsters for damage occasionally. Assuming the modifier
            //is simply INT with a degree of randomisation

                    Action->additionalEffect = SUBEFFECT_ICE_DAMAGE;
                    Action->addEffectMessage = 163;

                    //calculate damage
                    uint8 damage = (PAttacker->INT() - PDefender->INT())/2;
                    damage = std::clamp(damage,0,50);
                    damage += 10; //10~60
                    damage += WELL512::GetRandomNumber(8); //10~67 randomised
                    //set damage TODO: handle resist/staff/day
                    damage += (float)damage * ((float)PDefender->getMod(Mod::ICERES)/-100);
                    damage = HandleStoneskin(PDefender, damage);
                    Action->addEffectParam  = damage;
                    PDefender->takeDamage(damage, PAttacker);
                }
                break;
            case 17327: // Grand knights Arrow
            case 17322:{ //Fire Arrow
            //damage doesn't exceed ~67 unless wearing ice staff/iceday/weather
            //there isn't a formula, but INT affects damage, so this is guesstimated. It seems to be level
            //invarient since its used on harder monsters for damage occasionally. Assuming the modifier
            //is simply INT with a degree of randomisation

                    Action->additionalEffect = SUBEFFECT_FIRE_DAMAGE;
                    Action->addEffectMessage = 163;

                    //calculate damage
                    uint8 damage = (PAttacker->INT() - PDefender->INT())/2;
                    damage = std::clamp(damage,0,50);

                    damage += 10; //10~60
                    damage += WELL512::GetRandomNumber(8); //10~67 randomised
                    //set damage TODO: handle resist/staff/day
                    damage += (float)damage * ((float)PDefender->getMod(Mod::FIRERES)/-100);

                    if(PAmmo->getID() == 17327){
                        damage *= 2;
                    }
                    damage = HandleStoneskin(PDefender, damage);

                    Action->addEffectParam  = damage;
                    PDefender->takeDamage(damage, PAttacker);
                }
                break;
            }*/
    }

    uint8 GetRangedHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isBarrage, int8 accBonus)
    {
        int acc = 0;
        int hitrate = 75;

        if (PAttacker->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)PAttacker;
            CItemWeapon* PItem = (CItemWeapon*)PChar->getEquip(SLOT_RANGED);

            if (PItem == nullptr || !PItem->isType(ITEM_WEAPON))
            {
                // try throwing weapon
                PItem = (CItemWeapon*)PChar->getEquip(SLOT_AMMO);
            }

            if (PItem != nullptr && PItem->isType(ITEM_WEAPON))
            {
                acc = PChar->RACC(PItem->getSkillType());
            }

            //Check For Ambush Merit - Ranged
            if ((charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_AMBUSH)) && ((abs(PDefender->loc.p.rotation - PAttacker->loc.p.rotation) < 23))) {
                acc += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_AMBUSH, (CCharEntity*)PAttacker);
            }

        }
        else if (PAttacker->objtype == TYPE_PET && ((CPetEntity*)PAttacker)->getPetType() == PETTYPE_AUTOMATON)
        {
            acc = PAttacker->RACC(SKILL_AUTOMATON_RANGED);
        }
        // Check for Yonin evasion bonus while in front of target
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_YONIN) && ((abs(abs(PAttacker->loc.p.rotation - PDefender->loc.p.rotation) - 128) < 23)))
        {
            acc -= PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_YONIN)->GetPower();
        }

        // Add any specific accuracy bonus, e.g. Daken RAcc +100
        acc += accBonus;

        int eva = PDefender->EVA();
        hitrate = hitrate + (acc - eva) / 2 + (PAttacker->GetMLevel() - PDefender->GetMLevel()) * 2;

        uint8 finalhitrate = std::clamp(hitrate, 20, 95);
        return finalhitrate;
    }

    uint8 GetRangedHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isBarrage)
    {
        return GetRangedHitRate(PAttacker, PDefender, isBarrage, 0);
    }

    //todo: need to penalise attacker's RangedAttack depending on distance from mob. (% decrease)
    float GetRangedDamageRatio(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isCritical)
    {
        //get ranged attack value
        uint16 rAttack = 1;

        if (PAttacker->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)PAttacker;
            CItemWeapon* PItem = (CItemWeapon*)PChar->getEquip(SLOT_RANGED);

            if (PItem != nullptr && PItem->isType(ITEM_WEAPON))
            {
                rAttack = PChar->RATT(PItem->getSkillType(), PItem->getILvlSkill());
            }
            else
            {
                PItem = (CItemWeapon*)PChar->getEquip(SLOT_AMMO);

                if (PItem == nullptr || !PItem->isType(ITEM_WEAPON) || (PItem->getSkillType() != SKILL_THROWING)) {
                    ShowDebug("battleutils::GetRangedPDIF Cannot find a valid ranged weapon to calculate PDIF for. \n");
                }
                else
                {
                    rAttack = PChar->RATT(PItem->getSkillType(), PItem->getILvlSkill());
                }
            }
        }
        else if (PAttacker->objtype == TYPE_PET && ((CPetEntity*)PAttacker)->getPetType() == PETTYPE_AUTOMATON)
        {
            rAttack = PAttacker->RATT(SKILL_AUTOMATON_RANGED);
        }
        else
        {
            //assume mobs capped
            rAttack = battleutils::GetMaxSkill(SKILL_ARCHERY, JOB_RNG, PAttacker->GetMLevel());
        }

        //get ratio (not capped for RAs)
        float ratio = (float)rAttack / (float)PDefender->DEF();

        ratio = std::clamp<float>(ratio, 0, 3);

        //level correct (0.025 not 0.05 like for melee)
        if (PDefender->GetMLevel() > PAttacker->GetMLevel()) {
            ratio -= 0.025f * (PDefender->GetMLevel() - PAttacker->GetMLevel());
        }

        //calculate min/max PDIF
        float minPdif = 0;
        float maxPdif = 0;

        if (ratio < 0.9)
        {
            minPdif = ratio;
            maxPdif = (10.0f / 9.0f) * ratio;
        }
        else if (ratio <= 1.1)
        {
            minPdif = 1;
            maxPdif = 1;
        }
        else
        {
            minPdif = (-3.0f / 19.0f) + ((20.0f / 19.0f) * ratio);
            maxPdif = ratio;
        }

        minPdif = std::clamp<float>(minPdif, 0, 3);
        maxPdif = std::clamp<float>(maxPdif, 0, 3);

        //return random number between the two
        float pdif = tpzrand::GetRandomNumber(minPdif, maxPdif);

        if (isCritical)
        {
            pdif *= 1.25;
            int16 criticaldamage = PAttacker->getMod(Mod::CRIT_DMG_INCREASE) + PAttacker->getMod(Mod::RANGED_CRIT_DMG_INCREASE) - PDefender->getMod(Mod::CRIT_DEF_BONUS);
            criticaldamage = std::clamp<int16>(criticaldamage, 0, 100);
            pdif *= ((100 + criticaldamage) / 100.0f);
        }

        return pdif;
    }

    int16 CalculateBaseTP(int delay){
        int16 x = 1;
        if (delay <= 180) {
            x = (int16)(61 + ((delay - 180) * 63.f) / 360);
        }
        else if (delay <= 540) {
            x = (int16)(61 + ((delay - 180) * 88.f) / 360);
        }
        else if (delay <= 630) {
            x = (int16)(149 + ((delay - 540) * 20.f) / 360);
        }
        else if (delay <= 720) {
            x = (int16)(154 + ((delay - 630) * 28.f) / 360);
        }
        else if (delay <= 900) {
            x = (int16)(161 + ((delay - 720) * 24.f) / 360);
        }
        else {
            x = (int16)(173 + ((delay - 900) * 28.f) / 360);
        }
        return x;
    }

    bool TryInterruptSpell(CBattleEntity* PAttacker, CBattleEntity* PDefender, CSpell* PSpell)
    {
        if (PDefender->objtype == TYPE_TRUST)
        {
            return false;
        }

        // cannot interrupt when manafont is active
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT))
        {
            return false;
        }

        // Songs cannot be interrupted by physical attacks.
        if ((SKILLTYPE)PSpell->getSkillType() == SKILL_SINGING)
        {
            return false;
        }

        //Reasonable assumption for the time being.
        int base = 40;

        int diff = PAttacker->GetMLevel() - PDefender->GetMLevel();

        if (PDefender->objtype == TYPE_MOB) {
            base = 5;
        }

        float check = (float)(base + diff);
        uint8 meritReduction = 0;

        if (PDefender->objtype == TYPE_PC) { //Check player's skill.
            //For mobs, we can assume their skill is capped at their level, so this term is 1 anyway.
            CCharEntity* PChar = (CCharEntity*)PDefender;
            float skill = PChar->GetSkill(PSpell->getSkillType());
            if (skill <= 0) {
                skill = 1;
            }

            float cap = GetMaxSkill((SKILLTYPE)PSpell->getSkillType(), PChar->GetMJob(), PChar->GetMLevel());

            //if cap is 0 then player is using a spell from their subjob
            if (cap == 0)
            {
                cap = GetMaxSkill((SKILLTYPE)PSpell->getSkillType(), PChar->GetSJob(),
                    PChar->GetMLevel()); // This may need to be re-investigated in the future...
            }

            if (skill > cap)
                skill = cap;

            float ratio = (float)cap / skill;
            check *= ratio;

            //prevent from spilling over 100 - resulting in players never being interupted
            if (check > 100) check = 100;

            //apply any merit reduction
            meritReduction = ((CCharEntity*)PDefender)->PMeritPoints->GetMeritValue(MERIT_SPELL_INTERUPTION_RATE, (CCharEntity*)PDefender);
        }

        float interruptRate = ((float)((100.0f - (meritReduction + (float)PDefender->getMod(Mod::SPELLINTERRUPT))) / 100.0f));
        check *= interruptRate;
        uint8 chance = tpzrand::GetRandomNumber(100);

        // caps, always give a 1% chance of interrupt
        if (check < 1) {
            check = 0;
        }

        if (chance < check)
        {
            // Prevent interrupt if Aquaveil is active, if it were to interrupt.
            if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_AQUAVEIL))
            {
                auto aquaCount = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_AQUAVEIL)->GetPower();
                // ShowDebug("Aquaveil counter: %u\n", aquaCount);
                if (aquaCount - 1 == 0) // removes the status, but still prevents the interrupt
                {
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_AQUAVEIL);
                }
                else
                {
                    PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_AQUAVEIL)->SetPower(aquaCount - 1);
                }
                return false;
            }
            //Otherwise interrupt the spell cast.
            return true;
        }

        return false;
    }

    /***********************************************************************
            Calculates the block rate of the defender
    Incorporates testing and data from:
    http://www.ffxiah.com/forum/topic/21671/paladin-faq-info-and-trade-studies/34/#2581818
    https://docs.google.com/spreadsheet/ccc?key=0AkX3maplDraRdFdCZHI2OU93aVgtWlZhN3ozZEtnakE#gid=0
    http://www.ffxionline.com/forums/paladin/55139-shield-data-size-2-vs-size-3-a.html

    Formula is:
    ShieldBaseRate + (DefenderShieldSkill - AttackerCombatSkill) * SkillModifier

    Skill Modifier appears to be 0.215 based on the data available.

    Base block rates are (small to large shield type) 55% -> 50% -> 45% -> 30%
    Aegis is a special case, having the base block rate of a size 2 type.
    ************************************************************************/
    uint8 GetBlockRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        int8 shieldSize = 3;
        int32 base = 0;
        float blockRateMod = (100.0f + PDefender->getMod(Mod::SHIELDBLOCKRATE)) / 100.0f;
        auto weapon = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_MAIN]);
        uint16 attackskill = PAttacker->GetSkill((SKILLTYPE)(weapon ? weapon->getSkillType() : 0));
        uint16 blockskill = PDefender->GetSkill(SKILL_SHIELD);

        if (PDefender->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)PDefender;
            CItemEquipment* PItem = (CItemEquipment*)PChar->getEquip(SLOT_SUB);

            if (PItem)
                shieldSize = PItem->getShieldSize();
            else
                return 0;
        }
        else if (PDefender->objtype == TYPE_MOB && PDefender->GetMJob() == JOB_PLD)
        {
            CMobEntity* PMob = (CMobEntity*)PDefender;
            if (PMob->m_EcoSystem != SYSTEM_UNDEAD && PMob->m_EcoSystem != SYSTEM_BEASTMEN)
                return 0;
        }
        else if (PDefender->objtype == TYPE_PET && static_cast<CPetEntity*>(PDefender)->getPetType() == PETTYPE_AUTOMATON && PDefender->GetMJob() == JOB_PLD)
        {
            float skillmodifier = (PDefender->GetSkill(SKILL_AUTOMATON_MELEE) - attackskill) * 0.215f;
            base = PDefender->getMod(Mod::SHIELDBLOCKRATE);
            if (base <= 0)
                return 0;
            else
                return base + (int32)skillmodifier;
        }
        else
            return 0;

        switch (shieldSize)
        {
            case 1: // buckler
                base = 55;
                break;
            case 2: // round
            case 5: // aegis
                base = 50;
                break;
            case 3: // kite
                base = 45;
                break;
            case 4: // tower
                base = 30;
                break;
            case 6: // ochain
                base = 110;
                break;
            default:
                return 0;
        }

        float skillmodifier = (blockskill - attackskill) * 0.215f;
        return (int8)std::clamp((int32)((base + (int32)skillmodifier) * blockRateMod), 5, (shieldSize == 6 ? 100 : std::max<int32>((int32)(65 * blockRateMod), 100)));
    }

    uint8 GetParryRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        CItemWeapon* PWeapon = GetEntityWeapon(PDefender, SLOT_MAIN);
        if ((PWeapon != nullptr && PWeapon->getID() != 0 && PWeapon->getID() != 65535 &&
            PWeapon->getSkillType() != SKILL_HAND_TO_HAND) && PDefender->PAI->IsEngaged())
        {
            JOBTYPE job = PDefender->GetMJob();

            if (job == JOB_NIN || job == JOB_SAM ||
                job == JOB_THF || job == JOB_BST || job == JOB_DRG ||
                job == JOB_PLD || job == JOB_WAR || job == JOB_BRD ||
                job == JOB_DRK || job == JOB_RDM || job == JOB_COR ||
                job == JOB_DNC || job == JOB_PUP || job == JOB_RUN ||
                job == JOB_BLU || job == JOB_MNK || job == JOB_GEO ||
                job == JOB_SCH)
            {
                // http://wiki.ffxiclopedia.org/wiki/Talk:Parrying_Skill
                // {(Parry Skill x .125) + ([Player Agi - Enemy Dex] x .125)} x Diff

                float skill = (float)(PDefender->GetSkill(SKILL_PARRY) + PDefender->getMod(Mod::PARRY) + PWeapon->getILvlParry());

                float diff = 1.0f + (((float)PDefender->GetMLevel() - PAttacker->GetMLevel()) / 15.0f);

                if (PWeapon->isTwoHanded())
                {
                    // two handed weapons get a bonus
                    diff += 0.1f;
                }

                if (diff < 0.4f) diff = 0.4f;
                if (diff > 1.4f) diff = 1.4f;

                float dex = PAttacker->DEX();
                float agi = PDefender->AGI();

                auto parryRate = std::clamp<uint8>((uint8)((skill * 0.1f + (agi - dex) * 0.125f + 10.0f) * diff), 5, 25);

                // Issekigan grants parry rate bonus. From best available data, if you already capped out at 25% parry it grants another 25% bonus for ~50% parry rate
                if (PDefender->objtype == TYPE_PC && PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ISSEKIGAN)) {
                    int16 issekiganBonus = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_ISSEKIGAN)->GetPower();
                    //ShowDebug(CL_CYAN"GetParryRate: Issekigan Active, Parry Rate %d -> %d...\n" CL_RESET, parryRate, (parryRate+issekiganBonus));
                    parryRate = parryRate + issekiganBonus;
                }

                // Inquartata grants a flat parry rate bonus.
                int16 inquartataBonus = PDefender->getMod(Mod::INQUARTATA);
                parryRate += inquartataBonus;

                return parryRate;
            }
        }

        return 0;
    }

    uint8 GetGuardRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        CItemWeapon* PWeapon = GetEntityWeapon(PDefender, SLOT_MAIN);

        // Defender must have no weapon equipped, or a hand to hand weapon equipped to guard
        bool validWeapon = (PWeapon == nullptr || PWeapon->getSkillType() == SKILL_HAND_TO_HAND);

        if (PDefender->objtype == TYPE_MOB || PDefender->objtype == TYPE_PET) {
            validWeapon = PDefender->GetMJob() == JOB_MNK || PDefender->GetMJob() == JOB_PUP;
        }

        bool hasGuardSkillRank = (GetSkillRank(SKILL_GUARD, PDefender->GetMJob()) > 0 || GetSkillRank(SKILL_GUARD, PDefender->GetSJob()) > 0);

        if (validWeapon && hasGuardSkillRank && PDefender->PAI->IsEngaged())
        {
            // assuming this is like parry
            float skill = (float)PDefender->GetSkill(SKILL_GUARD) + PDefender->getMod(Mod::GUARD);

            if (PWeapon)
                skill += PWeapon->getILvlParry(); //no weapon will ever have ilvl guard and parry

            float diff = 1.0f + (((float)PDefender->GetMLevel() - PAttacker->GetMLevel()) / 15.0f);

            if (diff < 0.4f) diff = 0.4f;
            if (diff > 1.4f) diff = 1.4f;

            float dex = PAttacker->DEX();
            float agi = PDefender->AGI();

            return std::clamp<uint8>((uint8)((skill * 0.1f + (agi - dex) * 0.125f + 10.0f) * diff), 5, 25);
        }

        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Calculates damage based on damage and resistance to damage type      *
    *                                                                       *
    ************************************************************************/

    int32 TakePhysicalDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, PHYSICAL_ATTACK_TYPE physicalAttackType, int32 damage, bool isBlocked, uint8 slot, uint16 tpMultiplier, CBattleEntity* taChar, bool giveTPtoVictim, bool giveTPtoAttacker, bool isCounter)
    {
        auto weapon = GetEntityWeapon(PAttacker, (SLOTTYPE)slot);
        giveTPtoAttacker = giveTPtoAttacker && !PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI);
        giveTPtoVictim = giveTPtoVictim && physicalAttackType != PHYSICAL_ATTACK_TYPE::DAKEN;
        bool isRanged = (slot == SLOT_AMMO || slot == SLOT_RANGED);
        int32 baseDamage = damage;
        ATTACKTYPE attackType = ATTACK_PHYSICAL;
        DAMAGETYPE damageType = DAMAGE_NONE;
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_FORMLESS_STRIKES) && !isCounter)
        {
            attackType = ATTACK_SPECIAL;
            uint8 formlessMod = 70;

            if (PAttacker->objtype == TYPE_PC)
                formlessMod += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_FORMLESS_STRIKES, (CCharEntity*)PAttacker);

            damage = damage * formlessMod / 100;

            // TODO: chance to 'resist'

            damage = MagicDmgTaken(PDefender, damage, ELEMENT_NONE);
        }
        else
        {
            damageType = (DAMAGETYPE)(weapon ? weapon->getDmgType() : 0);

            if (isRanged)
            {
                attackType = ATTACK_RANGED;
                damage = RangedDmgTaken(PDefender, damage, damageType);
            }
            else
            {
                damage = PhysicalDmgTaken(PDefender, damage, damageType);
            }

            //absorb mods are handled in the above functions, but they do not affect counters
            //this is a little hacky, but will work for now
            if (damage < 0 && isCounter)
                damage = -damage;

            if (!isCounter || giveTPtoAttacker) // counters are always considered blunt (assuming h2h) damage, except retaliation (which is the only counter that gives TP to the attacker)
            {
                switch (damageType)
                {
                    case DAMAGE_PIERCING: damage = (damage * (PDefender->getMod(Mod::PIERCERES))) / 1000; break;
                    case DAMAGE_SLASHING: damage = (damage * (PDefender->getMod(Mod::SLASHRES))) / 1000; break;
                    case DAMAGE_IMPACT:   damage = (damage * (PDefender->getMod(Mod::IMPACTRES))) / 1000; break;
                    case DAMAGE_HTH:      damage = (damage * (PDefender->getMod(Mod::HTHRES))) / 1000; break;
                    default:
                        break;
                }
            }
            else
                damage = (damage * (PDefender->getMod(Mod::HTHRES))) / 1000;

            if (isBlocked)
            {
                uint8 absorb = 100;
                if (PDefender->m_Weapons[SLOT_SUB]->IsShield())
                {
                    if (PDefender->objtype == TYPE_PC)
                    {
                        absorb = std::clamp(100 - PDefender->m_Weapons[SLOT_SUB]->getShieldAbsorption(), 0, 100);
                        absorb -= PDefender->getMod(Mod::SHIELD_DEF_BONUS); // Include Shield Defense Bonus in absorb amount

                        // Shield Mastery
                        if ((std::max(damage - (PDefender->getMod(Mod::PHALANX) + PDefender->getMod(Mod::STONESKIN)), 0) > 0)
                            && charutils::hasTrait((CCharEntity*)PDefender, TRAIT_SHIELD_MASTERY))
                        {
                            // If the player blocked with a shield and has shield mastery, add shield mastery TP bonus
                            // unblocked damage (before block but as if affected by stoneskin/phalanx) must be greater than zero
                            PDefender->addTP(PDefender->getMod(Mod::SHIELD_MASTERY_TP));
                        }
                    }
                    else if (PDefender->objtype == TYPE_PET)
                    {
                        absorb = 50;

                        //Shield Mastery
                        if ((std::max(damage - (PDefender->getMod(Mod::PHALANX) + PDefender->getMod(Mod::STONESKIN)), 0) > 0)
                            && (PDefender->getMod(Mod::SHIELD_MASTERY_TP)))
                        {
                            // If the player blocked with a shield and has shield mastery, add shield mastery TP bonus
                            // unblocked damage (before block but as if affected by stoneskin/phalanx) must be greater than zero
                            PDefender->addTP(PDefender->getMod(Mod::SHIELD_MASTERY_TP));
                        }
                    }
                    else
                    {
                        absorb = 50;
                    }

                    //Reprisal
                    if ((damage > 0) && PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_REPRISAL))
                    {
                        // Reflect a portion of the blocked damage back. This is calculated before Stoneskin, Phalanx, Sentinel or Invincible
                        // Subpower is the remaining damage that can be reflected. When it reaches 0 the effect ends
                        CStatusEffect* reprisalEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_REPRISAL);
                        int32 blockedDamage = (damage * (100 - absorb)) / 100;
                        if (PDefender->StatusEffectContainer->HasStatusEffect({EFFECT_INVINCIBLE, EFFECT_SENTINEL}))
                        {
                            blockedDamage = (baseDamage * (100 - absorb)) / 100;
                        }
                        // Subpower is the remaining damage that can be reflected. When it reaches 0 the effect ends
                        // Set Reprisal spike damage
                        PDefender->setModifier(Mod::SPIKES_DMG, std::clamp<int16>((blockedDamage * (reprisalEffect->GetPower())) / 100,
                            0, reprisalEffect->GetSubPower()));
                    }
                }

                damage = (damage * absorb) / 100;
            }
        }
        if (damage > 0)
        {
            damage = std::max(damage - PDefender->getMod(Mod::PHALANX), 0);

            damage = HandleStoneskin(PDefender, damage);
            HandleAfflatusMiseryDamage(PDefender, damage);
        }
        damage = std::clamp(damage, -99999, 99999);

        int32 corrected = PDefender->takeDamage(damage, PAttacker, attackType, damageType);
        if (damage < 0)
            damage = -corrected;

        battleutils::ClaimMob(PDefender, PAttacker);

        if (damage > 0)
        {
            PDefender->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);

            // Check for bind breaking
            BindBreakCheck(PAttacker, PDefender);

            switch (PDefender->objtype)
            {
                case TYPE_MOB:
                    if (taChar == nullptr)
                        ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(PAttacker, damage);
                    else
                        ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(taChar, damage);

                    if (((CMobEntity*)PDefender)->m_HiPCLvl < PAttacker->GetMLevel())
                    {
                        ((CMobEntity*)PDefender)->m_HiPCLvl = PAttacker->GetMLevel();
                    }

                    //if the mob is charmed by player
                    if (PDefender->PMaster != nullptr && PDefender->PMaster->objtype == TYPE_PC)
                        ((CPetEntity*)PDefender)->loc.zone->PushPacket(PDefender, CHAR_INRANGE, new CEntityUpdatePacket(PDefender, ENTITY_UPDATE, UPDATE_COMBAT));

                    break;

                case TYPE_PET:
                    ((CPetEntity*)PDefender)->loc.zone->PushPacket(PDefender, CHAR_INRANGE, new CEntityUpdatePacket(PDefender, ENTITY_UPDATE, UPDATE_COMBAT));
                    break;
                case TYPE_PC:
                    if (PAttacker->objtype == TYPE_MOB)
                    {
                        ((CMobEntity*)PAttacker)->PEnmityContainer->UpdateEnmityFromAttack(PDefender, damage);
                    }
                    break;
                default:
                    break;
            }

            // try to interrupt spell if not a ranged attack and not blocked by Shield Mastery
            if ((!isRanged)
                && !((isBlocked) && (PDefender->objtype == TYPE_PC) && (charutils::hasTrait((CCharEntity*)PDefender, TRAIT_SHIELD_MASTERY))))
            {
                PDefender->TryHitInterrupt(PAttacker);
            }

            int16 baseTp = 0;

            if ((slot == SLOT_RANGED || slot == SLOT_AMMO) && PAttacker->objtype == TYPE_PC)
            {
                int16 delay = PAttacker->GetRangedWeaponDelay(true);

                baseTp = CalculateBaseTP((delay * 120) / 1000);

            }
            else
            {
                int16 delay = PAttacker->GetWeaponDelay(true);
                auto sub_weapon = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_SUB]);

                if (sub_weapon && sub_weapon->getDmgType() > 0 &&
                    sub_weapon->getDmgType() < 4 &&
                    weapon->getSkillType() != SKILL_HAND_TO_HAND)
                {
                    delay = delay / 2;
                }

                float ratio = 1.0f;

                if (weapon->getSkillType() == SKILL_HAND_TO_HAND)
                    ratio = 2.0f;

                baseTp = CalculateBaseTP((int16)(delay * 60.0f / 1000.0f / ratio));
            }


            if (giveTPtoAttacker)
            {
                if (PAttacker->objtype == TYPE_PC && physicalAttackType == PHYSICAL_ATTACK_TYPE::ZANSHIN)
                {
                    baseTp += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_IKISHOTEN, (CCharEntity*)PAttacker);
                }

                PAttacker->addTP((int16)(tpMultiplier * (baseTp * (1.0f + 0.01f * (float)((PAttacker->getMod(Mod::STORETP) + getStoreTPbonusFromMerit(PAttacker)))))));
            }

            if (giveTPtoVictim)
            {
                //account for attacker's subtle blow which reduces the baseTP gain for the defender
                float sBlowMult = ((100.0f - std::clamp((float)PAttacker->getMod(Mod::SUBTLE_BLOW), 0.0f, 50.0f)) / 100.0f);

                //mobs hit get basetp+30 whereas pcs hit get basetp/3
                if (PDefender->objtype == TYPE_PC || (PDefender->objtype == TYPE_PET && PDefender->PMaster && PDefender->PMaster->objtype == TYPE_PC))
                {
                    PDefender->addTP((int16)(tpMultiplier * ((baseTp / 3) * sBlowMult * (1.0f + 0.01f * (float)((PDefender->getMod(Mod::STORETP) + getStoreTPbonusFromMerit(PAttacker))))))); //yup store tp counts on hits taken too!
                }
                else
                    PDefender->addTP((uint16)(tpMultiplier * ((baseTp + 30) * sBlowMult * (1.0f + 0.01f * (float)PDefender->getMod(Mod::STORETP))))); //subtle blow also reduces the "+30" on mob tp gain
            }
        }
        else if (PDefender->objtype == TYPE_MOB)
            ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(PAttacker, 0);

        if (PAttacker->objtype == TYPE_PC && !isRanged)
            PAttacker->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ATTACK);

        return damage;
    }

    /************************************************************************
    *                                                                       *
    *  Handles Damage from Weaponskills (dmg type reductions calced in lua) *
    *                                                                       *
    ************************************************************************/

    int32 TakeWeaponskillDamage(CCharEntity* PAttacker, CBattleEntity* PDefender, int32 damage, ATTACKTYPE attackType, DAMAGETYPE damageType, uint8 slot, bool primary, float tpMultiplier, uint16 bonusTP, float targetTPMultiplier)
    {
        auto weapon = GetEntityWeapon(PAttacker, (SLOTTYPE)slot);
        bool isRanged = (slot == SLOT_AMMO || slot == SLOT_RANGED);

        if (damage > 0)
        {
            damage = std::max(damage - PDefender->getMod(Mod::PHALANX), 0);
            damage = HandleStoneskin(PDefender, damage);
        }

        if (!isRanged)
        {
            damage = getOverWhelmDamageBonus(PAttacker, PDefender, damage);
        }

        HandleAfflatusMiseryDamage(PDefender, damage);
        damage = std::clamp(damage, -99999, 99999);

        int32 corrected = PDefender->takeDamage(damage, PAttacker, attackType, damageType);
        if (damage < 0)
            damage = -corrected;

        if (PAttacker->objtype == TYPE_PC)
        {
            battleutils::ClaimMob(PDefender, PAttacker);
        }

        int16 standbyTp = 0;

        if (damage > 0)
        {
            PDefender->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);

            // Check for bind breaking
            BindBreakCheck(PAttacker, PDefender);

            switch (PDefender->objtype)
            {
                case TYPE_MOB:
                    //if the mob is charmed by player
                    if (PDefender->PMaster != nullptr && PDefender->PMaster->objtype == TYPE_PC)
                        ((CPetEntity*)PDefender)->loc.zone->PushPacket(PDefender, CHAR_INRANGE, new CEntityUpdatePacket(PDefender, ENTITY_UPDATE, UPDATE_COMBAT));

                    if (((CMobEntity*)PDefender)->m_HiPCLvl < PAttacker->GetMLevel())
                    {
                        ((CMobEntity*)PDefender)->m_HiPCLvl = PAttacker->GetMLevel();
                    }

                    break;

                case TYPE_PET:
                    ((CPetEntity*)PDefender)->loc.zone->PushPacket(PDefender, CHAR_INRANGE, new CEntityUpdatePacket(PDefender, ENTITY_UPDATE, UPDATE_COMBAT));
                    break;

                default:
                    break;
            }

            // try to interrupt spell
            PDefender->TryHitInterrupt(PAttacker);

            int16 baseTp = 0;

            if (isRanged)
            {
                int16 delay = PAttacker->GetRangedWeaponDelay(true);
                baseTp = CalculateBaseTP((delay * 120) / 1000);
            }
            else
            {
                int16 delay = PAttacker->GetWeaponDelay(true);

                auto sub_weapon = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_SUB]);

                if (sub_weapon && sub_weapon->getDmgType() > 0 &&
                    sub_weapon->getDmgType() < 4 &&
                    weapon->getSkillType() != SKILL_HAND_TO_HAND)
                {
                    delay /= 2;
                }

                float ratio = 1.0f;

                if (weapon && weapon->getSkillType() == SKILL_HAND_TO_HAND)
                    ratio = 2.0f;

                baseTp = (int16)(CalculateBaseTP((delay * 60) / 1000) / ratio);
            }


            // add tp to attacker
            if (primary)
            // Calculate TP Return from WS
            {
                standbyTp = ((int16)(((tpMultiplier * baseTp) + bonusTP) * (1.0f + 0.01f * (float)((PAttacker->getMod(Mod::STORETP) + getStoreTPbonusFromMerit(PAttacker))))));
            }

            //account for attacker's subtle blow which reduces the baseTP gain for the defender
            float sBlowMult = ((100.0f - std::clamp((float)PAttacker->getMod(Mod::SUBTLE_BLOW), 0.0f, 50.0f)) / 100.0f);

            //mobs hit get basetp+30 whereas pcs hit get basetp/3
            if (PDefender->objtype == TYPE_PC)
                PDefender->addTP((int16)(tpMultiplier * targetTPMultiplier * ((baseTp / 3) * sBlowMult * (1.0f + 0.01f * (float)((PDefender->getMod(Mod::STORETP) + getStoreTPbonusFromMerit(PAttacker))))))); //yup store tp counts on hits taken too!
            else
                PDefender->addTP((int16)(tpMultiplier * targetTPMultiplier * ((baseTp + 30) * sBlowMult * (1.0f + 0.01f * (float)PDefender->getMod(Mod::STORETP))))); //subtle blow also reduces the "+30" on mob tp gain
        }
        else if (PDefender->objtype == TYPE_MOB)
            ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(PAttacker, 0);

        if (!isRanged)
            PAttacker->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ATTACK);

        // Apply TP
        PAttacker->addTP(std::max((PAttacker->getMod(Mod::SAVETP)), standbyTp));

        // Remove Hagakure Effect if present
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_HAGAKURE))
        {
            PAttacker->StatusEffectContainer->DelStatusEffect(EFFECT_HAGAKURE);
        }

        return damage;
    }


    /************************************************************************
    *                                                                       *
    *  Handles Damage from Spells (dmg type reductions calced in lua)       *
    *                                                                       *
    ************************************************************************/

    int32 TakeSpellDamage(CBattleEntity* PDefender, CCharEntity* PAttacker, CSpell* PSpell, int32 damage, ATTACKTYPE attackType, DAMAGETYPE damageType)
    {
        PDefender->takeDamage(damage, PAttacker, attackType, damageType);

        // Remove effects from damage
        if (PSpell->canTargetEnemy() && damage > 0 && PSpell->dealsDamage())
        {
            PDefender->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);
            // Check for bind breaking
            BindBreakCheck(PAttacker, PDefender);

            // Do we get TP for damaging spells?
            int16 tp = battleutils::CalculateSpellTP(PAttacker, PSpell);
            PAttacker->addTP(tp);
        }

        return damage;
    }

    /************************************************************************
    *                                                                       *
    *  Calculate Probability attack will hit (20% min cap - 95% max cap)    *
    *  attackNumber: 0=main, 1=sub, 2=kick                                  *
    *                                                                       *
    ************************************************************************/

    uint8 GetHitRateEx(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber, int8 offsetAccuracy) //subWeaponAttack is for calculating acc of dual wielded sub weapon
    {
        int32 hitrate = 75;

        if (PAttacker->objtype == TYPE_PC && ((PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK_ATTACK) && (abs(PDefender->loc.p.rotation - PAttacker->loc.p.rotation) < 23 || PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE))) ||
            (charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_ASSASSIN) && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK) && battleutils::getAvailableTrickAttackChar(PAttacker, PDefender))))
        {
            hitrate = 100; //attack with SA active or TA/Assassin cannot miss
        }
        else
        {
            //ShowDebug("Accuracy mod before direction checks: %d\n", offsetAccuracy);
            //Check For Ambush Merit - Melee
            if (PAttacker->objtype == TYPE_PC && (charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_AMBUSH)) && ((abs(PDefender->loc.p.rotation - PAttacker->loc.p.rotation) < 23)))
            {
                offsetAccuracy += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_AMBUSH, (CCharEntity*)PAttacker);
            }
            // Check for Closed Position merit on attacker and that attacker and defender are facing each other (within ~20 degrees from straight on)
            if (PAttacker->objtype == TYPE_PC && (charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_CLOSED_POSITION)) && ((abs(abs(PDefender->loc.p.rotation - PAttacker->loc.p.rotation) - 128) < 15)))
            {
                offsetAccuracy += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_CLOSED_POSITION, (CCharEntity*)PAttacker);
            }
            // Check for Closed Position merit on defender that attacker and defender are facing each other (within ~20 degrees from straight on)
            if (PDefender->objtype == TYPE_PC && (charutils::hasTrait((CCharEntity*)PDefender, TRAIT_CLOSED_POSITION)) && ((abs(abs(PDefender->loc.p.rotation - PAttacker->loc.p.rotation) - 128) < 15)))
            {
                offsetAccuracy -= ((CCharEntity*)PDefender)->PMeritPoints->GetMeritValue(MERIT_CLOSED_POSITION, (CCharEntity*)PDefender);
            }
            // Check for Innin accuracy bonus from behind target
            if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_INNIN) && ((abs(PDefender->loc.p.rotation - PAttacker->loc.p.rotation) < 23)))
            {
                offsetAccuracy += PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_INNIN)->GetPower();
            }
            // Check for Yonin evasion bonus while in front of target
            if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_YONIN) && ((abs(abs(PAttacker->loc.p.rotation - PDefender->loc.p.rotation) - 128) < 23)))
            {
                offsetAccuracy -= PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_YONIN)->GetPower();
            }
            //ShowDebug("Accuracy mod after direction checks: %d\n", offsetAccuracy);

            hitrate = hitrate + (PAttacker->ACC(attackNumber, offsetAccuracy) - PDefender->EVA()) / 2 + (PAttacker->GetMLevel() - PDefender->GetMLevel()) * 2;

            if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_ENLIGHT))
            {
                hitrate += PAttacker->getMod(Mod::ENSPELL_DMG);
            }

            hitrate = std::clamp(hitrate, 20, 95);
        }
        return (uint8)hitrate;
    }
    uint8 GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        return GetHitRateEx(PAttacker, PDefender, 0, 0); //assume attack 0(main)
    }
    uint8 GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber)
    {
        return GetHitRateEx(PAttacker, PDefender, attackNumber, 0);
    }
    uint8 GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber, int8 offsetAccuracy)
    {
        return GetHitRateEx(PAttacker, PDefender, attackNumber, offsetAccuracy);
    }

    /************************************************************************
    *                                                                       *
    *  Crit Rate                                                            *
    *                                                                       *
    ************************************************************************/

    uint8 GetCritHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool ignoreSneakTrickAttack)
    {
        int32 crithitrate = 5;
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_MIGHTY_STRIKES, 0) ||
            PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_MIGHTY_STRIKES)) {
            return 100;
        }
        else if (PAttacker->objtype == TYPE_PC && (!ignoreSneakTrickAttack) && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK_ATTACK))
        {

            if (abs(PDefender->loc.p.rotation - PAttacker->loc.p.rotation) < 23 || PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE))
            {
                crithitrate = 100;
            }
        }
        else if (PAttacker->objtype == TYPE_PC && PAttacker->GetMJob() == JOB_THF && charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_ASSASSIN) && (!ignoreSneakTrickAttack) &&
            PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK))
        {
            CBattleEntity* taChar = battleutils::getAvailableTrickAttackChar(PAttacker, PDefender);
            if (taChar != nullptr) crithitrate = 100;
        }
        else
        {
            //apply merit mods and traits
            if (PAttacker->objtype == TYPE_PC)
            {
                CCharEntity* PCharAttacker = static_cast<CCharEntity*>(PAttacker);
                crithitrate += PCharAttacker->PMeritPoints->GetMeritValue(MERIT_CRIT_HIT_RATE, PCharAttacker);

                // Add Fencer crit hit rate
                CItemWeapon* PMain = dynamic_cast<CItemWeapon*>(PCharAttacker->m_Weapons[SLOT_MAIN]);
                CItemWeapon* PSub = dynamic_cast<CItemWeapon*>(PCharAttacker->m_Weapons[SLOT_SUB]);
                if (PMain && !PMain->isTwoHanded() && !PMain->isHandToHand() &&
                    (!PSub || PSub->getSkillType() == SKILL_NONE || PCharAttacker->m_Weapons[SLOT_SUB]->IsShield()))
                {
                    crithitrate += PCharAttacker->getMod(Mod::FENCER_CRITHITRATE);
                }
            }

            if (PDefender->objtype == TYPE_PC) crithitrate -= ((CCharEntity*)PDefender)->PMeritPoints->GetMeritValue(MERIT_ENEMY_CRIT_RATE, (CCharEntity*)PDefender);
            //ShowDebug("Crit rate mod before Innin/Yonin: %d\n", crithitrate);
            // Check for Innin crit rate bonus from behind target
            if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_INNIN) && ((abs(PDefender->loc.p.rotation - PAttacker->loc.p.rotation) < 23)))
            {
                crithitrate += PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_INNIN)->GetPower();
            }
            // Check for Yonin crit rate bonus while in front of target
            if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_YONIN) && ((abs(abs(PAttacker->loc.p.rotation - PDefender->loc.p.rotation) - 128) < 23)))
            {
                crithitrate -= PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_YONIN)->GetPower();
            }
            //ShowDebug("Crit rate mod after Innin/Yonin: %d\n", crithitrate);

            int32 attackerdex = PAttacker->DEX();
            int32 defenderagi = PDefender->AGI();

            int32 dDEX = std::clamp(attackerdex - defenderagi, 0, 50);

            crithitrate += (dDEX * 30) / 100 + PAttacker->getMod(Mod::CRITHITRATE) + PDefender->getMod(Mod::ENEMYCRITRATE);
            crithitrate = std::clamp(crithitrate, 0, 100);
        }
        return (uint8)crithitrate;
    }

    /************************************************************************
    *                                                                       *
    *   Formula for calculating damage ratio                                *
    *                                                                       *
    ************************************************************************/

    float GetDamageRatio(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isCritical, float bonusAttPercent)
    {
        // used to apply a % of attack bonus
        float attPercentBonus = 0;
        if (bonusAttPercent >= 1)
            attPercentBonus = PAttacker->ATT() * bonusAttPercent;

        //wholly possible for DEF to be near 0 with the amount of debuffs/effects now.
        float ratio = (float)(PAttacker->ATT() + attPercentBonus) / (float)((PDefender->DEF() == 0) ? 1 : PDefender->DEF());
        float cRatioMax = 0;
        float cRatioMin = 0;
        float ratioCap = 2.0f;

        if (PAttacker->objtype == TYPE_PC)
        {
            ratioCap = isCritical ? 3 : 2.25f;
        }
        if (PAttacker->objtype == TYPE_MOB)
        {
            ratioCap = 4.f;
        }

        ratio = std::clamp<float>(ratio, 0, ratioCap);
        float cRatio = ratio;
        if (PAttacker->objtype == TYPE_PC)
        {
            if (PAttacker->GetMLevel() < PDefender->GetMLevel())
            {
                cRatio -= 0.050f * (PDefender->GetMLevel() - PAttacker->GetMLevel());
            }
        }
        else
        {
            if (PAttacker->GetMLevel() > PDefender->GetMLevel())
            {
                cRatio += 0.050f * (PAttacker->GetMLevel() - PDefender->GetMLevel());
            }
        }

        if (isCritical)
        {
            cRatio += 1;
        }

        cRatio = std::clamp<float>(cRatio, 0, ratioCap);

        if ((0 <= cRatio) && (cRatio < 0.5)) {
            cRatioMax = cRatio + 0.5f;
        }
        else if ((0.5 <= cRatio) && (cRatio <= 0.7)) {
            cRatioMax = 1;
        }
        else if ((0.7 < cRatio) && (cRatio <= 1.2)) {
            cRatioMax = cRatio + 0.3f;
        }
        else if ((1.2 < cRatio) && (cRatio <= 1.5)) {
            cRatioMax = (cRatio * 0.25f) + cRatio;
        }
        else if ((1.5 < cRatio) && (cRatio <= 2.625)) {
            cRatioMax = cRatio + 0.375f;
        }
        else if ((2.625 < cRatio) && (cRatio <= 3.25)) {
            cRatioMax = 3;
        }
        else {
            cRatioMax = cRatio;
        }

        if ((0 <= cRatio) && (cRatio < 0.38)) {
            cRatioMin = 0;
        }
        else if ((0.38 <= cRatio) && (cRatio <= 1.25)) {
            cRatioMin = cRatio * (float)(1176 / 1024) - (float)(448 / 1024);
        }
        else if ((1.25 < cRatio) && (cRatio <= 1.51)) {
            cRatioMin = 1;
        }
        else if ((1.51 < cRatio) && (cRatio <= 2.44)) {
            cRatioMin = cRatio * (float)(1176 / 1024) - (float)(775 / 1024);
        }
        else {
            cRatioMin = cRatio - 0.375f;
        }

        float pDIF = tpzrand::GetRandomNumber(cRatioMin, cRatioMax);

        if (isCritical)
        {
            int16 criticaldamage = PAttacker->getMod(Mod::CRIT_DMG_INCREASE) - PDefender->getMod(Mod::CRIT_DEF_BONUS);
            criticaldamage = std::clamp<int16>(criticaldamage, 0, 100);
            pDIF *= ((100 + criticaldamage) / 100.0f);
        }

        //x1.00 ~ x1.05 final multiplier, giving max value 3*1.05 -> 3.15
        return pDIF * tpzrand::GetRandomNumber(1.f, 1.05f);
    }

    /************************************************************************
    *   Formula for Strength                                                *
    ************************************************************************/

    int32 GetFSTR(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 SlotID)
    {
        int32 rank = 0;
        int32 fstr = 0;
        float dif = (float)(PAttacker->STR() - PDefender->VIT());
        if (dif >= 12) {
            fstr = (int32)((dif + 4) / 2);
        }
        else if (dif >= 6) {
            fstr = (int32)((dif + 6) / 2);
        }
        else if (dif >= 1) {
            fstr = (int32)((dif + 7) / 2);
        }
        else if (dif >= -2) {
            fstr = (int32)((dif + 8) / 2);
        }
        else if (dif >= -7) {
            fstr = (int32)((dif + 9) / 2);
        }
        else if (dif >= -15) {
            fstr = (int32)((dif + 10) / 2);
        }
        else if (dif >= -21) {
            fstr = (int32)((dif + 12) / 2);
        }
        else {
            fstr = (int32)((dif + 13) / 2);
        }
        if (SlotID == SLOT_RANGED)
        {
            rank = PAttacker->GetRangedWeaponRank();
            //different caps than melee weapons
            if (fstr <= (-rank * 2))
                return (-rank * 2);

            if ((fstr > (-rank * 2)) && (fstr <= (2 * (rank + 8))))
                return fstr;

            else
                return 2 * (rank + 8);
        }
        else
        {
            fstr /= 2;
            if (SlotID == SLOT_MAIN)
            {
                rank = PAttacker->GetMainWeaponRank();
            }
            else if (SlotID == SLOT_SUB)
            {
                rank = PAttacker->GetSubWeaponRank();
            }
            // everything else
            if (fstr <= (-rank))
                return (-rank);

            if ((fstr > (-rank)) && (fstr <= rank + 8))
                return fstr;
            else
                return rank + 8;
        }
    }

    /************************************************************************
    *                                                                       *
    *  Multihit calculator                                                  *
    *                                                                       *
    ************************************************************************/

    uint8 getHitCount(uint8 hits)
    {
        uint8 distribution = tpzrand::GetRandomNumber(100);
        uint8 num = 1;

        switch (hits)
        {
            case 0: break;
            case 1: break;
            case 2: // cdf = 55,100
                if (distribution < 55) { break; }
                else { num += 1; break; }
                break;
            case 3: // cdf = 30,80,100
                if (distribution < 30) { break; }
                else if (distribution < 80) { num += 1; break; }
                else { num += 2; break; }
                break;
            case 4: // cdf = 20,50,80,100
                if (distribution < 20) { break; }
                else if (distribution < 50) { num += 1; break; }
                else if (distribution < 80) { num += 2; break; }
                else { num += 3; break; }
                break;
            case 5: // cdf = 10,30,60,90,100
                if (distribution < 10) { break; }
                else if (distribution < 30) { num += 1; break; }
                else if (distribution < 60) { num += 2; break; }
                else if (distribution < 90) { num += 3; break; }
                else { num += 4; break; }
                break;
            case 6: // cdf = 10,30,50,70,90,100
                if (distribution < 10) { break; }
                else if (distribution < 30) { num += 1; break; }
                else if (distribution < 50) { num += 2; break; }
                else if (distribution < 70) { num += 3; break; }
                else if (distribution < 90) { num += 4; break; }
                else { num += 5; break; }
                break;
            case 7: // cdf = 5,20,45,70,85,95,100
                if (distribution < 5) { break; }
                else if (distribution < 20) { num += 1; break; }
                else if (distribution < 45) { num += 2; break; }
                else if (distribution < 70) { num += 3; break; }
                else if (distribution < 85) { num += 4; break; }
                else if (distribution < 95) { num += 5; break; }
                else { num += 6; break; }
                break;
            case 8: // cdf = 5,20,45,70,85,95,98,100
                if (distribution < 5) { break; }
                else if (distribution < 20) { num += 1; break; }
                else if (distribution < 45) { num += 2; break; }
                else if (distribution < 70) { num += 3; break; }
                else if (distribution < 85) { num += 4; break; }
                else if (distribution < 95) { num += 5; break; }
                else if (distribution < 98) { num += 6; break; }
                else { num += 7; break; }
                break;
        }
        return std::min<uint8>(num, 8); // No more than eight hits per attack
    }

    /************************************************************************
    *                                                                       *
    *  Returns the number of hits for multihit weapons if applicable        *
    *  (Keeping this for backwards compatibility with the old system)       *
    ************************************************************************/

    uint8 CheckMultiHits(CBattleEntity* PEntity, CItemWeapon* PWeapon)
    {
        if (!PWeapon)
            return 0;

        //checking players weapon hit count
        uint8 num = PWeapon->getHitCount();

        int16 tripleAttack = PEntity->getMod(Mod::TRIPLE_ATTACK);
        int16 doubleAttack = PEntity->getMod(Mod::DOUBLE_ATTACK);
        int16 quadAttack = PEntity->getMod(Mod::QUAD_ATTACK);

        //check for merit upgrades
        if (PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)PEntity;

            //merit chance only applies if player has the job trait
            if (charutils::hasTrait(PChar, TRAIT_TRIPLE_ATTACK)) {
                tripleAttack += PChar->PMeritPoints->GetMeritValue(MERIT_TRIPLE_ATTACK_RATE, (CCharEntity*)PEntity);
            }
            if (charutils::hasTrait(PChar, TRAIT_DOUBLE_ATTACK)) {
                doubleAttack += PChar->PMeritPoints->GetMeritValue(MERIT_DOUBLE_ATTACK_RATE, (CCharEntity*)PEntity);
            }
        }

        quadAttack = std::clamp<int16>(quadAttack, 0, 100);
        doubleAttack = std::clamp<int16>(doubleAttack, 0, 100);
        tripleAttack = std::clamp<int16>(tripleAttack, 0, 100);

        if (tpzrand::GetRandomNumber(100) < quadAttack)
        {
            num += 3;
        }
        else if (tpzrand::GetRandomNumber(100) < tripleAttack)
        {
            num += 2;
        }
        else if (tpzrand::GetRandomNumber(100) < doubleAttack)
        {
            num += 1;
        }

        // hasso occasionally triggers Zanshin after landing a normal attack, only active while Samurai is set as Main
        if (PEntity->GetMJob() == JOB_SAM)
        {
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_HASSO))
            {
                uint16 zanshin = PEntity->getMod(Mod::ZANSHIN);
                if (PEntity->objtype == TYPE_PC)
                    zanshin += ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_ZASHIN_ATTACK_RATE, (CCharEntity*)PEntity);

                if (tpzrand::GetRandomNumber(100) < (zanshin / 4))
                    num++;
            }
        }
        return std::min<uint8>(num, 8);
    }

    /************************************************************************
    *                                                                       *
    *  Chance paralysis will cause you to be paralyzed                      *
    *                                                                       *
    ************************************************************************/

    bool IsParalyzed(CBattleEntity* PAttacker)
    {
        return (tpzrand::GetRandomNumber(100) < std::clamp(PAttacker->getMod(Mod::PARALYZE) - PAttacker->getMod(Mod::PARALYZERES), 0, 100));
    }

    /************************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    bool IsAbsorbByShadow(CBattleEntity* PDefender)
    {
        //utsus always overwrites blink, so if utsus>0 then we know theres no blink.
        uint16 Shadow = PDefender->getMod(Mod::UTSUSEMI);
        Mod modShadow = Mod::UTSUSEMI;
        if (Shadow == 0)
        {
            Shadow = PDefender->getMod(Mod::BLINK);
            modShadow = Mod::BLINK;
            //random chance, assume 80% proc
            if (tpzrand::GetRandomNumber(100) < 20)
            {
                return false;
            }
        }

        if (Shadow > 0)
        {
            PDefender->setModifier(modShadow, --Shadow);

            if (Shadow == 0)
            {
                switch (modShadow)
                {
                    case Mod::UTSUSEMI:
                        PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_COPY_IMAGE);
                        break;
                    case Mod::BLINK:
                        PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_BLINK);
                        break;
                    default:
                        break;
                }
            }
            else if (Shadow < 4 && Mod::UTSUSEMI == modShadow)
            {
                if (PDefender->objtype == TYPE_PC)
                {
                    CStatusEffect* PStatusEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_COPY_IMAGE);

                    if (PStatusEffect != nullptr)
                    {
                        uint16 icon = EFFECT_COPY_IMAGE_3;
                        switch (Shadow)
                        {
                            case 1: icon = EFFECT_COPY_IMAGE_1; break;
                            case 2: icon = EFFECT_COPY_IMAGE_2; break;
                        }
                        PStatusEffect->SetIcon(icon);
                        PDefender->StatusEffectContainer->UpdateStatusIcons();
                    }
                }
            }
            return true;
        }

        return false;
    }

    /************************************************************************
    *                                                                       *
    *  Intimidation from Killer Effects (chance to intimidate)              *
    *                                                                       *
    ************************************************************************/

    bool IsIntimidated(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        // cannot intimidate yourself!
        if (PAttacker == PDefender) return false;

        int16 KillerEffect = 0;

        switch (PAttacker->m_EcoSystem)
        {
            case SYSTEM_AMORPH:     KillerEffect = PDefender->getMod(Mod::AMORPH_KILLER);   break;
            case SYSTEM_AQUAN:      KillerEffect = PDefender->getMod(Mod::AQUAN_KILLER);    break;
            case SYSTEM_ARCANA:     KillerEffect = PDefender->getMod(Mod::ARCANA_KILLER);   break;
            case SYSTEM_BEAST:      KillerEffect = PDefender->getMod(Mod::BEAST_KILLER);    break;
            case SYSTEM_BIRD:       KillerEffect = PDefender->getMod(Mod::BIRD_KILLER);     break;
            case SYSTEM_DEMON:      KillerEffect = PDefender->getMod(Mod::DEMON_KILLER);    break;
            case SYSTEM_DRAGON:     KillerEffect = PDefender->getMod(Mod::DRAGON_KILLER);   break;
            case SYSTEM_EMPTY:      KillerEffect = PDefender->getMod(Mod::EMPTY_KILLER);    break;
            case SYSTEM_HUMANOID:   KillerEffect = PDefender->getMod(Mod::HUMANOID_KILLER); break;
            case SYSTEM_LIZARD:     KillerEffect = PDefender->getMod(Mod::LIZARD_KILLER);   break;
            case SYSTEM_LUMINION:   KillerEffect = PDefender->getMod(Mod::LUMINION_KILLER); break;
            case SYSTEM_LUMORIAN:   KillerEffect = PDefender->getMod(Mod::LUMORIAN_KILLER); break;
            case SYSTEM_PLANTOID:   KillerEffect = PDefender->getMod(Mod::PLANTOID_KILLER); break;
            case SYSTEM_UNDEAD:     KillerEffect = PDefender->getMod(Mod::UNDEAD_KILLER);   break;
            case SYSTEM_VERMIN:     KillerEffect = PDefender->getMod(Mod::VERMIN_KILLER);   break;
            default: break;
        }

        // Add intimidation rate from Bully
        if (CStatusEffect* PDoubtEffect = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_DOUBT))
        {
            KillerEffect += PDoubtEffect->GetPower();
        }

        return (tpzrand::GetRandomNumber(100) < KillerEffect);
    }

    /************************************************************************
    *                                                                       *
    *  Gets SkillChain Effect                                               *
    *                                                                       *
    ************************************************************************/
#define PAIR(x, y) ((x << 8) + y)

    uint8 GetSkillchainSubeffect(SKILLCHAIN_ELEMENT skillchain)
    {
        TPZ_DEBUG_BREAK_IF(skillchain < SC_NONE || skillchain > SC_DARKNESS_II);

        static const uint8 effects[] = {
            SUBEFFECT_NONE,          // SC_NONE
            SUBEFFECT_TRANSFIXION,   // SC_TRANSFIXION
            SUBEFFECT_COMPRESSION,   // SC_COMPRESSION
            SUBEFFECT_LIQUEFACATION, // SC_LIQUEFACTION
            SUBEFFECT_SCISSION,      // SC_SCISSION
            SUBEFFECT_REVERBERATION, // SC_REVERBERATION
            SUBEFFECT_DETONATION,    // SC_DETONATION
            SUBEFFECT_INDURATION,    // SC_INDURATION
            SUBEFFECT_IMPACTION,     // SC_IMPACTION
            SUBEFFECT_GRAVITATION,   // SC_GRAVITATION
            SUBEFFECT_DISTORTION,    // SC_DISTORTION
            SUBEFFECT_FUSION,        // SC_FUSION
            SUBEFFECT_FRAGMENTATION, // SC_FRAGMENTATION
            SUBEFFECT_LIGHT,         // SC_LIGHT
            SUBEFFECT_DARKNESS,      // SC_DARKNESS
            SUBEFFECT_LIGHT,         // SC_LIGHT_II
            SUBEFFECT_DARKNESS,      // SC_DARKNESS_II
        };

        return effects[skillchain];
    }

    uint8 GetSkillchainTier(SKILLCHAIN_ELEMENT skillchain)
    {
        TPZ_DEBUG_BREAK_IF(skillchain < SC_NONE || skillchain > SC_DARKNESS_II);

        static const uint8 tiers[] = {
            0, // SC_NONE
            1, // SC_TRANSFIXION
            1, // SC_COMPRESSION
            1, // SC_LIQUEFACTION
            1, // SC_SCISSION
            1, // SC_REVERBERATION
            1, // SC_DETONATION
            1, // SC_INDURATION
            1, // SC_IMPACTION
            2, // SC_GRAVITATION
            2, // SC_DISTORTION
            2, // SC_FUSION
            2, // SC_FRAGMENTATION
            3, // SC_LIGHT
            3, // SC_DARKNESS
            4, // SC_LIGHT_II
            4, // SC_DARKNESS_II
        };

        return tiers[skillchain];
    }

    static const std::map<std::pair<SKILLCHAIN_ELEMENT, SKILLCHAIN_ELEMENT>, SKILLCHAIN_ELEMENT> skillchain_map = {
        // Level 3 Pairs
        {{SC_LIGHT, SC_LIGHT},SC_LIGHT_II},
        {{SC_DARKNESS, SC_DARKNESS}, SC_DARKNESS_II},

        // Level 2 Pairs
        {{SC_DISTORTION, SC_GRAVITATION}, SC_DARKNESS},
        {{SC_FRAGMENTATION, SC_GRAVITATION}, SC_FRAGMENTATION},

        {{SC_GRAVITATION, SC_DISTORTION}, SC_DARKNESS},
        {{SC_FUSION, SC_DISTORTION}, SC_FUSION},

        {{SC_GRAVITATION, SC_FUSION}, SC_GRAVITATION},
        {{SC_FRAGMENTATION, SC_FUSION}, SC_LIGHT},

        {{SC_DISTORTION, SC_FRAGMENTATION}, SC_DISTORTION},
        {{SC_FUSION, SC_FRAGMENTATION}, SC_LIGHT},

			//Level 1 Pairs > Level 2 Skillchain

        {{SC_SCISSION, SC_TRANSFIXION}, SC_DISTORTION},
        {{SC_IMPACTION, SC_LIQUEFACTION}, SC_FUSION},
        {{SC_COMPRESSION, SC_DETONATION}, SC_GRAVITATION},
        {{SC_REVERBERATION, SC_INDURATION}, SC_FRAGMENTATION},

            // Level 1 Pairs
        {{SC_COMPRESSION, SC_TRANSFIXION}, SC_COMPRESSION},
        {{SC_REVERBERATION, SC_TRANSFIXION}, SC_REVERBERATION},

        {{SC_TRANSFIXION, SC_COMPRESSION}, SC_TRANSFIXION},
        {{SC_DETONATION, SC_COMPRESSION}, SC_DETONATION},

        {{SC_SCISSION, SC_LIQUEFACTION}, SC_SCISSION},

        {{SC_LIQUEFACTION, SC_SCISSION}, SC_LIQUEFACTION},
        {{SC_REVERBERATION, SC_SCISSION}, SC_REVERBERATION},
        {{SC_DETONATION, SC_SCISSION}, SC_DETONATION},

        {{SC_INDURATION, SC_REVERBERATION}, SC_INDURATION},
        {{SC_IMPACTION, SC_REVERBERATION}, SC_IMPACTION},

        {{SC_SCISSION, SC_DETONATION}, SC_SCISSION},

        {{SC_COMPRESSION, SC_INDURATION}, SC_COMPRESSION},
        {{SC_IMPACTION, SC_INDURATION}, SC_IMPACTION},

        {{SC_LIQUEFACTION, SC_IMPACTION}, SC_LIQUEFACTION},
        {{SC_DETONATION, SC_IMPACTION}, SC_DETONATION}
    };

    SKILLCHAIN_ELEMENT FormSkillchain(const std::list<SKILLCHAIN_ELEMENT>& resonance, const std::list<SKILLCHAIN_ELEMENT>& skill)
    {
        for (auto& resonance_element : resonance)
        {
            for (auto& skill_element : skill)
            {
                if (auto skillchain = skillchain_map.find({ skill_element, resonance_element }); skillchain != skillchain_map.end())
                {
                    return skillchain->second;
                }
            }
        }
        return SC_NONE;
    }


    SUBEFFECT GetSkillChainEffect(CBattleEntity* PDefender, uint8 primary, uint8 secondary, uint8 tertiary)
    {
        CStatusEffect* PSCEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
        CStatusEffect* PCBEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_CHAINBOUND, 0);
        SKILLCHAIN_ELEMENT skillchain = SC_NONE;
        auto combined_properties = primary | (secondary << 4) | (tertiary << 8);

        if (PSCEffect == nullptr && PCBEffect == nullptr)
        {
            // No effect exists, apply an effect using the weaponskill ID as the power with a tier of 0.
            PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_SKILLCHAIN, 0, combined_properties, 0, 10, 0, 0, 0));
            return SUBEFFECT_NONE;
        }
        else
        {
            std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
            std::list<SKILLCHAIN_ELEMENT> skillProperties = {(SKILLCHAIN_ELEMENT)primary, (SKILLCHAIN_ELEMENT)secondary, (SKILLCHAIN_ELEMENT)tertiary};

            // Chainbound active on target
            if (PCBEffect)
            {
                if (PCBEffect->GetStartTime() + 3s < server_clock::now())
                {
                    //Konzen-Ittai
                    if (PCBEffect->GetPower() > 1)
                    {
                        resonanceProperties.push_back(SC_LIGHT);
                        resonanceProperties.push_back(SC_DARKNESS);
                        resonanceProperties.push_back(SC_GRAVITATION);
                        resonanceProperties.push_back(SC_FRAGMENTATION);
                        resonanceProperties.push_back(SC_DISTORTION);
                        resonanceProperties.push_back(SC_FUSION);
                    }
                    resonanceProperties.push_back(SC_LIQUEFACTION);
                    resonanceProperties.push_back(SC_INDURATION);
                    resonanceProperties.push_back(SC_REVERBERATION);
                    resonanceProperties.push_back(SC_IMPACTION);
                    resonanceProperties.push_back(SC_COMPRESSION);

                    skillchain = FormSkillchain(resonanceProperties, skillProperties);
                }
                PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_SKILLCHAIN, 0, combined_properties, 0, 10, 0, 0, 0));
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_CHAINBOUND);
                PSCEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);

            }
            // Previous effect exists
            else if (PSCEffect && PSCEffect->GetTier() == 0)
            {
                TPZ_DEBUG_BREAK_IF(!PSCEffect->GetPower());
                // Previous effect is an opening effect, meaning the power is
                // actually the ID of the opening weaponskill.  We need all 3
                // of the possible skillchain properties on the initial link.
                if (PSCEffect->GetStartTime() + 3s < server_clock::now())
                {
                    auto properties = PSCEffect->GetPower();
                    resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(properties & 0b1111));
                    resonanceProperties.push_back((SKILLCHAIN_ELEMENT)((properties >> 4) & 0b1111));
                    resonanceProperties.push_back((SKILLCHAIN_ELEMENT)((properties >> 8) & 0b1111));
                    skillchain = FormSkillchain(resonanceProperties, skillProperties);
                }
            }
            else
            {
                // Previous effect is not an opening effect, meaning the power is
                // The skill chain ID resonating.
                resonanceProperties.push_back((SKILLCHAIN_ELEMENT)PSCEffect->GetPower());
                skillchain = FormSkillchain(resonanceProperties, skillProperties);
            }

            if (skillchain != SC_NONE)
            {
                PSCEffect->SetStartTime(server_clock::now());
                //   ShowDebug("duration: %d", PSCEffect->GetDuration());
                PSCEffect->SetDuration(PSCEffect->GetDuration() - 1000);
                PSCEffect->SetTier(GetSkillchainTier((SKILLCHAIN_ELEMENT)skillchain));
                PSCEffect->SetPower(skillchain);
                PSCEffect->SetSubPower(std::min(PSCEffect->GetSubPower() + 1, 5)); // Linked, limited to 5

                return (SUBEFFECT)GetSkillchainSubeffect((SKILLCHAIN_ELEMENT)skillchain);
            }

            PSCEffect->SetStartTime(server_clock::now());
            PSCEffect->SetDuration(10000);
            PSCEffect->SetTier(0);
            PSCEffect->SetPower(combined_properties);
            PSCEffect->SetSubPower(0);

            return SUBEFFECT_NONE;
        }
    }

    int16 GetSkillchainMinimumResistance(SKILLCHAIN_ELEMENT element, CBattleEntity* PDefender, ELEMENT* appliedEle)
    {
        static const Mod resistances[][4] =
        {
            {Mod::NONE,       Mod::NONE, Mod::NONE, Mod::NONE}, // SC_NONE
            {Mod::LIGHTDEF,   Mod::NONE, Mod::NONE, Mod::NONE}, // SC_TRANSFIXION
            {Mod::DARKDEF,    Mod::NONE, Mod::NONE, Mod::NONE}, // SC_COMPRESSION
            {Mod::FIREDEF,    Mod::NONE, Mod::NONE, Mod::NONE}, // SC_LIQUEFACTION
            {Mod::EARTHDEF,   Mod::NONE, Mod::NONE, Mod::NONE}, // SC_SCISSION
            {Mod::WATERDEF,   Mod::NONE, Mod::NONE, Mod::NONE}, // SC_REVERBERATION
            {Mod::WINDDEF,    Mod::NONE, Mod::NONE, Mod::NONE}, // SC_DETONATION
            {Mod::ICEDEF,     Mod::NONE, Mod::NONE, Mod::NONE}, // SC_INDURATION
            {Mod::THUNDERDEF, Mod::NONE, Mod::NONE, Mod::NONE}, // SC_IMPACTION

            { Mod::EARTHDEF, Mod::DARKDEF, Mod::NONE, Mod::NONE }, // SC_GRAVITATION
            { Mod::ICEDEF, Mod::WATERDEF, Mod::NONE, Mod::NONE }, // SC_DISTORTION
            {Mod::FIREDEF,  Mod::LIGHTDEF,   Mod::NONE, Mod::NONE}, // SC_FUSION
            {Mod::WINDDEF,  Mod::THUNDERDEF, Mod::NONE, Mod::NONE}, // SC_FRAGMENTATION

            {Mod::FIREDEF, Mod::WINDDEF,  Mod::THUNDERDEF, Mod::LIGHTDEF}, // SC_LIGHT
            {Mod::ICEDEF,  Mod::EARTHDEF, Mod::WATERDEF,   Mod::DARKDEF},  // SC_DARKNESS
            {Mod::FIREDEF, Mod::WINDDEF,  Mod::THUNDERDEF, Mod::LIGHTDEF}, // SC_LIGHT
            {Mod::ICEDEF,  Mod::EARTHDEF, Mod::WATERDEF,   Mod::DARKDEF},  // SC_DARKNESS_II
        };

        Mod defMod = Mod::NONE;

        switch (element)
        {
            // Level 1 skill chains
            case SC_LIQUEFACTION:
            case SC_IMPACTION:
            case SC_DETONATION:
            case SC_SCISSION:
            case SC_REVERBERATION:
            case SC_INDURATION:
            case SC_COMPRESSION:
            case SC_TRANSFIXION:
                defMod = resistances[element][0];
                break;

                // Level 2 skill chains
            case SC_FUSION:
            case SC_FRAGMENTATION:
            case SC_GRAVITATION:
            case SC_DISTORTION:
                if (PDefender->getMod(resistances[element][0]) < PDefender->getMod(resistances[element][1]))
                    defMod = resistances[element][0];
                else
                    defMod = resistances[element][1];
                break;

                // Level 3 & 4 skill chains
            case SC_LIGHT:
            case SC_LIGHT_II:
            case SC_DARKNESS:
            case SC_DARKNESS_II:
                if (PDefender->getMod(resistances[element][0]) < PDefender->getMod(resistances[element][1]))
                    defMod = resistances[element][0];
                else
                    defMod = resistances[element][1];
                if (PDefender->getMod(resistances[element][2]) < PDefender->getMod(defMod))
                    defMod = resistances[element][2];
                if (PDefender->getMod(resistances[element][3]) < PDefender->getMod(defMod))
                    defMod = resistances[element][3];
                break;

            default:
                TPZ_DEBUG_BREAK_IF(true);
                return 0;
                break;
        }

        switch (defMod)
        {
            case Mod::FIREDEF:
                *appliedEle = ELEMENT_FIRE;
                break;
            case Mod::EARTHDEF:
                *appliedEle = ELEMENT_EARTH;
                break;
            case Mod::WATERDEF:
                *appliedEle = ELEMENT_WATER;
                break;
            case Mod::WINDDEF:
                *appliedEle = ELEMENT_WIND;
                break;
            case Mod::ICEDEF:
                *appliedEle = ELEMENT_ICE;
                break;
            case Mod::THUNDERDEF:
                *appliedEle = ELEMENT_THUNDER;
                break;
            case Mod::LIGHTDEF:
                *appliedEle = ELEMENT_LIGHT;
                break;
            case Mod::DARKDEF:
                *appliedEle = ELEMENT_DARK;
                break;
            default:
                break;
        }

        return PDefender->getMod(defMod);
    }

    std::vector<ELEMENT> GetSkillchainMagicElement(SKILLCHAIN_ELEMENT skillchain)
    {
        static const std::unordered_map<SKILLCHAIN_ELEMENT, std::vector<ELEMENT>> resonanceToElement = {
            {SC_NONE, {}},
            {SC_TRANSFIXION, {ELEMENT_LIGHT}},
            {SC_COMPRESSION, {ELEMENT_DARK}},
            {SC_LIQUEFACTION, {ELEMENT_FIRE}},
            {SC_SCISSION, {ELEMENT_EARTH}},
            {SC_REVERBERATION, {ELEMENT_WATER}},
            {SC_DETONATION, {ELEMENT_WIND}},
            {SC_INDURATION, {ELEMENT_ICE}},
            {SC_IMPACTION, {ELEMENT_THUNDER}},

            {SC_GRAVITATION, {ELEMENT_DARK, ELEMENT_EARTH}},
            {SC_DISTORTION, {ELEMENT_WATER, ELEMENT_ICE}},
            {SC_FUSION, {ELEMENT_LIGHT, ELEMENT_FIRE}},
            {SC_FRAGMENTATION, {ELEMENT_WIND, ELEMENT_THUNDER}},

            {SC_LIGHT, {ELEMENT_LIGHT, ELEMENT_FIRE, ELEMENT_WIND, ELEMENT_THUNDER}},
            {SC_DARKNESS, {ELEMENT_DARK, ELEMENT_EARTH, ELEMENT_WATER, ELEMENT_ICE}},
            {SC_LIGHT_II, {ELEMENT_LIGHT}},
            {SC_DARKNESS_II, {ELEMENT_DARK}}};

        return resonanceToElement.at(skillchain);
    }

    int32 TakeSkillchainDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 lastSkillDamage, CBattleEntity* taChar)
    {
        TPZ_DEBUG_BREAK_IF(PAttacker == nullptr);
        TPZ_DEBUG_BREAK_IF(PDefender == nullptr);

        CStatusEffect* PEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);

        // Determine the skill chain level and elemental resistance.
        SKILLCHAIN_ELEMENT skillchain = (SKILLCHAIN_ELEMENT)PEffect->GetPower();
        uint16 chainLevel = PEffect->GetTier();
        uint16 chainCount = PEffect->GetSubPower();
        ELEMENT appliedEle = ELEMENT_NONE;
        int16 resistance = GetSkillchainMinimumResistance(skillchain, PDefender, &appliedEle);

        TPZ_DEBUG_BREAK_IF(chainLevel <= 0 || chainLevel > 4 || chainCount <= 0 || chainCount > 5);

        // Skill chain damage = (Closing Damage)
        //                      × (Skill chain Level/Number from Table)
        //                      × (1 + Skill chain Bonus ÷ 100)
        //                      × (1 + Skill chain Damage + %/100)
        //            TODO:     × (1 + Day/Weather bonuses)
        //            TODO:     × (1 + Staff Affinity)

        auto damage = (int32)floor((double)(abs(lastSkillDamage))
            * g_SkillChainDamageModifiers[chainLevel][chainCount] / 1000
            * (100 + PAttacker->getMod(Mod::SKILLCHAINBONUS)) / 100
            * (100 + PAttacker->getMod(Mod::SKILLCHAINDMG)) / 100);

        auto PChar = dynamic_cast<CCharEntity *>(PAttacker);
        if (PChar && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_INNIN))
        {
            auto angle = PDefender->loc.p.rotation - getangle(PDefender->loc.p, PChar->loc.p);
            // assuming default tolerance of 42 from lua_baseentity.cpp
            if (angle > 86 && angle < 170)
                damage = (int32)(damage * (1.f + PChar->PMeritPoints->GetMeritValue(MERIT_INNIN_EFFECT, PChar)/100.f));
        }
        damage = damage * (1000 - resistance) / 1000;
        damage = MagicDmgTaken(PDefender, damage, appliedEle);
        if (damage > 0)
        {
            damage = std::max(damage - PDefender->getMod(Mod::PHALANX), 0);
            damage = HandleStoneskin(PDefender, damage);
            HandleAfflatusMiseryDamage(PDefender, damage);
        }
        damage = std::clamp(damage, -99999, 99999);

        PDefender->takeDamage(damage, PAttacker, ATTACK_SPECIAL, appliedEle == ELEMENT_NONE ? DAMAGE_NONE : (DAMAGETYPE)(DAMAGE_ELEMENTAL + appliedEle));

        battleutils::ClaimMob(PDefender, PAttacker);
        PDefender->updatemask |= UPDATE_STATUS;

        PDefender->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);

        switch (PDefender->objtype)
        {
            case TYPE_PC:
            {
                if (PDefender->animation == ANIMATION_SIT)
                {
                    PDefender->animation = ANIMATION_NONE;
                    PDefender->updatemask |= UPDATE_HP;
                }
            }
            break;

            case TYPE_MOB:
            {
                ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(taChar ? taChar : PAttacker, (uint16)damage);
            }
            break;
            default:
            {
                break;
            }
        }

        return damage;
    }

    CItemEquipment* GetEntityArmor(CBattleEntity* PEntity, SLOTTYPE Slot)
    {
        TPZ_DEBUG_BREAK_IF(Slot < SLOT_HEAD || Slot > SLOT_LINK2);

        if (PEntity->objtype == TYPE_PC)
        {
            return (((CCharEntity*)PEntity)->getEquip(Slot));
        }
        return nullptr;
    }

    CItemWeapon* GetEntityWeapon(CBattleEntity* PEntity, SLOTTYPE Slot)
    {
        TPZ_DEBUG_BREAK_IF(Slot < SLOT_MAIN || Slot > SLOT_AMMO);
        return dynamic_cast<CItemWeapon*>(((CMobEntity*)PEntity)->m_Weapons[Slot]);
    }

    void MakeEntityStandUp(CBattleEntity* PEntity)
    {
        TPZ_DEBUG_BREAK_IF(PEntity == nullptr);

        if (PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PPlayer = ((CCharEntity*)PEntity);

            if (PPlayer->animation == ANIMATION_HEALING)
            {
                PPlayer->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
                PPlayer->updatemask |= UPDATE_HP;
            }
        }
    }

    /************************************************************************
    *                                                                       *
    *  Для всех сущностей, за исключением персонажей, по умолчанию true     *
    *                                                                       *
    ************************************************************************/

    bool HasNinjaTool(CBattleEntity* PEntity, CSpell* PSpell, bool ConsumeTool)
    {
        TPZ_DEBUG_BREAK_IF(PEntity == nullptr || PSpell == nullptr);

        if (PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = ((CCharEntity*)PEntity);

            uint8  SlotID = 0;
            uint16 toolID = PSpell->getMPCost();

            if (ERROR_SLOTID == (SlotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(toolID)))
            {
                if (PChar->GetMJob() == JOB_NIN)
                {
                    switch (toolID)
                    {
                        case ITEM_UCHITAKE:
                        case ITEM_TSURARA:
                        case ITEM_KAWAHORI_OGI:
                        case ITEM_MAKIBISHI:
                        case ITEM_HIRAISHIN:
                        case ITEM_MIZU_DEPPO:
                            toolID = ITEM_INOSHISHINOFUDA;
                            break;

                        case ITEM_RYUNO:
                        case ITEM_MOKUJIN:
                        case ITEM_SANJAKU_TENUGUI:
                        case ITEM_KABENRO:
                        case ITEM_SHINOBI_TABI:
                        case ITEM_SHIHEI:
                        case ITEM_RANKA:
                        case ITEM_FURUSUMI:

                            toolID = ITEM_SHIKANOFUDA;
                            break;

                        case ITEM_SOSHI:
                        case ITEM_KODOKU:
                        case ITEM_KAGINAWA:
                        case ITEM_JUSATSU:
                        case ITEM_SAIRUI_RAN:
                        case ITEM_JINKO:
                            toolID = ITEM_CHONOFUDA;
                            break;

                        default: return false;
                    }
                    if (ERROR_SLOTID == (SlotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(toolID)))
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }

            // Should only make it to this point if a ninja tool was found.

            // Check For Futae Effect
            bool hasFutae = PChar->StatusEffectContainer->HasStatusEffect(EFFECT_FUTAE);
            // Futae only applies to Elemental Wheel Tools
            bool useFutae = (toolID == ITEM_UCHITAKE || toolID == ITEM_TSURARA || toolID == ITEM_KAWAHORI_OGI || toolID == ITEM_MAKIBISHI || toolID == ITEM_HIRAISHIN || toolID == ITEM_MIZU_DEPPO);

            // If you have Futae active, Ninja Tool Expertise does not apply.
            if (ConsumeTool && hasFutae && useFutae)
            {
                // Futae Takes 2 of Your Tools
                charutils::UpdateItem(PChar, LOC_INVENTORY, SlotID, -2);
                PChar->pushPacket(new CInventoryFinishPacket());
            }
            else
            {
                uint16 meritBonus = 0;

                if (charutils::hasTrait(PChar, TRAIT_NINJA_TOOL_EXPERT))
                    meritBonus = PChar->PMeritPoints->GetMeritValue(MERIT_NINJA_TOOL_EXPERTISE, (CCharEntity*)PChar);

                uint16 chance = (PChar->getMod(Mod::NINJA_TOOL) + meritBonus);

                if (ConsumeTool && tpzrand::GetRandomNumber(100) > chance)
                {
                    charutils::UpdateItem(PChar, LOC_INVENTORY, SlotID, -1);
                    PChar->pushPacket(new CInventoryFinishPacket());
                }
            }
        }
        return true;
    }


    /*
     * Find if any party members are in position for trick attack.  Do this by making a narrow triangle:
     *  one endpoint at the mob, and the other two endpoints being equidistant from the TA user, perpendicular to
     *  the line between the mob and the TA user.  Find the slope of the line between the TA user and the mob, and
     *  decide whether to use x or z as the dependent variable (to avoid big numbers and divide by 0 errors on
     *  vertical slopes).  Using this slope, we can find the angle of the perpendicular line to the x or z line
     *  (depending on what the dependent var is), and using that angle, the disassembled x and z components to that
     *  line.  Divide those by 2 for a half yalm length line for each side of the base of the triangle, and we get
     *  the min and max values for x/z around the TA user.  Now it's simply a matter of first: making sure the
     *  TA target is closer than the TA user, and that the TA targets x and z coordinates fall within the triangle
     *  we made.  Using the min/max points and the mobs coordinate, we can construct min and max slopes, check that
     *  the x or z coordinates are between the mob and player, and finally calculate where the z coordinate should
     *  be based on the users x coordinate (or the other way around in a z dependent scenario) and check if the
     *  actual z coordinate is between those two values.
     */

    CBattleEntity* getAvailableTrickAttackChar(CBattleEntity* taUser, CBattleEntity* PMob)
    {
        if (!taUser->StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK))
        {
            return nullptr;
        }

        float taUserX = taUser->loc.p.x;
        float taUserZ = taUser->loc.p.z;
        float mobX = PMob->loc.p.x;
        float mobZ = PMob->loc.p.z;

        float xdif = taUserX - mobX;
        float zdif = taUserZ - mobZ;
        float slope = 0;
        float maxSlope = 0;
        float minSlope = 0;
        bool zDependent = true; //using a slope where z is dependent var
        if (abs(xdif) <= abs(zdif))
        {
            slope = xdif / zdif;

            float angle = (float)atan((double)1) * 2 - atan(slope);

            float zoffset = cos(angle) / 2;
            float xoffset = sin(angle) / 2;
            float maxXpoint = taUserX + xoffset;
            float maxZpoint = taUserZ - zoffset;
            float minXpoint = taUserX - xoffset;
            float minZpoint = taUserZ + zoffset;
            maxSlope = ((maxXpoint - mobX) / (maxZpoint - mobZ));
            minSlope = ((minXpoint - mobX) / (minZpoint - mobZ));
            zDependent = false;
        }
        else {
            slope = zdif / xdif;

            float angle = (float)atan((double)1) * 2 - atan(slope);

            float xoffset = cos(angle) / 2;
            float zoffset = sin(angle) / 2;
            float maxXpoint = taUserX - xoffset;
            float maxZpoint = taUserZ + zoffset;
            float minXpoint = taUserX + xoffset;
            float minZpoint = taUserZ - zoffset;
            maxSlope = (maxZpoint - mobZ) / (maxXpoint - mobX);
            minSlope = (minZpoint - mobZ) / (minXpoint - mobX);
        }
        if (taUser->PParty != nullptr)
        {
            if (taUser->PParty->m_PAlliance != nullptr)
            {
                for (uint8 a = 0; a < taUser->PParty->m_PAlliance->partyList.size(); ++a)
                {
                    for (uint8 i = 0; i < taUser->PParty->m_PAlliance->partyList.at(a)->members.size(); ++i)
                    {
                        CBattleEntity* member = taUser->PParty->m_PAlliance->partyList.at(a)->members.at(i);
                        if (taUser->id != member->id && distance(member->loc.p, PMob->loc.p) <= distance(taUser->loc.p, PMob->loc.p))
                        {
                            float memberXdif = member->loc.p.x - mobX;
                            float memberZdif = member->loc.p.z - mobZ;
                            if (zDependent)
                            {
                                if ((memberZdif <= memberXdif * maxSlope) &&
                                    (memberZdif >= memberXdif * minSlope))
                                {
                                    //finally found a TA partner
                                    return member;
                                }
                            }
                            else {
                                if ((memberXdif <= memberZdif * maxSlope) &&
                                    (memberXdif >= memberZdif * minSlope))
                                {
                                    //finally found a TA partner
                                    return member;
                                }
                            }
                        }
                    }
                }
            }
            else {//no alliance
                for (uint8 i = 0; i < taUser->PParty->members.size(); ++i)
                {
                    CBattleEntity* member = taUser->PParty->members.at(i);
                    if (member->id != taUser->id && distance(member->loc.p, PMob->loc.p) <= distance(taUser->loc.p, PMob->loc.p))
                    {
                        float memberXdif = member->loc.p.x - mobX;
                        float memberZdif = member->loc.p.z - mobZ;
                        if (zDependent)
                        {
                            if ((memberZdif <= memberXdif * maxSlope) &&
                                (memberZdif >= memberXdif * minSlope))
                            {
                                //finally found a TA partner
                                return member;
                            }
                        }
                        else {
                            if ((memberXdif <= memberZdif * maxSlope) &&
                                (memberXdif >= memberZdif * minSlope))
                            {
                                //finally found a TA partner
                                return member;
                            }
                        }
                    }
                }
            }
        }
        //no Trick attack party member available
        return nullptr;
    }

    /************************************************************************
    *                                                                       *
    *  Adds enmity to PSource for all the MOB targets who have              *
    *  PTarget on their enmity list.                                        *
    *                                                                       *
    ************************************************************************/

    void GenerateCureEnmity(CBattleEntity* PSource, CBattleEntity* PTarget, int32 amount)
    {
        TPZ_DEBUG_BREAK_IF(PSource == nullptr);
        TPZ_DEBUG_BREAK_IF(PTarget == nullptr);

        auto PMasterSource = PSource->PMaster ? PSource->PMaster : PSource;
        auto PMasterSourceChar = static_cast<CCharEntity*>(PMasterSource);

        for (SpawnIDList_t::const_iterator it = PMasterSourceChar->SpawnMOBList.begin(); it != PMasterSourceChar->SpawnMOBList.end(); ++it)
        {
            CMobEntity* PCurrentMob = static_cast<CMobEntity*>(it->second);

            if (PCurrentMob->m_HiPCLvl > 0 && PCurrentMob->PEnmityContainer->HasID(PTarget->id))
            {
                PCurrentMob->PEnmityContainer->UpdateEnmityFromCure(PSource, PTarget->GetMLevel(), amount, (amount == 65535)); //true for "cure v"
            }
        }
    }

    //Generate enmity for all targets in range

    void GenerateInRangeEnmity(CBattleEntity* PSource, int16 CE, int16 VE)
    {
        TPZ_DEBUG_BREAK_IF(PSource == nullptr);

        CCharEntity* PIterSource = nullptr;

        if (PSource->objtype != TYPE_PC)
        {
            if (PSource->PMaster && PSource->PMaster->objtype == TYPE_PC)
            {
                PIterSource = static_cast<CCharEntity*>(PSource->PMaster);
            }
        }
        else
        {
            PIterSource = static_cast<CCharEntity*>(PSource);
        }

        if (PIterSource)
        {
            for (SpawnIDList_t::const_iterator it = PIterSource->SpawnMOBList.begin(); it != PIterSource->SpawnMOBList.end(); ++it)
            {
                CMobEntity* PCurrentMob = (CMobEntity*)it->second;

                if (PCurrentMob->m_HiPCLvl > 0 && PCurrentMob->PEnmityContainer->HasID(PSource->id))
                {
                    PCurrentMob->PEnmityContainer->UpdateEnmity(PSource, CE, VE);
                }
            }
        }
    }

    /************************************************************************
    *                                                                       *
    *   Transfer Enmity (used with ACCOMPLICE & COLLABORATOR ability type)  *
    *                                                                       *
    ************************************************************************/

    void TransferEnmity(CBattleEntity* PHateReceiver, CBattleEntity* PHateGiver, CMobEntity* PMob, uint8 percentToTransfer)
    {
        // Ensure the players have a battle target..
        if (PMob == nullptr || ((CMobEntity*)PMob)->PEnmityContainer == nullptr)
            return;

        //CBaseEntity* PMob = CharHateGiver->GetEntity(mobID, TYPE_MOB);

        ((CMobEntity*)PMob)->PEnmityContainer->LowerEnmityByPercent(PHateGiver, percentToTransfer, PHateReceiver);
    }



    /************************************************************************
    *                                                                       *
    *   Effect from soul eater                                              *
    *                                                                       *
    ************************************************************************/
    uint16 doSoulEaterEffect(CCharEntity* m_PChar, uint32 damage)
    {
        // Souleater has no effect <10HP.
        if (m_PChar->GetMJob() == JOB_DRK && m_PChar->health.hp >= 10 && m_PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SOULEATER))
        {
            //lost 10% current hp, converted to damage (displayed as just a strong regular hit)
            float drainPercent = 0.1f;

            //at most 2% bonus from gear
            auto gearBonusPercent = m_PChar->getMod(Mod::SOULEATER_EFFECT);
            drainPercent = drainPercent + std::min(0.02f, 0.01f * gearBonusPercent);

            damage += (uint32)(m_PChar->health.hp * drainPercent);
            m_PChar->addHP((int32)(m_PChar->health.hp * -(drainPercent - m_PChar->getMod(Mod::STALWART_SOUL) * 0.001f)));
        }
        else if (m_PChar->GetSJob() == JOB_DRK &&m_PChar->health.hp >= 10 && m_PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SOULEATER)) {
            //lose 10% Current HP, only HALF (5%) converted to damage
            damage += (uint32)(m_PChar->health.hp * 0.05f);
            m_PChar->addHP((int32)(m_PChar->health.hp * -0.1f));
        }
        return damage;
    }

    uint16 doConsumeManaEffect(CCharEntity* m_PChar, uint32 damage)
    {
        if (m_PChar->StatusEffectContainer->HasStatusEffect(EFFECT_CONSUME_MANA))
        {
            damage += (uint32)(floor(m_PChar->health.mp / 10));
            m_PChar->health.mp = 0;
            m_PChar->StatusEffectContainer->DelStatusEffect(EFFECT_CONSUME_MANA);
        }
        return damage;
    }

    /************************************************************************
    *                                                                       *
    *   Samurai get merit storeTP value                                     *
    *                                                                       *
    ************************************************************************/
    uint8 getStoreTPbonusFromMerit(CBattleEntity* PEntity)
    {
        if (PEntity->objtype == TYPE_PC)
        {
            if (((CCharEntity*)PEntity)->GetMJob() == JOB_SAM)
            {
                return ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_STORE_TP_EFFECT, (CCharEntity*)PEntity);
            }
        }
        return 0;
    }



    /************************************************************************
    *                                                                       *
    *   Samurai overwhelm damage bonus                                      *
    *                                                                       *
    ************************************************************************/
    int32 getOverWhelmDamageBonus(CCharEntity* m_PChar, CBattleEntity* PDefender, int32 damage)
    {
        if (m_PChar->objtype == TYPE_PC) // Some mobskills use TakeWeaponskillDamage function, which calls upon this one.
        {
            // must be facing mob
            if (isFaceing(PDefender->loc.p, m_PChar->loc.p, 23))
            {
                uint8 meritCount = m_PChar->PMeritPoints->GetMeritValue(MERIT_OVERWHELM, m_PChar);
                // ShowDebug("Merits: %u\n", meritCount);
                float tmpDamage = static_cast<float>(damage);

                switch (meritCount)
                {
                    case 1: tmpDamage += tmpDamage * 0.05f; break;
                    case 2: tmpDamage += tmpDamage * 0.10f; break;
                    case 3: tmpDamage += tmpDamage * 0.15f; break;
                    case 4: tmpDamage += tmpDamage * 0.17f; break;
                    case 5: tmpDamage += tmpDamage * 0.19f; break;
                    default: break;
                }
                damage = static_cast<int32>(floor(tmpDamage));
            }
        }
        return damage;
    }


    /************************************************************************
    *                                                                       *
    *   get barrage shot count                                              *
    *                                                                       *
    ************************************************************************/

    uint8 getBarrageShotCount(CCharEntity* PChar)
    {
        /*
        Ranger level 30, four shots.
        Ranger level 50, five shots.
        Ranger level 75, six shots.
        Ranger level 90, seven shots.
        Ranger level 99, eight shots.
        */

        // only archery + marksmanship can use barrage
        CItemWeapon* PItem = (CItemWeapon*)PChar->getEquip(SLOT_RANGED);

        if (PItem && PItem->getSkillType() != 25 && PItem->getSkillType() != 26)
        {
            return 0;
        }

        uint8 lvl = PChar->jobs.job[JOB_RNG];       // Get Ranger level of char
        uint8 shotCount = 0;                    // the total number of extra hits

        if (PChar->GetSJob() == JOB_RNG)        // if rng is sub then use the sub level
            lvl = PChar->GetSLevel();

        // Hunters bracers+1 will add an extra shot
        CItemEquipment* PItemHands = PChar->getEquip(SLOT_HANDS);


        if (PItemHands && PItemHands->getID() == 14900)
            shotCount++;

        if (lvl < 30)   return 0;
        else if (lvl < 50)  shotCount += 3;
        else if (lvl < 75)  shotCount += 4;
        else if (lvl < 90)  shotCount += 5;
        else if (lvl < 99)  shotCount += 6;
        else if (lvl >= 99) shotCount += 7;


        // make sure we have enough ammo for all these shots
        CItemWeapon* PAmmo = (CItemWeapon*)PChar->getEquip(SLOT_AMMO);

        if (PAmmo && PAmmo->getQuantity() < shotCount)
        {
            shotCount = PAmmo->getQuantity() - 1;
        }

        return shotCount;
    }

    /************************************************************************
    *                                                                       *
    *   Jump DRG Job ability                                                *
    *                                                                       *
    ************************************************************************/

    uint16 jumpAbility(CBattleEntity* PAttacker, CBattleEntity* PVictim, uint8 tier)
    {

        // super jump - remove 99% of enmity
        if (tier == 3 && PVictim->objtype == TYPE_MOB)
        {
            ((CMobEntity*)PVictim)->PEnmityContainer->LowerEnmityByPercent(PAttacker, 99, nullptr);
            return 0;
        }

        // target has perfect dodge - do not go any further
        if (PVictim->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_DODGE, 0)) {

            // Claim the mob.
            battleutils::ClaimMob(PVictim, PAttacker);
            return 0;
        }


        // multihit's just multiply jump damage
        auto sub = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_SUB]);
        uint8 numattacksLeftHand = 0;

        //sub weapon is equipped
        if (sub && sub->getDmgType() > 0 && sub->getDmgType() < 4)
            numattacksLeftHand = battleutils::CheckMultiHits(PAttacker, sub);

        auto PWeapon = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_MAIN]);

        //h2h equipped
        if (PWeapon && PWeapon->getSkillType() == SKILL_HAND_TO_HAND)
            numattacksLeftHand = battleutils::CheckMultiHits(PAttacker, PWeapon);

        // normal multi hit from left hand
        uint8 numattacksRightHand = battleutils::CheckMultiHits(PAttacker, PWeapon);


        uint8 fstrslot = SLOT_MAIN;

        uint8 hitrate = battleutils::GetHitRate(PAttacker, PVictim);
        uint8 realHits = 0;         // to store the real number of hit for tp multipler
        uint16 totalDamage = 0;
        uint16 damageForRound = 0;
        bool hitTarget = false;

        // Loop number of hits
        for (uint8 i = 0; i < (numattacksLeftHand + numattacksRightHand); ++i)
        {
            if (i != 0)
            {
                if (PVictim->isDead())
                    break;

                if (PWeapon && PWeapon->getSkillType() != SKILL_HAND_TO_HAND && i >= numattacksRightHand)
                {
                    PWeapon = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_SUB]);
                    fstrslot = SLOT_SUB;
                }
            }

            if (tpzrand::GetRandomNumber(100) < hitrate)
            {

                // attack hit, try to be absorbed by shadow
                if (!battleutils::IsAbsorbByShadow(PVictim))
                {
                    // successful hit, add damage
                    float AttMultiplerPercent = 0.f;

                    // get jump attack bonus from gear
                    if (PAttacker->objtype == TYPE_PC)
                        AttMultiplerPercent = PAttacker->getMod(Mod::JUMP_ATT_BONUS) / 100.f;

                    float DamageRatio = battleutils::GetDamageRatio(PAttacker, PVictim, false, AttMultiplerPercent);
                    damageForRound = (uint16)((PAttacker->GetMainWeaponDmg() + battleutils::GetFSTR(PAttacker, PVictim, SLOT_MAIN)) * DamageRatio);

                    // bonus applies to jump only, not high jump
                    if (tier == 1)
                    {
                        float jumpBonus = 1.f + PAttacker->VIT() / 256.f;
                        damageForRound = (uint16)(damageForRound * jumpBonus);
                    }

                    hitTarget = true;
                    realHits++;

                    // incase player has gungnir^^ (or any other damage increases weapons)
                    damageForRound = attackutils::CheckForDamageMultiplier((CCharEntity*)PAttacker, PWeapon, damageForRound, PHYSICAL_ATTACK_TYPE::NORMAL, SLOT_MAIN);

                    totalDamage += damageForRound;
                }
            }
        }


        //check for soul eater
        if (PAttacker->objtype == TYPE_PC)
            totalDamage = battleutils::doSoulEaterEffect((CCharEntity*)PAttacker, totalDamage);

        // bonus jump tp is added even if damage is 0, will not add if jump misses
        if (PAttacker->objtype == TYPE_PC && hitTarget)
        {
            int mod = PAttacker->getMod(Mod::JUMP_TP_BONUS);
            PAttacker->addTP(mod);
        }

        // if damage is 0 then jump missed
        if (totalDamage == 0) {

            // Claim the mob.
            battleutils::ClaimMob(PVictim, PAttacker);
            return 0;
        }


        // high jump removes %50 emnity + more from any gear mods
        if (tier == 2 && PVictim->objtype == TYPE_MOB)
        {
            uint16 enmityReduction = PAttacker->getMod(Mod::HIGH_JUMP_ENMITY_REDUCTION) + 50;

            // DRG sub has only 30% enmity removed instead of 50%.
            if (PAttacker->GetSJob() == JOB_DRG)
            {
                enmityReduction = PAttacker->getMod(Mod::HIGH_JUMP_ENMITY_REDUCTION) + 30;
            }

            // cap it
            if (enmityReduction > 100)
            {
                enmityReduction = 100;
            }
            ((CMobEntity*)PVictim)->PEnmityContainer->LowerEnmityByPercent(PAttacker, (uint8)enmityReduction, nullptr);
        }

        // Under Spirit Surge, High Jump lowers the target's TP proportionately to the amount of damage dealt (TP is reduced by damage * 20)
        if (tier == 2 && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_SPIRIT_SURGE))
            PVictim->addTP(-(totalDamage * 20));

        // try skill up (CharEntity only)
        if (PAttacker->objtype == TYPE_PC)
            charutils::TrySkillUP((CCharEntity*)PAttacker, (SKILLTYPE)PWeapon->getSkillType(), PVictim->GetMLevel());

        // jump + high jump doesn't give any tp to victim
        battleutils::TakePhysicalDamage(PAttacker, PVictim, PHYSICAL_ATTACK_TYPE::NORMAL, totalDamage, false, fstrslot, realHits, nullptr, false, true);

        return totalDamage;
    }

    /************************************************************************
    *                                                                       *
    *   Entity charms another                                               *
    *                                                                       *
    ************************************************************************/

    void tryToCharm(CBattleEntity* PCharmer, CBattleEntity* PVictim)
    {
        //Gear with Charm + does not affect the success rate of Charm, but increases the duration of the Charm.
        //Each +1 to Charm increases the duration of charm by 5%; +20 Charm doubles the duration of charm.

        //Too Weak          30 Minutes
        //Easy Prey         20 Minutes
        //Decent Challenge  10 Minutes
        //Even Match        3.0 Minutes
        //Tough             1.5 Minutes
        //VT                1 minute    guess
        //IT                30 seconds  guess
        uint32 CharmTime = 0;

        // player charming mob
        CMobEntity* PMob = dynamic_cast<CMobEntity*>(PVictim);
        if (PMob && PCharmer->objtype == TYPE_PC)
        {
            //Bind uncharmable mobs and pets for 1 to 5 seconds
            if (((CMobEntity*)PVictim)->getMobMod(MOBMOD_CHARMABLE) == 0  ||  PVictim->PMaster != nullptr)
            {
                PVictim->StatusEffectContainer->AddStatusEffect(
                    new CStatusEffect(EFFECT_BIND, EFFECT_BIND, 1, 0, tpzrand::GetRandomNumber(1, 5)));
                return;
            }

            // mob is charmable
            const EMobDifficulty mobCheck = charutils::CheckMob(PCharmer->GetMLevel(), PVictim->GetMLevel());
            switch (mobCheck)
            {
            case EMobDifficulty::TooWeak:
                CharmTime = 1800000;
                break;

            case EMobDifficulty::IncrediblyEasyPrey:
            case EMobDifficulty::EasyPrey:
                CharmTime = 1200000;
                break;

            case EMobDifficulty::DecentChallenge:
                CharmTime = 600000;
                break;

            case EMobDifficulty::EvenMatch:
                CharmTime = 180000;
                break;

            case EMobDifficulty::Tough:
                CharmTime = 90000;
                break;

            case EMobDifficulty::VeryTough:
                CharmTime = 45000;
                break;

            case EMobDifficulty::IncrediblyTough:
                CharmTime = 22500;
                break;

            default:
                // no-op
                break;
            }

            //apply charm time extension from gear
            uint16 charmModValue = (PCharmer->getMod(Mod::CHARM_TIME));
            // adds 5% increase
            uint32 extraCharmTime = (uint32)(CharmTime * (charmModValue * 0.5f) / 10.f);
            CharmTime += extraCharmTime;

            //randomize charm time if > EM
            if (mobCheck > EMobDifficulty::EvenMatch)
                CharmTime = (uint32)(CharmTime * tpzrand::GetRandomNumber(0.75f, 1.25f));

            if (!TryCharm(PCharmer, PVictim))
                return;
        }

        applyCharm(PCharmer, PVictim, std::chrono::milliseconds(CharmTime));
    }

    void applyCharm(CBattleEntity* PCharmer, CBattleEntity* PVictim, duration charmTime)
    {
        PVictim->isCharmed = true;

        if (PVictim->objtype == TYPE_MOB)
        {
            PVictim->PMaster = PCharmer;
            PCharmer->PPet = PVictim;

            //make the mob disengage
            if (PCharmer->PPet->PAI->IsEngaged())
            {
                PCharmer->PPet->PAI->Disengage();
            }

            //clear the victims emnity list
            ((CMobEntity*)PVictim)->PEnmityContainer->Clear();

            //set the mobs ai to petAi
            PCharmer->PPet->PAI->SetController(std::make_unique<CPetController>(static_cast<CPetEntity*>(PCharmer->PPet)));
            PCharmer->PPet->charmTime = server_clock::now() + charmTime;

            // this will make him transition back to roaming if sleeping
            PCharmer->PPet->animation = ANIMATION_NONE;
            PCharmer->updatemask |= UPDATE_HP;

            charutils::BuildingCharAbilityTable((CCharEntity*)PCharmer);
            charutils::BuildingCharPetAbilityTable((CCharEntity*)PCharmer, (CPetEntity*)PVictim, PVictim->id);
            ((CCharEntity*)PCharmer)->pushPacket(new CCharUpdatePacket((CCharEntity*)PCharmer));
            ((CCharEntity*)PCharmer)->pushPacket(new CPetSyncPacket((CCharEntity*)PCharmer));
            PCharmer->ForAlliance([&PVictim](CBattleEntity* PMember){
                if (static_cast<CCharEntity*>(PMember)->PClaimedMob == PVictim)
                    static_cast<CCharEntity*>(PMember)->PClaimedMob = nullptr;
            });
            ((CMobEntity*)PVictim)->m_OwnerID.clean();
            PVictim->updatemask |= UPDATE_STATUS;
        }

        else if (PVictim->objtype == TYPE_PC)
        {
            if (PVictim->PPet)
            {
                petutils::DespawnPet(PVictim);
            }

            static_cast<CCharEntity*>(PVictim)->ClearTrusts();

            PVictim->PAI->SetController(std::make_unique<CPlayerCharmController>(static_cast<CCharEntity*>(PVictim)));

            battleutils::RelinquishClaim(static_cast<CCharEntity*>(PVictim));
            PVictim->PMaster = PCharmer;
            PVictim->updatemask |= UPDATE_ALL_CHAR;
        }
        PVictim->allegiance = PCharmer->allegiance;
        PVictim->updatemask |= UPDATE_HP;
    }

    void unCharm(CBattleEntity* PEntity)
    {
        if (PEntity->objtype == TYPE_PC)
        {
            PEntity->isCharmed = false;
            PEntity->PAI->SetController(std::make_unique<CPlayerController>(static_cast<CCharEntity*>(PEntity)));

            PEntity->PMaster = nullptr;
            if (PEntity->PAI->IsEngaged())
            {
                PEntity->PAI->Disengage();
            }
            if (PEntity->isDead())
            {
                PEntity->Die();
            }
            PEntity->updatemask |= UPDATE_ALL_CHAR;
        }
    }

    /************************************************************************
    *                                                                       *
    *   Returns the percentage chance that one entity has to charm another. *
    *                                                                       *
    ************************************************************************/

    float GetCharmChance(CBattleEntity* PCharmer, CBattleEntity* PTarget, bool includeCharmAffinityAndChanceMods)
    {
        //---------------------------------------------------------
        // chance of charm is based on:
        //  CHR - both entities
        //  Victims M level
        //  charmers BST level (not main level)
        //
        //  75 with a BST SJ Lvl l0 will struggle on EP
        //  75 with a BST SJ Lvl 75 will not - this player has bst leveled to 75 and is using it as SJ
        //---------------------------------------------------------

        // Paranoid check
        if (!PCharmer || !PTarget)
            return 0.f;

        // Can the target even be charmed?
        CMobEntity* PTargetAsMob = dynamic_cast<CMobEntity*>(PTarget);
        if (PTargetAsMob)
        {
            // Cannot charm pets, or other non-charmable mobs
            if (!PTargetAsMob->getMobMod(MOBMOD_CHARMABLE) || PTargetAsMob->PMaster)
                return 0.f;
        }


        uint8 charmerLvl = PCharmer->GetMLevel();
        uint8 targetLvl = PTarget->GetMLevel();

        //printf("Charmer = %s, Lvl. %u\n", PCharmer->name.c_str(), charmerLvl);
        //printf("Target = %s, Lvl. %u\n", PTarget->name.c_str(), targetLvl);

        EMobDifficulty mobCheck = charutils::CheckMob(charmerLvl, targetLvl);
        float charmChance = 0.f;

        switch (mobCheck)
        {
        case EMobDifficulty::TooWeak:
            charmChance = 90.f;
            break;
        case EMobDifficulty::IncrediblyEasyPrey:
        case EMobDifficulty::EasyPrey:
            charmChance = 75.f;
            break;
        case EMobDifficulty::DecentChallenge:
            charmChance = 60.f;
            break;
        case EMobDifficulty::EvenMatch:
            charmChance = 40.f;
            break;
        case EMobDifficulty::Tough:
            charmChance = 30.f;
            break;
        case EMobDifficulty::VeryTough:
            charmChance = 20.f;
            break;
        case EMobDifficulty::IncrediblyTough:
            charmChance = 10.f;
            break;
        default:
            // no-op
            break;
        }

        uint8 charmerBSTlevel = 0;

        if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(PCharmer))
        {
            uint8 charmerBRDlevel = PChar->jobs.job[JOB_BRD];
            charmerBSTlevel = PChar->jobs.job[JOB_BST];
            if (PCharmer->GetMJob() == JOB_BRD && charmerBRDlevel > charmerBSTlevel)
                charmerBSTlevel = charmerBRDlevel;

            charmerBSTlevel = std::min(charmerBSTlevel, charmerLvl);
        }
        else if (PCharmer->objtype == TYPE_MOB)
        {
            charmerBSTlevel = charmerLvl;
        }

        // FIXME: Level and CHR ratios are complete guesses
        const float levelRatio = (charmerBSTlevel - targetLvl) / 100.f;
        charmChance *= (1.f + levelRatio);

        const float chrRatio = (PCharmer->CHR() - PTarget->CHR()) / 100.f;
        charmChance *= (1.f + chrRatio);

        // Retail doesn't take light/apollo into account for Gauge
        if (includeCharmAffinityAndChanceMods)
        {
            // NQ elemental staves have 2 affinity, HQ have 3 affinity. Boost is 10/15% respectively so multiply by 5.
            const float charmAffintyMods = PCharmer->getMod(Mod::LIGHT_AFFINITY_ACC) * 5.f;
            const float charmChanceMods = (float)PCharmer->getMod(Mod::CHARM_CHANCE);

            charmChance *= (1.f + (charmChanceMods + charmAffintyMods) / 100.0f);
        }

        // Cap chance at 95%
        return std::clamp(charmChance, 0.f, 95.f);
    }

    /************************************************************************
    *                                                                       *
    *   calculate if charm is successful                                    *
    *                                                                       *
    ************************************************************************/

    bool TryCharm(CBattleEntity* PCharmer, CBattleEntity* PVictim)
    {
        return GetCharmChance(PCharmer, PVictim) > tpzrand::GetRandomNumber(100.f);
    }

    void ClaimMob(CBattleEntity* PDefender, CBattleEntity* PAttacker, bool passing)
    {
        if (PDefender->objtype == TYPE_MOB)
        {
            CBattleEntity* original = PAttacker;
            if (PAttacker->objtype != TYPE_PC)
            {
                if (PAttacker->PMaster && PAttacker->PMaster->objtype == TYPE_PC)
                { // claim by master
                    PAttacker = PAttacker->PMaster;
                }
                else
                {
                    return;
                }
            }
            CBattleEntity* battleTarget = original->GetBattleTarget();
            CMobEntity* mob = static_cast<CMobEntity*>(PDefender);
            if (!passing)
            {
                mob->PEnmityContainer->UpdateEnmity(original, 0, 0, true, true);
            }
            if (PAttacker)
            {
                CCharEntity* attacker = static_cast<CCharEntity*>(PAttacker);
                if (!passing)
                {
                    battleutils::DirtyExp(PDefender, PAttacker);
                }
                if (!battleTarget || battleTarget == PDefender || battleTarget != attacker->PClaimedMob || PDefender->isDead())
                {
                    if (PDefender->isAlive() && attacker->PClaimedMob && attacker->PClaimedMob != PDefender
                        && attacker->PClaimedMob->isAlive() && attacker->PClaimedMob->m_OwnerID.id == attacker->id)
                    { // unclaim any other living mobs owned by attacker
                        static_cast<CMobController*>(attacker->PClaimedMob->PAI->GetController())->TapDeclaimTime();
                        attacker->PClaimedMob = nullptr;
                    }
                    if (!mob->CalledForHelp())
                    {
                        if (battleutils::HasClaim(PAttacker, PDefender))
                        { // mob is currently claimed by your alliance, update ownership
                            mob->m_OwnerID.id = PAttacker->id;
                            mob->m_OwnerID.targid = PAttacker->targid;
                            if (PDefender->isAlive())
                            { // ignore killing blow
                                mob->updatemask |= UPDATE_STATUS;
                                attacker->PClaimedMob = PDefender;
                            }
                        }
                        else
                        { // mob is unclaimed
                            if (PDefender->isDead())
                            { // always give rewards on the killing blow
                                mob->m_OwnerID.id = PAttacker->id;
                                mob->m_OwnerID.targid = PAttacker->targid;
                                return;
                            }
                            CBattleEntity* highestClaim = mob->PEnmityContainer->GetHighestEnmity();
                            if (highestClaim->objtype == TYPE_TRUST)
                            {
                                highestClaim = static_cast<CTrustEntity*>(highestClaim)->PMaster;
                            }
                            PAttacker->ForAlliance([&](CBattleEntity* PMember){
                                if (!highestClaim || highestClaim == PMember || highestClaim == PMember->PPet)
                                { // someone in your alliance is top of hate list, claim for your alliance
                                    mob->m_OwnerID.id = PAttacker->id;
                                    mob->m_OwnerID.targid = PAttacker->targid;
                                    if (PDefender->isAlive())
                                    { // ignore killing blow
                                        mob->updatemask |= UPDATE_STATUS;
                                        attacker->PClaimedMob = PDefender;
                                    }
                                }
                            });
                        }
                    }
                }
            }
        }
    }

    void DirtyExp(CBattleEntity* PDefender, CBattleEntity* PAttacker)
    {
        if (PDefender->objtype == TYPE_MOB)
        {
            CMobEntity* mob = static_cast<CMobEntity*>(PDefender);
            if (PAttacker->objtype != TYPE_PC)
            {
                if (PAttacker->PMaster && PAttacker->PMaster->objtype == TYPE_PC)
                {
                    PAttacker = PAttacker->PMaster;
                }
                else
                {
                    PAttacker = nullptr;
                }
            }
            if (PAttacker)
            {
                uint8 pcinzone = 0;
                uint8 maxLevel = 0;
                PAttacker->ForAlliance([&pcinzone, &maxLevel, &mob](CBattleEntity* PMember) {
                    if (PMember->getZone() == mob->getZone() && distance(PMember->loc.p, mob->loc.p) < 100)
                    {
                        maxLevel = std::max(maxLevel, PMember->GetMLevel());
                        pcinzone++;
                    }
                });
                mob->m_HiPartySize = std::max(pcinzone, mob->m_HiPartySize);
                mob->m_HiPCLvl = std::max(maxLevel, mob->m_HiPCLvl);
            }
        }
    }

    void RelinquishClaim(CCharEntity* PChar)
    {
        CBattleEntity* mob = PChar->PClaimedMob;
        if (mob && mob->isAlive() && mob->m_OwnerID.id == PChar->id)
        { // if we currently own a mob
            bool found = false;
            static_cast<CBattleEntity*>(PChar)->ForAlliance([&PChar, &mob, &found](CBattleEntity* PMember){
                CCharEntity* member = static_cast<CCharEntity*>(PMember);
                if (member != PChar && !found && member->getZone() == PChar->getZone() && member->isAlive() && (!member->PClaimedMob || member->PClaimedMob == mob))
                { // check if we can pass claim to someone else
                    found = true;
                    battleutils::ClaimMob(mob, PMember, true);
                }
            });
            if (!found)
            { // if mob didn't pass to someone else, unclaim it
                static_cast<CMobController*>(mob->PAI->GetController())->TapDeclaimTime();
            }
        }
        PChar->PClaimedMob = nullptr;
    }

    int32 BreathDmgTaken(CBattleEntity* PDefender, int32 damage)
    {
        float resist = 1.0f + floor( 256.0f * ( PDefender->getMod(Mod::UDMGBREATH) / 100.0f )  ) / 256.0f;
        resist = std::max<float>(resist, 0);
        damage = (int32)(damage * resist);

        resist = 1.0f + ( floor( 256.0f * ( PDefender->getMod(Mod::DMGBREATH) / 100.0f ) ) / 256.0f )
                      + ( floor( 256.0f * ( PDefender->getMod(Mod::DMG)       / 100.0f ) ) / 256.0f );
        resist = std::clamp(resist, 0.5f, 1.5f); //assuming if its floored at .5f its capped at 1.5f but who's stacking +dmgtaken equip anyway???
        damage = (int32)(damage * resist);

        if (tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE))
            damage = -damage;
        else
        {
            damage = HandleSevereDamage(PDefender, damage, false);
            int16 absorbedMP = (int16)(damage * PDefender->getMod(Mod::ABSORB_DMG_TO_MP) / 100);
            if (absorbedMP > 0)
                PDefender->addMP(absorbedMP);
        }

        return damage;
    }

    int32 MagicDmgTaken(CBattleEntity* PDefender, int32 damage, ELEMENT element)
    {
        Mod absorb[8] = { Mod::FIRE_ABSORB, Mod::EARTH_ABSORB, Mod::WATER_ABSORB, Mod::WIND_ABSORB, Mod::ICE_ABSORB, Mod::LTNG_ABSORB, Mod::LIGHT_ABSORB, Mod::DARK_ABSORB };
        Mod nullarray[8] = { Mod::FIRE_NULL, Mod::EARTH_NULL, Mod::WATER_NULL, Mod::WIND_NULL, Mod::ICE_NULL, Mod::LTNG_NULL, Mod::LIGHT_NULL, Mod::DARK_NULL };

        float resist = 1.f + PDefender->getMod(Mod::UDMGMAGIC) / 100.f;
        resist = std::max(resist, 0.f);
        damage = (int32)(damage * resist);

        resist = 1.f + PDefender->getMod(Mod::DMGMAGIC) / 100.f + PDefender->getMod(Mod::DMG) / 100.f;
        resist = std::max(resist, 0.5f);
        resist += PDefender->getMod(Mod::DMGMAGIC_II) / 100.f;
        resist = std::max(resist, 0.125f); // Total cap with MDT-% II included is 87.5%
        damage = (int32)(damage * resist);

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_STEAM_JACKET) > 1)
            damage = HandleSteamJacket(PDefender, damage, 5);

        if (tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE) ||
            (element && tpzrand::GetRandomNumber(100) < PDefender->getMod(absorb[element - 1])) ||
            tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::MAGIC_ABSORB))
            damage = -damage;
        else if ((element && tpzrand::GetRandomNumber(100) < PDefender->getMod(nullarray[element - 1])) ||
            tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::MAGIC_NULL))
            damage = 0;
        else
        {
            damage = HandleSevereDamage(PDefender, damage, false);
            int16 absorbedMP = (int16)(damage * PDefender->getMod(Mod::ABSORB_DMG_TO_MP) / 100);
            if (absorbedMP > 0)
                PDefender->addMP(absorbedMP);
        }

        //ShowDebug(CL_CYAN"MagicDmgTaken: Element = %d\n" CL_RESET, element);
        return damage;
    }

    int32 PhysicalDmgTaken(CBattleEntity* PDefender, int32 damage, int16 damageType)
    {
        float resist = 1.f + PDefender->getMod(Mod::UDMGPHYS) / 100.f;
        resist = std::max(resist, 0.f);
        damage = (int32)(damage * resist);

        resist = 1.f + PDefender->getMod(Mod::DMGPHYS) / 100.f + PDefender->getMod(Mod::DMG) / 100.f;
        resist = std::max(resist, 0.5f); // PDT caps at -50%
        resist += PDefender->getMod(Mod::DMGPHYS_II) / 100.f; // Add Burtgang reduction after 50% cap. Extends cap to -68%
        damage = (int32)(damage * resist);

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_STEAM_JACKET) > 0)
            damage = HandleSteamJacket(PDefender, damage, damageType);

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_EQUALIZER) > 0)
            damage -= (int32)(damage / float(PDefender->GetMaxHP()) * (PDefender->getMod(Mod::AUTO_EQUALIZER) / 100.0f));

        if (tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE) ||
            tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::PHYS_ABSORB))
            damage = -damage;
        else if (tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_PHYSICAL_DAMAGE))
            damage = 0;
        else
        {
            damage = HandleSevereDamage(PDefender, damage, true);
            int16 absorbedMP = (int16)(damage * (PDefender->getMod(Mod::ABSORB_DMG_TO_MP) + PDefender->getMod(Mod::ABSORB_PHYSDMG_TO_MP)) / 100);
            if (absorbedMP > 0)
                PDefender->addMP(absorbedMP);
            damage = HandleFanDance(PDefender, damage);
        }

        return damage;
    }

    int32 RangedDmgTaken(CBattleEntity* PDefender, int32 damage, int16 damageType)
    {
        float resist = 1.0f + PDefender->getMod(Mod::UDMGRANGE) / 100.f;
        resist = std::max(resist, 0.f);
        damage = (int32)(damage * resist);

        resist = 1.0f + PDefender->getMod(Mod::DMGRANGE) / 100.f + PDefender->getMod(Mod::DMG) / 100.f;
        resist = std::max(resist, 0.5f);
        damage = (int32)(damage * resist);

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_STEAM_JACKET) > 0)
            damage = HandleSteamJacket(PDefender, damage, damageType);

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_EQUALIZER) > 0)
        {
            damage -= (int32)(damage / float(PDefender->GetMaxHP()) * (PDefender->getMod(Mod::AUTO_EQUALIZER) / 100.0f));
        }

        if (tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE) ||
            tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::PHYS_ABSORB))
            damage = -damage;
        else if (tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_PHYSICAL_DAMAGE))
            damage = 0;
        else
        {
            damage = HandleSevereDamage(PDefender, damage, true);
            int16 absorbedMP = (int16)(damage * (PDefender->getMod(Mod::ABSORB_DMG_TO_MP) + PDefender->getMod(Mod::ABSORB_PHYSDMG_TO_MP)) / 100);
            if (absorbedMP > 0)
                PDefender->addMP(absorbedMP);
            damage = HandleFanDance(PDefender, damage);
        }

        return damage;
    }

    int32 HandleSteamJacket(CBattleEntity* PDefender, int32 damage, int16 damageType)
    {
        auto steamJacketType = (int16)PDefender->GetLocalVar("steam_jacket_type");
        int16 steamJacketHits = (int16)PDefender->GetLocalVar("steam_jacket_hits");

        if (steamJacketType != damageType)
        {
            PDefender->SetLocalVar("steam_jacket_type", damageType);
            steamJacketHits = 0;
        }

        steamJacketHits += 1;
        PDefender->SetLocalVar("steam_jacket_hits", steamJacketHits);

        if (steamJacketHits >= PDefender->getMod(Mod::AUTO_STEAM_JACKET))
            return damage - (int32)(damage * (PDefender->getMod(Mod::AUTO_STEAM_JACKED_REDUCTION) / 100.0f));
        return damage;
    }

    void HandleIssekiganEnmityBonus(CBattleEntity* PDefender, CBattleEntity* PAttacker) {
        if (PAttacker->objtype == TYPE_MOB &&
             PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ISSEKIGAN)) {
            // Issekigan is Known to Grant 300 CE per parry, but unknown how it effects VE (per bgwiki). So VE is left alone for now.
            static_cast<CMobEntity*>(PAttacker)->PEnmityContainer->UpdateEnmity(PDefender, 300, 0, false);
        }
    }

    void HandleAfflatusMiseryAccuracyBonus(CBattleEntity* PAttacker) {
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_AFFLATUS_MISERY) &&
            PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_AUSPICE)) {

            // We keep track of the running total of Accuracy Bonus as part of the Sub Power of the Effect
            // This is used to re-adjust Mod::ACC when the effect wears off

            uint16 accBonus = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_AFFLATUS_MISERY)->GetSubPower();

            // Per BGWiki, this bonus is thought to cap at +30
            if (accBonus < 30) {
                accBonus = accBonus + 10;
                PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_AFFLATUS_MISERY)->SetSubPower(accBonus);

                // Update the Accuracy Modifer as well, so that this is reflected
                // throughout the battle system
                PAttacker->addModifier(Mod::ACC, 10);
            }
        }
    }

    void HandleAfflatusMiseryDamage(CBattleEntity* PDefender, int32 damage)
    {
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_AFFLATUS_MISERY) && damage > 0)
        {
            PDefender->setModifier(Mod::AFFLATUS_MISERY, damage);
            // ShowDebug("Misery power: %d\n", damage);
        }
    }

    void HandleTacticalParry(CBattleEntity* PEntity)
    {
        if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(PEntity))
        {
            if (charutils::hasTrait(PChar, TRAIT_TACTICAL_PARRY))
            {
                int16 tpBonus = PChar->getMod(Mod::TACTICAL_PARRY);
                PChar->addTP(tpBonus);
            }
        }
    }

    void HandleTacticalGuard(CBattleEntity* PEntity)
    {
        if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(PEntity))
        {
            if (charutils::hasTrait(PChar, TRAIT_TACTICAL_GUARD))
            {
                int16 tpBonus = PChar->getMod(Mod::TACTICAL_GUARD);
                PChar->addTP(tpBonus);
            }
        }
    }

    float HandleTranquilHeart(CBattleEntity* PEntity)
    {
        float reductionPercent = 0.f;

        if (PEntity->objtype == TYPE_PC && charutils::hasTrait((CCharEntity*)PEntity, TRAIT_TRANQUIL_HEART))
        {
            int16 healingSkill = PEntity->GetSkill(SKILL_HEALING_MAGIC);
            reductionPercent = ((healingSkill / 10) * .5f);

            // Reduction Percent Caps at 25%
            if (reductionPercent > 25) {
                reductionPercent = 25;
            }

            //ShowDebug(CL_CYAN"HandleTranquilHeart: Tranquil Heart is Active! Reduction Percent = %f\n" CL_RESET, reductionPercent);

            reductionPercent = reductionPercent / 100.f;
        }

        return reductionPercent;
    }

    void BindBreakCheck(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_BIND))
        {
            uint16 BindBreakChance = 0; // 0-1000 (100.0%) scale. Maybe change to a float later..
            EMobDifficulty mobCheck = charutils::CheckMob(PAttacker->GetMLevel(), PDefender->GetMLevel());

            // Todo: replace with an actual calculated value based on level difference. Not it, Bro!
            // This entire block of conditionals should not exist. Lv diff really shouldn't be handled at the exp check level either.
            // It might not even be in sync with the check values the entire way from lv 1 to lv 99 for all we know.
            switch (mobCheck)
            {
            case EMobDifficulty::TooWeak:
            case EMobDifficulty::IncrediblyEasyPrey:
                BindBreakChance = 10;
                break;

            case EMobDifficulty::EasyPrey:
            case EMobDifficulty::DecentChallenge:
                BindBreakChance = 150;
                break;

            case EMobDifficulty::EvenMatch:
                BindBreakChance = 300;
                break;

            case EMobDifficulty::Tough:
                BindBreakChance = 750;
                break;

            case EMobDifficulty::VeryTough:
            case EMobDifficulty::IncrediblyTough:
                BindBreakChance = 990;
                break;

            default:
                // no-op
                break;
            }

            if (BindBreakChance > tpzrand::GetRandomNumber(1000))
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_BIND);
        }
    }

    int32 HandleStoneskin(CBattleEntity* PDefender, int32 damage)
    {
        int16 skin = PDefender->getMod(Mod::STONESKIN);
        if (damage > 0 && skin > 0)
        {
            if (skin > damage)
            {
                PDefender->delModifier(Mod::STONESKIN, damage);
                return 0;
            }

            PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_STONESKIN);
            return damage - skin;
        }

        return damage;
    }

    int32 HandleSevereDamage(CBattleEntity* PDefender, int32 damage, bool isPhysical) {
        damage = HandleSevereDamageEffect(PDefender, EFFECT_MIGAWARI, damage, true);
        // In the future, handle other Severe Damage Effects like Earthen Armor here

        if (isPhysical && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_SCHURZEN) != 0 && damage >= PDefender->health.hp &&
            ((CPetEntity*)PDefender)->PMaster->StatusEffectContainer->GetEffectsCount(EFFECT_EARTH_MANEUVER) >= 1)
        {
            damage = PDefender->health.hp - 1;
            ((CPetEntity*)PDefender)->PMaster->StatusEffectContainer->DelStatusEffectSilent(EFFECT_EARTH_MANEUVER);
        }

        return damage;
    }

    int32 HandleFanDance(CBattleEntity* PDefender, int32 damage)
    {
        // Handle Fan Dance
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_FAN_DANCE))
        {

            int power = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_FAN_DANCE)->GetPower();
            float resist = 1.0f - (power / 100.0f);
            damage = (int32)(damage * resist);
            if (power > 20)
            {
                // reduce fan dance effectiveness by 10% each hit, to a min of 20%
                PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_FAN_DANCE)->SetPower(power - 10);
            }
        }
        return damage;
    }

    int32 HandleSevereDamageEffect(CBattleEntity* PDefender, EFFECT effect, int32 damage, bool removeEffect) {

        if (PDefender->StatusEffectContainer->HasStatusEffect(effect)) {
            int32 maxHp = PDefender->GetMaxHP();

            // The Threshold for Damage is Stored in the Effect Power
            float threshold = (PDefender->StatusEffectContainer->GetStatusEffect(effect)->GetPower() / 100.00f);

            // We calcluate the Damage Threshold off of Max HP & the Threshold Percentage
            float damageThreshold = maxHp * threshold;

            //ShowDebug(CL_CYAN"HandleSevereDamageEffect: Severe Damage Occurred! Damage = %d, Threshold = %f, Damage Threshold = %f\n" CL_RESET, damage, threshold, damageThreshold);

            // Severe Damage is when the Attack's Damage Exceeds a Certain Threshold
            if (damage > damageThreshold) {
                uint16 severeReduction = PDefender->StatusEffectContainer->GetStatusEffect(effect)->GetSubPower();
                severeReduction = std::clamp((100 - severeReduction), 0, 100) / 100;
                damage = damage * severeReduction;

                if (removeEffect) {
                    PDefender->StatusEffectContainer->DelStatusEffect(effect);
                }

                //ShowDebug(CL_CYAN"HandleSevereDamageEffect: Reduciing Severe Damage!\n" CL_RESET);
            }
        }

        //ShowDebug(CL_CYAN"HandleSevereDamageEffect: NOT Reducing Severe Damage!\n" CL_RESET);

        return damage;
    }



    /************************************************************************
    *                                                                       *
    *   handle the /assist command                                          *
    *                                                                       *
    ************************************************************************/
    void assistTarget(CCharEntity* PChar, uint16 TargID)
    {
        // get the player we want to assist
        CBattleEntity* PlayerToAssist = (CBattleEntity*)PChar->GetEntity(TargID, TYPE_MOB | TYPE_PC);
        if (PlayerToAssist != nullptr)
        {
            if (PlayerToAssist->objtype == TYPE_PC && PlayerToAssist->m_TargID != 0)
            {
                // get that players target (mob,player,pet only)
                CBattleEntity* EntityToLockon = (CBattleEntity*)PChar->GetEntity(PlayerToAssist->m_TargID, TYPE_MOB | TYPE_PC | TYPE_PET);
                if (EntityToLockon != nullptr)
                {
                    // lock on to the new target!
                    PChar->pushPacket(new CLockOnPacket(PChar, EntityToLockon));
                }
            }
            else if (PlayerToAssist->GetBattleTargetID() != 0)
            {
                // lock on to the new target!
                PChar->pushPacket(new CLockOnPacket(PChar, PlayerToAssist->GetBattleTarget()));
            }
        }
    }

    uint8 GetSpellAoEType(CBattleEntity* PCaster, CSpell* PSpell)
    {
        if (PSpell->getAOE() == SPELLAOE_RADIAL_ACCE) // Divine Veil goes here because -na spells have AoE w/ Accession
        {
            if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_ACCESSION) || (PCaster->objtype == TYPE_PC &&
                charutils::hasTrait((CCharEntity*)PCaster, TRAIT_DIVINE_VEIL) && PSpell->isNa() &&
                (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_DIVINE_SEAL) || PCaster->getMod(Mod::AOE_NA) == 1)))
                return SPELLAOE_RADIAL;
            else
                return SPELLAOE_NONE;
        }
        if (PSpell->getAOE() == SPELLAOE_RADIAL_MANI)
        {
            if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_MANIFESTATION))
                return SPELLAOE_RADIAL;
            else
                return SPELLAOE_NONE;
        }
        if (PSpell->getAOE() == SPELLAOE_PIANISSIMO)
        {
            if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_PIANISSIMO))
            {
                PCaster->StatusEffectContainer->DelStatusEffect(EFFECT_PIANISSIMO);
                return SPELLAOE_NONE;
            }
            else
                return SPELLAOE_RADIAL;
        }
        if (PSpell->getAOE() == SPELLAOE_DIFFUSION)
        {
            if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_DIFFUSION))
                return SPELLAOE_RADIAL;
            else
                return SPELLAOE_NONE;
        }

        return PSpell->getAOE();
    }

    WEATHER GetWeather(CBattleEntity* PEntity, bool ignoreScholar)
    {
        return GetWeather(PEntity, ignoreScholar, zoneutils::GetZone(PEntity->getZone())->GetWeather());
    }

    WEATHER GetWeather(CBattleEntity* PEntity, bool ignoreScholar, uint16 zoneWeather)
    {
        WEATHER scholarSpell = WEATHER_NONE;
        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_FIRESTORM))
            scholarSpell = WEATHER_HOT_SPELL;
        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_RAINSTORM))
            scholarSpell = WEATHER_RAIN;
        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SANDSTORM))
            scholarSpell = WEATHER_DUST_STORM;
        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_WINDSTORM))
            scholarSpell = WEATHER_WIND;
        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_HAILSTORM))
            scholarSpell = WEATHER_SNOW;
        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_THUNDERSTORM))
            scholarSpell = WEATHER_THUNDER;
        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_AURORASTORM))
            scholarSpell = WEATHER_AURORAS;
        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_VOIDSTORM))
            scholarSpell = WEATHER_GLOOM;

        if (ignoreScholar || scholarSpell == WEATHER_NONE || zoneWeather == (scholarSpell + 1)) // Strong weather overwrites scholar spell weak weather
            return (WEATHER)zoneWeather;
        else if (scholarSpell == zoneWeather)
            return (WEATHER)(zoneWeather + 1); // Storm spells stack with weather
        else
            return scholarSpell;
    }

    bool WeatherMatchesElement(WEATHER weather, uint8 element)
    {
        switch (element)
        {
            case ELEMENT_NONE:
                return false; // Can't match with no element...
                break;
            case ELEMENT_FIRE:
                switch (weather)
                {
                    case WEATHER_HOT_SPELL:
                    case WEATHER_HEAT_WAVE:
                        return true;
                        break;
                    default:
                        return false;
                }
                break;
            case ELEMENT_EARTH:
                switch (weather)
                {
                    case WEATHER_DUST_STORM:
                    case WEATHER_SAND_STORM:
                        return true;
                        break;
                    default:
                        return false;
                }
                break;
            case ELEMENT_WATER:
                switch (weather)
                {
                    case WEATHER_RAIN:
                    case WEATHER_SQUALL:
                        return true;
                        break;
                    default:
                        return false;
                }
                break;
            case ELEMENT_WIND:
                switch (weather)
                {
                    case WEATHER_WIND:
                    case WEATHER_GALES:
                        return true;
                        break;
                    default:
                        return false;
                }
                break;
            case ELEMENT_ICE:
                switch (weather)
                {
                    case WEATHER_SNOW:
                    case WEATHER_BLIZZARDS:
                        return true;
                        break;
                    default:
                        return false;
                }
                break;
            case ELEMENT_THUNDER:
                switch (weather)
                {
                    case WEATHER_THUNDER:
                    case WEATHER_THUNDERSTORMS:
                        return true;
                        break;
                    default:
                        return false;
                }
                break;
            case ELEMENT_LIGHT:
                switch (weather)
                {
                    case WEATHER_AURORAS:
                    case WEATHER_STELLAR_GLARE:
                        return true;
                        break;
                    default:
                        return false;
                }
                break;
            case ELEMENT_DARK:
                switch (weather)
                {
                    case WEATHER_GLOOM:
                    case WEATHER_DARKNESS:
                        return true;
                        break;
                    default:
                        return false;
                }
                break;
            default:
                return false;
        }
    }

    bool DrawIn(CBattleEntity* PEntity, CMobEntity* PMob, float offset)
    {
        position_t& pos = PMob->loc.p;
        position_t nearEntity = nearPosition(pos, offset, (float)0);

        // validate the drawin position before continuing
        if (!PMob->PAI->PathFind->ValidPosition(pos))
        {
            return false;
        }

        bool success = false;
        float drawInDistance = (float)(PMob->getMobMod(MOBMOD_DRAW_IN) > 1 ? PMob->getMobMod(MOBMOD_DRAW_IN) : PMob->GetMeleeRange() * 2);

        if (std::chrono::time_point_cast<std::chrono::seconds>(server_clock::now()).time_since_epoch().count() - PMob->GetLocalVar("DrawInTime") < 2)
            return false;

        std::function <void(CBattleEntity*)> drawInFunc = [PMob, drawInDistance, &nearEntity, &success](CBattleEntity* PMember)
        {
            float pDistance = distance(PMob->loc.p, PMember->loc.p);

            if (PMob->loc.zone == PMember->loc.zone && pDistance > drawInDistance && PMember->status != STATUS_CUTSCENE_ONLY)
            {
                // don't draw in dead players for now!
                // see tractor
                if (PMember->isDead() || PMember->isMounted())
                {
                    // don't do anything
                }
                else
                {
                    // draw in!
                    PMember->loc.p.x = nearEntity.x;
                    // move a little higher to prevent getting stuck
                    PMember->loc.p.y = nearEntity.y - 0.5f;
                    PMember->loc.p.z = nearEntity.z;

                    if (PMember->objtype == TYPE_PC)
                    {
                        CCharEntity* PChar = (CCharEntity*)PMember;
                        PChar->pushPacket(new CPositionPacket(PChar));
                    }
                    else
                    {
                        PMember->loc.zone->PushPacket(PMember, CHAR_INRANGE, new CEntityUpdatePacket(PMember, ENTITY_UPDATE, UPDATE_POS));
                    }

                    luautils::OnMobDrawIn(PMob, PMember);
                    PMob->loc.zone->PushPacket(PMob, CHAR_INRANGE, new CMessageBasicPacket(PMember, PMember, 0, 0, 232));
                    success = true;
                }
            }
        };

        // check if i should draw-in party/alliance
        if (PMob->getMobMod(MOBMOD_DRAW_IN) > 1)
        {
            PEntity->ForAlliance(drawInFunc);
        }
        // no party present or draw-in is set to target only
        else
        {
            drawInFunc(PEntity);
        }

        if (success)
            PMob->SetLocalVar("DrawInTime", (uint32)std::chrono::time_point_cast<std::chrono::seconds>(server_clock::now()).time_since_epoch().count());

        return success;
    }

    /************************************************************************
    *                                                                       *
    *   Does the wild card effect to a specific character                   *
    *                                                                       *
    ************************************************************************/
    void DoWildCardToEntity(CCharEntity* PCaster, CCharEntity* PTarget, uint8 roll)
    {
        auto TotalRecasts = PTarget->PRecastContainer->GetRecastList(RECAST_ABILITY)->size();

        // Don't count the 2hr.
        if (PTarget->PRecastContainer->Has(RECAST_ABILITY, 0))
        {
            TotalRecasts -= 1;
        }

        // Restore some abilities (Randomly select some abilities?)
        auto RecastsToDelete = tpzrand::GetRandomNumber(TotalRecasts == 0 ? 1 : TotalRecasts);

        // Restore at least 1 ability (unless none are on recast)
        RecastsToDelete = TotalRecasts == 0 ? 0 : RecastsToDelete == 0 ? 1 : RecastsToDelete;

        switch (roll)
        {
            case 1:
                // Restores some Job Abilities (does not restore One Hour Abilities)
                for (auto i = RecastsToDelete; i > 0; --i)
                {
                    if (PTarget->PRecastContainer->GetRecastList(RECAST_ABILITY)->at(i - 1).ID != 0)
                    {
                        PTarget->PRecastContainer->DeleteByIndex(RECAST_ABILITY, (uint8)(i - 1));
                    }
                }
                break;

            case 2:
                // Restores all Job Abilities (does not restore One Hour Abilities)
                PTarget->PRecastContainer->ResetAbilities();
                break;

            case 3:
                // Restores some Job Abilities (does not restore One Hour Abilities), 100% TP Restore
                for (auto i = RecastsToDelete; i > 0; --i)
                {
                    if (PTarget->PRecastContainer->GetRecastList(RECAST_ABILITY)->at(i - 1).ID != 0)
                    {
                        PTarget->PRecastContainer->DeleteByIndex(RECAST_ABILITY, (uint8)(i - 1));
                    }
                }
                PTarget->health.tp = 1000;
                break;

            case 4:
                // Restores all Job Abilities (does not restore One Hour Abilities), 300% TP Restore
                PTarget->PRecastContainer->ResetAbilities();
                PTarget->health.tp = 3000;
                break;

            case 5:
                // Restores some Job Abilities and One Hour Abilities (Not Wild Card though), 50% MP Restore
                for (auto i = RecastsToDelete; i > 0; --i)
                {
                    if (PTarget->PRecastContainer->GetRecastList(RECAST_ABILITY)->at(i - 1).ID != 0)
                    {
                        PTarget->PRecastContainer->DeleteByIndex(RECAST_ABILITY, (uint8)(i - 1));
                    }
                }

                // Restore 2hr except for Wildcard.
                if (PTarget->GetMJob() != JOB_COR)
                {
                    PTarget->PRecastContainer->Del(RECAST_ABILITY, 0);
                }

                if (PTarget->health.maxmp > 0 && (PTarget->health.mp < (PTarget->health.maxmp / 2)))
                {
                    PTarget->health.mp = PTarget->health.maxmp / 2;
                }
                break;

            case 6:
                // Restores all Job Abilities and One Hour Abilities (Not Wild Card though), 100% MP Restore
                if (PTarget->GetMJob() == JOB_COR)
                {
                    PTarget->PRecastContainer->ResetAbilities();
                }
                else
                {
                    PTarget->PRecastContainer->Del(RECAST_ABILITY);
                }
                PTarget->addMP(PTarget->health.maxmp);
                break;
        }
    }

    /************************************************************************
    *                                                                       *
    *   Get the Snapshot shot time reduction                                *
    *                                                                       *
    ************************************************************************/
    int16 GetSnapshotReduction(CCharEntity* m_PChar, int16 delay)
    {
        auto SnapShotReductionPercent {m_PChar->getMod(Mod::SNAP_SHOT)};

        if (charutils::hasTrait(m_PChar, TRAIT_SNAPSHOT))
        {
            SnapShotReductionPercent += m_PChar->PMeritPoints->GetMeritValue(MERIT_SNAPSHOT, m_PChar);
        }

        // Reduction from velocity shot mod
        if (m_PChar->StatusEffectContainer->HasStatusEffect(EFFECT_VELOCITY_SHOT))
        {
            SnapShotReductionPercent += m_PChar->getMod(Mod::VELOCITY_SNAPSHOT_BONUS);
        }

        return (int16)(delay * (100 - SnapShotReductionPercent) / 100.f);
    }

    /************************************************************************
    *                                                                       *
    *   Get any ranged attack bonuses here                                  *
    *                                                                       *
    ************************************************************************/
    int32 GetRangedAttackBonuses(CBattleEntity* battleEntity)
    {
        if (battleEntity->objtype != TYPE_PC)
        {
            return 0;
        }

        int32 bonus = 0;

        // Reduction from velocity shot mod
        if (battleEntity->StatusEffectContainer->HasStatusEffect(EFFECT_VELOCITY_SHOT))
        {
            bonus += battleEntity->getMod(Mod::VELOCITY_RATT_BONUS);
        }

        return bonus;
    }


    /************************************************************************
    *                                                                       *
    *   Get any ranged accuracy bonuses here                                *
    *                                                                       *
    ************************************************************************/
    int32 GetRangedAccuracyBonuses(CBattleEntity* battleEntity)
    {
        if (battleEntity->objtype != TYPE_PC)
        {
            return 0;
        }

        int32 bonus = 0;

        // Bonus from barrage mod
        if (battleEntity->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE))
        {
            bonus += battleEntity->getMod(Mod::BARRAGE_ACC);
        }

        return bonus;
    }

    void AddTraits(CBattleEntity* PEntity, TraitList_t* traitList, uint8 level)
    {
        CCharEntity* PChar = PEntity->objtype == TYPE_PC ? static_cast<CCharEntity*>(PEntity) : nullptr;

        for (auto&& PTrait : *traitList)
        {
            if (level >= PTrait->getLevel() && PTrait->getLevel() > 0)
            {
                bool add = true;

                for (uint8 j = 0; j < PEntity->TraitList.size(); ++j)
                {
                    CTrait* PExistingTrait = PEntity->TraitList.at(j);

                    if (PExistingTrait->getID() == PTrait->getID())
                    {
                        // Check if we still have the merit required for this trait
                        if (PChar)
                        {
                            if (PExistingTrait->getMeritID() > 0)
                            {
                                if (PChar->PMeritPoints->GetMerit((MERIT_TYPE)PExistingTrait->getMeritID())->count == 0)
                                {
                                    PEntity->delTrait(PExistingTrait);
                                    break;
                                }
                                else if (PExistingTrait->getMeritID() == PTrait->getMeritID())
                                {
                                    add = false;
                                    break;
                                }
                            }
                        }

                        if (PExistingTrait->getRank() < PTrait->getRank())
                        {
                            PEntity->delTrait(PExistingTrait);
                            break;
                        }
                        else if (PExistingTrait->getRank() > PTrait->getRank())
                        {
                            add = false;
                            break;
                        }
                        else if (PExistingTrait->getMod() == PTrait->getMod())
                        {
                            add = false;
                            break;
                        }
                    }
                }

                // Don't add traits that aren't merited yet
                if (PChar)
                {
                    if (PTrait->getMeritID() > 0 && PChar->PMeritPoints->GetMerit((MERIT_TYPE)PTrait->getMeritID())->count == 0)
                    {
                        add = false;
                    }
                }

                if (add)
                {
                    PEntity->addTrait(PTrait);
                }
            }
        }
    }

    bool HasClaim(CBattleEntity* PEntity, CBattleEntity* PTarget)
    {
        TPZ_DEBUG_BREAK_IF(PTarget == nullptr);
        CBattleEntity* PMaster = PEntity;

        if (PEntity->PMaster != nullptr)
        {
            PMaster = PEntity->PMaster;
        }

        if (PTarget->m_OwnerID.id == PMaster->id)
        {
            return true;
        }

        bool found = false;

        PMaster->ForAlliance([&PTarget, &found](CBattleEntity* PChar){
            if (PChar->id == PTarget->m_OwnerID.id)
            {
                found = true;
            }
        });

        return found;
    }

    uint32 CalculateSpellCastTime(CBattleEntity* PEntity, CMagicState* PMagicState)
    {
        CSpell* PSpell = PMagicState->GetSpell();
        if (PSpell == nullptr)
        {
            return 0;
        }

        // Check Quick Magic procs
        int16 quickMagicRate = PEntity->getMod(Mod::QUICK_MAGIC);
        if (tpzrand::GetRandomNumber(100) < quickMagicRate)
        {
            PMagicState->SetInstantCast(true);
            return 0;
        }

        bool applyArts = true;
        uint32 base = PSpell->getCastTime();
        uint32 cast = base;

        if (PEntity->StatusEffectContainer->HasStatusEffect({EFFECT_HASSO, EFFECT_SEIGAN}))
        {
            cast = (uint32)(cast * 2.0f);
        }

        if (PSpell->getSpellGroup() == SPELLGROUP_BLACK)
        {
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ALACRITY))
            {
                uint16 bonus = 0;
                //Only apply Alacrity/celerity mod if the spell element matches the weather.
                if (battleutils::WeatherMatchesElement(battleutils::GetWeather(PEntity, false), (uint8)PSpell->getElement()))
                {
                    bonus = PEntity->getMod(Mod::ALACRITY_CELERITY_EFFECT);
                }
                cast -= (uint32)(base * ((100 - (50 + bonus)) / 100.0f));
                applyArts = false;
            }
            else if (applyArts)
            {
                if (PEntity->StatusEffectContainer->HasStatusEffect({EFFECT_DARK_ARTS, EFFECT_ADDENDUM_BLACK}))
                {
                    // Add any "Grimoire: Reduces spellcasting time" bonuses
                    cast = (uint32)(cast * (1.0f + (PEntity->getMod(Mod::BLACK_MAGIC_CAST) + PEntity->getMod(Mod::GRIMOIRE_SPELLCASTING)) / 100.0f));
                }
                else
                {
                    cast = (uint32)(cast * (1.0f + PEntity->getMod(Mod::BLACK_MAGIC_CAST) / 100.0f));
                }
            }
        }
        else if (PSpell->getSpellGroup() == SPELLGROUP_WHITE)
        {
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_CELERITY))
            {
                uint16 bonus = 0;
                //Only apply Alacrity/celerity mod if the spell element matches the weather.
                if (battleutils::WeatherMatchesElement(battleutils::GetWeather(PEntity, false), (uint8)PSpell->getElement()))
                {
                    bonus = PEntity->getMod(Mod::ALACRITY_CELERITY_EFFECT);
                }
                cast -= (uint32)(base * ((100 - (50 + bonus)) / 100.0f));
                applyArts = false;
            }
            else if (applyArts)
            {
                if (PEntity->StatusEffectContainer->HasStatusEffect({EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE}))
                {
                    // Add any "Grimoire: Reduces spellcasting time" bonuses
                    cast = (uint32)(cast * (1.0f + (PEntity->getMod(Mod::WHITE_MAGIC_CAST) + PEntity->getMod(Mod::GRIMOIRE_SPELLCASTING)) / 100.0f));
                }
                else
                {
                    cast = (uint32)(cast * (1.0f + PEntity->getMod(Mod::WHITE_MAGIC_CAST) / 100.0f));
                }
            }
        }
        else if (PSpell->getSpellGroup() == SPELLGROUP_SONG)
        {
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_PIANISSIMO))
            {
                if (PSpell->getAOE() == SPELLAOE_PIANISSIMO)
                {
                    cast = base / 2;
                }
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_NIGHTINGALE))
            {
                if (PEntity->objtype == TYPE_PC &&
                    tpzrand::GetRandomNumber(100) < ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_NIGHTINGALE, (CCharEntity*)PEntity) - 25)
                {
                    return 0;
                }
                cast = (uint32)(cast * 0.5f);
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TROUBADOUR))
            {
                cast = (uint32)(cast * 1.5f);
            }
            uint16 songcasting = PEntity->getMod(Mod::SONG_SPELLCASTING_TIME);
            cast = (uint32)(cast * (1.0f - ((songcasting > 50 ? 50 : songcasting) / 100.0f)));
        }

        int16 fastCast = std::clamp<int16>(PEntity->getMod(Mod::FASTCAST), -100, 50);
        if (PSpell->getSkillType() == SKILLTYPE::SKILL_ELEMENTAL_MAGIC) // Elemental Celerity reductions
        {
            fastCast += PEntity->getMod(Mod::ELEMENTAL_CELERITY);
        }
        else if (PSpell->isCure()) // Cure cast time reductions
        {
            fastCast += PEntity->getMod(Mod::CURE_CAST_TIME);
            if (PEntity->objtype == TYPE_PC)
            {
                fastCast += ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_CURE_CAST_TIME, (CCharEntity*)PEntity);
            }
        }

        fastCast = std::clamp<int16>(fastCast, -100, 80);
        int16 uncappedFastCast = std::clamp<int16>(PEntity->getMod(Mod::UFASTCAST), -100, 100);

        // Add in fast cast from Divine Benison
        if (PSpell->isNa())
        {
            uncappedFastCast = std::clamp<int16>(uncappedFastCast + PEntity->getMod(Mod::DIVINE_BENISON), -100, 100);
        }

        float sumFastCast = std::clamp<float>((float)(fastCast + uncappedFastCast), -100.f, 100.f);

        return (uint32)(cast * ((100.0f - sumFastCast) / 100.0f));
    }

    uint16 CalculateSpellCost(CBattleEntity* PEntity, CSpell* PSpell)
    {
        if (PSpell == nullptr)
        {
            ShowWarning("battleutils::CalculateMPCost Spell is NULL\n");
            return 0;
        }

        // ninja tools or bard song
        if (!PSpell->hasMPCost())
        {
            return 0;
        }

        bool applyArts = true;
        uint16 base = PSpell->getMPCost();
        if (PSpell->getID() == SpellID::Embrava || PSpell->getID() == SpellID::Kaustra) //Embrava/Kaustra
        {
            base = (uint16)(PEntity->health.maxmp * 0.2);
        }

        int16 cost = base;

        if (PSpell->getSpellGroup() == SPELLGROUP_BLACK)
        {
            if (PSpell->getAOE() == SPELLAOE_RADIAL_MANI && PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANIFESTATION))
            {
                cost *= 2;
                applyArts = false;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_PARSIMONY))
            {
                cost /= 2;
                applyArts = false;
            }
            else if (applyArts)
            {
                cost += (int16)(base * (PEntity->getMod(Mod::BLACK_MAGIC_COST) / 100.0f));
            }
        }
        else if (PSpell->getSpellGroup() == SPELLGROUP_WHITE)
        {
            if (PSpell->getAOE() == SPELLAOE_RADIAL_ACCE && PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ACCESSION))
            {
                cost *= 2;
                applyArts = false;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_PENURY))
            {
                cost /= 2;
                applyArts = false;
            }
            else if (applyArts)
            {
                cost += (int16)(base * (PEntity->getMod(Mod::WHITE_MAGIC_COST) / 100.0f));
            }
        }
        if (tpzrand::GetRandomNumber(100) < (PEntity->getMod(Mod::NO_SPELL_MP_DEPLETION)))
        {
            cost = 0;
        }
        return std::clamp<int16>(cost, 0, 9999);
    }
    uint32 CalculateSpellRecastTime(CBattleEntity* PEntity, CSpell* PSpell)
    {
        if (PSpell == nullptr)
        {
            return 0;
        }

        bool applyArts = true;
        uint32 base = PSpell->getRecastTime();
        int32 recast = base;

        // Apply Fast Cast
        recast = (int32)(recast * ((100.0f - std::clamp((float)PEntity->getMod(Mod::FASTCAST) / 2.0f, 0.0f, 25.0f)) / 100.0f));

        // Apply Haste (Magic and Gear)
        int16 haste = PEntity->getMod(Mod::HASTE_MAGIC) + PEntity->getMod(Mod::HASTE_GEAR);
        recast -= (int32)(recast * haste / 10000.f);

        if (PSpell->getSpellGroup() == SPELLGROUP_SONG)
        {
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_NIGHTINGALE))
            {
                recast = (int32)(recast * 0.5f);
            }
            // The following modifiers are not multiplicative - as such they must be applied last.
            // ShowDebug("Recast before reduction: %u\n", recast);
            if (PEntity->objtype == TYPE_PC)
            {
                if (PSpell->getID() == SpellID::Magic_Finale) // apply Finale recast merits
                {
                    recast -= ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_FINALE_RECAST, (CCharEntity*)PEntity) * 1000;
                }
                if (PSpell->getID() == SpellID::Foe_Lullaby || PSpell->getID() == SpellID::Foe_Lullaby_II || PSpell->getID() == SpellID::Horde_Lullaby || PSpell->getID() == SpellID::Horde_Lullaby_II) // apply Lullaby recast merits
                {
                    recast -= ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_LULLABY_RECAST, (CCharEntity*)PEntity) * 1000;
                }
            }
            recast -= PEntity->getMod(Mod::SONG_RECAST_DELAY) * 1000;
            // ShowDebug("Recast after merit reduction: %u\n", recast);
        }

        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_COMPOSURE))
        {
            recast = (int32)(recast * 1.25f);
        }

        if (PEntity->StatusEffectContainer->HasStatusEffect({EFFECT_HASSO, EFFECT_SEIGAN}))
        {
            recast = (int32)(recast * 1.5f);
        }

        recast = std::max<int32>(recast, (int32)(base * 0.2f));

        // Light/Dark arts recast bonus/penalties applies after the 80% cap
        if (PSpell->getSpellGroup() == SPELLGROUP_BLACK)
        {
            if (PSpell->getAOE() == SPELLAOE_RADIAL_MANI && PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANIFESTATION))
            {
                if (PEntity->GetMJob() == JOB_SCH)
                {
                    recast *= 2;
                }
                else
                {
                    recast *= 3;
                }
                applyArts = false;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ALACRITY))
            {
                uint16 bonus = 0;
                //Only apply Alacrity/celerity mod if the spell element matches the weather.
                if (battleutils::WeatherMatchesElement(battleutils::GetWeather(PEntity, false), (uint8)PSpell->getElement()))
                {
                    bonus = PEntity->getMod(Mod::ALACRITY_CELERITY_EFFECT);
                }
                recast = (int32)(recast * ((50 - bonus) / 100.0f));

                applyArts = false;
            }
            if (applyArts)
            {
                if (PEntity->StatusEffectContainer->HasStatusEffect({EFFECT_DARK_ARTS, EFFECT_ADDENDUM_BLACK}))
                {
                    // Add any "Grimoire: Reduces spellcasting time" bonuses
                    recast = (int32)(recast * (1.0f + (PEntity->getMod(Mod::BLACK_MAGIC_RECAST) + PEntity->getMod(Mod::GRIMOIRE_SPELLCASTING)) / 100.0f));
                }
                else
                {
                    recast = (int32)(recast * (1.0f + PEntity->getMod(Mod::BLACK_MAGIC_RECAST) / 100.0f));
                }
            }
        }
        else if (PSpell->getSpellGroup() == SPELLGROUP_WHITE)
        {
            if (PSpell->getAOE() == SPELLAOE_RADIAL_ACCE && PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ACCESSION))
            {
                if (PEntity->GetMJob() == JOB_SCH)
                {
                    recast *= 2;
                }
                else
                {
                    recast *= 3;
                }
                applyArts = false;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_CELERITY))
            {
                uint16 bonus = 0;
                //Only apply Alacrity/celerity mod if the spell element matches the weather.
                if (battleutils::WeatherMatchesElement(battleutils::GetWeather(PEntity, true), (uint8)PSpell->getElement()))
                {
                    bonus = PEntity->getMod(Mod::ALACRITY_CELERITY_EFFECT);
                }
                recast = (int32)(recast * ((50 - bonus) / 100.0f));

                applyArts = false;
            }
            if (applyArts)
            {
                if (PEntity->StatusEffectContainer->HasStatusEffect({EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE}))
                {
                    // Add any "Grimoire: Reduces spellcasting time" bonuses
                    recast = (int32)(recast * (1.0f + (PEntity->getMod(Mod::WHITE_MAGIC_RECAST) + PEntity->getMod(Mod::GRIMOIRE_SPELLCASTING)) / 100.0f));
                }
                else
                {
                    recast = (int32)(recast * (1.0f + PEntity->getMod(Mod::WHITE_MAGIC_RECAST) / 100.0f));
                }
            }
        }

        recast = std::max(recast, 0);

        return recast / 1000;
    }

    // Calculate TP generated by spell for Occult Acumen trait
    int16 CalculateSpellTP(CBattleEntity* PEntity, CSpell* PSpell)
    {
        // Players onry
        if (PEntity->objtype == TYPE_PC)
        {
            if (PSpell->getSkillType() == SKILLTYPE::SKILL_ELEMENTAL_MAGIC || PSpell->getSkillType() == SKILLTYPE::SKILL_DARK_MAGIC)
            {
                CCharEntity* PChar = static_cast<CCharEntity*>(PEntity);
                if (charutils::hasTrait(PChar, TRAIT_OCCULT_ACUMEN))
                {
                    return static_cast<int16>(PSpell->getMPCost() * PChar->getMod(Mod::OCCULT_ACUMEN) / 100.f * (1 + (PChar->getMod(Mod::STORETP) / 100.f)));
                }

            }
        }

        return 0;
    }

    int16 CalculateWeaponSkillTP(CBattleEntity* PEntity, CWeaponSkill* PWeaponSkill, int16 spentTP)
    {
        //apply TP Bonus
        int16 tp = spentTP + PEntity->getMod(Mod::TP_BONUS);

        if (PEntity->objtype == TYPE_PC)
        {
            auto PChar = static_cast<CCharEntity*>(PEntity);
            uint8 damslot = SLOT_MAIN;
            if (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 221)
            {
                damslot = SLOT_RANGED;
            }

            //remove TP Bonus from offhand weapon
            if (PChar->equip[SLOT_SUB] != 0)
            {
                tp -= battleutils::GetScaledItemModifier(PEntity, PChar->m_Weapons[SLOT_SUB], Mod::TP_BONUS);
            }

            //if ranged WS, remove TP bonus from mainhand weapon
            if (damslot == SLOT_RANGED)
            {
                if (PChar->equip[SLOT_MAIN] != 0)
                {
                    tp -= battleutils::GetScaledItemModifier(PEntity, PChar->m_Weapons[SLOT_MAIN], Mod::TP_BONUS);
                }
            }
            else
            {
                //if melee WS, remove TP bonus from ranged weapon
                if (PChar->equip[SLOT_RANGED] != 0)
                {
                    tp -= battleutils::GetScaledItemModifier(PEntity, PChar->m_Weapons[SLOT_RANGED], Mod::TP_BONUS);
                }

                // Add Fencer TP Bonus
                CItemWeapon* PMain = dynamic_cast<CItemWeapon*>(PEntity->m_Weapons[SLOT_MAIN]);
                CItemWeapon* PSub = dynamic_cast<CItemWeapon*>(PEntity->m_Weapons[SLOT_SUB]);
                if (PMain && !PMain->isTwoHanded() && !PMain->isHandToHand() &&
                    (!PSub || PSub->getSkillType() == SKILL_NONE || PEntity->m_Weapons[SLOT_SUB]->IsShield()))
                {
                    tp += PEntity->getMod(Mod::FENCER_TP_BONUS);
                }
            }
        }

        return std::min(tp, (int16)3000);
    }

    bool RemoveAmmo(CCharEntity* PChar, int quantity)
    {
        CItemWeapon* PItem = (CItemWeapon*)PChar->getEquip(SLOT_AMMO);

        if (PItem)
        {
            if ((PItem->getQuantity() - quantity) < 1)
            {
                uint8 slot = PChar->equip[SLOT_AMMO];
                uint8 loc = PChar->equipLoc[SLOT_AMMO];
                charutils::UnequipItem(PChar, SLOT_AMMO);
                charutils::SaveCharEquip(PChar);
                charutils::UpdateItem(PChar, loc, slot, -quantity);
                PChar->pushPacket(new CInventoryFinishPacket());
                return true;
            }
            else
            {
                charutils::UpdateItem(PChar, PChar->equipLoc[SLOT_AMMO], PChar->equip[SLOT_AMMO], -quantity);
                PChar->pushPacket(new CInventoryFinishPacket());
                return false;
            }
        }
        return false;
    }

    int32 GetMeritValue(CBattleEntity* PEntity, MERIT_TYPE merit)
    {
        if (PEntity->objtype == TYPE_PC)
        {
            return static_cast<CCharEntity*>(PEntity)->PMeritPoints->GetMeritValue(merit, static_cast<CCharEntity*>(PEntity));
        }
        return 0;
    }

    int32 GetScaledItemModifier(CBattleEntity* PEntity, CItemEquipment* PItem, Mod mod)
    {
        if (PEntity->GetMLevel() < PItem->getReqLvl())
        {
            auto modAmount = PItem->getModifier(mod);
            switch (mod)
            {
                case Mod::DEF:
                case Mod::MAIN_DMG_RATING:
                case Mod::SUB_DMG_RATING:
                case Mod::RANGED_DMG_RATING:
                    modAmount *= 3;
                    modAmount /= 4;
                    break;
                case Mod::HP:
                case Mod::MP:
                    modAmount /= 2;
                    break;
                case Mod::STR:
                case Mod::DEX:
                case Mod::VIT:
                case Mod::AGI:
                case Mod::INT:
                case Mod::MND:
                case Mod::CHR:
                case Mod::ATT:
                case Mod::RATT:
                case Mod::ACC:
                case Mod::RACC:
                case Mod::MATT:
                case Mod::MACC:
                    modAmount /= 3;
                    break;
                default:
                    modAmount = 0;
                    break;
            }
            return modAmount / PItem->getReqLvl();
        }
        else
        {
            return PItem->getModifier(mod);
        }
    }

    DAMAGETYPE GetSpikesDamageType(SUBEFFECT spikesType)
    {
        switch (spikesType)
        {
            case SUBEFFECT_BLAZE_SPIKES:
                return DAMAGE_FIRE;
            case SUBEFFECT_ICE_SPIKES:
                return DAMAGE_ICE;
            case SUBEFFECT_DREAD_SPIKES:
                return DAMAGE_DARK;
            case SUBEFFECT_CURSE_SPIKES:
                return DAMAGE_NONE;
            case SUBEFFECT_SHOCK_SPIKES:
                return DAMAGE_LIGHTNING;
            case SUBEFFECT_REPRISAL:
                return DAMAGE_LIGHT;
            case SUBEFFECT_GALE_SPIKES:
                return DAMAGE_WIND;
            case SUBEFFECT_CLOD_SPIKES:
                return DAMAGE_EARTH;
            default:
                return DAMAGE_NONE;
        }
    }

    DAMAGETYPE GetEnspellDamageType(ENSPELL enspellType)
    {
        switch (enspellType)
        {
            case ENSPELL_I_FIRE:
            case ENSPELL_II_FIRE:
                return DAMAGE_FIRE;
            case ENSPELL_I_EARTH:
            case ENSPELL_II_EARTH:
                return DAMAGE_EARTH;
            case ENSPELL_I_WATER:
            case ENSPELL_II_WATER:
                return DAMAGE_WATER;
            case ENSPELL_I_WIND:
            case ENSPELL_II_WIND:
                return DAMAGE_WIND;
            case ENSPELL_I_ICE:
            case ENSPELL_II_ICE:
                return DAMAGE_ICE;
            case ENSPELL_I_THUNDER:
            case ENSPELL_II_THUNDER:
            case ENSPELL_ROLLING_THUNDER:
                return DAMAGE_LIGHTNING;
            case ENSPELL_I_LIGHT:
            case ENSPELL_II_LIGHT:
                return DAMAGE_LIGHT;
            case ENSPELL_I_DARK:
                return DAMAGE_DARK;
            default:
                return DAMAGE_NONE;
        }
    }
};
