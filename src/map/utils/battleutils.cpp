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

#include <algorithm>
#include <array>
#include <cmath>
#include <cstring>
#include <unordered_map>

#include "packets/char_health.h"
#include "packets/char_status.h"
#include "packets/inventory_finish.h"
#include "packets/message_basic.h"

#include "lua/luautils.h"

#include "ability.h"
#include "ai/ai_container.h"
#include "ai/controllers/pet_controller.h"
#include "ai/controllers/player_charm_controller.h"
#include "ai/controllers/player_controller.h"
#include "ai/states/magic_state.h"
#include "alliance.h"
#include "attack.h"
#include "attackutils.h"
#include "battleutils.h"
#include "charutils.h"
#include "enmity_container.h"
#include "entities/battleentity.h"
#include "entities/mobentity.h"
#include "entities/petentity.h"
#include "entities/trustentity.h"
#include "item_container.h"
#include "items.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "map.h"
#include "mob_modifier.h"
#include "mobskill.h"
#include "modifier.h"
#include "notoriety_container.h"
#include "packets/char_abilities.h"
#include "packets/char_recast.h"
#include "packets/char_sync.h"
#include "packets/lock_on.h"
#include "packets/pet_sync.h"
#include "packets/position.h"
#include "party.h"
#include "petskill.h"
#include "recast_container.h"
#include "spell.h"
#include "status_effect_container.h"
#include "trait.h"
#include "utils/petutils.h"
#include "weapon_skill.h"
#include "zoneutils.h"

/************************************************************************
 *                                                                       *
 *  Lists used in battleutils                                            *
 *                                                                       *
 ************************************************************************/

std::array<std::array<uint16, 14>, 100>                                            g_SkillTable;
std::array<std::array<uint8, MAX_JOBTYPE>, MAX_SKILLTYPE>                          g_SkillRanks;
std::array<std::array<uint16, MAX_SKILLCHAIN_COUNT + 1>, MAX_SKILLCHAIN_LEVEL + 1> g_SkillChainDamageModifiers;

std::array<CWeaponSkill*, MAX_WEAPONSKILL_ID> g_PWeaponSkillList; // Holds all Weapon skills
std::array<CMobSkill*, MAX_MOBSKILL_ID>       g_PMobSkillList;    // List of mob skills
std::unordered_map<uint32, CPetSkill*>        g_PPetSkillList;    // List of pet skills

std::array<std::list<CWeaponSkill*>, MAX_SKILLTYPE> g_PWeaponSkillsList;
std::unordered_map<uint16, std::vector<uint16>>     g_PMobSkillLists; // List of mob skills defined from mob_skill_lists.sql

namespace battleutils
{

    const float worldAngleMinDistance = 0.5f;
    const uint8 worldAngleMaxDeviance = 8;

    void LoadSkillTable()
    {
        const char* fmtQuery = "SELECT r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13 \
                            FROM skill_caps \
                            ORDER BY level \
                            LIMIT 100";

        int32 ret = _sql->Query(fmtQuery);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            for (uint32 x = 0; x < 100 && _sql->NextRow() == SQL_SUCCESS; ++x)
            {
                for (uint32 y = 0; y < 14; ++y)
                {
                    g_SkillTable[x][y] = (uint16)_sql->GetIntData(y);
                }
            }
        }

        fmtQuery = "SELECT skillid,war,mnk,whm,blm,rdm,thf,pld,drk,bst,brd,rng,sam,nin,drg,smn,blu,cor,pup,dnc,sch,geo,run \
                FROM skill_ranks \
                LIMIT 64";

        ret = _sql->Query(fmtQuery);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            for (uint32 x = 0; x < MAX_SKILLTYPE && _sql->NextRow() == SQL_SUCCESS; ++x)
            {
                auto SkillID = std::clamp<uint8>(_sql->GetIntData(0), 0, MAX_SKILLTYPE - 1);

                // NOTE: Skip over Monstrosity, they re-use other jobs ranks
                for (uint32 y = 1; y < JOB_MON; ++y)
                {
                    g_SkillRanks[SkillID][y] = std::clamp<uint8>(_sql->GetIntData(y), 0, 11);
                }
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Load Skills List                                                     *
     *                                                                       *
     ************************************************************************/

    void LoadWeaponSkillsList()
    {
        const char* fmtQuery = "SELECT weaponskillid, name, jobs, type, skilllevel, element, animation, "
                               "animationTime, `range`, aoe, primary_sc, secondary_sc, tertiary_sc, main_only, unlock_id "
                               "FROM weapon_skills "
                               "WHERE weaponskillid < %u "
                               "ORDER BY type, skilllevel ASC";

        int32 ret = _sql->Query(fmtQuery, MAX_WEAPONSKILL_ID);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                CWeaponSkill* PWeaponSkill = new CWeaponSkill(_sql->GetIntData(0));

                PWeaponSkill->setName(_sql->GetStringData(1));
                PWeaponSkill->setJob(_sql->GetData(2));
                PWeaponSkill->setType(_sql->GetIntData(3));
                PWeaponSkill->setSkillLevel(_sql->GetIntData(4));
                PWeaponSkill->setElement(_sql->GetIntData(5));
                PWeaponSkill->setAnimationId(_sql->GetIntData(6));
                PWeaponSkill->setAnimationTime(std::chrono::milliseconds(_sql->GetUIntData(7)));
                PWeaponSkill->setRange(_sql->GetIntData(8));
                PWeaponSkill->setAoe(_sql->GetIntData(9));
                PWeaponSkill->setPrimarySkillchain(_sql->GetIntData(10));
                PWeaponSkill->setSecondarySkillchain(_sql->GetIntData(11));
                PWeaponSkill->setTertiarySkillchain(_sql->GetIntData(12));
                PWeaponSkill->setMainOnly(_sql->GetIntData(13));
                PWeaponSkill->setUnlockId(_sql->GetIntData(14));

                g_PWeaponSkillList[PWeaponSkill->getID()] = PWeaponSkill;
                g_PWeaponSkillsList[PWeaponSkill->getType()].emplace_back(PWeaponSkill);

                auto filename = fmt::format("./scripts/actions/weaponskills/{}.lua", PWeaponSkill->getName());
                luautils::CacheLuaObjectFromFile(filename);
            }
        }
    }

    void LoadMobSkillsList()
    {
        // Load all mob skills
        const char* specialQuery = "SELECT mob_skill_id, mob_anim_id, mob_skill_name, \
        mob_skill_aoe, mob_skill_aoe_radius, mob_skill_distance, mob_anim_time, mob_prepare_time, \
        mob_valid_targets, mob_skill_flag, mob_skill_param, knockback, primary_sc, secondary_sc, tertiary_sc \
        FROM mob_skills";

        int32 ret = _sql->Query(specialQuery);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                CMobSkill* PMobSkill = new CMobSkill(_sql->GetIntData(0));
                PMobSkill->setAnimationID(_sql->GetIntData(1));
                PMobSkill->setName(_sql->GetStringData(2));
                PMobSkill->setAoe(_sql->GetIntData(3));
                PMobSkill->setAoeRadius(_sql->GetIntData(4));
                PMobSkill->setDistance(_sql->GetFloatData(5));
                PMobSkill->setAnimationTime(_sql->GetIntData(6));
                PMobSkill->setActivationTime(_sql->GetIntData(7));
                PMobSkill->setValidTargets(_sql->GetIntData(8));
                PMobSkill->setFlag(_sql->GetIntData(9));
                PMobSkill->setParam(_sql->GetIntData(10));
                PMobSkill->setKnockback(_sql->GetUIntData(11));
                PMobSkill->setPrimarySkillchain(_sql->GetUIntData(12));
                PMobSkill->setSecondarySkillchain(_sql->GetUIntData(13));
                PMobSkill->setTertiarySkillchain(_sql->GetUIntData(14));
                PMobSkill->setMsg(185); // standard damage message. Scripters will change this.
                g_PMobSkillList[PMobSkill->getID()] = PMobSkill;

                auto filename = fmt::format("./scripts/actions/mobskills/{}.lua", PMobSkill->getName());
                luautils::CacheLuaObjectFromFile(filename);
            }
        }

        const char* fmtQuery = "SELECT skill_list_id, mob_skill_id \
        FROM mob_skill_lists";

        ret = _sql->Query(fmtQuery);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                int16 skillListId = _sql->GetIntData(0);

                uint16 skillId = _sql->GetIntData(1);

                g_PMobSkillLists[skillListId].emplace_back(skillId);
            }
        }
    }

    void LoadPetSkillsList()
    {
        // Load all pet skills
        const char* specialQuery = "SELECT pet_skill_id, pet_anim_id, pet_skill_name, \
        pet_skill_aoe, pet_skill_distance, pet_anim_time, pet_prepare_time, \
        pet_valid_targets, pet_message, pet_skill_flag, pet_skill_param, pet_skill_finish_category, knockback, primary_sc, secondary_sc, tertiary_sc \
        FROM pet_skills";

        int32 ret = _sql->Query(specialQuery);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                CPetSkill* PPetSkill = new CPetSkill(_sql->GetIntData(0));
                PPetSkill->setAnimationID(_sql->GetIntData(1));
                PPetSkill->setName(_sql->GetStringData(2));
                PPetSkill->setAoe(_sql->GetIntData(3));
                PPetSkill->setDistance(_sql->GetFloatData(4));
                PPetSkill->setAnimationTime(_sql->GetIntData(5));
                PPetSkill->setActivationTime(_sql->GetIntData(6));
                PPetSkill->setValidTargets(_sql->GetIntData(7));
                PPetSkill->setMsg(_sql->GetIntData(8));
                PPetSkill->setFlag(_sql->GetIntData(9));
                PPetSkill->setParam(_sql->GetIntData(10));
                PPetSkill->setSkillFinishCategory(_sql->GetIntData(11));
                PPetSkill->setKnockback(_sql->GetUIntData(12));
                PPetSkill->setPrimarySkillchain(_sql->GetUIntData(13));
                PPetSkill->setSecondarySkillchain(_sql->GetUIntData(14));
                PPetSkill->setTertiarySkillchain(_sql->GetUIntData(15));
                g_PPetSkillList[PPetSkill->getID()] = PPetSkill;

                auto filename = fmt::format("./scripts/actions/abilities/pet/{}.lua", PPetSkill->getName());
                luautils::CacheLuaObjectFromFile(filename);
            }
        }
    }

    void LoadSkillChainDamageModifiers()
    {
        const char* fmtQuery = "SELECT chain_level, chain_count, initial_modifier, magic_burst_modifier \
                           FROM skillchain_damage_modifiers \
                           ORDER BY chain_level, chain_count";

        int32 ret = _sql->Query(fmtQuery);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16 level                              = (uint16)_sql->GetIntData(0);
                uint16 count                              = (uint16)_sql->GetIntData(1);
                uint16 value                              = (uint16)_sql->GetIntData(2);
                g_SkillChainDamageModifiers[level][count] = value;
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Clear Up (Free) Skills List                                          *
     *                                                                       *
     ************************************************************************/

    void FreeWeaponSkillsList()
    {
        for (int32 SkillId = 0; SkillId < MAX_WEAPONSKILL_ID; ++SkillId)
        {
            destroy(g_PWeaponSkillList[SkillId]);
        }
    }

    void FreeMobSkillList()
    {
        for (auto& mobskill : g_PMobSkillList)
        {
            destroy(mobskill);
        }
    }

    void FreePetSkillList()
    {
        for (auto& petskill : g_PPetSkillList)
        {
            destroy(petskill.second);
        }
        g_PPetSkillList.clear();
    }

    /************************************************************************
     *                                                                       *
     *  Get Skill Rank By SkillId and JobId                                  *
     *                                                                       *
     ************************************************************************/

    uint8 GetSkillRank(SKILLTYPE SkillID, JOBTYPE JobID)
    {
        return g_SkillRanks[SkillID][JobID];
    }

    /************************************************************************
     *                                                                       *
     *  Return Max Skill by SkillType, JobType, and Level                    *
     *                                                                       *
     ************************************************************************/

    uint16 GetMaxSkill(SKILLTYPE SkillID, JOBTYPE JobID, uint8 level)
    {
        // The skill_caps table is 0-indexed, so our maximum level should one lower
        // than the size of the array.
        auto maxLevel = static_cast<uint8>(g_SkillTable.size() - 1);

        // TODO: Research on mobs level 99+ is still on-going. This line can be removed once the correct formula/skilltype have been established.
        // max indexed value and level is capped at 99 as stated above for skill_caps table
        if (level > 99)
        {
            level = 99;
        }

        if (level > maxLevel)
        {
            ShowDebug("battleutils::GetMaxSkill() received level value greater than array size! (Received: %d, Clamped to: %d)", level, maxLevel);
        }

        return g_SkillTable[std::clamp<uint8>(level, 0, maxLevel)][g_SkillRanks[SkillID][JobID]];
    }

    uint16 GetMaxSkill(uint8 rank, uint8 level)
    {
        auto maxLevel = static_cast<uint8>(g_SkillTable.size() - 1);

        if (level > maxLevel)
        {
            ShowDebug("battleutils::GetMaxSkill() received level value greater than array size! (Received: %d, Clamped to: %d)", level, maxLevel);
        }

        return g_SkillTable[std::clamp<uint8>(level, 0, maxLevel)][rank];
    }

    bool isValidSelfTargetWeaponskill(int wsid)
    {
        switch (wsid)
        {
            case 163: // starlight
            case 164: // moonlight
            case 173: // dagan
            case 190: // myrkr
                return true;
        }
        return false;
    }

    bool CanUseWeaponskill(CCharEntity* PChar, CWeaponSkill* PSkill)
    {
        return ((PSkill->getSkillLevel() > 0 && PChar->GetSkill(PSkill->getType()) >= PSkill->getSkillLevel() &&
                 (PSkill->getUnlockId() == 0 || charutils::hasLearnedWeaponskill(PChar, PSkill->getUnlockId()))) ||
                (PSkill->getSkillLevel() == 0 && (PSkill->getUnlockId() == 0 ||
                                                  (charutils::hasLearnedWeaponskill(PChar, PSkill->getUnlockId()) && PChar->GetMLevel() >= 75)))) &&
               (PSkill->getJob(PChar->GetMJob()) > 0 || (PSkill->getJob(PChar->GetSJob()) > 0 && !PSkill->mainOnly()));
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
        {
            return level + 10;
        }
        else if (level <= 50)
        {
            return 20 + (level - 10) / 2;
        }

        return (int16)(40 + (level - 50) * 0.6);
    }

    /************************************************************************
     *                                                                       *
     *  Get Weapon Skill by ID                                               *
     *                                                                       *
     ************************************************************************/

    CWeaponSkill* GetWeaponSkill(uint16 WSkillID)
    {
        if (WSkillID >= MAX_WEAPONSKILL_ID)
        {
            ShowError("WSkillID (%d) exceeds MAX_WEAPONSKILL_ID.", WSkillID);
            return nullptr;
        }

        // False positive: this is CWeaponSkill*, so it's OK
        // cppcheck-suppress CastIntegerToAddressAtReturn
        return g_PWeaponSkillList[WSkillID];
    }

    /************************************************************************
     *                                                                       *
     * Get List of Weapon Skills from skill type                             *
     *                                                                       *
     ************************************************************************/

    const std::list<CWeaponSkill*>& GetWeaponSkills(uint8 skill)
    {
        if (skill >= MAX_SKILLTYPE)
        {
            ShowWarning("Skill (%d) exceeds MAX_SKILLTYPE", skill);
            return g_PWeaponSkillsList[SKILL_NONE];
        }

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
            // False positive: this is CMobSkill*, so it's OK
            // cppcheck-suppress CastIntegerToAddressAtReturn
            return g_PMobSkillList[SkillID];
        }
        else
        {
            return nullptr;
        }
    }

    /************************************************************************
     *                                                                       *
     *  Get Pet Skill by Id                                                  *
     *                                                                       *
     ************************************************************************/

    CPetSkill* GetPetSkill(uint16 SkillID)
    {
        if (g_PPetSkillList.find(SkillID) != g_PPetSkillList.end())
        {
            return g_PPetSkillList[SkillID];
        }
        else
        {
            return nullptr;
        }
    }

    /************************************************************************
     *                                                                       *
     *  Get Mob Skills by List Id                                            *
     *                                                                       *
     ************************************************************************/

    const std::vector<uint16>& GetMobSkillList(uint16 ListID)
    {
        return g_PMobSkillLists[ListID];
    }

    int32 CalculateEnspellDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 Tier, uint8 element)
    {
        int32 damage = 0;

        // Tier 1 enspells have their damaged pre-calculated AT CAST TIME and is stored in Mod::ENSPELL_DMG
        if (Tier == 1)
        {
            damage      = PAttacker->getMod(Mod::ENSPELL_DMG) + PAttacker->getMod(Mod::ENSPELL_DMG_BONUS);
            auto* PChar = dynamic_cast<CCharEntity*>(PAttacker);
            if (PChar)
            {
                damage += PChar->PMeritPoints->GetMeritValue(MERIT_ENSPELL_DAMAGE, PChar);
            }
        }
        else if (Tier == 2)
        {
            // Tier 2 enspells calculate the damage on each hit and increment the potency in Mod::ENSPELL_DMG per hit
            uint16 skill = PAttacker->GetSkill(SKILL_ENHANCING_MAGIC);
            uint16 cap   = 3 + ((6 * skill) / 100);
            if (skill > 200)
            {
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

            auto* PChar = dynamic_cast<CCharEntity*>(PAttacker);
            if (PChar)
            {
                damage += PChar->PMeritPoints->GetMeritValue(MERIT_ENSPELL_DAMAGE, PChar) * 2;
            }
        }
        else if (Tier == 3) // enlight or endark
        {
            damage = PAttacker->getMod(Mod::ENSPELL_DMG);

            if (damage > 1)
            {
                PAttacker->delModifier(Mod::ENSPELL_DMG, 1);
            }
            else
            {
                if (element == ELEMENT_DARK)
                {
                    PAttacker->StatusEffectContainer->DelStatusEffect(EFFECT_ENDARK);
                }
                else
                {
                    PAttacker->StatusEffectContainer->DelStatusEffect(EFFECT_ENLIGHT);
                }
            }

            damage += PAttacker->getMod(Mod::ENSPELL_DMG_BONUS);
        }
        else if (Tier == 4) // Rune Enhancement
        {
            // see https://www.ffxiah.com/forum/topic/56613/rune-enhancement-damage-formula-testing/ for data and comments
            double       runeDPS = 0.0;
            CItemWeapon* PWeapon = static_cast<CItemWeapon*>(static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_MAIN));

            if (PWeapon == nullptr) // h2h, though base DPS is so low it will never hit non-zero enspell damage numbers with current rune count and modifiers.
            {
                runeDPS = 3.0 / 240.0;
            }
            else
            {
                runeDPS = PWeapon->getDPS();
            }

            if (PAttacker->m_dualWield)
            {
                runeDPS /= 2; // DPS is divided evenly between hands derived from mainhand only
            }

            runeDPS = std::fmin(21, runeDPS); // max DPS currently known is 21.

            double min = 0.0;
            double max = 0.0;

            EFFECT highestRuneEffect = PAttacker->StatusEffectContainer->GetHighestRuneEffect();
            int    runeBonus         = PAttacker->StatusEffectContainer->GetEffectsCount(highestRuneEffect);

            if (runeBonus == 1)
            {
                min = std::floor(runeDPS * 0.97);
                max = std::floor(runeDPS * 1.30);
            }
            else if (runeBonus == 2)
            {
                min = std::floor(runeDPS * 1.40);
                max = std::floor(runeDPS * 1.70);
            }
            else if (runeBonus == 3)
            {
                min = std::floor(runeDPS * 1.90);
                max = std::floor(runeDPS * 2.20);
            }

            if (max == 0.0)
            {
                damage = 0.0;
            }
            else
            {
                // see https://bugs.llvm.org/show_bug.cgi?id=18767#c1 ; essentially, [min, max] range on this RNG call excludes the max
                // so we must add +1 to our max to achieve the range we want
                max = max + 1;

                // TODO: verify gaussian vs linear distribution for RNG from retail
                damage = (int32)xirand::GetRandomNumber<double>(min, max);
            }
        }

        // matching day 10% bonus, matching weather 10% or 25% for double weather
        float   dBonus  = 1.0;
        float   resist  = 1.0;
        uint32  WeekDay = CVanaTime::getInstance()->getWeekday();
        WEATHER weather = GetWeather(PAttacker, false);

        DAYTYPE strongDay[8]           = { FIRESDAY, ICEDAY, WINDSDAY, EARTHSDAY, LIGHTNINGDAY, WATERSDAY, LIGHTSDAY, DARKSDAY };
        DAYTYPE weakDay[8]             = { WATERSDAY, FIRESDAY, ICEDAY, WINDSDAY, EARTHSDAY, LIGHTNINGDAY, DARKSDAY, LIGHTSDAY };
        WEATHER strongWeatherSingle[8] = { WEATHER_HOT_SPELL, WEATHER_SNOW, WEATHER_WIND, WEATHER_DUST_STORM,
                                           WEATHER_THUNDER, WEATHER_RAIN, WEATHER_AURORAS, WEATHER_GLOOM };
        WEATHER strongWeatherDouble[8] = { WEATHER_HEAT_WAVE, WEATHER_BLIZZARDS, WEATHER_GALES, WEATHER_SAND_STORM,
                                           WEATHER_THUNDERSTORMS, WEATHER_SQUALL, WEATHER_STELLAR_GLARE, WEATHER_DARKNESS };
        WEATHER weakWeatherSingle[8]   = { WEATHER_RAIN, WEATHER_HOT_SPELL, WEATHER_SNOW, WEATHER_WIND,
                                           WEATHER_DUST_STORM, WEATHER_THUNDER, WEATHER_GLOOM, WEATHER_AURORAS };
        WEATHER weakWeatherDouble[8]   = { WEATHER_SQUALL, WEATHER_HEAT_WAVE, WEATHER_BLIZZARDS, WEATHER_GALES,
                                           WEATHER_SAND_STORM, WEATHER_THUNDERSTORMS, WEATHER_DARKNESS, WEATHER_STELLAR_GLARE };
        uint32  obi[8]                 = { 15435, 15436, 15437, 15438, 15439, 15440, 15441, 15442 };
        Mod     resistarray[8]         = { Mod::FIRE_MEVA, Mod::ICE_MEVA, Mod::WIND_MEVA, Mod::EARTH_MEVA,
                                           Mod::THUNDER_MEVA, Mod::WATER_MEVA, Mod::LIGHT_MEVA, Mod::DARK_MEVA };
        bool    obiBonus               = false;

        double half      = (double)(PDefender->getMod(resistarray[element - 1])) / 100;
        double quart     = pow(half, 2);
        double eighth    = pow(half, 3);
        double sixteenth = pow(half, 4);
        double resvar    = xirand::GetRandomNumber(1.);

        // Determine resist based on which thresholds have been crossed.
        if (resvar <= sixteenth)
        {
            resist = 0.0625f;
        }
        else if (resvar <= eighth)
        {
            resist = 0.125f;
        }
        else if (resvar <= quart)
        {
            resist = 0.25f;
        }
        else if (resvar <= half)
        {
            resist = 0.5f;
        }

        if (PAttacker->objtype == TYPE_PC)
        {
            CItemEquipment* waist = ((CCharEntity*)PAttacker)->getEquip(SLOT_WAIST);
            if (waist && waist->getID() == obi[element - 1])
            {
                obiBonus = true;
            }
        }
        else
        {
            // mobs random multiplier
            dBonus += xirand::GetRandomNumber(100) / 1000.0f;
        }
        if (WeekDay == strongDay[element - 1] && (obiBonus || xirand::GetRandomNumber(100) < 33))
        {
            dBonus += 0.1f;
        }
        else if (WeekDay == weakDay[element - 1] && (obiBonus || xirand::GetRandomNumber(100) < 33))
        {
            dBonus -= 0.1f;
        }
        if (weather == strongWeatherSingle[element - 1] && (obiBonus || xirand::GetRandomNumber(100) < 33))
        {
            dBonus += 0.1f;
        }
        else if (weather == strongWeatherDouble[element - 1] && (obiBonus || xirand::GetRandomNumber(100) < 33))
        {
            dBonus += 0.25f;
        }
        else if (weather == weakWeatherSingle[element - 1] && (obiBonus || xirand::GetRandomNumber(100) < 33))
        {
            dBonus -= 0.1f;
        }
        else if (weather == weakWeatherDouble[element - 1] && (obiBonus || xirand::GetRandomNumber(100) < 33))
        {
            dBonus -= 0.25f;
        }

        damage = (int32)(damage * resist);
        damage = (int32)(damage * dBonus);
        damage = MagicDmgTaken(PDefender, damage, (ELEMENT)(element));

        if (damage > 0)
        {
            damage = std::max(damage - PDefender->getMod(Mod::PHALANX), 0);
            damage = HandleOneForAll(PDefender, damage);
            damage = HandleStoneskin(PDefender, damage);
        }

        damage = std::clamp(damage, -99999, 99999);

        return damage;
    }

    /************************************************************************
     *                                                                       *
     *  Calculate Spike Damage                                               *
     *                                                                       *
     ************************************************************************/

    int32 CalculateSpikeDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, uint16 damageTaken)
    {
        ELEMENT spikeElement = (ELEMENT)((uint8)GetSpikesDamageType(Action->spikesEffect) - (uint8)DAMAGE_TYPE::ELEMENTAL);
        int32   damage       = Action->spikesParam;

        if (PDefender->getMod(Mod::SPIKES_DMG_BONUS) > 0)
        {
            damage *= 1 + (PDefender->getMod(Mod::SPIKES_DMG_BONUS) / 100.f);
        }

        if (static_cast<SPIKES>(Action->spikesEffect) == SPIKES::SPIKE_DREAD)
        {
            // drain same as damage taken
            damage = damageTaken;
        }

        damage = MagicDmgTaken(PAttacker, damage, spikeElement); // apply MDT/MDT2/DT, liement to whoever is taking damage

        if (damage < 0) // apply heal message
        {
            Action->spikesMessage = MSGBASIC_SPIKES_EFFECT_HEAL;
        }

        return damage;
    }

    bool HandleSpikesDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, int32 damage)
    {
        Action->spikesEffect  = (SUBEFFECT)PDefender->getMod(Mod::SPIKES);
        Action->spikesMessage = MSGBASIC_SPIKES_EFFECT_DMG;
        Action->spikesParam   = std::max<int16>(PDefender->getMod(Mod::SPIKES_DMG), 0);

        // Handle Retaliation
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_RETALIATION) && PDefender->PAI->IsEngaged() &&
            battleutils::GetHitRate(PDefender, PAttacker) / 2 > xirand::GetRandomNumber(100) && facing(PDefender->loc.p, PAttacker->loc.p, 64))
        {
            // Retaliation rate is based on player acc vs mob evasion. Missed retaliations do not even display in log.
            // Other theories exist but were not proven or reliably tested (I have to assume too many things to even consider JP translations about weapon
            // delay), this at least has data to back it up.
            // https://web.archive.org/web/20141228105335/http://www.bluegartr.com/threads/120193-Retaliation-Testing?s=7a6221e10ffdfaa6a7f5e8f0387f787d&p=4620727&viewfull=1#post4620727
            Action->reaction     = REACTION::HIT;
            Action->spikesEffect = SUBEFFECT_COUNTER;

            if (battleutils::IsAbsorbByShadow(PAttacker, PDefender)) // Struck a shadow
            {
                Action->spikesMessage = 535;
            }
            else // Struck the target
            {
                SKILLTYPE skilltype = SKILLTYPE::SKILL_NONE;

                if (PDefender->objtype == TYPE_PC)
                {
                    if (auto* weapon = dynamic_cast<CItemWeapon*>(PDefender->m_Weapons[SLOT_MAIN]))
                    {
                        skilltype = static_cast<SKILLTYPE>(weapon->getSkillType());
                    }
                    else
                    {
                        skilltype = SKILLTYPE::SKILL_HAND_TO_HAND;
                    }

                    // Check for skillup
                    charutils::TrySkillUP((CCharEntity*)PDefender, skilltype, PAttacker->GetMLevel());
                }

                // Check if crit
                bool crit = battleutils::GetCritHitRate(PDefender, PAttacker, true) > xirand::GetRandomNumber(100);

                // Dmg math.
                float  DamageRatio = GetDamageRatio(PDefender, PAttacker, crit, 1.f, skilltype, SLOT_MAIN, false);
                uint16 dmg         = (uint32)((PDefender->GetMainWeaponDmg() + battleutils::GetFSTR(PDefender, PAttacker, SLOT_MAIN)) * DamageRatio);
                dmg                = attackutils::CheckForDamageMultiplier(((CCharEntity*)PDefender), dynamic_cast<CItemWeapon*>(PDefender->m_Weapons[SLOT_MAIN]), dmg,
                                                                           PHYSICAL_ATTACK_TYPE::NORMAL, SLOT_MAIN);
                uint16 bonus       = dmg * (PDefender->getMod(Mod::RETALIATION) / 100);
                dmg                = dmg + bonus;

                // TP and stoneskin are handled inside TakePhysicalDamage
                Action->spikesMessage = 536;
                Action->spikesParam =
                    battleutils::TakePhysicalDamage(PDefender, PAttacker, PHYSICAL_ATTACK_TYPE::NORMAL, dmg, false, SLOT_MAIN, 1, nullptr, true, true, true);
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
            int32 spikesDamage = CalculateSpikeDamage(PAttacker, PDefender, Action, (uint16)(abs(damage)));
            if (spikesDamage > 0)
            {
                spikesDamage = std::max(spikesDamage - PAttacker->getMod(Mod::PHALANX), 0);
                spikesDamage = HandleOneForAll(PAttacker, spikesDamage);
                spikesDamage = HandleStoneskin(PAttacker, spikesDamage);
            }

            if (spikesDamage < 0) // because spikes damage in action packet is uint16, we have to change the healed amount to a positive number and cast to uint16
            {
                Action->spikesParam = static_cast<uint16>(std::clamp(spikesDamage * -1, 0, PAttacker->GetMaxHP() - PAttacker->health.hp));
            }
            else
            {
                Action->spikesParam = static_cast<uint16>(spikesDamage);
            }

            if (PDefender->objtype != TYPE_MOB || ((CMobEntity*)PDefender)->getMobMod(MOBMOD_AUTO_SPIKES) == 0)
            {
                switch (static_cast<SPIKES>(Action->spikesEffect))
                {
                    case SPIKE_BLAZE:
                    case SPIKE_ICE:
                    case SPIKE_SHOCK:
                        PAttacker->takeDamage(spikesDamage, PDefender, ATTACK_TYPE::MAGICAL, GetSpikesDamageType(Action->spikesEffect));
                        break;

                    case SPIKE_DREAD:
                        if (PAttacker->m_EcoSystem == ECOSYSTEM::UNDEAD)
                        {
                            // is undead no effect
                            Action->spikesEffect = (SUBEFFECT)0;
                            return false;
                        }
                        else
                        {
                            if (PDefender->isAlive())
                            {
                                auto* PEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_DREAD_SPIKES);
                                if (PEffect)
                                {
                                    // see https://www.bg-wiki.com/ffxi/Dread_Spikes

                                    // Subpower is the remaining damage that can be drained. When it reaches 0 the effect ends
                                    int remainingDrain = PEffect->GetSubPower();
                                    if (remainingDrain - abs(damage) <= 0) // power absorbed from Dread Spikes takes pre-MDT etc values
                                    {
                                        PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_DREAD_SPIKES);
                                    }
                                    else
                                    {
                                        PEffect->SetSubPower(remainingDrain - abs(damage));
                                    }
                                }

                                if (spikesDamage > 0) // do not add HP if spikes damage was absorbed.
                                {
                                    Action->spikesMessage = MSGBASIC_SPIKES_EFFECT_HP_DRAIN;
                                    PDefender->addHP(spikesDamage);
                                }
                            }
                            PAttacker->takeDamage(spikesDamage, PDefender, ATTACK_TYPE::MAGICAL, DAMAGE_TYPE::DARK);
                        }
                        break;

                    case SPIKE_REPRISAL:
                        if ((Action->reaction & REACTION::BLOCK) == REACTION::BLOCK)
                        {
                            PAttacker->takeDamage(spikesDamage, PDefender, ATTACK_TYPE::MAGICAL, DAMAGE_TYPE::LIGHT);
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
        else if (PDefender->getMod(Mod::ITEM_SUBEFFECT) > 0)
        {
            if (CCharEntity* PCharDef = dynamic_cast<CCharEntity*>(PDefender))
            {
                for (auto&& slot : { SLOT_SUB, SLOT_BODY, SLOT_LEGS, SLOT_HEAD, SLOT_HANDS, SLOT_FEET })
                {
                    CItemEquipment* PItem = PCharDef->getEquip(slot);
                    if (PItem && !PItem->isType(ITEM_WEAPON))
                    {
                        uint8 chance = 0;

                        Action->spikesEffect = (SUBEFFECT)0;
                        auto spikes_type     = battleutils::GetScaledItemModifier(PDefender, PItem, Mod::ITEM_SUBEFFECT);
                        if (spikes_type > 0 && spikes_type < 7)
                        {
                            Action->spikesEffect = (SUBEFFECT)spikes_type;
                        }

                        Action->spikesParam = battleutils::GetScaledItemModifier(PDefender, PItem, Mod::ITEM_ADDEFFECT_DMG);
                        chance              = battleutils::GetScaledItemModifier(PDefender, PItem, Mod::ITEM_ADDEFFECT_CHANCE);

                        if (CMobEntity* PMobAtt = dynamic_cast<CMobEntity*>(PDefender))
                        {
                            PMobAtt->m_HiPCLvl = std::max(PMobAtt->m_HiPCLvl, PDefender->GetMLevel());
                        }

                        if (Action->spikesEffect && HandleSpikesEquip(PAttacker, PDefender, Action, (uint8)Action->spikesParam, Action->spikesEffect, chance))
                        {
                            return true;
                        }
                    }
                }
            }
        }
        else if (Action->spikesEffect == 0)
        {
            Action->spikesParam   = 0;
            Action->spikesMessage = 0;
        }
        return false;
    }

    bool HandleParrySpikesDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, int32 damage)
    {
        Action->spikesEffect  = (SUBEFFECT)PDefender->getMod(Mod::PARRY_SPIKES);
        Action->spikesMessage = MSGBASIC_SPIKES_EFFECT_DMG;
        Action->spikesParam   = std::max<int16>(PDefender->getMod(Mod::PARRY_SPIKES_DMG), 0);

        if (Action->spikesEffect > 0)
        {
            // calculate damage
            int32 spikesDamage = CalculateSpikeDamage(PAttacker, PDefender, Action, (uint16)(abs(damage)));
            if (spikesDamage > 0)
            {
                spikesDamage = std::max(spikesDamage - PAttacker->getMod(Mod::PHALANX), 0);
                spikesDamage = HandleOneForAll(PAttacker, spikesDamage);
                spikesDamage = HandleStoneskin(PAttacker, spikesDamage);
            }

            if (spikesDamage < 0) // fit healed spikes into uint16
            {
                Action->spikesParam = static_cast<uint16>(std::clamp(spikesDamage * -1, 0, PAttacker->GetMaxHP() - PAttacker->health.hp));
            }
            else
            {
                Action->spikesParam = static_cast<uint16>(spikesDamage);
            }

            PAttacker->takeDamage(spikesDamage, PDefender, ATTACK_TYPE::MAGICAL, GetSpikesDamageType(Action->spikesEffect));

            battleutils::DirtyExp(PAttacker, PDefender);
            if (PAttacker->isDead())
            {
                battleutils::ClaimMob(PAttacker, PDefender);
            }
            return true;
        }
        return false;
    }

    bool HandleSpikesEquip(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, uint8 damage, SUBEFFECT spikesType, uint8 chance)
    {
        int lvlDiff = std::clamp((PDefender->GetMLevel() - PAttacker->GetMLevel()), -5, 5) * 2;

        if (xirand::GetRandomNumber(100) < chance + lvlDiff)
        {
            if (spikesType == SUBEFFECT_CURSE_SPIKES)
            {
                Action->spikesMessage = MSGBASIC_STATUS_SPIKES;
                Action->spikesParam   = EFFECT_CURSE;
            }
            /* Todo: wire this up fully.
            else if (spikesType == SUBEFFECT_DEATH_SPIKES)
            {
                Action->spikesMessage = MSGBASIC_STATUS_SPIKES;
                Action->spikesParam   = EFFECT_KO;
                PDefender->setHP(0);
            }
            */
            else
            {
                auto ratio = std::clamp<uint8>(damage / 4, 1, 255);

                // calculate damage
                int32 spikesDamage = CalculateSpikeDamage(PAttacker, PDefender, Action, damage - xirand::GetRandomNumber<uint16>(ratio) + xirand::GetRandomNumber<uint16>(ratio));
                if (spikesDamage > 0)
                {
                    spikesDamage = std::max(spikesDamage - PAttacker->getMod(Mod::PHALANX), 0);
                    spikesDamage = HandleOneForAll(PAttacker, spikesDamage);
                    spikesDamage = HandleStoneskin(PAttacker, spikesDamage);
                }
                else if (spikesDamage < 0) // fit healed spikes into uint16
                {
                    Action->spikesParam = static_cast<uint16>(std::clamp(spikesDamage * -1, 0, PAttacker->GetMaxHP() - PAttacker->health.hp));
                }
                else
                {
                    Action->spikesParam = static_cast<uint16>(spikesDamage);
                }

                PAttacker->takeDamage(spikesDamage, PDefender, ATTACK_TYPE::MAGICAL, GetSpikesDamageType(spikesType));
            }

            // Temp till moved to script.
            HandleSpikesStatusEffect(PAttacker, PDefender, Action);

            return true;
        }
        else
        {
            // Technically, these should be the default values and then conditional branches change them
            // However, it wasn't worth the effort when the whole thing is going to be eventually burned down to make way for fully scripted spikes
            Action->spikesEffect  = SUBEFFECT_NONE;
            Action->spikesParam   = 0;
            Action->spikesMessage = 0;
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
                if (!PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE))
                {
                    PAttacker->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_CURSE, EFFECT_CURSE, 15, 0, 180));
                }
                break;
            }
            case SUBEFFECT_ICE_SPIKES:
            {
                if (xirand::GetRandomNumber(100) < 20 + lvlDiff && !PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_PARALYSIS))
                {
                    PAttacker->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_PARALYSIS, EFFECT_PARALYSIS, 20, 0, 30));
                }
                break;
            }
            case SUBEFFECT_SHOCK_SPIKES:
            {
                if (xirand::GetRandomNumber(100) < 30 + lvlDiff && !PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_STUN))
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
     *  Handle Enspell effect and damage                                     *
     *                                                                       *
     ************************************************************************/

    void HandleEnspell(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, bool isFirstSwing, CItemWeapon* weapon, int32 finaldamage, CAttack& attack)
    {
        CCharEntity* PChar = nullptr;

        if (PAttacker->objtype == TYPE_PC)
        {
            PChar = dynamic_cast<CCharEntity*>(PAttacker);

            if (!settings::get<bool>("map.DISABLE_TREASURE_HUNTER_PROCS"))
            {
                // TODO: cleanup lua further so we can handle all this add effect stuff somewhere else
                // Treasure hunter takes priority over enspells
                if (PChar &&
                    finaldamage > 0 &&
                    isFirstSwing &&
                    PDefender->objtype == TYPE_MOB &&
                    PChar->GetMJob() == JOB_THF &&
                    PChar->hasTrait(TRAITTYPE::TRAIT_TREASURE_HUNTER)) // TH trait as a requirement is assumed, but likely. Could this just be a level 15 check instead?
                {
                    auto PMob = dynamic_cast<CMobEntity*>(PDefender);
                    if (PMob && PMob->m_THLvl < (12 + PChar->getMod(Mod::TREASURE_HUNTER_CAP))) // TH proc cap is 12 + job gifts
                    {
                        int16 playerTH = PChar->getMod(Mod::TREASURE_HUNTER);

                        int16 THdiff = PMob->m_THLvl - playerTH;

                        // Auto upgrade TH to mod level up to TH8
                        if (THdiff < 0 && PMob->m_THLvl < 8)
                        {
                            PMob->m_THLvl = std::min<int16>(8, playerTH);

                            // Recalculate diff
                            THdiff = PMob->m_THLvl - playerTH;
                        }

                        float procRate = 0.04f / std::pow<float>(2.f, std::max<int16>(0, THdiff)); // Numbers below diff of -1 (i.e. TH 10 vs mobs TH8 level) are not known. Assume no extra bonus for now.

                        // Not known if Feint and Gifts are multiplicative or additive. Currently assuming additive
                        // The mob has an evasion down from feint that applies this mod.
                        // The player has job point gifts that apply this mod.
                        float procRateBonus = 1.f + (PChar->getMod(Mod::TREASURE_HUNTER_PROC) + PMob->getMod(Mod::TREASURE_HUNTER_PROC)) / 100.f;

                        // It's unlikely that SATA bonus is multiplicative SA * TA bonus -- the rate would be astronomically higher if it was
                        // Add the two together if they exist
                        float sneakAttackTrickAttackBonus = 0.f;

                        // BG wiki claims 10x bonus for SA
                        if (attack.CheckHadSneakAttack())
                        {
                            sneakAttackTrickAttackBonus += 10.f;
                        }

                        // BG wiki claims 10x bonus for TA
                        if (attack.CheckHadTrickAttack())
                        {
                            sneakAttackTrickAttackBonus += 10.f;
                        }

                        // way greater than epsilon just in case...
                        if (sneakAttackTrickAttackBonus > 1.f)
                        {
                            procRateBonus *= sneakAttackTrickAttackBonus;
                        }

                        procRate *= procRateBonus;

                        if (xirand::GetRandomNumber<float>(0.f, 1.f) <= procRate)
                        {
                            PMob->m_THLvl++;

                            Action->additionalEffect = SUBEFFECT_LIGHT_DAMAGE; // Looks like enlight, and is reflected in the capture
                            Action->addEffectMessage = static_cast<uint16>(MsgStd::TreasureHunterProc);
                            Action->addEffectParam   = PMob->m_THLvl;
                            return;
                        }
                    }
                }
            }
        }

        Action->additionalEffect = SUBEFFECT_NONE;
        Action->addEffectMessage = 0;
        Action->addEffectParam   = 0;

        EFFECT previous_daze       = EFFECT_NONE;
        uint16 previous_daze_power = 0;

        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_SAMBA) && PDefender->m_EcoSystem != ECOSYSTEM::UNDEAD)
        {
            previous_daze       = EFFECT_DRAIN_DAZE;
            previous_daze_power = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_DRAIN_SAMBA)->GetPower();
        }
        else if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_SAMBA))
        {
            previous_daze       = EFFECT_ASPIR_DAZE;
            previous_daze_power = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_ASPIR_SAMBA)->GetPower();
        }
        else if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_SAMBA))
        {
            previous_daze       = EFFECT_HASTE_DAZE;
            previous_daze_power = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_HASTE_SAMBA)->GetPower();
        }

        if (previous_daze != EFFECT_NONE)
        {
            if (PAttacker->objtype == TYPE_PC && PAttacker->PParty != nullptr)
            {
                for (auto* PMember : PAttacker->PParty->members)
                {
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_DRAIN_DAZE, PMember->id);
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_HASTE_DAZE, PMember->id);
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_ASPIR_DAZE, PMember->id);
                }
            }
            else if (PAttacker->objtype == TYPE_TRUST && PAttacker->PMaster)
            {
                // clang-format off
                static_cast<CCharEntity*>(PAttacker->PMaster)->ForPartyWithTrusts(
                [&](CBattleEntity* PMember)
                {
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_DRAIN_DAZE, PMember->id);
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_HASTE_DAZE, PMember->id);
                    PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_ASPIR_DAZE, PMember->id);
                });
                // clang-format on
            }
            else
            {
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_DRAIN_DAZE, PAttacker->id);
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_HASTE_DAZE, PAttacker->id);
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_ASPIR_DAZE, PAttacker->id);
            }
            if (PDefender->objtype == TYPE_PC)
            {
                PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(previous_daze, 0, previous_daze_power, 0, 10, PAttacker->id), true);
            }
            else
            {
                if (previous_daze == EFFECT_DRAIN_DAZE && PDefender->m_EcoSystem != ECOSYSTEM::UNDEAD)
                {
                    PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_DRAIN_DAZE, 0, previous_daze_power, 0, 10, PAttacker->id), true);
                }
                else
                {
                    PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(previous_daze, 0, previous_daze_power, 0, 10, PAttacker->id), true);
                }
            }
        }

        if ((PAttacker->getMod(Mod::ENSPELL) > 0 && // Enspell overwrites weapon effects
             (PAttacker->getMod(Mod::ENSPELL_CHANCE) == 0 || PAttacker->getMod(Mod::ENSPELL_CHANCE) > xirand::GetRandomNumber(100))) ||
            PAttacker->StatusEffectContainer->GetActiveRuneCount() > 0) // Rune Enhancement means we deal enspell damage
        {
            static SUBEFFECT enspell_subeffects[8] = {
                SUBEFFECT_FIRE_DAMAGE,
                SUBEFFECT_ICE_DAMAGE,
                SUBEFFECT_WIND_DAMAGE,
                SUBEFFECT_EARTH_DAMAGE,
                SUBEFFECT_LIGHTNING_DAMAGE,
                SUBEFFECT_WATER_DAMAGE,
                SUBEFFECT_LIGHT_DAMAGE,
                SUBEFFECT_DARKNESS_DAMAGE,
            };

            uint8 enspell = (uint8)PAttacker->getMod(Mod::ENSPELL);

            if (enspell == ENSPELL_BLOOD_WEAPON && PDefender->m_EcoSystem != ECOSYSTEM::UNDEAD)
            {
                Action->additionalEffect = SUBEFFECT_HP_DRAIN;
                Action->addEffectMessage = 161;

                // Increase HP Absorbed by 2% per JP
                int32 absorbed = Action->param;
                if (PAttacker->objtype == TYPE_PC)
                {
                    absorbed += (int32)floor(
                        absorbed * 0.02f * static_cast<CCharEntity*>(PAttacker)->PJobPoints->GetJobPointValue(JP_BLOOD_WEAPON_EFFECT));
                }

                Action->addEffectParam = PAttacker->addHP(absorbed);

                if (PChar != nullptr)
                {
                    PChar->updatemask |= UPDATE_HP;
                }
            }
            else if (PAttacker->StatusEffectContainer->GetActiveRuneCount() > 0) // Rune Enhancement enspell damage, takes priority over all but blood weapon.
            {
                EFFECT highestRuneEffect = PAttacker->StatusEffectContainer->GetHighestRuneEffect();
                EFFECT newestRuneEffect  = PAttacker->StatusEffectContainer->GetNewestRuneEffect();
                int    highestRuneCount  = PAttacker->StatusEffectContainer->GetEffectsCount(highestRuneEffect);

                DAMAGE_TYPE damageType = DAMAGE_TYPE::NONE;
                int         element    = 0;

                if (highestRuneCount == 1) // only have unique or one rune, set element to newest.
                {
                    element                  = GetRuneEnhancementElement(newestRuneEffect);
                    Action->additionalEffect = enspell_subeffects[newestRuneEffect - EFFECT_IGNIS];
                    damageType               = GetRuneEnhancementDamageType(newestRuneEffect);
                }
                else // set element to strongest rune
                {
                    element                  = GetRuneEnhancementElement(highestRuneEffect);
                    Action->additionalEffect = enspell_subeffects[highestRuneEffect - EFFECT_IGNIS];
                    damageType               = GetRuneEnhancementDamageType(highestRuneEffect);
                }

                Action->addEffectParam = CalculateEnspellDamage(PAttacker, PDefender, 4, element);

                if (Action->addEffectParam < 0)
                {
                    Action->addEffectParam   = -Action->addEffectParam;
                    Action->addEffectMessage = 384;
                }
                else
                {
                    Action->addEffectMessage = 229;
                }

                PDefender->takeDamage(Action->addEffectParam, PAttacker, ATTACK_TYPE::MAGICAL, damageType);
            }
            else if (enspell == ENSPELL_AUSPICE && isFirstSwing)
            {
                Action->additionalEffect = SUBEFFECT_LIGHT_DAMAGE;
                Action->addEffectMessage = 229;
                Action->addEffectParam   = CalculateEnspellDamage(PAttacker, PDefender, 2, 7);

                if (Action->addEffectParam < 0)
                {
                    Action->addEffectParam   = -Action->addEffectParam;
                    Action->addEffectMessage = 384;
                }

                PDefender->takeDamage(Action->addEffectParam, PAttacker, ATTACK_TYPE::MAGICAL, GetEnspellDamageType((ENSPELL)enspell));
            }
            else if (enspell <= ENSPELL_II_DARK) // Elemental enspells
            {
                if (enspell > ENSPELL_I_DARK && isFirstSwing) // Tier II elemental enspell
                {
                    // Enlight II and Endark II currently not implemented; may vary
                    Action->additionalEffect = enspell_subeffects[enspell - 9];
                    Action->addEffectParam   = CalculateEnspellDamage(PAttacker, PDefender, 2, enspell - 8);
                }
                else if (enspell <= ENSPELL_I_DARK) // Tier I elemental enspell
                {
                    Action->additionalEffect = enspell_subeffects[enspell - 1];
                    if (enspell >= ENSPELL_I_LIGHT) // Enlight or Endark
                    {
                        Action->addEffectParam = CalculateEnspellDamage(PAttacker, PDefender, 3, enspell);
                    }
                    else
                    {
                        Action->addEffectParam = CalculateEnspellDamage(PAttacker, PDefender, 1, enspell);
                    }
                }

                if (Action->additionalEffect)
                {
                    if (Action->addEffectParam < 0)
                    {
                        Action->addEffectParam   = -Action->addEffectParam;
                        Action->addEffectMessage = 384;
                    }
                    else
                    {
                        Action->addEffectMessage = 229;
                    }

                    PDefender->takeDamage(Action->addEffectParam, PAttacker, ATTACK_TYPE::MAGICAL, GetEnspellDamageType((ENSPELL)enspell));
                }
            }
        }
        // check weapon for additional effects
        else if (PAttacker->objtype == TYPE_PC && battleutils::GetScaledItemModifier(PAttacker, weapon, Mod::ITEM_ADDEFFECT_TYPE) > 0 &&
                 luautils::additionalEffectAttack(PAttacker, PDefender, weapon, Action, finaldamage) == 0 && Action->additionalEffect)
        {
            if (Action->addEffectMessage == 163 && Action->addEffectParam < 0)
            {
                Action->addEffectMessage = 384; // TODO: enums instead of raw IDs
            }
        }
        // check script for grip if main failed
        else if (PAttacker->objtype == TYPE_PC && static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_SUB) && weapon == PAttacker->m_Weapons[SLOT_MAIN] &&
                 static_cast<CItemWeapon*>(static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_SUB))->getSkillType() == SKILL_NONE &&
                 battleutils::GetScaledItemModifier(PAttacker, static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_SUB), Mod::ITEM_ADDEFFECT_TYPE) > 0 &&
                 luautils::additionalEffectAttack(PAttacker, PDefender, static_cast<CItemWeapon*>(static_cast<CCharEntity*>(PAttacker)->getEquip(SLOT_SUB)), Action,
                                                  finaldamage) == 0 &&
                 Action->additionalEffect)
        {
            if (Action->addEffectMessage == 163 && Action->addEffectParam < 0)
            {
                Action->addEffectMessage = 384;
            }
        }
        else if (PAttacker->objtype == TYPE_MOB && ((CMobEntity*)PAttacker)->getMobMod(MOBMOD_ADD_EFFECT) > 0)
        {
            luautils::OnAdditionalEffect(PAttacker, PDefender, Action, finaldamage);
            if (Action->addEffectMessage == 163 && Action->addEffectParam < 0)
            {
                Action->addEffectMessage = 384;
            }
        }
        else
        {
            bool hasDrainDaze = PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_DAZE);
            bool hasAspirDaze = PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_DAZE);
            bool hasHasteDaze = PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_DAZE);

            if (hasDrainDaze || hasAspirDaze || hasHasteDaze)
            {
                int32 delay = PAttacker->GetWeaponDelay(false) / 10;

                EFFECT daze       = EFFECT_NONE;
                uint32 attackerID = 0;
                uint16 power      = 0;

                if (hasDrainDaze)
                {
                    daze = EFFECT_DRAIN_DAZE;
                }
                else if (hasAspirDaze)
                {
                    daze = EFFECT_ASPIR_DAZE;
                }
                else if (hasHasteDaze)
                {
                    daze = EFFECT_HASTE_DAZE;
                }

                attackerID = PDefender->StatusEffectContainer->GetStatusEffect(daze)->GetSubID();

                if (PAttacker->objtype == TYPE_PC && PAttacker->PParty != nullptr)
                {
                    if (PChar)
                    {
                        // clang-format off
                        PChar->ForPartyWithTrusts([&](CBattleEntity* PMember)
                        {
                            if (attackerID == PMember->id)
                            {
                                power = PDefender->StatusEffectContainer->GetStatusEffect(daze)->GetPower();
                            }
                        });
                        // clang-format on
                    }
                }
                else if (PAttacker->objtype == TYPE_TRUST)
                {
                    if (auto* PMaster = dynamic_cast<CCharEntity*>(PAttacker->PMaster))
                    {
                        // clang-format off
                        PMaster->ForPartyWithTrusts([&](CBattleEntity* PMember)
                        {
                            if (attackerID == PMember->id)
                            {
                                power = PDefender->StatusEffectContainer->GetStatusEffect(daze)->GetPower();
                            }
                        });
                        // clang-format on
                    }
                }
                else if (PAttacker->PMaster == nullptr)
                {
                    if (attackerID == PAttacker->id)
                    {
                        power = PDefender->StatusEffectContainer->GetStatusEffect(daze)->GetPower();
                    }
                }

                if (daze == EFFECT_DRAIN_DAZE && power > 0)
                {
                    uint16 multiplier = (uint16)(3 + 5.5f * (power - 1));
                    int8   Samba      = xirand::GetRandomNumber(1, (delay * multiplier) / 100 + 1);

                    // vary damage based on lvl diff
                    int8 lvlDiff = (PDefender->GetMLevel() - PAttacker->GetMLevel());

                    if (lvlDiff > 0)
                    {
                        if (lvlDiff > 10)
                        {
                            lvlDiff = 10;
                        }
                        Samba -= ceil(Samba * lvlDiff * .04); // 4% penalty per level
                    }

                    if (finaldamage <= 2)
                    {
                        Samba = 0;
                    }
                    else if (Samba > (finaldamage / 2))
                    {
                        Samba = finaldamage / 2;
                    }
                    else if (Samba < 0)
                    {
                        Samba = 0;
                    }

                    Action->additionalEffect = SUBEFFECT_HP_DRAIN;
                    Action->addEffectMessage = 161;
                    Action->addEffectParam   = Samba;

                    PAttacker->addHP(Samba); // does not do any additional damage to targets HP, only heals the attacker

                    if (PChar != nullptr)
                    {
                        PChar->updatemask |= UPDATE_HP;
                    }
                }
                else if (daze == EFFECT_ASPIR_DAZE && power > 0 && PDefender->GetMaxMP() > 0)
                {
                    uint16 multiplier = 1 + 2 * (power - 1);
                    int8   Samba      = xirand::GetRandomNumber(1, (delay * multiplier) / 100 + 1);

                    if (finaldamage <= 2)
                    {
                        Samba = 0;
                    }
                    else if (Samba >= finaldamage / 4)
                    {
                        Samba = finaldamage / 4;
                    }
                    else if (Samba < 0)
                    {
                        Samba = 0;
                    }

                    Action->additionalEffect = SUBEFFECT_MP_DRAIN;
                    Action->addEffectMessage = 162;

                    int16 mpDrained = PDefender->addMP(-Samba);

                    PAttacker->addMP(mpDrained);
                    Action->addEffectParam = mpDrained;

                    if (PChar != nullptr)
                    {
                        PChar->updatemask |= UPDATE_HP;
                    }
                }
                else if (daze == EFFECT_HASTE_DAZE && power > 0)
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
     *  Handle Ranged weapon's additional effects (e.g. Bolts)               *
     *                                                                       *
     ************************************************************************/

    void HandleRangedAdditionalEffect(CCharEntity* PAttacker, CBattleEntity* PDefender, apAction_t* Action)
    {
        // TODO: remove function
    }

    uint8 GetRangedHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isBarrage, int16 accBonus)
    {
        int acc     = 0;
        int hitrate = 75;

        // Check to see if distance is greater than 25 and force hitrate to be 0
        if (distance(PAttacker->loc.p, PDefender->loc.p) > 25)
        {
            return 0;
        }

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

            // Check For Ambush Merit - Ranged
            if ((charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_AMBUSH)) && behind(PAttacker->loc.p, PDefender->loc.p, 64))
            {
                acc += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_AMBUSH, (CCharEntity*)PAttacker);
            }
        }
        else if (PAttacker->objtype == TYPE_PET && ((CPetEntity*)PAttacker)->getPetType() == PET_TYPE::AUTOMATON)
        {
            acc = PAttacker->RACC(SKILL_AUTOMATON_RANGED);
        }
        else if (PAttacker->objtype == TYPE_TRUST)
        {
            auto archery_acc      = PAttacker->RACC(SKILL_ARCHERY);
            auto marksmanship_acc = PAttacker->RACC(SKILL_MARKSMANSHIP);
            auto throwing_acc     = PAttacker->RACC(SKILL_THROWING);

            acc = std::max({ archery_acc, marksmanship_acc, throwing_acc });
        }
        // Check for Yonin evasion bonus while in front of target
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_YONIN) && infront(PDefender->loc.p, PAttacker->loc.p, 64))
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

    // todo: need to penalise attacker's RangedAttack depending on distance from mob. (% decrease)
    float GetRangedDamageRatio(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isCritical, int16 bonusRangedAttack)
    {
        float pDIF = 1.0;

        auto* targ_weapon = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_RANGED]);
        uint8 weaponType  = targ_weapon ? targ_weapon->getSkillType() : static_cast<uint8>(SKILL_MARKSMANSHIP); // TODO: does the no-weapon case actually hit?

        auto levelCorrectionFunc = lua["xi"]["combat"]["levelCorrection"]["isLevelCorrectedZone"];
        auto rangedPDIFFunc      = lua["xi"]["combat"]["physical"]["calculateRangedPDIF"];

        if (rangedPDIFFunc.valid() && levelCorrectionFunc.valid())
        {
            auto levelCorrectionResult = levelCorrectionFunc(PAttacker);
            if (!levelCorrectionResult.valid())
            {
                sol::error err = levelCorrectionResult;
                ShowError("battleutils::GetRangedDamageRatio(): %s", err.what());
                return pDIF;
            }

            auto rangedPDIFFuncResult = rangedPDIFFunc(PAttacker, PDefender, weaponType, 1.0, isCritical, levelCorrectionResult.get<bool>(0), false, 0.0, false, bonusRangedAttack);
            if (!rangedPDIFFuncResult.valid())
            {
                sol::error err = rangedPDIFFuncResult;
                ShowError("battleutils::GetRangedDamageRatio(): %s", err.what());
                return pDIF;
            }
            pDIF = rangedPDIFFuncResult.get<float>(0);
        }
        else
        {
            ShowError("battleutils::GetRangedDamageRatio() failed to run lua calls");
        }

        return pDIF;
    }

    int16 CalculateBaseTP(int32 delay)
    {
        int16 x = 1;
        if (delay <= 180)
        {
            x = (int16)(61 + ((delay - 180) * 63.f) / 360);
        }
        else if (delay <= 540)
        {
            x = (int16)(61 + ((delay - 180) * 88.f) / 360);
        }
        else if (delay <= 630)
        {
            x = (int16)(149 + ((delay - 540) * 20.f) / 360);
        }
        else if (delay <= 720)
        {
            x = (int16)(154 + ((delay - 630) * 28.f) / 360);
        }
        else if (delay <= 900)
        {
            x = (int16)(161 + ((delay - 720) * 24.f) / 360);
        }
        else
        {
            x = (int16)(173 + ((delay - 900) * 28.f) / 360);
        }
        return x;
    }

    bool TryInterruptSpell(CBattleEntity* PAttacker, CBattleEntity* PDefender, CSpell* PSpell)
    {
        // Exceptions.
        if (PDefender->objtype == TYPE_TRUST ||                                   // Caster is a trust.
            PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT) || // Caster has Manafont.
            (SKILLTYPE)PSpell->getSkillType() == SKILL_SINGING)                   // Spell is a song.
        {
            return false;
        }

        // Calculate level ratio.
        int   baseRate   = (PDefender->objtype == TYPE_MOB) ? 5 : 50;
        float levelRatio = (float)(baseRate + PAttacker->GetMLevel() - PDefender->GetMLevel()) / 100.0f;

        if (levelRatio < 0.01)
        {
            levelRatio = 0.01f;
        }

        // Calculate skill ratio.
        float skillRatio     = 1.0f;
        uint8 meritReduction = 0;

        if (PDefender->objtype == TYPE_PC)
        {
            CCharEntity* PChar      = (CCharEntity*)PDefender;
            float        skillCap   = GetMaxSkill((SKILLTYPE)PSpell->getSkillType(), PChar->GetMJob(), PChar->GetMLevel());
            float        skillLevel = PChar->GetSkill(PSpell->getSkillType());

            // If skill cap is 0, player may be using a spell from their subjob.
            if (skillCap == 0)
            {
                skillCap = GetMaxSkill((SKILLTYPE)PSpell->getSkillType(), PChar->GetSJob(), PChar->GetMLevel()); // This may need to be re-investigated in the future.
            }

            // If skill level is 0, set ratio to 10.
            if (skillLevel <= 0)
            {
                skillRatio = 10.0f;
            }
            else
            {
                skillRatio = skillCap / skillLevel;
            }

            // Fetch player-only interruption rate reduction from merits.
            meritReduction = ((CCharEntity*)PDefender)->PMeritPoints->GetMeritValue(MERIT_SPELL_INTERUPTION_RATE, (CCharEntity*)PDefender);
        }

        // SIRD reduces the interrupt after all the calculations are done -- as evidenced by the infamous "102% SIRD" builds.
        // Anything less than 102% interrupt results in the ability to be interrupted.
        // Note: the 102% is probably an x/256 x/1024 nonsense -- sometimes 101% works.
        float SIRDRatio = (100.0f - meritReduction - (float)PDefender->getMod(Mod::SPELLINTERRUPT)) / 100.0f;
        float chance    = xirand::GetRandomNumber<float>(1.0f);

        // This are all ratios.
        // levelRatio : 0.01 to infinity.
        // skillRatio:  1.0 to infinity.
        // SIRDRatio:   No limits. Can be negative. A negative value will guarantee NOT being interrupted.
        float finalRatio = levelRatio * skillRatio * SIRDRatio; // TL;DR Higher = Worse = More chances to get interrupted.

        // You get interrupted. Handle aquaveil.
        if (chance < finalRatio)
        {
            if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_AQUAVEIL))
            {
                auto aquaCount = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_AQUAVEIL)->GetPower();
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

            return true;
        }

        return false;
    }

    /*************************************************************************************************************
     *                                                                                                            *
     *  Calculate the block rate of the defender                                                                  *
     *  Incorporates testing and data from:                                                                       *
     *  http://www.ffxiah.com/forum/topic/21671/paladin-faq-info-and-trade-studies/34/#2581818                    *
     *  https://docs.google.com/spreadsheet/ccc?key=0AkX3maplDraRdFdCZHI2OU93aVgtWlZhN3ozZEtnakE#gid=0            *
     *  http://www.ffxionline.com/forums/paladin/55139-shield-data-size-2-vs-size-3-a.html                        *
     *  https://www.bg-wiki.com/ffxi/Shield_Skill - Base calculations - does not floor                            *
     *  https://www.ffxiah.com/forum/topic/53625/make-paladin-great-again/6/#3434884 - Palisade +base block rate  *
     *                                                                                                            *
     *  Base block rates are (small to large shield type) 55% -> 50% -> 45% -> 30%                                *
     *  Aegis is a special case, having the base block rate of a size 2 type.                                     *
     *                                                                                                            *
     *************************************************************************************************************/

    float GetBlockRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        float  base          = 0;
        int8   shieldSize    = 3;
        float  blockRate     = 0;
        float  skillModifier = 0;
        int16  blockRateMod  = PDefender->getMod(Mod::SHIELDBLOCKRATE);
        int16  palisadeMod   = PDefender->getMod(Mod::PALISADE_BLOCK_BONUS);
        float  reprisalMult  = 1.0f;
        auto*  weapon        = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_MAIN]);
        uint16 attackSkill   = PAttacker->GetSkill((SKILLTYPE)(weapon ? weapon->getSkillType() : 0));
        float  blockSkill    = PDefender->GetSkill(SKILL_SHIELD);

        if (PDefender->objtype == TYPE_PC)
        {
            CCharEntity*    PChar = (CCharEntity*)PDefender;
            CItemEquipment* PItem = PChar->getEquip(SLOT_SUB);

            if (PItem)
            {
                shieldSize = PItem->getShieldSize();
            }
            else
            {
                return 0;
            }
        }
        else if (PDefender->objtype != TYPE_PC)
        {
            CMobEntity* PEntity = (CMobEntity*)PDefender;
            if (PEntity->getMobMod(MOBMOD_CAN_SHIELD_BLOCK) > 0)
            {
                base = PDefender->getMod(Mod::SHIELDBLOCKRATE);
                if (PDefender->objtype == TYPE_PET)
                {
                    skillModifier = (int8)((PDefender->GetSkill(SKILL_AUTOMATON_MELEE) - attackSkill) * 0.215f);
                    if (base <= 0)
                    {
                        return 0;
                    }
                    else
                    {
                        return base + skillModifier;
                    }
                }
                else
                {
                    // TODO: check trust type for ilvl > 99 when implemented
                    blockSkill = GetMaxSkill(SKILLTYPE::SKILL_SHIELD, PDefender->GetMJob(), PDefender->GetMLevel() > 99 ? 99 : PDefender->GetMLevel());

                    // Check for Reprisal and adjust skill and block rate bonus multiplier
                    if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_REPRISAL))
                    {
                        blockSkill   = blockSkill * 1.15f;
                        reprisalMult = 1.5f; // Default is 1.5x

                        // Adamas and Priwen set the multiplier to 3.0x while equipped
                        if (PDefender->getMod(Mod::REPRISAL_BLOCK_BONUS) > 0)
                        {
                            reprisalMult = 3.0f;
                        }
                    }

                    skillModifier = (blockSkill - attackSkill) * 0.2325f;

                    // Add skill and Palisade bonuses
                    base += skillModifier + palisadeMod;
                    // Multiply by Reprisal's bonus
                    base = base * reprisalMult;

                    // Apply the lower and upper caps
                    blockRate = (base < 5) ? 5 : base;
                    blockRate = (base > 100) ? 100 : base;

                    return blockRate;
                }
            }
            else // No block mobmod, so zero rate
            {
                return 0;
            }
        }
        else
        {
            return 0;
        }

        switch (shieldSize)
        {
            case 1: // Buckler
                base = 55;
                break;
            case 2: // Round
                base = 40;
                break;
            case 3: // Kite
                base = 45;
                break;
            case 4: // Tower
                base = 30;
                break;
            case 5: // Aegis and Srivatsa
                base = 50;
                break;
            case 6: // Ochain -- https://www.bg-wiki.com/ffxi/Category:Shields
                base = 108;
                break;
            default:
                return 0;
        }

        // Check for Reprisal and adjust skill and block rate bonus multiplier
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_REPRISAL))
        {
            blockSkill   = blockSkill * 1.15f;
            reprisalMult = 1.5f; // Default is 1.5x

            // Adamas and Priwen set the multiplier to 3.0x while equipped
            if (PDefender->getMod(Mod::REPRISAL_BLOCK_BONUS) > 0)
            {
                reprisalMult = 3.0f;
            }
        }

        skillModifier = (blockSkill - attackSkill) * 0.2325f;

        // Add skill and Palisade bonuses
        base += skillModifier + palisadeMod;
        // Multiply by Reprisal's bonus
        base = base * reprisalMult;
        // Add Chance of Successful Block
        base += blockRateMod;

        // Apply the lower and upper caps
        blockRate = (base < 5) ? 5 : base;
        blockRate = (base > 100) ? 100 : base;

        return blockRate;
    }

    uint8 GetParryRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        CItemWeapon* PWeapon = GetEntityWeapon(PDefender, SLOT_MAIN);
        if ((PWeapon != nullptr && PWeapon->getID() != 0 && PWeapon->getID() != 65535 && PWeapon->getSkillType() != SKILL_HAND_TO_HAND) &&
            PDefender->PAI->IsEngaged())
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

            if (diff < 0.4f)
            {
                diff = 0.4f;
            }
            if (diff > 1.4f)
            {
                diff = 1.4f;
            }

            float dex = PAttacker->DEX();
            float agi = PDefender->AGI();

            auto parryRate = std::clamp<uint8>((uint8)((skill * 0.1f + (agi - dex) * 0.125f + 10.0f) * diff), 5, 25);

            // Issekigan grants parry rate bonus. From best available data, if you already capped out at 25% parry it grants another 25% bonus for ~50%
            // parry rate
            if ((PDefender->objtype == TYPE_PC || PDefender->objtype == TYPE_TRUST) && PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ISSEKIGAN))
            {
                int16 issekiganBonus = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_ISSEKIGAN)->GetPower();
                parryRate += issekiganBonus;
            }

            // Inquartata grants a flat parry rate bonus.
            int16 inquartataBonus = PDefender->getMod(Mod::INQUARTATA);
            parryRate += inquartataBonus;

            return parryRate;
        }

        return 0;
    }

    uint8 GetGuardRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        CItemWeapon* PWeapon = GetEntityWeapon(PDefender, SLOT_MAIN);

        // Defender must have no weapon equipped, or a hand to hand weapon equipped to guard
        bool validWeapon = (PWeapon == nullptr || PWeapon->getSkillType() == SKILL_HAND_TO_HAND);

        if (PDefender->objtype == TYPE_MOB || PDefender->objtype == TYPE_PET)
        {
            validWeapon = PDefender->GetMJob() == JOB_MNK || PDefender->GetMJob() == JOB_PUP;
        }

        int16 cannotGuardMod = 0;
        if (auto* PMob = dynamic_cast<CMobEntity*>(PDefender))
        {
            cannotGuardMod = PMob->getMobMod(MOBMOD_CANNOT_GUARD);
        }

        bool hasGuardSkillRank = (GetSkillRank(SKILL_GUARD, PDefender->GetMJob()) > 0 || GetSkillRank(SKILL_GUARD, PDefender->GetSJob()) > 0);

        if (validWeapon && cannotGuardMod == 0 && hasGuardSkillRank && PDefender->PAI->IsEngaged())
        {
            // assuming this is like parry
            float gbase = (float)PDefender->GetSkill(SKILL_GUARD) + PDefender->getMod(Mod::GUARD);
            float skill = gbase + gbase * (PDefender->getMod(Mod::GUARD_PERCENT) / 100);

            if (PWeapon)
            {
                skill += PWeapon->getILvlParry(); // no weapon will ever have ilvl guard and parry
            }

            float diff = 1.0f + (((float)PDefender->GetMLevel() - PAttacker->GetMLevel()) / 15.0f);

            if (diff < 0.4f)
            {
                diff = 0.4f;
            }
            if (diff > 1.4f)
            {
                diff = 1.4f;
            }

            float dex = PAttacker->DEX();
            float agi = PDefender->AGI();

            // Dodge's guard bonus goes over the cap
            return std::clamp<uint8>((uint8)((skill * 0.1f + (agi - dex) * 0.125f + 10.0f) * diff), 5, 25) + PDefender->getMod(Mod::ADDITIVE_GUARD);
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Calculate damage based on damage and resistance to damage type       *
     *                                                                       *
     ************************************************************************/

    int32 TakePhysicalDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, PHYSICAL_ATTACK_TYPE physicalAttackType, int32 damage, bool isBlocked,
                             uint8 slot, uint16 tpMultiplier, CBattleEntity* taChar, bool giveTPtoVictim, bool giveTPtoAttacker, bool isCounter, bool isCovered,
                             CBattleEntity* POriginalTarget)
    {
        auto* weapon           = GetEntityWeapon(PAttacker, (SLOTTYPE)slot);
        giveTPtoAttacker       = giveTPtoAttacker && !PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI);
        giveTPtoVictim         = giveTPtoVictim && physicalAttackType != PHYSICAL_ATTACK_TYPE::DAKEN;
        bool        isRanged   = (slot == SLOT_AMMO || slot == SLOT_RANGED);
        int32       baseDamage = damage;
        ATTACK_TYPE attackType = ATTACK_TYPE::PHYSICAL;
        DAMAGE_TYPE damageType = DAMAGE_TYPE::NONE;
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_FORMLESS_STRIKES) && !isCounter)
        {
            attackType        = ATTACK_TYPE::SPECIAL;
            uint8 formlessMod = 55; // Start at 55

            // https://www.bg-wiki.com/ffxi/Formless_Strikes
            // Merit value of 1 is +5%, so 60% normal power
            if (PAttacker->objtype == TYPE_PC)
            {
                formlessMod += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_FORMLESS_STRIKES, (CCharEntity*)PAttacker);
            }

            damage = damage * formlessMod / 100;

            // TODO: chance to 'resist'
            // breath damage, not magic damage
            damage = BreathDmgTaken(PDefender, damage);
        }
        else
        {
            damageType = weapon ? weapon->getDmgType() : DAMAGE_TYPE::NONE;

            if (isRanged)
            {
                attackType = ATTACK_TYPE::RANGED;
                damage     = RangedDmgTaken(PDefender, damage, damageType, isCovered);
            }
            else
            {
                damage = PhysicalDmgTaken(PDefender, damage, damageType, isCovered);
            }

            // absorb mods are handled in the above functions, but they do not affect counters
            // this is a little hacky, but will work for now
            if (damage < 0 && isCounter)
            {
                damage = -damage;
            }

            if (!isCounter || giveTPtoAttacker) // counters are always considered blunt (assuming h2h) damage, except retaliation (which is the only counter
                                                // that gives TP to the attacker)
            {
                switch (damageType)
                {
                    case DAMAGE_TYPE::PIERCING:
                        damage = (damage * (PDefender->getMod(Mod::PIERCE_SDT))) / 1000;
                        break;
                    case DAMAGE_TYPE::SLASHING:
                        damage = (damage * (PDefender->getMod(Mod::SLASH_SDT))) / 1000;
                        break;
                    case DAMAGE_TYPE::IMPACT:
                        damage = (damage * (PDefender->getMod(Mod::IMPACT_SDT))) / 1000;
                        break;
                    case DAMAGE_TYPE::HTH:
                        damage = (damage * (PDefender->getMod(Mod::HTH_SDT))) / 1000;
                        break;
                    default:
                        break;
                }
            }
            else
            {
                damage = (damage * (PDefender->getMod(Mod::HTH_SDT))) / 1000;
            }

            if (isBlocked)
            {
                uint8 absorb = 100;

                // shield def bonus is a flat raw damage reduction that occurs before absorb
                // however do not reduce below 0 or if damage is negative
                if (damage > 0)
                {
                    damage = std::max(0, damage - PDefender->getMod(Mod::SHIELD_DEF_BONUS));
                }

                if (const auto PChar = dynamic_cast<CCharEntity*>(PDefender))
                {
                    CItemEquipment* slotSub = PChar->getEquip(SLOT_SUB);
                    if (slotSub && slotSub->IsShield())
                    {
                        absorb = std::clamp(100 - slotSub->getShieldAbsorption(), 0, 100);

                        // Shield Mastery
                        if ((std::max(damage - (PDefender->getMod(Mod::PHALANX) + PDefender->getMod(Mod::STONESKIN)), 0) > 0) &&
                            PDefender->getMod(Mod::SHIELD_MASTERY_TP))
                        {
                            // If the player blocked with a shield and has shield mastery, add shield mastery TP bonus
                            // unblocked damage (before block but as if affected by stoneskin/phalanx) must be greater than zero
                            PDefender->addTP(PDefender->getMod(Mod::SHIELD_MASTERY_TP));
                        }
                    }
                }
                else if (PDefender->objtype == TYPE_PET)
                {
                    absorb = 50;

                    // Shield Mastery
                    if ((std::max(damage - (PDefender->getMod(Mod::PHALANX) + PDefender->getMod(Mod::STONESKIN)), 0) > 0) &&
                        (PDefender->getMod(Mod::SHIELD_MASTERY_TP)))
                    {
                        // If the pet blocked with a shield and has shield mastery, add shield mastery TP bonus
                        // unblocked damage (before block but as if affected by stoneskin/phalanx) must be greater than zero
                        PDefender->addTP(PDefender->getMod(Mod::SHIELD_MASTERY_TP));
                    }
                }
                else if (PDefender->objtype == TYPE_TRUST)
                {
                    absorb = 50;

                    // Shield Mastery
                    if ((std::max(damage - (PDefender->getMod(Mod::PHALANX) + PDefender->getMod(Mod::STONESKIN)), 0) > 0) &&
                        (PDefender->getMod(Mod::SHIELD_MASTERY_TP)))
                    {
                        // If the trust blocked with a shield and has shield mastery, add shield mastery TP bonus
                        // unblocked damage (before block but as if affected by stoneskin/phalanx) must be greater than zero
                        PDefender->addTP(PDefender->getMod(Mod::SHIELD_MASTERY_TP));
                    }
                }
                else
                {
                    absorb = 50;
                }

                // Reprisal
                if (damage > 0 && PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_REPRISAL))
                {
                    // Reflect a portion of the blocked damage back. This is calculated before Stoneskin, Phalanx, Sentinel or Invincible
                    CStatusEffect* reprisalEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_REPRISAL);

                    if (reprisalEffect != nullptr)
                    {
                        float spikesBonus   = 1.f + (PDefender->getMod(Mod::REPRISAL_SPIKES_BONUS) / 100.f);
                        int16 effectPower   = (int16)(reprisalEffect->GetPower() * spikesBonus);
                        int32 blockedDamage = (damage * (100 - absorb)) / 100;
                        int32 spikesDamage  = 0;

                        if (PDefender->StatusEffectContainer->HasStatusEffect({ EFFECT_INVINCIBLE, EFFECT_SENTINEL }))
                        {
                            blockedDamage = (baseDamage * (100.f - absorb)) / 100.f;
                        }

                        spikesDamage = blockedDamage * (effectPower / 100.f);

                        // Set Reprisal spike damage
                        PDefender->setModifier(Mod::SPIKES_DMG, spikesDamage);
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

        damage = CheckAndApplyDamageCap(damage, PDefender);

        // Scarlet Delirium: Updates status effect power with damage bonus
        battleutils::HandleScarletDelirium(PDefender, damage);

        int32 corrected = PDefender->takeDamage(damage, PAttacker, attackType, damageType);
        if (damage < 0)
        {
            damage = -corrected;
        }

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
                    {
                        ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(PAttacker, damage);
                    }
                    else
                    {
                        ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(taChar, damage);
                    }

                    if (((CMobEntity*)PDefender)->m_HiPCLvl < PAttacker->GetMLevel())
                    {
                        ((CMobEntity*)PDefender)->m_HiPCLvl = PAttacker->GetMLevel();
                    }

                    // if the mob is charmed by player
                    if (PDefender->PMaster != nullptr && PDefender->PMaster->objtype == TYPE_PC)
                    {
                        ((CPetEntity*)PDefender)
                            ->loc.zone->UpdateEntityPacket(PDefender, ENTITY_UPDATE, UPDATE_COMBAT);

                        if (PAttacker->objtype == TYPE_MOB)
                        {
                            // charmed mob should lose enmity from normal attacks
                            ((CMobEntity*)PAttacker)->PEnmityContainer->UpdateEnmityFromAttack(PDefender, damage);
                        }
                    }
                    break;

                case TYPE_PET:
                    ((CPetEntity*)PDefender)->loc.zone->UpdateEntityPacket(PDefender, ENTITY_UPDATE, UPDATE_COMBAT);

                    if (PAttacker->objtype == TYPE_MOB)
                    {
                        // pets should lose enmity from normal attacks
                        ((CMobEntity*)PAttacker)->PEnmityContainer->UpdateEnmityFromAttack(PDefender, damage);
                    }
                    break;
                case TYPE_PC:
                    if (PAttacker->objtype == TYPE_MOB)
                    {
                        if (isCovered)
                        {
                            ((CMobEntity*)PAttacker)->PEnmityContainer->UpdateEnmityFromCover(POriginalTarget, PDefender);
                        }
                        else
                        {
                            ((CMobEntity*)PAttacker)->PEnmityContainer->UpdateEnmityFromAttack(PDefender, damage);
                        }
                    }
                    break;
                default:
                    break;
            }

            // try to interrupt spell if not a ranged attack and not blocked by Shield Mastery
            if ((!isRanged) && !((isBlocked) && (PDefender->objtype == TYPE_PC) && (charutils::hasTrait((CCharEntity*)PDefender, TRAIT_SHIELD_MASTERY))))
            {
                PDefender->TryHitInterrupt(PAttacker);
            }

            int16 baseTp = 0;

            if ((slot == SLOT_RANGED || slot == SLOT_AMMO) && PAttacker->objtype == TYPE_PC)
            {
                int32 delay = PAttacker->GetRangedWeaponDelay(true);

                baseTp = CalculateBaseTP(delay * 120 / 1000);
            }
            else
            {
                int32 delay      = PAttacker->GetWeaponDelay(true);
                auto* sub_weapon = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_SUB]);

                if (sub_weapon && sub_weapon->getDmgType() > DAMAGE_TYPE::NONE && sub_weapon->getDmgType() < DAMAGE_TYPE::HTH &&
                    weapon->getSkillType() != SKILL_HAND_TO_HAND)
                {
                    delay = delay / 2;
                }

                float ratio = 1.0f;

                if (weapon && weapon->getSkillType() == SKILL_HAND_TO_HAND)
                {
                    ratio = 2.0f;
                }

                baseTp = CalculateBaseTP(delay * 60.0f / 1000.0f / ratio);
            }

            if (giveTPtoAttacker)
            {
                if (PAttacker->objtype == TYPE_PC && physicalAttackType == PHYSICAL_ATTACK_TYPE::ZANSHIN)
                {
                    baseTp += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_IKISHOTEN, (CCharEntity*)PAttacker);
                }

                PAttacker->addTP(
                    (int16)(tpMultiplier * (baseTp * (1.0f + 0.01f * (float)((PAttacker->getMod(Mod::STORETP) + getStoreTPbonusFromMerit(PAttacker)))))));
            }

            if (giveTPtoVictim)
            {
                uint32 sBlowMerit = 0;
                if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(PAttacker))
                {
                    sBlowMerit = PChar->PMeritPoints->GetMeritValue(MERIT_TYPE::MERIT_SUBTLE_BLOW_EFFECT, PChar);
                }

                // account for attacker's subtle blow which reduces the baseTP gain for the defender
                float sBlow1    = std::clamp((float)(PAttacker->getMod(Mod::SUBTLE_BLOW) + sBlowMerit), -50.0f, 50.0f);
                float sBlow2    = std::clamp((float)PAttacker->getMod(Mod::SUBTLE_BLOW_II), -50.0f, 50.0f);
                float sBlowMult = ((100.0f - std::clamp(sBlow1 + sBlow2, -75.0f, 75.0f)) / 100.0f);

                // mobs hit get basetp+30 whereas pcs hit get basetp/3
                if (PDefender->objtype == TYPE_PC || (PDefender->objtype == TYPE_PET && PDefender->PMaster && PDefender->PMaster->objtype == TYPE_PC))
                {
                    PDefender->addTP(
                        (int16)(tpMultiplier * ((baseTp / 3) * sBlowMult *
                                                (1.0f + 0.01f * (float)((PDefender->getMod(Mod::STORETP) +
                                                                         getStoreTPbonusFromMerit(PAttacker))))))); // yup store tp counts on hits taken too!
                }
                else
                {
                    PDefender->addTP((uint16)(tpMultiplier *
                                              ((baseTp + 30) * sBlowMult *
                                               (1.0f + 0.01f * (float)PDefender->getMod(Mod::STORETP))))); // subtle blow also reduces the "+30" on mob tp gain
                }
            }
        }
        else if (PDefender->objtype == TYPE_MOB)
        {
            ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(PAttacker, 0);
        }

        if (PAttacker->objtype == TYPE_PC && !isRanged && !isCounter)
        {
            PAttacker->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ATTACK);
        }

        return damage;
    }

    /************************************************************************
     *                                                                       *
     *  Handle Damage from Weaponskills (dmg type reductions calced in lua)  *
     *                                                                       *
     ************************************************************************/

    int32 TakeWeaponskillDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 damage, ATTACK_TYPE attackType, DAMAGE_TYPE damageType, uint8 slot,
                                bool primary, float tpMultiplier, uint16 bonusTP, float targetTPMultiplier)
    {
        auto* weapon   = GetEntityWeapon(PAttacker, (SLOTTYPE)slot);
        bool  isRanged = (slot == SLOT_AMMO || slot == SLOT_RANGED);

        if (attackType == ATTACK_TYPE::PHYSICAL &&
            PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_DEFENSE_BOOST) &&
            PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_DEFENSE_BOOST)->GetSubPower() != 0 &&
            infront(PAttacker->loc.p, PDefender->loc.p, PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_DEFENSE_BOOST)->GetSubPower()))
        {
            damage = 0;
        }

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

        damage = CheckAndApplyDamageCap(damage, PDefender);

        int32 corrected = PDefender->takeDamage(damage, PAttacker, attackType, damageType);
        if (damage < 0)
        {
            damage = -corrected;
        }

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
                    // if the mob is charmed by player
                    if (PDefender->PMaster != nullptr && PDefender->PMaster->objtype == TYPE_PC)
                    {
                        ((CPetEntity*)PDefender)
                            ->loc.zone->UpdateEntityPacket(PDefender, ENTITY_UPDATE, UPDATE_COMBAT);
                    }

                    if (((CMobEntity*)PDefender)->m_HiPCLvl < PAttacker->GetMLevel())
                    {
                        ((CMobEntity*)PDefender)->m_HiPCLvl = PAttacker->GetMLevel();
                    }

                    break;

                case TYPE_PET:
                    ((CPetEntity*)PDefender)->loc.zone->UpdateEntityPacket(PDefender, ENTITY_UPDATE, UPDATE_COMBAT);
                    break;

                default:
                    break;
            }

            // try to interrupt spell
            PDefender->TryHitInterrupt(PAttacker);

            int16 baseTp = 0;

            if (isRanged)
            {
                int32 delay = PAttacker->GetRangedWeaponDelay(true);
                baseTp      = CalculateBaseTP((delay * 120) / 1000);
            }
            else
            {
                int32 delay = PAttacker->GetWeaponDelay(true);

                auto* sub_weapon = dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_SUB]);

                if (sub_weapon && sub_weapon->getDmgType() > DAMAGE_TYPE::NONE && sub_weapon->getDmgType() < DAMAGE_TYPE::HTH &&
                    weapon->getSkillType() != SKILL_HAND_TO_HAND)
                {
                    delay /= 2;
                }

                float ratio = 1.0f;

                if (weapon && weapon->getSkillType() == SKILL_HAND_TO_HAND)
                {
                    ratio = 2.0f;
                }

                baseTp = CalculateBaseTP(delay * 60 / 1000 / ratio);
            }

            // add tp to attacker
            if (primary)
            // Calculate TP Return from WS
            {
                standbyTp = bonusTP + ((int16)((tpMultiplier * baseTp) *
                                               (1.0f + 0.01f * (float)((PAttacker->getMod(Mod::STORETP) + getStoreTPbonusFromMerit(PAttacker))))));
            }

            uint32 sBlowMerit = 0;
            if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(PAttacker))
            {
                sBlowMerit = PChar->PMeritPoints->GetMeritValue(MERIT_TYPE::MERIT_SUBTLE_BLOW_EFFECT, PChar);
            }

            // account for attacker's subtle blow which reduces the baseTP gain for the defender
            float sBlow1    = std::clamp((float)(PAttacker->getMod(Mod::SUBTLE_BLOW) + sBlowMerit), -50.0f, 50.0f);
            float sBlow2    = std::clamp((float)PAttacker->getMod(Mod::SUBTLE_BLOW_II), -50.0f, 50.0f);
            float sBlowMult = (100.0f - std::clamp(sBlow1 + sBlow2, -75.0f, 75.0f)) / 100.0f;

            // mobs hit get basetp+30 whereas pcs hit get basetp/3
            if (PDefender->objtype == TYPE_PC)
            {
                PDefender->addTP((int16)(tpMultiplier * targetTPMultiplier *
                                         ((baseTp / 3) * sBlowMult *
                                          (1.0f + 0.01f * (float)((PDefender->getMod(Mod::STORETP) +
                                                                   getStoreTPbonusFromMerit(PAttacker))))))); // yup store tp counts on hits taken too!
            }
            else
            {
                PDefender->addTP((int16)(tpMultiplier * targetTPMultiplier *
                                         ((baseTp + 30) * sBlowMult *
                                          (1.0f + 0.01f * (float)PDefender->getMod(Mod::STORETP))))); // subtle blow also reduces the "+30" on mob tp gain
            }
        }
        else if (PDefender->objtype == TYPE_MOB)
        {
            ((CMobEntity*)PDefender)->PEnmityContainer->UpdateEnmityFromDamage(PAttacker, 0);
        }

        if (!isRanged)
        {
            PAttacker->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ATTACK);
        }

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
     *  Handle Damage from Spells (dmg type reductions calced in lua)        *
     *                                                                       *
     ************************************************************************/

    int32 TakeSpellDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, CSpell* PSpell, int32 damage, ATTACK_TYPE attackType, DAMAGE_TYPE damageType)
    {
        // Scarlet Delirium: Updates status effect power with damage bonus
        battleutils::HandleScarletDelirium(PDefender, damage);

        PDefender->takeDamage(damage, PAttacker, attackType, damageType);

        // Remove effects from damage
        if (PSpell->canTargetEnemy() && damage > 0)
        {
            PDefender->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);

            // Check for bind breaking
            BindBreakCheck(PAttacker, PDefender);

            // Add TP for damaging spells (Only player chars who have the Occult Accumen trait)
            int16 tp = battleutils::CalculateSpellTP(PAttacker, PSpell);
            PAttacker->addTP(tp);

            // Targets of damaging spells gain TP
            auto tpGainFunc = lua["xi"]["combat"]["tp"]["calculateTPGainOnMagicalDamage"];
            if (tpGainFunc.valid())
            {
                PDefender->addTP(tpGainFunc(damage, PAttacker, PDefender));
            }
        }

        return damage;
    }

    /************************************************************************
     *                                                                       *
     *  Handle Damage from Swipe/Lunge (dmg type reductions calced in lua)   *
     *                                                                       *
     ************************************************************************/

    int32 TakeSwipeLungeDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, int32 damage, ATTACK_TYPE attackType, DAMAGE_TYPE damageType)
    {
        damage = CheckAndApplyDamageCap(damage, PDefender);

        PDefender->takeDamage(damage, PAttacker, attackType, damageType);

        // Remove effects from damage
        if (damage > 0)
        {
            PDefender->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);
            // Check for bind breaking
            BindBreakCheck(PAttacker, PDefender);

            // Do targets get TP?
        }

        return damage;
    }

    /************************************************************************
     *                                                                       *
     *  Calculate Probability attack will hit (20% min - 95~99% max cap)     *
     *  attackNumber: 0=main, 1=sub, 2=kick                                  *
     *                                                                       *
     ************************************************************************/

    uint8 GetHitRateEx(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber,
                       int16 offsetAccuracy) // subWeaponAttack is for calculating acc of dual wielded sub weapon
    {
        int32 hitrate = 75;

        if (PAttacker->objtype == TYPE_PC &&
            ((PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK_ATTACK) &&
              (behind(PAttacker->loc.p, PDefender->loc.p, 64) || PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE))) ||
             (charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_ASSASSIN) && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK) &&
              battleutils::getAvailableTrickAttackChar(PAttacker, PDefender))))
        {
            hitrate = 100; // Attack with SA active or TA/Assassin cannot miss
        }
        else
        {
            // Check For Ambush Merit - Melee
            if (PAttacker->objtype == TYPE_PC && (charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_AMBUSH)) && behind(PAttacker->loc.p, PDefender->loc.p, 64))
            {
                offsetAccuracy += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_AMBUSH, (CCharEntity*)PAttacker);
            }
            // Check for Closed Position merit on attacker for additional accuracy and that attacker and defender are facing each other
            if (PAttacker->objtype == TYPE_PC && (charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_CLOSED_POSITION)) &&
                (infront(PAttacker->loc.p, PDefender->loc.p, 64) && facing(PAttacker->loc.p, PDefender->loc.p, 64)))
            {
                offsetAccuracy += ((CCharEntity*)PAttacker)->PMeritPoints->GetMeritValue(MERIT_CLOSED_POSITION, (CCharEntity*)PAttacker);
            }
            // Check for Closed Position merit on defender for additional evasion and that attacker and defender are facing each other
            if (PDefender->objtype == TYPE_PC && (charutils::hasTrait((CCharEntity*)PDefender, TRAIT_CLOSED_POSITION)) &&
                (infront(PDefender->loc.p, PAttacker->loc.p, 64) && facing(PDefender->loc.p, PAttacker->loc.p, 64)))
            {
                offsetAccuracy -= ((CCharEntity*)PDefender)->PMeritPoints->GetMeritValue(MERIT_CLOSED_POSITION, (CCharEntity*)PDefender);
            }
            // Check for Innin accuracy bonus from behind target
            if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_INNIN) && behind(PAttacker->loc.p, PDefender->loc.p, 64))
            {
                offsetAccuracy += PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_INNIN)->GetPower();
            }
            // Check for Yonin evasion bonus while in front of target
            if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_YONIN) && infront(PDefender->loc.p, PAttacker->loc.p, 64))
            {
                offsetAccuracy -= PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_YONIN)->GetPower();
            }

            // Hit Rate (%) = 75 + floor( (Accuracy - Evasion)/2 ) + 2*(dLVL)
            // For Avatars negative penalties for level correction seem to be ignored for attack and likely for accuracy,
            // bonuses cap at level diff of 38 based on this testing:
            // https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage

            // Floor because hitrate can only be integer values
            // https://www.bluegartr.com/threads/68786-Dexterity-s-impact-on-critical-hits?p=3209015&viewfull=1#post3209015

            uint16 attackerAcc = PAttacker->ACC(attackNumber, offsetAccuracy);

            hitrate += static_cast<int32>(std::floor((attackerAcc - PDefender->EVA()) / 2));

            // Level correction does not happen in Adoulin zones, Legion, or zones in Escha/Reisenjima
            // https://www.bg-wiki.com/bg/PDIF#Level_Correction_Function_.28cRatio.29
            uint16 zoneId = PAttacker->getZone();

            // All zones from Adoulin onward have an id of 256+
            // This includes Escha/Reisenjima and the new Dynamis zones
            // (Not a post Adoulin Zone) && (Not Legion_A)
            bool shouldApplyLevelCorrection = (zoneId < 256) && (zoneId != 183);

            if (shouldApplyLevelCorrection)
            {
                int16 dLvl = 0;
                // Skip penalties for avatars, this should likely be all pets and mobs but I have no proof
                // of this for ACC, ATT level correction for Pets/Avatars is the same as mobs though.
                bool isPet    = PAttacker->objtype == TYPE_PET;
                bool isAvatar = false;

                if (isPet)
                {
                    CPetEntity* petEntity = dynamic_cast<CPetEntity*>(PAttacker);
                    isAvatar              = petEntity ? petEntity->getPetType() == PET_TYPE::AVATAR : false;
                }

                if (isAvatar)
                {
                    dLvl = PAttacker->GetMLevel() - PDefender->GetMLevel();
                    // Avatars have a known level difference cap of 38
                    dLvl = std::clamp(dLvl, static_cast<int16>(0), static_cast<int16>(38));
                }
                // Only players are penalized for dLvl
                else if (PAttacker->objtype == TYPE_PC && PAttacker->GetMLevel() < PDefender->GetMLevel())
                {
                    dLvl = PAttacker->GetMLevel() - PDefender->GetMLevel();
                }

                hitrate += static_cast<int16>(dLvl * 2);
            }

            // https://www.bg-wiki.com/bg/Hit_Rate
            // Update Notes: https://forum.square-enix.com/ffxi/threads/45365?p=534537#post534537
            // The maximum accuracy of one-handed weapons equipped as the main weapon has been increased from 95% to 99%.
            // * Owing to this change, the maximum accuracy of abilities that rely on main weapon accuracy has also been raised from 95% to 99%.
            // Further, some monster damage types have been changed from hand-to-hand to blunt.* Fellows and alter egos enjoy this benefit as well.
            // The maximum accuracy of beastmaster familiars, wyverns, avatars, and automatons has been increased from 95% to 99%.
            // * In line with this change, familiars summoned using the following items have had their damage types changed from hand-to-hand to blunt.
            // Carrot Broth / Famous Carrot Broth / Bug Broth / Quadav Bug Broth / Berbal Broth / Singing Herbal Broth / Carrion Broth /
            // Cold Carrion Broth / Meat Broth / Warm Meat Broth / Tree Sap / Scarlet Sap / Fish Broth / Fish Oil Broth / Seedbed Soil / Sun Water /
            // Grasshopper Broth / Noisy Grasshopper Broth / Mole Broth / Lively Mole Broth / Blood Broth / Clear Blood Broth / Antica Broth / Fragrant Antica
            // Broth

            int32 maxHitRate  = 99;
            auto* targ_weapon = PAttacker ? dynamic_cast<CItemWeapon*>(PAttacker->m_Weapons[SLOT_MAIN]) : nullptr;

            // As far as I can tell kick attacks fall under Hand-to-Hand so ignoring them and letting them go to 99
            bool isOffhand   = attackNumber == 1;
            bool isTwoHanded = targ_weapon && targ_weapon->isTwoHanded();

            if (isOffhand || isTwoHanded)
            {
                maxHitRate = 95;
            }

            hitrate = std::clamp(hitrate, 20, maxHitRate);
        }
        return static_cast<uint8>(hitrate);
    }
    uint8 GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        return GetHitRateEx(PAttacker, PDefender, 0, 0); // assume attack 0(main)
    }
    uint8 GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber)
    {
        return GetHitRateEx(PAttacker, PDefender, attackNumber, 0);
    }
    uint8 GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber, int16 offsetAccuracy)
    {
        return GetHitRateEx(PAttacker, PDefender, attackNumber, offsetAccuracy);
    }

    /************************************************************************
     *                                                                       *
     *  Calculate Crit Hit Rate                                              *
     *                                                                       *
     ************************************************************************/

    uint8 GetCritHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool ignoreSneakTrickAttack, SLOTTYPE weaponSlot)
    {
        int32 critHitRate = 5;
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_MIGHTY_STRIKES, 0) ||
            PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_MIGHTY_STRIKES))
        {
            return 100;
        }
        else if (PAttacker->objtype == TYPE_PC && (!ignoreSneakTrickAttack) && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK_ATTACK))
        {
            if (behind(PAttacker->loc.p, PDefender->loc.p, 64) || PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE))
            {
                critHitRate = 100;
            }
        }
        else if (PAttacker->objtype == TYPE_PC && PAttacker->GetMJob() == JOB_THF && charutils::hasTrait((CCharEntity*)PAttacker, TRAIT_ASSASSIN) &&
                 (!ignoreSneakTrickAttack) && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK))
        {
            CBattleEntity* taChar = battleutils::getAvailableTrickAttackChar(PAttacker, PDefender);
            if (taChar != nullptr)
            {
                critHitRate = 100;
            }
        }
        else
        {
            // apply merit mods and traits
            if (PAttacker->objtype == TYPE_PC)
            {
                CCharEntity* PCharAttacker = static_cast<CCharEntity*>(PAttacker);
                critHitRate += PCharAttacker->PMeritPoints->GetMeritValue(MERIT_CRIT_HIT_RATE, PCharAttacker);

                // Add Fencer crit hit rate
                CItemWeapon*    PMain      = dynamic_cast<CItemWeapon*>(PCharAttacker->m_Weapons[SLOT_MAIN]);
                CItemEquipment* PSub       = PCharAttacker->getEquip(SLOT_SUB);
                CItemWeapon*    PSubWeapon = dynamic_cast<CItemWeapon*>(PCharAttacker->m_Weapons[SLOT_SUB]);

                if (PMain && !PMain->isTwoHanded() && !PMain->isHandToHand() &&
                    (!PSub || (PSubWeapon && PSubWeapon->getSkillType() == SKILL_NONE) || PSub->IsShield()))
                {
                    critHitRate += PCharAttacker->getMod(Mod::FENCER_CRITHITRATE);
                }
            }

            if (PDefender->objtype == TYPE_PC)
            {
                critHitRate -= ((CCharEntity*)PDefender)->PMeritPoints->GetMeritValue(MERIT_ENEMY_CRIT_RATE, (CCharEntity*)PDefender);
            }

            // Check for Innin crit rate bonus from behind target
            if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_INNIN) && behind(PAttacker->loc.p, PDefender->loc.p, 64))
            {
                critHitRate += PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_INNIN)->GetPower();
            }
            // Check for Yonin enemy crit rate reduction while in front of target
            if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_YONIN) && infront(PDefender->loc.p, PAttacker->loc.p, 64))
            {
                critHitRate -= PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_YONIN)->GetPower();
            }

            critHitRate += GetDexCritBonus(PAttacker, PDefender);
            critHitRate += PAttacker->getMod(Mod::CRITHITRATE);
            critHitRate -= PDefender->getMod(Mod::CRITICAL_HIT_EVASION); // Similar to merits. However, it can be possitive or negative. When mod is negative, it raises crit-hit-rate.

            // need to check for mods that only impact attacks with a specific weapon (like Senjuinrikio)
            if (auto* player = dynamic_cast<CCharEntity*>(PAttacker))
            {
                auto* weapon = dynamic_cast<CItemWeapon*>(player->getEquip(weaponSlot));
                if (weapon && weapon->getModifier(Mod::CRITHITRATE_ONLY_WEP) > 0)
                {
                    critHitRate += weapon->getModifier(Mod::CRITHITRATE_ONLY_WEP);
                }
            }

            critHitRate = std::clamp(critHitRate, 0, 100);
        }
        return (uint8)critHitRate;
    }

    int8 GetDexCritBonus(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        // https://www.bg-wiki.com/bg/Critical_Hit_Rate
        int32 attackerDex = PAttacker->DEX();
        int32 defenderAgi = PDefender->AGI();
        int32 dDex        = attackerDex - defenderAgi;
        // only care for values between 0 and 50
        int32 dDexClamp = std::clamp(dDex, 0, 50);

        // Default to +0 crit rate for a delta of 0-6
        int32 critRate = 0;
        if (dDexClamp > 39)
        {
            // 40-50: (dDEX-35)
            critRate = dDexClamp - 35;
        }
        else if (dDexClamp > 29)
        {
            // 30-39: +4
            critRate = 4;
        }
        else if (dDexClamp > 19)
        {
            // 20-29: +3
            critRate = 3;
        }
        else if (dDexClamp > 13)
        {
            // 14-19: +2
            critRate = 2;
        }
        else if (dDexClamp > 6)
        {
            critRate = 1;
        }

        // Crit rate delta from stats caps at 15
        return std::min(critRate, 15);
    }

    /************************************************************************
     *                                                                       *
     *  Calculate Ranged Crit Hit Rate                                       *
     *                                                                       *
     ************************************************************************/

    uint8 GetRangedCritHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        int32 critHitRate = 5;
        // apply merit mods and traits
        if (PAttacker->objtype == TYPE_PC)
        {
            CCharEntity* PCharAttacker = static_cast<CCharEntity*>(PAttacker);
            critHitRate += PCharAttacker->PMeritPoints->GetMeritValue(MERIT_CRIT_HIT_RATE, PCharAttacker);
        }

        if (PDefender->objtype == TYPE_PC)
        {
            critHitRate -= ((CCharEntity*)PDefender)->PMeritPoints->GetMeritValue(MERIT_ENEMY_CRIT_RATE, (CCharEntity*)PDefender);
        }

        // Check for Innin crit rate bonus from behind target
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_INNIN) && behind(PAttacker->loc.p, PDefender->loc.p, 64))
        {
            critHitRate += PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_INNIN)->GetPower();
        }
        // Check for Yonin enemy crit rate reduction while in front of target
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_YONIN) && infront(PDefender->loc.p, PAttacker->loc.p, 64))
        {
            critHitRate -= PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_YONIN)->GetPower();
        }

        critHitRate += GetAGICritBonus(PAttacker, PDefender);
        critHitRate += PAttacker->getMod(Mod::CRITHITRATE);
        critHitRate -= PDefender->getMod(Mod::CRITICAL_HIT_EVASION); // Similar to merits. However, it can be possitive or negative. When mod is negative, it raises crit-hit-rate.
        critHitRate = std::clamp(critHitRate, 0, 100);

        return (uint8)critHitRate;
    }

    int8 GetAGICritBonus(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        // https://www.bg-wiki.com/bg/Critical_Hit_Rate
        int32 attackerAgi = PAttacker->AGI();
        int32 defenderAgi = PDefender->AGI();
        int32 dAgi        = attackerAgi - defenderAgi;
        // Only consider positive dAgi
        int32 dAgiPositive = std::max(0, dAgi);

        int32 critRate = dAgiPositive / 10;

        return critRate;
    }

    /************************************************************************
     *                                                                       *
     *   Formula for calculating damage ratio                                *
     *                                                                       *
     ************************************************************************/

    float GetDamageRatio(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isCritical, float bonusAttPercent, SKILLTYPE weaponType, SLOTTYPE weaponSlot, bool isCannonball)
    {
        float pDIF = 1.0f;

        auto levelCorrectionFunc = lua["xi"]["combat"]["levelCorrection"]["isLevelCorrectedZone"];
        auto meleePDIFFunc       = lua["xi"]["combat"]["physical"]["calculateMeleePDIF"];

        if (meleePDIFFunc.valid() && levelCorrectionFunc.valid())
        {
            auto levelCorrectionResult = levelCorrectionFunc(PAttacker);
            if (!levelCorrectionResult.valid())
            {
                sol::error err = levelCorrectionResult;
                ShowError("battleutils::GetDamageRatio(): %s", err.what());
                return pDIF;
            }

            auto meleePDIFFuncResult = meleePDIFFunc(PAttacker, PDefender, weaponType, bonusAttPercent, isCritical, levelCorrectionResult.get<bool>(0), false, 0.0, false, weaponSlot, false);
            if (!meleePDIFFuncResult.valid())
            {
                sol::error err = meleePDIFFuncResult;
                ShowError("battleutils::GetDamageRatio(): %s", err.what());
                return pDIF;
            }
            pDIF = meleePDIFFuncResult.get<float>(0);
        }
        else
        {
            ShowError("battleutils::GetDamageRatio() failed to run lua calls");
        }

        return pDIF;
    }

    /************************************************************************
     *                                                                       *
     *   Formula for Strength                                                *
     *                                                                       *
     ************************************************************************/

    int32 GetFSTR(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 SlotID)
    {
        int32 rank = 0;
        int32 fstr = 0;
        float dif  = (float)(PAttacker->STR() - PDefender->VIT());

        // does mob FSTR2 for ranged attack apply here?
        if (PAttacker->objtype == TYPE_MOB || PAttacker->objtype == TYPE_PET)
        {
            fstr = (PAttacker->STR() - PDefender->VIT() + 4) / 4;

            // Level -1 mobs are coded as level 1, but they have an fSTR of 1 always
            if (PAttacker->objtype == TYPE_MOB && PAttacker->GetMLevel() == 1)
            {
                return 1;
            }

            return std::clamp(fstr, -20, 24);
        }

        if (dif >= 12)
        {
            fstr = static_cast<int32>((dif + 4) / 2);
        }
        else if (dif >= 6)
        {
            fstr = static_cast<int32>((dif + 6) / 2);
        }
        else if (dif >= 1)
        {
            fstr = static_cast<int32>((dif + 7) / 2);
        }
        else if (dif >= -2)
        {
            fstr = static_cast<int32>((dif + 8) / 2);
        }
        else if (dif >= -7)
        {
            fstr = static_cast<int32>((dif + 9) / 2);
        }
        else if (dif >= -15)
        {
            fstr = static_cast<int32>((dif + 10) / 2);
        }
        else if (dif >= -21)
        {
            fstr = static_cast<int32>((dif + 12) / 2);
        }
        else
        {
            fstr = static_cast<int32>((dif + 13) / 2);
        }

        if (SlotID == SLOT_RANGED || SlotID == SLOT_AMMO)
        {
            rank = PAttacker->GetRangedWeaponRank();
            // Different caps than melee weapons
            if (fstr <= (-rank * 2))
            {
                return (-rank * 2);
            }

            if ((fstr > (-rank * 2)) && (fstr <= (2 * (rank + 8))))
            {
                return fstr;
            }
            else
            {
                return 2 * (rank + 8);
            }
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

            // Everything else
            if (fstr <= (-rank))
            {
                return (-rank);
            }

            if ((fstr > (-rank)) && (fstr <= rank + 8))
            {
                return fstr;
            }
            else
            {
                return rank + 8;
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Multihit calculator                                                  *
     *                                                                       *
     ************************************************************************/

    uint8 getHitCount(uint8 hits)
    {
        uint8 distribution = xirand::GetRandomNumber(100);
        uint8 num          = 1;

        switch (hits)
        {
            case 0:
                break;
            case 1:
                break;
            case 2: // cdf = 55,100
                if (distribution < 55)
                {
                    break;
                }
                else
                {
                    num += 1;
                    break;
                }
                break;
            case 3: // cdf = 30,80,100
                if (distribution < 30)
                {
                    break;
                }
                else if (distribution < 80)
                {
                    num += 1;
                    break;
                }
                else
                {
                    num += 2;
                    break;
                }
                break;
            case 4: // cdf = 20,50,80,100
                if (distribution < 20)
                {
                    break;
                }
                else if (distribution < 50)
                {
                    num += 1;
                    break;
                }
                else if (distribution < 80)
                {
                    num += 2;
                    break;
                }
                else
                {
                    num += 3;
                    break;
                }
                break;
            case 5: // cdf = 10,30,60,90,100
                if (distribution < 10)
                {
                    break;
                }
                else if (distribution < 30)
                {
                    num += 1;
                    break;
                }
                else if (distribution < 60)
                {
                    num += 2;
                    break;
                }
                else if (distribution < 90)
                {
                    num += 3;
                    break;
                }
                else
                {
                    num += 4;
                    break;
                }
                break;
            case 6: // cdf = 10,30,50,70,90,100
                if (distribution < 10)
                {
                    break;
                }
                else if (distribution < 30)
                {
                    num += 1;
                    break;
                }
                else if (distribution < 50)
                {
                    num += 2;
                    break;
                }
                else if (distribution < 70)
                {
                    num += 3;
                    break;
                }
                else if (distribution < 90)
                {
                    num += 4;
                    break;
                }
                else
                {
                    num += 5;
                    break;
                }
                break;
            case 7: // cdf = 5,20,45,70,85,95,100
                if (distribution < 5)
                {
                    break;
                }
                else if (distribution < 20)
                {
                    num += 1;
                    break;
                }
                else if (distribution < 45)
                {
                    num += 2;
                    break;
                }
                else if (distribution < 70)
                {
                    num += 3;
                    break;
                }
                else if (distribution < 85)
                {
                    num += 4;
                    break;
                }
                else if (distribution < 95)
                {
                    num += 5;
                    break;
                }
                else
                {
                    num += 6;
                    break;
                }
                break;
            case 8: // cdf = 5,20,45,70,85,95,98,100
                if (distribution < 5)
                {
                    break;
                }
                else if (distribution < 20)
                {
                    num += 1;
                    break;
                }
                else if (distribution < 45)
                {
                    num += 2;
                    break;
                }
                else if (distribution < 70)
                {
                    num += 3;
                    break;
                }
                else if (distribution < 85)
                {
                    num += 4;
                    break;
                }
                else if (distribution < 95)
                {
                    num += 5;
                    break;
                }
                else if (distribution < 98)
                {
                    num += 6;
                    break;
                }
                else
                {
                    num += 7;
                    break;
                }
                break;
        }
        return std::min<uint8>(num, 8); // No more than eight hits per attack
    }

    /************************************************************************
     *                                                                       *
     *  Returns the number of hits for multihit weapons if applicable        *
     *  (Keeping this for backwards compatibility with the old system)       *
     *                                                                       *
     ************************************************************************/

    uint8 CheckMultiHits(CBattleEntity* PEntity, CItemWeapon* PWeapon)
    {
        if (!PWeapon)
        {
            return 0;
        }

        // checking players weapon hit count
        uint8 num = PWeapon->getHitCount();

        int16 tripleAttack = PEntity->getMod(Mod::TRIPLE_ATTACK);
        int16 doubleAttack = PEntity->getMod(Mod::DOUBLE_ATTACK);
        int16 quadAttack   = PEntity->getMod(Mod::QUAD_ATTACK);

        // check for merit upgrades
        if (PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)PEntity;

            // merit chance only applies if player has the job trait
            if (charutils::hasTrait(PChar, TRAIT_TRIPLE_ATTACK))
            {
                tripleAttack += PChar->PMeritPoints->GetMeritValue(MERIT_TRIPLE_ATTACK_RATE, (CCharEntity*)PEntity);
            }
            if (charutils::hasTrait(PChar, TRAIT_DOUBLE_ATTACK))
            {
                doubleAttack += PChar->PMeritPoints->GetMeritValue(MERIT_DOUBLE_ATTACK_RATE, (CCharEntity*)PEntity);
            }
        }

        quadAttack   = std::clamp<int16>(quadAttack, 0, 100);
        doubleAttack = std::clamp<int16>(doubleAttack, 0, 100);
        tripleAttack = std::clamp<int16>(tripleAttack, 0, 100);

        if (xirand::GetRandomNumber(100) < quadAttack)
        {
            num += 3;
        }
        else if (xirand::GetRandomNumber(100) < tripleAttack)
        {
            num += 2;
        }
        else if (xirand::GetRandomNumber(100) < doubleAttack)
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
                {
                    zanshin += ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_ZASHIN_ATTACK_RATE, (CCharEntity*)PEntity);
                }

                if (xirand::GetRandomNumber(100) < (zanshin / 4))
                {
                    num++;
                }
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
        return (xirand::GetRandomNumber(100) < PAttacker->getMod(Mod::PARALYZE));
    }

    /************************************************************************
     *                                                                       *
     *  Chance Shadows (Blink/Utsusemi) will proc                            *
     *                                                                       *
     ************************************************************************/

    bool IsAbsorbByShadow(CBattleEntity* PDefender, CBattleEntity* PAttacker)
    {
        // utsus always overwrites blink, so if utsus>0 then we know theres no blink.
        uint16 Shadow    = PDefender->getMod(Mod::UTSUSEMI);
        Mod    modShadow = Mod::UTSUSEMI;
        if (Shadow == 0)
        {
            Shadow    = PDefender->getMod(Mod::BLINK);
            modShadow = Mod::BLINK;
            // random chance, assume 80% proc
            if (xirand::GetRandomNumber(100) < 20)
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
                            case 1:
                                icon = EFFECT_COPY_IMAGE_1;
                                break;
                            case 2:
                                icon = EFFECT_COPY_IMAGE_2;
                                break;
                        }
                        // player loses 25 CE if attack absorbed by utsusemi shadow
                        if (auto* PMob = dynamic_cast<CMobEntity*>(PAttacker))
                        {
                            PMob->PEnmityContainer->UpdateEnmity(PDefender, -25, 0);
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
        if (PAttacker == PDefender)
        {
            return false;
        }

        int16 KillerEffect = 0;

        switch (PAttacker->m_EcoSystem)
        {
            case ECOSYSTEM::AMORPH:
                KillerEffect = PDefender->getMod(Mod::AMORPH_KILLER);
                break;
            case ECOSYSTEM::AQUAN:
                KillerEffect = PDefender->getMod(Mod::AQUAN_KILLER);
                break;
            case ECOSYSTEM::ARCANA:
                KillerEffect = PDefender->getMod(Mod::ARCANA_KILLER);
                break;
            case ECOSYSTEM::BEAST:
                KillerEffect = PDefender->getMod(Mod::BEAST_KILLER);
                break;
            case ECOSYSTEM::BIRD:
                KillerEffect = PDefender->getMod(Mod::BIRD_KILLER);
                break;
            case ECOSYSTEM::DEMON:
                KillerEffect = PDefender->getMod(Mod::DEMON_KILLER);
                break;
            case ECOSYSTEM::DRAGON:
                KillerEffect = PDefender->getMod(Mod::DRAGON_KILLER);
                break;
            case ECOSYSTEM::EMPTY:
                KillerEffect = PDefender->getMod(Mod::EMPTY_KILLER);
                break;
            case ECOSYSTEM::HUMANOID:
                KillerEffect = PDefender->getMod(Mod::HUMANOID_KILLER);
                break;
            case ECOSYSTEM::LIZARD:
                KillerEffect = PDefender->getMod(Mod::LIZARD_KILLER);
                break;
            case ECOSYSTEM::LUMINION:
                KillerEffect = PDefender->getMod(Mod::LUMINION_KILLER);
                break;
            case ECOSYSTEM::LUMINIAN:
                KillerEffect = PDefender->getMod(Mod::LUMINIAN_KILLER);
                break;
            case ECOSYSTEM::PLANTOID:
                KillerEffect = PDefender->getMod(Mod::PLANTOID_KILLER);
                break;
            case ECOSYSTEM::UNDEAD:
                KillerEffect = PDefender->getMod(Mod::UNDEAD_KILLER);
                break;
            case ECOSYSTEM::VERMIN:
                KillerEffect = PDefender->getMod(Mod::VERMIN_KILLER);
                break;
            default:
                break;
        }

        // Add intimidation rate from Bully
        if (CStatusEffect* PDoubtEffect = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_DOUBT))
        {
            KillerEffect += PDoubtEffect->GetPower();
        }

        // Add intimidation rate from Intimidate status effect
        if (CStatusEffect* PIntimidateEffect = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_INTIMIDATE))
        {
            KillerEffect += PIntimidateEffect->GetPower();
        }

        return (xirand::GetRandomNumber(100) < KillerEffect);
    }

    /************************************************************************
     *                                                                       *
     *  Get SkillChain Effect                                                *
     *                                                                       *
     ************************************************************************/
#define PAIR(x, y) (((x) << 8) + (y))

    uint8 GetSkillchainSubeffect(SKILLCHAIN_ELEMENT skillchain)
    {
        if (skillchain < SC_NONE || skillchain > SC_DARKNESS_II)
        {
            ShowWarning("battleutils::GetSkillchainSubeffect() - Invalid Element passed to function.");
            return 0;
        }

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
        if (skillchain < SC_NONE || skillchain > SC_DARKNESS_II)
        {
            ShowWarning("battleutils::GetSkillchainTier() - Invalid Element passed to function.");
            return 0;
        }

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
        { { SC_LIGHT, SC_LIGHT }, SC_LIGHT_II },
        { { SC_DARKNESS, SC_DARKNESS }, SC_DARKNESS_II },

        // Level 2 Pairs
        { { SC_DISTORTION, SC_GRAVITATION }, SC_DARKNESS },
        { { SC_FRAGMENTATION, SC_GRAVITATION }, SC_FRAGMENTATION },

        { { SC_GRAVITATION, SC_DISTORTION }, SC_DARKNESS },
        { { SC_FUSION, SC_DISTORTION }, SC_FUSION },

        { { SC_GRAVITATION, SC_FUSION }, SC_GRAVITATION },
        { { SC_FRAGMENTATION, SC_FUSION }, SC_LIGHT },

        { { SC_DISTORTION, SC_FRAGMENTATION }, SC_DISTORTION },
        { { SC_FUSION, SC_FRAGMENTATION }, SC_LIGHT },

        // Level 1 Pairs > Level 2 Skillchain

        { { SC_SCISSION, SC_TRANSFIXION }, SC_DISTORTION },
        { { SC_IMPACTION, SC_LIQUEFACTION }, SC_FUSION },
        { { SC_COMPRESSION, SC_DETONATION }, SC_GRAVITATION },
        { { SC_REVERBERATION, SC_INDURATION }, SC_FRAGMENTATION },

        // Level 1 Pairs
        { { SC_COMPRESSION, SC_TRANSFIXION }, SC_COMPRESSION },
        { { SC_REVERBERATION, SC_TRANSFIXION }, SC_REVERBERATION },

        { { SC_TRANSFIXION, SC_COMPRESSION }, SC_TRANSFIXION },
        { { SC_DETONATION, SC_COMPRESSION }, SC_DETONATION },

        { { SC_SCISSION, SC_LIQUEFACTION }, SC_SCISSION },

        { { SC_LIQUEFACTION, SC_SCISSION }, SC_LIQUEFACTION },
        { { SC_REVERBERATION, SC_SCISSION }, SC_REVERBERATION },
        { { SC_DETONATION, SC_SCISSION }, SC_DETONATION },

        { { SC_INDURATION, SC_REVERBERATION }, SC_INDURATION },
        { { SC_IMPACTION, SC_REVERBERATION }, SC_IMPACTION },

        { { SC_SCISSION, SC_DETONATION }, SC_SCISSION },

        { { SC_COMPRESSION, SC_INDURATION }, SC_COMPRESSION },
        { { SC_IMPACTION, SC_INDURATION }, SC_IMPACTION },

        { { SC_LIQUEFACTION, SC_IMPACTION }, SC_LIQUEFACTION },
        { { SC_DETONATION, SC_IMPACTION }, SC_DETONATION }
    };

    SKILLCHAIN_ELEMENT FormSkillchain(const std::list<SKILLCHAIN_ELEMENT>& resonance, const std::list<SKILLCHAIN_ELEMENT>& skill)
    {
        for (const auto& resonance_element : resonance)
        {
            for (const auto& skill_element : skill)
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
        CStatusEffect*     PSCEffect           = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
        CStatusEffect*     PCBEffect           = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_CHAINBOUND, 0);
        SKILLCHAIN_ELEMENT skillchain          = SC_NONE;
        auto               combined_properties = primary | (secondary << 4) | (tertiary << 8);

        if (PSCEffect == nullptr && PCBEffect == nullptr)
        {
            // No effect exists, apply an effect using the weaponskill ID as the power with a tier of 0.
            PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_SKILLCHAIN, 0, combined_properties, 0, 10, 0, 0, 0));
            return SUBEFFECT_NONE;
        }
        else
        {
            std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
            std::list<SKILLCHAIN_ELEMENT> skillProperties = { (SKILLCHAIN_ELEMENT)primary, (SKILLCHAIN_ELEMENT)secondary, (SKILLCHAIN_ELEMENT)tertiary };

            // Chainbound active on target
            if (PCBEffect)
            {
                if (PCBEffect->GetStartTime() + 2s < server_clock::now())
                {
                    // Konzen-Ittai
                    if (PCBEffect->GetPower() > 1)
                    {
                        resonanceProperties.emplace_back(SC_LIGHT);
                        resonanceProperties.emplace_back(SC_DARKNESS);
                        resonanceProperties.emplace_back(SC_GRAVITATION);
                        resonanceProperties.emplace_back(SC_FRAGMENTATION);
                        resonanceProperties.emplace_back(SC_DISTORTION);
                        resonanceProperties.emplace_back(SC_FUSION);
                    }
                    resonanceProperties.emplace_back(SC_LIQUEFACTION);
                    resonanceProperties.emplace_back(SC_INDURATION);
                    resonanceProperties.emplace_back(SC_REVERBERATION);
                    resonanceProperties.emplace_back(SC_IMPACTION);
                    resonanceProperties.emplace_back(SC_COMPRESSION);

                    skillchain = FormSkillchain(resonanceProperties, skillProperties);
                }
                PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_SKILLCHAIN, 0, combined_properties, 0, 10, 0, 0, 0));
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_CHAINBOUND);
                PSCEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
            }
            // Previous effect exists
            else if (PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now())
            {
                if (PSCEffect->GetTier() == 0)
                {
                    if (!PSCEffect->GetPower())
                    {
                        ShowWarning("PSCEffect Power was 0.");
                        return SUBEFFECT_NONE;
                    }

                    // Previous effect is an opening effect, meaning the power is
                    // actually the ID of the opening weaponskill.  We need all 3
                    // of the possible skillchain properties on the initial link.
                    auto properties = PSCEffect->GetPower();
                    resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(properties & 0b1111));
                    resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)((properties >> 4) & 0b1111));
                    resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)((properties >> 8) & 0b1111));
                    skillchain = FormSkillchain(resonanceProperties, skillProperties);
                }
                else
                {
                    // Previous effect is not an opening effect, meaning the power is
                    // The skill chain ID resonating.
                    resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)PSCEffect->GetPower());
                    skillchain = FormSkillchain(resonanceProperties, skillProperties);
                }
            }

            Mod resistanceRankMods[] = { Mod::FIRE_RES_RANK, Mod::ICE_RES_RANK, Mod::WIND_RES_RANK, Mod::EARTH_RES_RANK, Mod::THUNDER_RES_RANK, Mod::ICE_RES_RANK, Mod::LIGHT_RES_RANK, Mod::DARK_RES_RANK };

            // Reset any resistance rank mods on the defender
            PDefender->delModifiers(&PSCEffect->modList);

            // Reset the effects resistance rank mods
            for (auto& resistanceRank : resistanceRankMods)
            {
                PSCEffect->setMod(resistanceRank, 0);
            }

            if (skillchain != SC_NONE)
            {
                PSCEffect->SetStartTime(server_clock::now());
                PSCEffect->SetDuration(PSCEffect->GetDuration() - 1000);
                PSCEffect->SetTier(GetSkillchainTier(skillchain));
                PSCEffect->SetPower(skillchain);
                PSCEffect->SetSubPower(std::min(PSCEffect->GetSubPower() + 1, 5)); // Linked, limited to 5

                // Set new resistance rank modifiers
                // https://www.bg-wiki.com/ffxi/Resist#Modifying_Resistance_Rank
                for (auto& element : GetSkillchainMagicElement(skillchain))
                {
                    Mod resistanceRankMod = GetResistanceRankModFromElement(element);
                    PSCEffect->setMod(resistanceRankMod, -1);
                }

                // Add the mods back to the player (effect cleanup will destroy the mods for us later)
                PDefender->addModifiers(&PSCEffect->modList);

                return (SUBEFFECT)GetSkillchainSubeffect(skillchain);
            }

            PSCEffect->SetStartTime(server_clock::now());
            PSCEffect->SetDuration(10000);
            PSCEffect->SetTier(0);
            PSCEffect->SetPower(combined_properties);
            PSCEffect->SetSubPower(0);

            return SUBEFFECT_NONE;
        }
    }

    // This whole thing need re-evaluated
    int16 GetSkillchainMinimumResistance(SKILLCHAIN_ELEMENT element, CBattleEntity* PDefender, ELEMENT* appliedEle)
    {
        static const Mod resistances[][4] = {
            { Mod::NONE, Mod::NONE, Mod::NONE, Mod::NONE },        // SC_NONE
            { Mod::LIGHT_SDT, Mod::NONE, Mod::NONE, Mod::NONE },   // SC_TRANSFIXION
            { Mod::DARK_SDT, Mod::NONE, Mod::NONE, Mod::NONE },    // SC_COMPRESSION
            { Mod::FIRE_SDT, Mod::NONE, Mod::NONE, Mod::NONE },    // SC_LIQUEFACTION
            { Mod::EARTH_SDT, Mod::NONE, Mod::NONE, Mod::NONE },   // SC_SCISSION
            { Mod::WATER_SDT, Mod::NONE, Mod::NONE, Mod::NONE },   // SC_REVERBERATION
            { Mod::WIND_SDT, Mod::NONE, Mod::NONE, Mod::NONE },    // SC_DETONATION
            { Mod::ICE_SDT, Mod::NONE, Mod::NONE, Mod::NONE },     // SC_INDURATION
            { Mod::THUNDER_SDT, Mod::NONE, Mod::NONE, Mod::NONE }, // SC_IMPACTION

            { Mod::EARTH_SDT, Mod::DARK_SDT, Mod::NONE, Mod::NONE },   // SC_GRAVITATION
            { Mod::ICE_SDT, Mod::WATER_SDT, Mod::NONE, Mod::NONE },    // SC_DISTORTION
            { Mod::FIRE_SDT, Mod::LIGHT_SDT, Mod::NONE, Mod::NONE },   // SC_FUSION
            { Mod::WIND_SDT, Mod::THUNDER_SDT, Mod::NONE, Mod::NONE }, // SC_FRAGMENTATION

            { Mod::FIRE_SDT, Mod::WIND_SDT, Mod::THUNDER_SDT, Mod::LIGHT_SDT }, // SC_LIGHT
            { Mod::ICE_SDT, Mod::EARTH_SDT, Mod::WATER_SDT, Mod::DARK_SDT },    // SC_DARKNESS
            { Mod::FIRE_SDT, Mod::WIND_SDT, Mod::THUNDER_SDT, Mod::LIGHT_SDT }, // SC_LIGHT
            { Mod::ICE_SDT, Mod::EARTH_SDT, Mod::WATER_SDT, Mod::DARK_SDT },    // SC_DARKNESS_II
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
                {
                    defMod = resistances[element][0];
                }
                else
                {
                    defMod = resistances[element][1];
                }
                break;

                // Level 3 & 4 skill chains
            case SC_LIGHT:
            case SC_LIGHT_II:
            case SC_DARKNESS:
            case SC_DARKNESS_II:
                if (PDefender->getMod(resistances[element][0]) < PDefender->getMod(resistances[element][1]))
                {
                    defMod = resistances[element][0];
                }
                else
                {
                    defMod = resistances[element][1];
                }
                if (PDefender->getMod(resistances[element][2]) < PDefender->getMod(defMod))
                {
                    defMod = resistances[element][2];
                }
                if (PDefender->getMod(resistances[element][3]) < PDefender->getMod(defMod))
                {
                    defMod = resistances[element][3];
                }
                break;

            default:
                ShowWarning("Invalid Skillchain Type received (%d).", element);
                return 0;
                break;
        }

        switch (defMod)
        {
            case Mod::FIRE_SDT:
                *appliedEle = ELEMENT_FIRE;
                break;
            case Mod::ICE_SDT:
                *appliedEle = ELEMENT_ICE;
                break;
            case Mod::WIND_SDT:
                *appliedEle = ELEMENT_WIND;
                break;
            case Mod::EARTH_SDT:
                *appliedEle = ELEMENT_EARTH;
                break;
            case Mod::THUNDER_SDT:
                *appliedEle = ELEMENT_THUNDER;
                break;
            case Mod::WATER_SDT:
                *appliedEle = ELEMENT_WATER;
                break;
            case Mod::LIGHT_SDT:
                *appliedEle = ELEMENT_LIGHT;
                break;
            case Mod::DARK_SDT:
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
            { SC_NONE, {} },
            { SC_TRANSFIXION, { ELEMENT_LIGHT } },
            { SC_COMPRESSION, { ELEMENT_DARK } },
            { SC_LIQUEFACTION, { ELEMENT_FIRE } },
            { SC_SCISSION, { ELEMENT_EARTH } },
            { SC_REVERBERATION, { ELEMENT_WATER } },
            { SC_DETONATION, { ELEMENT_WIND } },
            { SC_INDURATION, { ELEMENT_ICE } },
            { SC_IMPACTION, { ELEMENT_THUNDER } },

            { SC_GRAVITATION, { ELEMENT_DARK, ELEMENT_EARTH } },
            { SC_DISTORTION, { ELEMENT_WATER, ELEMENT_ICE } },
            { SC_FUSION, { ELEMENT_LIGHT, ELEMENT_FIRE } },
            { SC_FRAGMENTATION, { ELEMENT_WIND, ELEMENT_THUNDER } },

            { SC_LIGHT, { ELEMENT_LIGHT, ELEMENT_FIRE, ELEMENT_WIND, ELEMENT_THUNDER } },
            { SC_DARKNESS, { ELEMENT_DARK, ELEMENT_EARTH, ELEMENT_WATER, ELEMENT_ICE } },
            { SC_LIGHT_II, { ELEMENT_LIGHT, ELEMENT_FIRE, ELEMENT_WIND, ELEMENT_THUNDER } },
            { SC_DARKNESS_II, { ELEMENT_DARK, ELEMENT_EARTH, ELEMENT_WATER, ELEMENT_ICE } }
        };

        return resonanceToElement.at(skillchain);
    }

    Mod GetResistanceRankModFromElement(ELEMENT& element)
    {
        static const std::unordered_map<ELEMENT, Mod> elementToMod = {
            { ELEMENT_FIRE, Mod::FIRE_RES_RANK },
            { ELEMENT_WATER, Mod::WATER_RES_RANK },
            { ELEMENT_WIND, Mod::WIND_RES_RANK },
            { ELEMENT_EARTH, Mod::EARTH_RES_RANK },
            { ELEMENT_THUNDER, Mod::EARTH_RES_RANK },
            { ELEMENT_ICE, Mod::ICE_RES_RANK },
            { ELEMENT_LIGHT, Mod::LIGHT_RES_RANK },
            { ELEMENT_DARK, Mod::DARK_RES_RANK },
        };

        return elementToMod.at(element);
    }

    int32 TakeSkillchainDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 lastSkillDamage, CBattleEntity* taChar)
    {
        if (PAttacker == nullptr || PDefender == nullptr)
        {
            ShowWarning("battleutils::TakeSkillchainDamage() - PAttacker or PDefender was null.");
            return 0;
        }

        CStatusEffect* PEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);

        if (PEffect == nullptr)
        {
            ShowWarning("battleutils::TakeSkillchainDamage() - PEffect was null.");
            return 0;
        }

        // Determine the skill chain level and elemental resistance.
        SKILLCHAIN_ELEMENT skillchain = (SKILLCHAIN_ELEMENT)PEffect->GetPower();
        uint16             chainLevel = PEffect->GetTier();
        uint16             chainCount = PEffect->GetSubPower();
        ELEMENT            appliedEle = ELEMENT_NONE;
        int16              resistance = GetSkillchainMinimumResistance(skillchain, PDefender, &appliedEle);

        if (chainLevel <= 0 || chainLevel > 4 || chainCount <= 0 || chainCount > 5)
        {
            ShowWarning("chainLevel (%d) or chainCount (%d) exceeds bounds.", chainLevel, chainCount);
            return 0;
        }

        // Skill chain damage = (Closing Damage)
        //                      × (Skill chain Level/Number from Table)
        //                      × (1 + Skill chain Bonus ÷ 100)
        //                      × (1 + Skill chain Damage + %/100)
        //            TODO:     × (1 + Day/Weather bonuses)
        //            TODO:     × (1 + Staff Affinity)

        auto damage = (int32)floor((double)(abs(lastSkillDamage)) * g_SkillChainDamageModifiers[chainLevel][chainCount] / 1000 *
                                   (100 + PAttacker->getMod(Mod::SKILLCHAINBONUS)) / 100 * (10000 + PAttacker->getMod(Mod::SKILLCHAINDMG)) / 10000);

        auto* PChar = dynamic_cast<CCharEntity*>(PAttacker);
        if (PChar && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_INNIN) && behind(PChar->loc.p, PDefender->loc.p, 64))
        {
            damage = (int32)(damage * (1.f + PChar->PMeritPoints->GetMeritValue(MERIT_INNIN_EFFECT, PChar) / 100.f));
        }

        if (PDefender->getMod(Mod::SENGIKORI_SC_DMG_DEBUFF) > 0)
        {
            damage = static_cast<int32>(damage * (1.f + PDefender->getMod(Mod::SENGIKORI_SC_DMG_DEBUFF) / 100.f));
            PDefender->setModifier(Mod::SENGIKORI_SC_DMG_DEBUFF, 0); // Consume the effect
        }

        damage = damage * (10000 - resistance) / 10000;
        damage = MagicDmgTaken(PDefender, damage, appliedEle);
        if (damage > 0)
        {
            damage = std::max(damage - PDefender->getMod(Mod::PHALANX), 0);
            damage = HandleOneForAll(PDefender, damage);
            damage = HandleStoneskin(PDefender, damage);
            HandleAfflatusMiseryDamage(PDefender, damage);
        }
        damage = std::clamp(damage, -99999, 99999);

        uint16 elementOffset = static_cast<uint16>(DAMAGE_TYPE::ELEMENTAL) + static_cast<uint16>(appliedEle);
        PDefender->takeDamage(damage, PAttacker, ATTACK_TYPE::SPECIAL,
                              appliedEle == ELEMENT_NONE ? DAMAGE_TYPE::NONE : static_cast<DAMAGE_TYPE>(elementOffset), true);

        battleutils::ClaimMob(PDefender, PAttacker);
        PDefender->updatemask |= UPDATE_STATUS;

        PDefender->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);

        switch (PDefender->objtype)
        {
            case TYPE_PC:
            {
                if (PDefender->animation == ANIMATION_SIT || (PDefender->animation >= ANIMATION_SITCHAIR_0 && PDefender->animation <= ANIMATION_SITCHAIR_10))
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
        if (Slot < SLOT_HEAD || Slot > SLOT_LINK2)
        {
            ShowWarning("Invalid Slot Type (%d) passed to function.", static_cast<uint8>(Slot));
            return nullptr;
        }

        if (PEntity->objtype == TYPE_PC)
        {
            return (((CCharEntity*)PEntity)->getEquip(Slot));
        }

        return nullptr;
    }

    CItemWeapon* GetEntityWeapon(CBattleEntity* PEntity, SLOTTYPE Slot)
    {
        if (Slot < SLOT_MAIN || Slot > SLOT_AMMO)
        {
            ShowWarning("battleutils::GetEntityWeapon() - Received invalid slot type.");
            return nullptr;
        }

        return dynamic_cast<CItemWeapon*>(((CMobEntity*)PEntity)->m_Weapons[Slot]);
    }

    void MakeEntityStandUp(CBattleEntity* PEntity)
    {
        if (PEntity == nullptr)
        {
            ShowWarning("battleutils::MakeEntityStandUp() - PEntity was null.");
            return;
        }

        if (PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PPlayer = ((CCharEntity*)PEntity);

            if (PPlayer->animation == ANIMATION_HEALING)
            {
                PPlayer->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
                PPlayer->updatemask |= UPDATE_HP;
            }
            else if (PPlayer->animation == ANIMATION_SIT || (PPlayer->animation >= ANIMATION_SITCHAIR_0 && PPlayer->animation <= ANIMATION_SITCHAIR_10))
            {
                PPlayer->animation = ANIMATION_NONE;
                PPlayer->updatemask |= UPDATE_HP;

                CPetEntity* PPet = dynamic_cast<CPetEntity*>(PPlayer->PPet);
                if (PPet && (PPet->getPetType() == PET_TYPE::WYVERN || PPet->getPetType() == PET_TYPE::AUTOMATON))
                {
                    PPet->animation = ANIMATION_NONE;
                    PPet->updatemask |= UPDATE_HP;
                }
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Handle NIN tool usage                                                *
     *  (for all entities except characters, default to true)                *
     *                                                                       *
     ************************************************************************/

    bool HasNinjaTool(CBattleEntity* PEntity, CSpell* PSpell, bool ConsumeTool)
    {
        if (PEntity == nullptr || PSpell == nullptr)
        {
            ShowWarning("battleutils::HasNinjaTool() - PEntity or PSpell was null.");
            return false;
        }

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
                        case ITEMID::UCHITAKE:
                        case ITEMID::TSURARA:
                        case ITEMID::KAWAHORI_OGI:
                        case ITEMID::MAKIBISHI:
                        case ITEMID::HIRAISHIN:
                        case ITEMID::MIZU_DEPPO:
                            toolID = ITEMID::INOSHISHINOFUDA;
                            break;

                        case ITEMID::RYUNO:
                        case ITEMID::MOKUJIN:
                        case ITEMID::SANJAKU_TENUGUI:
                        case ITEMID::KABENRO:
                        case ITEMID::SHINOBI_TABI:
                        case ITEMID::SHIHEI:
                        case ITEMID::RANKA:
                        case ITEMID::FURUSUMI:

                            toolID = ITEMID::SHIKANOFUDA;
                            break;

                        case ITEMID::SOSHI:
                        case ITEMID::KODOKU:
                        case ITEMID::KAGINAWA:
                        case ITEMID::JUSATSU:
                        case ITEMID::SAIRUI_RAN:
                        case ITEMID::JINKO:
                            toolID = ITEMID::CHONOFUDA;
                            break;

                        default:
                            return false;
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
            bool useFutae = (toolID == ITEMID::UCHITAKE || toolID == ITEMID::TSURARA || toolID == ITEMID::KAWAHORI_OGI || toolID == ITEMID::MAKIBISHI ||
                             toolID == ITEMID::HIRAISHIN || toolID == ITEMID::MIZU_DEPPO);

            // If you have Futae active, Ninja Tool Expertise does not apply.
            if (ConsumeTool && hasFutae && useFutae)
            {
                // Futae Takes 2 of Your Tools
                charutils::UpdateItem(PChar, LOC_INVENTORY, SlotID, -2);
                PChar->pushPacket<CInventoryFinishPacket>();
            }
            else
            {
                uint16 meritBonus = 0;

                if (charutils::hasTrait(PChar, TRAIT_NINJA_TOOL_EXPERT))
                {
                    meritBonus = PChar->PMeritPoints->GetMeritValue(MERIT_NINJA_TOOL_EXPERTISE, PChar);
                }

                uint16 chance = (PChar->getMod(Mod::NINJA_TOOL) + meritBonus);

                if (ConsumeTool && xirand::GetRandomNumber(100) > chance)
                {
                    charutils::UpdateItem(PChar, LOC_INVENTORY, SlotID, -1);
                    PChar->pushPacket<CInventoryFinishPacket>();
                }
            }
        }
        return true;
    }

    /*
        pass result of worldAngle(anchorEntity, firstEntity) instead of calculating everytime to allow TA to be more efficient
        Note the order of worldAngle calls, the anchor must be first in all comparisons
        Calculates world angle between other entity and anchor entity,
        then determines if the difference of those angles is within acceptable range for moves that require the three to be "in a straight line"
        Used for Trick Attack and Cover: separate checks for distance/party membership must be done to confirm eligability
    */
    inline bool areInLine(uint8 firstEntityWorldAngle, CBattleEntity* anchorEntity, CBattleEntity* otherEntity)
    {
        // X-degree angle threshold, centered on the firstPlayer's world angle
        // X = 10 => 10/2 * 255 / 360 ~ 3.5 rotation diff, rounded to 4 which really gives X~11.3
        int16 angleDiff = angleDifference(firstEntityWorldAngle, worldAngle(anchorEntity->loc.p, otherEntity->loc.p));

        // Useful for debugging if trick attack/cover aren't reliably calculating eligability, but chatty otherwise
        // ShowDebug("InLine check angleDiff: %d\n", angleDiff);

        return std::abs(angleDiff) <= worldAngleMaxDeviance;
    }

    /*
     *  Find if any party members are in position for trick attack.  Do this by comparing the world angle between:
     *  1. the TA user and the TA target
     *  2. the TA user and the Mob
     *  First, build a list of players that are closer to the mob than the TA user,
     *   then sort by distance and choose the first that succeeds in meeting the criteria of areInline function
     */

    CBattleEntity* getAvailableTrickAttackChar(CBattleEntity* taUser, CBattleEntity* PMob)
    {
        TracyZoneScoped;
        if (!taUser->StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK))
        {
            return nullptr;
        }

        // angle and distance between mob and TA user
        uint8                                         angleTAmob = worldAngle(PMob->loc.p, taUser->loc.p);
        auto                                          distTAmob  = distance(taUser->loc.p, PMob->loc.p);
        std::vector<std::pair<float, CBattleEntity*>> taTargetList;

        if (taUser->PParty != nullptr)
        {
            std::vector<CParty*> taPartyList;
            if (taUser->PParty->m_PAlliance != nullptr)
            {
                taPartyList = taUser->PParty->m_PAlliance->partyList;
            }
            else
            {
                taPartyList.emplace_back(taUser->PParty);
            }

            // Collect all potential TA targets who are closer to the mob than the TA user
            for (auto&& party : taPartyList)
            {
                for (auto&& PMember : party->members)
                {
                    float distTAtarget = distance(PMember->loc.p, PMob->loc.p);
                    // require closer target not be closer than .5 yalms (.5*.5=.25 distsquared) to mob
                    if (distTAtarget >= worldAngleMinDistance && distTAtarget < distTAmob)
                    {
                        taTargetList.emplace_back(distTAtarget, PMember);
                    }

                    if (auto* PChar = dynamic_cast<CCharEntity*>(PMember))
                    {
                        for (auto* PTrust : PChar->PTrusts)
                        {
                            float distTAtarget = distance(PTrust->loc.p, PMob->loc.p);
                            // require closer target not be closer than .5 yalms (.5*.5=.25 distsquared) to mob
                            if (distTAtarget >= worldAngleMinDistance && distTAtarget < distTAmob)
                            {
                                taTargetList.emplace_back(distTAtarget, PTrust);
                            }
                        }
                    }
                }
            }
        }

        // Check TA user's fellow
        /*
        if (auto* PChar = dynamic_cast<CCharEntity*>(taUser))
        {
            if (PChar->PFellow)
            {
                if (auto* fellow = dynamic_cast<CBattleEntity*>(PChar->PFellow))
                {
                    float distTAtarget = distance(fellow->loc.p, PMob->loc.p);
                    // require closer target not be closer than .5 yalms (.5*.5=.25 distsquared) to mob
                    if (distTAtarget >= worldAngleMinDistance && distTAtarget < distTAmob)
                    {
                        taTargetList.emplace_back(distTAtarget, fellow);
                    }
                }
            }
        }
        */

        if (!taTargetList.empty())
        {
            // sorts by distance then by pointer id (only if floats are equal)
            std::sort(taTargetList.begin(), taTargetList.end());
            for (auto const& [dist, potentialTAtarget] : taTargetList)
            {
                if (taUser->id == potentialTAtarget->id || // can't TA self
                    potentialTAtarget->isDead())           // Dead entity should not be TA-able
                {
                    continue;
                }

                if (areInLine(angleTAmob, PMob, potentialTAtarget))
                {
                    return potentialTAtarget;
                }
            }
        }

        // No Trick attack party member available
        return nullptr;
    }

    /************************************************************************
     *                                                                       *
     *  Add enmity to PSource for all the MOB targets who have               *
     *  PTarget on their enmity list.                                        *
     *                                                                       *
     ************************************************************************/

    void GenerateCureEnmity(CBattleEntity* PSource, CBattleEntity* PTarget, int32 amount, int32 fixedCE, int32 fixedVE)
    {
        if (!PSource || !PTarget)
        {
            ShowWarning("battleutils::GenerateCureEnmity - PSource or PTarget was null.");
            return;
        }

        for (auto* PEntity : *PTarget->PNotorietyContainer)
        {
            if (CMobEntity* PCurrentMob = dynamic_cast<CMobEntity*>(PEntity))
            {
                if (PCurrentMob->m_HiPCLvl > 0 && PCurrentMob->PEnmityContainer->HasID(PTarget->id))
                {
                    PCurrentMob->PEnmityContainer->UpdateEnmityFromCure(PSource, PTarget->GetMLevel(), amount, fixedCE, fixedVE);
                }
            }
        }
    }

    // Generate enmity for all targets in range
    void GenerateInRangeEnmity(CBattleEntity* PSource, int16 CE, int16 VE)
    {
        if (PSource == nullptr)
        {
            ShowWarning("battleutils::GenerateInRangeEnmity() - PSource received as null.");
            return;
        }

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
            FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, PIterSource->SpawnMOBList)
            {
                if (PCurrentMob->m_HiPCLvl > 0 && PCurrentMob->PEnmityContainer->HasID(PSource->id))
                {
                    PCurrentMob->PEnmityContainer->UpdateEnmity(PSource, CE, VE, false, false, false);
                }
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Transfer Enmity (used with ACCOMPLICE & COLLABORATOR ability type)   *
     *                                                                       *
     ************************************************************************/

    void TransferEnmity(CBattleEntity* PHateReceiver, CBattleEntity* PHateGiver, CMobEntity* PMob, uint8 percentToTransfer)
    {
        // Ensure the players have a battle target..
        if (PMob == nullptr || (PMob)->PEnmityContainer == nullptr)
        {
            return;
        }

        PMob->PEnmityContainer->LowerEnmityByPercent(PHateGiver, percentToTransfer, PHateReceiver);
    }

    /************************************************************************
     *                                                                       *
     *  Handle Soul Eater effect                                             *
     *                                                                       *
     ************************************************************************/

    uint16 doSoulEaterEffect(CCharEntity* m_PChar, uint32 damage)
    {
        if (m_PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SOULEATER))
        {
            // Souleater's HP consumed is 10% (base) + x% from gear (ONLY HIGHEST) + x% from gear augments.
            float souleaterBonus    = m_PChar->getMaxGearMod(Mod::SOULEATER_EFFECT) * 0.01;
            float souleaterBonusII  = m_PChar->getMod(Mod::SOULEATER_EFFECT_II) * 0.01;
            float stalwartSoulBonus = 1 - static_cast<float>(m_PChar->getMod(Mod::STALWART_SOUL)) / 100;
            float bonusDamage       = m_PChar->health.hp * (0.1f + souleaterBonus + souleaterBonusII);

            if (bonusDamage >= 1)
            {
                m_PChar->addHP(-HandleStoneskin(m_PChar, (int32)(bonusDamage * stalwartSoulBonus)));

                if (m_PChar->GetMJob() == JOB_DRK)
                {
                    damage += bonusDamage;
                }
                else
                {
                    damage += bonusDamage / 2;
                }
            }
        }
        return damage;
    }

    uint16 doConsumeManaEffect(CCharEntity* m_PChar)
    {
        auto bonusDmg = 0;
        if (m_PChar->StatusEffectContainer->HasStatusEffect(EFFECT_CONSUME_MANA))
        {
            bonusDmg += (uint32)(floor(m_PChar->health.mp / 10));
            m_PChar->health.mp = 0;
            m_PChar->StatusEffectContainer->DelStatusEffect(EFFECT_CONSUME_MANA);
        }
        return bonusDmg;
    }

    /************************************************************************
     *                                                                       *
     *  Calculate Samurai Store TP value (from merit)                        *
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
     *  Calculate Samurai Overwhelm damage bonus                             *
     *                                                                       *
     ************************************************************************/

    int32 getOverWhelmDamageBonus(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 damage)
    {
        if (auto PChar = dynamic_cast<CCharEntity*>(PAttacker)) // Some mobskills use TakeWeaponskillDamage function, which calls upon this one.
        {
            // must be in front of mob
            if (infront(PChar->loc.p, PDefender->loc.p, 64))
            {
                uint8 meritCount = PChar->PMeritPoints->GetMeritValue(MERIT_OVERWHELM, PChar);
                float tmpDamage  = static_cast<float>(damage);

                switch (meritCount)
                {
                    case 1:
                        tmpDamage += tmpDamage * 0.05f;
                        break;
                    case 2:
                        tmpDamage += tmpDamage * 0.10f;
                        break;
                    case 3:
                        tmpDamage += tmpDamage * 0.15f;
                        break;
                    case 4:
                        tmpDamage += tmpDamage * 0.17f;
                        break;
                    case 5:
                        tmpDamage += tmpDamage * 0.19f;
                        break;
                    default:
                        break;
                }
                damage = static_cast<int32>(floor(tmpDamage));
            }
        }
        return damage;
    }

    /************************************************************************
     *                                                                       *
     *  Calculate/Handle Barrage shot count                                  *
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

        uint8 lvl       = PChar->jobs.job[JOB_RNG]; // Get Ranger level of char
        uint8 shotCount = 0;                        // the total number of extra hits

        if (PChar->GetSJob() == JOB_RNG)
        { // if rng is sub then use the sub level
            lvl = PChar->GetSLevel();
        }

        // Hunters bracers+1 will add an extra shot
        CItemEquipment* PItemHands = PChar->getEquip(SLOT_HANDS);

        if (PItemHands && PItemHands->getID() == 14900)
        {
            shotCount++;
        }

        if (lvl < 30)
        {
            return 0;
        }
        else if (lvl < 50)
        {
            shotCount += 3;
        }
        else if (lvl < 75)
        {
            shotCount += 4;
        }
        else if (lvl < 90)
        {
            shotCount += 5;
        }
        else if (lvl < 99)
        {
            shotCount += 6;
        }
        else
        {
            shotCount += 7;
        }

        shotCount += PChar->getMod(Mod::BARRAGE_COUNT);

        // make sure we have enough ammo for all these shots
        CItemWeapon* PAmmo = (CItemWeapon*)PChar->getEquip(SLOT_AMMO);

        if (PAmmo && PAmmo->getQuantity() < shotCount)
        {
            shotCount = PAmmo->getQuantity() - 1;
        }

        return shotCount;
    }

    void applyCharm(CBattleEntity* PCharmer, CBattleEntity* PVictim, duration charmTime)
    {
        PVictim->isCharmed = true;

        if (PVictim->objtype == TYPE_MOB)
        {
            CCharEntity* PChar = dynamic_cast<CCharEntity*>(PCharmer);
            CMobEntity*  PMob  = dynamic_cast<CMobEntity*>(PVictim);
            PVictim->PMaster   = PCharmer;
            PCharmer->PPet     = PVictim;

            // make the mob disengage
            if (PCharmer->PPet->PAI->IsEngaged())
            {
                PCharmer->PPet->PAI->Disengage();
            }

            // clear the victims emnity list
            PMob->PEnmityContainer->Clear();

            // set the mobs ai to petAi
            PCharmer->PPet->PAI->SetController(std::make_unique<CPetController>(PMob));
            PCharmer->PPet->charmTime = server_clock::now() + charmTime;

            // this will make him transition back to roaming if sleeping
            PCharmer->PPet->animation = ANIMATION_NONE;
            PCharmer->updatemask |= UPDATE_HP;

            if (PChar)
            {
                charutils::BuildingCharAbilityTable(PChar);
                std::memset(&PChar->m_PetCommands, 0, sizeof(PChar->m_PetCommands));
                PChar->pushPacket<CCharAbilitiesPacket>(PChar);
                PChar->pushPacket<CCharStatusPacket>(PChar);
                PChar->pushPacket<CPetSyncPacket>(PChar);
            }
            // clang-format off
            PCharmer->ForAlliance([&PVictim](CBattleEntity* PMember)
            {
                if (static_cast<CCharEntity*>(PMember)->PClaimedMob == PVictim)
                {
                    static_cast<CCharEntity*>(PMember)->PClaimedMob = nullptr;
                }
            });
            // clang-format on
            PMob->m_OwnerID.clean();
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

            // Prevent auto attacks for a little bit to simulate retail
            // On retail, you don't engage for a little bit, which we have no mechanism for yet
            // TODO: implement the delays on engage (also applies to mobs) and verify exact timings for those things.
            PVictim->PAI->Inactive(5000ms, false);
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
            PEntity->updatemask |= UPDATE_ALL_CHAR;
        }
    }

    void ClaimMob(CBattleEntity* PDefender, CBattleEntity* PAttacker, bool passing)
    {
        TracyZoneScoped;

        if (PDefender == nullptr ||
            (PDefender && PDefender->objtype != ENTITYTYPE::TYPE_MOB) ||                                                   // Do not try to claim anything but mobs (trusts, pets, players don't count)
            (PDefender && PDefender->objtype == ENTITYTYPE::TYPE_MOB && PDefender->allegiance == ALLEGIANCE_TYPE::PLAYER)) // Added mobs that are in allied with player
        {
            return;
        }

        if (auto* mob = dynamic_cast<CMobEntity*>(PDefender))
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
            if (!passing)
            {
                mob->PEnmityContainer->UpdateEnmity(original, 0, 0, true, true);
            }

            if (!mob->m_IsClaimable)
            {
                return;
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
                    if (PDefender->isAlive() && attacker->PClaimedMob && attacker->PClaimedMob != PDefender && attacker->PClaimedMob->isAlive() &&
                        attacker->PClaimedMob->m_OwnerID.id == attacker->id)
                    { // unclaim any other living mobs owned by attacker
                        static_cast<CMobController*>(attacker->PClaimedMob->PAI->GetController())->TapDeclaimTime();
                        attacker->PClaimedMob = nullptr;
                    }
                    if (!mob->GetCallForHelpFlag())
                    {
                        if (battleutils::HasClaim(PAttacker, PDefender))
                        { // mob is currently claimed by your alliance, update ownership
                            mob->m_OwnerID.id     = PAttacker->id;
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
                                mob->m_OwnerID.id     = PAttacker->id;
                                mob->m_OwnerID.targid = PAttacker->targid;
                                return;
                            }
                            CBattleEntity* highestClaim = mob->PEnmityContainer->GetHighestEnmity();
                            if (highestClaim && highestClaim->objtype == TYPE_TRUST)
                            {
                                highestClaim = static_cast<CTrustEntity*>(highestClaim)->PMaster;
                            }
                            // clang-format off
                            PAttacker->ForAlliance([&](CBattleEntity* PMember)
                            {
                                if (!highestClaim || highestClaim == PMember || highestClaim == PMember->PPet)
                                { // someone in your alliance is top of hate list, claim for your alliance
                                    mob->m_OwnerID.id     = PAttacker->id;
                                    mob->m_OwnerID.targid = PAttacker->targid;
                                    if (PDefender->isAlive())
                                    { // ignore killing blow
                                        mob->updatemask |= UPDATE_STATUS;
                                        attacker->PClaimedMob = PDefender;
                                    }
                                }
                            });
                            // clang-format on
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
                // clang-format off
                PAttacker->ForAlliance([&pcinzone, &maxLevel, &mob](CBattleEntity* PMember)
                {
                    if (PMember->getZone() == mob->getZone() && distance(PMember->loc.p, mob->loc.p) < 100)
                    {
                        maxLevel = std::max(maxLevel, PMember->GetMLevel());
                        pcinzone++;
                    }
                });
                // clang-format on
                mob->m_HiPartySize = std::max(pcinzone, mob->m_HiPartySize);
                mob->m_HiPCLvl     = std::max(maxLevel, mob->m_HiPCLvl);
            }
        }
    }

    void RelinquishClaim(CCharEntity* PChar)
    {
        CBattleEntity* mob = PChar->PClaimedMob;
        if (mob && mob->isAlive() && mob->m_OwnerID.id == PChar->id)
        { // if we currently own a mob
            bool found = false;
            // clang-format off
            static_cast<CBattleEntity*>(PChar)->ForAlliance([&PChar, &mob, &found](CBattleEntity* PMember)
            {
                CCharEntity* member = static_cast<CCharEntity*>(PMember);
                if (member != PChar && !found && member->getZone() == PChar->getZone() && member->isAlive() &&
                    (!member->PClaimedMob || member->PClaimedMob == mob))
                { // check if we can pass claim to someone else
                    found = true;
                    battleutils::ClaimMob(mob, PMember, true);
                }
            });
            // clang-format on
            if (!found)
            { // if mob didn't pass to someone else, unclaim it
                static_cast<CMobController*>(mob->PAI->GetController())->TapDeclaimTime();
            }
        }
        PChar->PClaimedMob = nullptr;
    }

    // Checks to see if the mob has a damage cap value
    // This is used for instances like Suttung, Antaeus, Crustacean Conundrum bcnm, Colonization reives
    int32 CheckAndApplyDamageCap(int32 damage, CBattleEntity* PDefender)
    {
        int32 damageCap     = PDefender->getMod(Mod::RECEIVED_DAMAGE_CAP);     // The max damage cap
        int32 damageVariant = PDefender->getMod(Mod::RECEIVED_DAMAGE_VARIANT); // The value you want the damage to have a variance by

        // If the target has no mod or the damage is less than the cap return normal damage
        if (damageCap == 0 || damage < damageCap)
        {
            return damage;
        }

        damage = std::clamp(damage, 0, damageCap);

        // If for whatever reason your damage variant is set too high set the variant to 0 as a fail safe
        if (damageVariant > damageCap)
        {
            ShowWarning("battleutils::CheckAndApplyDamageCap - RECEIVED_DAMAGE_VARIANT is > than RECEIVED_DAMAGE_CAP");
            damageVariant = 0;
        }

        // see https://bugs.llvm.org/show_bug.cgi?id=18767#c1 ; essentially, [min, max) range on this RNG call excludes the max
        // so we must add +1 to our max to achieve the range we want
        damage -= xirand::GetRandomNumber<int32>(0, damageVariant + 1);

        return std::clamp(damage, damageCap - damageVariant, damageCap);
    }

    int32 BreathDmgTaken(CBattleEntity* PDefender, int32 damage)
    {
        float resist = 1.0f + PDefender->getMod(Mod::UDMGBREATH) / 10000.f;
        resist       = std::max(resist, 0.f);
        damage       = (int32)(damage * resist);

        resist = 1.0f + PDefender->getMod(Mod::DMGBREATH) / 10000.f + PDefender->getMod(Mod::DMG) / 10000.f;
        resist = std::clamp(resist, 0.5f, 1.5f); // assuming if its floored at .5f its capped at 1.5f but who's stacking +dmgtaken equip anyway???
        damage = (int32)(damage * resist);

        // TODO: Breaths can have elements. Where are those handled for absorption and nullification.

        // Handle damage absorption.
        if (xirand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE)) // All damage.
        {
            damage = -damage;
        }

        // Handle damage nullification.
        else if (xirand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_DAMAGE) ||      // All damage.
                 xirand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_BREATH_DAMAGE)) // Breath damage.
        {
            damage = 0;
        }

        else
        {
            damage = HandleSevereDamage(PDefender, damage, false);
        }

        damage = CheckAndApplyDamageCap(damage, PDefender);

        return damage;
    }

    // TODO: Study using lua functions.
    int32 MagicDmgTaken(CBattleEntity* PDefender, int32 damage, ELEMENT element)
    {
        Mod absorb[8]    = { Mod::FIRE_ABSORB, Mod::ICE_ABSORB, Mod::WIND_ABSORB, Mod::EARTH_ABSORB,
                             Mod::LTNG_ABSORB, Mod::WATER_ABSORB, Mod::LIGHT_ABSORB, Mod::DARK_ABSORB };
        Mod nullarray[8] = { Mod::FIRE_NULL, Mod::ICE_NULL, Mod::WIND_NULL, Mod::EARTH_NULL, Mod::LTNG_NULL, Mod::WATER_NULL, Mod::LIGHT_NULL, Mod::DARK_NULL };

        DAMAGE_TYPE damageType = (DAMAGE_TYPE)((uint8)DAMAGE_TYPE::ELEMENTAL + (uint8)element);

        // Liement here
        float liement = CheckLiementAbsorb(PDefender, damageType);
        if (liement < 0) // Liement absorbed, short circuit early before MDT/DT
        {
            return (int32)(damage * liement);
        }

        float resist = 1.f + PDefender->getMod(Mod::UDMGMAGIC) / 10000.f;
        resist       = std::max(resist, 0.f);
        damage       = (int32)(damage * resist);

        resist = 1.f + PDefender->getMod(Mod::DMGMAGIC) / 10000.f + PDefender->getMod(Mod::DMG) / 10000.f;
        resist = std::max(resist, 0.5f);

        resist += PDefender->getMod(Mod::DMGMAGIC_II) / 10000.f;
        resist = std::max(resist, 0.125f); // Total cap with MDT-% II included is 87.5%
        damage = (int32)(damage * resist);

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_STEAM_JACKET) > 1)
        {
            damage = HandleSteamJacket(PDefender, damage, damageType);
        }

        // Handle damage absorption.
        if (xirand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE) ||         // All damage.
            xirand::GetRandomNumber(100) < PDefender->getMod(Mod::MAGIC_ABSORB) ||              // Magical damage
            (element && xirand::GetRandomNumber(100) < PDefender->getMod(absorb[element - 1]))) // Elemental damage.
        {
            damage = -damage;
        }

        // Handle damage nullification.
        else if (xirand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_DAMAGE) ||                  // All damage.
                 xirand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_MAGICAL_DAMAGE) ||          // Magical damage
                 (element && xirand::GetRandomNumber(100) < PDefender->getMod(nullarray[element - 1]))) // Elemental damage.
        {
            damage = 0;
        }
        else
        {
            damage = HandleSevereDamage(PDefender, damage, false);
        }

        damage = CheckAndApplyDamageCap(damage, PDefender);

        return damage;
    }

    int32 PhysicalDmgTaken(CBattleEntity* PDefender, int32 damage, DAMAGE_TYPE damageType, bool IsCovered)
    {
        float resist = 1.f + PDefender->getMod(Mod::UDMGPHYS) / 10000.f;
        resist       = std::max(resist, 0.f);
        damage       = (int32)(damage * resist);

        resist = 1.f + PDefender->getMod(Mod::DMGPHYS) / 10000.f + PDefender->getMod(Mod::DMG) / 10000.f;
        resist = std::max(resist, 0.5f);                        // PDT caps at -50%
        resist += PDefender->getMod(Mod::DMGPHYS_II) / 10000.f; // Add Burtgang reduction after 50% cap. Extends cap to -68%
        damage = (int32)(damage * resist);

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_STEAM_JACKET) > 0)
        {
            damage = HandleSteamJacket(PDefender, damage, damageType);
        }

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_EQUALIZER) > 0)
        {
            damage -= (int32)(damage / float(PDefender->GetMaxHP()) * (PDefender->getMod(Mod::AUTO_EQUALIZER) / 100.0f));
        }

        // Handle damage absorption.
        if (xirand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE) || // All damage.
            xirand::GetRandomNumber(100) < PDefender->getMod(Mod::PHYS_ABSORB))         // Physical damage.
        {
            damage = -damage;
        }

        // Handle damage nullification.
        else if (xirand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_DAMAGE) ||        // All damage.
                 xirand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_PHYSICAL_DAMAGE)) // Physical damage.
        {
            damage = 0;
        }

        else
        {
            damage = HandleSevereDamage(PDefender, damage, true);

            ConvertDmgToMP(PDefender, damage, IsCovered);

            damage = HandleFanDance(PDefender, damage);
        }

        damage = CheckAndApplyDamageCap(damage, PDefender);

        return damage;
    }

    int32 RangedDmgTaken(CBattleEntity* PDefender, int32 damage, DAMAGE_TYPE damageType, bool IsCovered)
    {
        float resist = 1.0f + PDefender->getMod(Mod::UDMGRANGE) / 10000.f;
        resist       = std::max(resist, 0.f);
        damage       = (int32)(damage * resist);

        resist = 1.0f + PDefender->getMod(Mod::DMGRANGE) / 10000.f + PDefender->getMod(Mod::DMG) / 10000.f;
        resist = std::max(resist, 0.5f);
        damage = (int32)(damage * resist);

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_STEAM_JACKET) > 0)
        {
            damage = HandleSteamJacket(PDefender, damage, damageType);
        }

        if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_EQUALIZER) > 0)
        {
            damage -= (int32)(damage / float(PDefender->GetMaxHP()) * (PDefender->getMod(Mod::AUTO_EQUALIZER) / 10000.0f));
        }

        // Handle damage absorption.
        if (xirand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE) || // All damage.
            xirand::GetRandomNumber(100) < PDefender->getMod(Mod::PHYS_ABSORB))         // Physical damage. TODO: Consider new modifier for ranged specific.
        {
            damage = -damage;
        }

        // Handle damage nullification.
        else if (xirand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_DAMAGE) ||      // All damage.
                 xirand::GetRandomNumber(100) < PDefender->getMod(Mod::NULL_RANGED_DAMAGE)) // Ranged damage.
        {
            damage = 0;
        }
        else
        {
            damage = HandleSevereDamage(PDefender, damage, true);

            ConvertDmgToMP(PDefender, damage, IsCovered);

            damage = HandleFanDance(PDefender, damage);
        }

        damage = CheckAndApplyDamageCap(damage, PDefender);

        return damage;
    }

    int32 HandleSteamJacket(CBattleEntity* PDefender, int32 damage, DAMAGE_TYPE damageType)
    {
        auto  steamJacketType = static_cast<DAMAGE_TYPE>(PDefender->GetLocalVar("steam_jacket_type"));
        int16 steamJacketHits = (int16)PDefender->GetLocalVar("steam_jacket_hits");

        if (steamJacketType != damageType)
        {
            PDefender->SetLocalVar("steam_jacket_type", static_cast<uint16>(damageType));
            steamJacketHits = 0;
        }

        steamJacketHits += 1;
        PDefender->SetLocalVar("steam_jacket_hits", steamJacketHits);

        if (steamJacketHits >= PDefender->getMod(Mod::AUTO_STEAM_JACKET))
        {
            return damage - (int32)(damage * (PDefender->getMod(Mod::AUTO_STEAM_JACKET_REDUCTION) / 100.0f));
        }
        return damage;
    }

    void HandleIssekiganEnmityBonus(CBattleEntity* PDefender, CBattleEntity* PAttacker)
    {
        if (PAttacker->objtype == TYPE_MOB && PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_ISSEKIGAN))
        {
            // Issekigan is Known to Grant 300 CE per parry, but unknown how it effects VE (per bgwiki). So VE is left alone for now.
            // JP is known to give 10 VE per point
            uint16 jpBonus = static_cast<CCharEntity*>(PDefender)->PJobPoints->GetJobPointValue(JP_ISSEKIGAN_EFFECT) * 10;
            static_cast<CMobEntity*>(PAttacker)->PEnmityContainer->UpdateEnmity(PDefender, 300, 0 + jpBonus, false, false);
        }
    }

    void HandleAfflatusMiseryAccuracyBonus(CBattleEntity* PAttacker)
    {
        if (PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_AFFLATUS_MISERY) && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_AUSPICE))
        {
            // We keep track of the running total of Accuracy Bonus as part of the Sub Power of the Effect
            // This is used to re-adjust Mod::ACC when the effect wears off

            uint16 accBonus = PAttacker->StatusEffectContainer->GetStatusEffect(EFFECT_AFFLATUS_MISERY)->GetSubPower();

            // Per BGWiki, this bonus is thought to cap at +30
            if (accBonus < 30)
            {
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
            reductionPercent   = ((healingSkill / 10) * .5f);

            // Reduction Percent Caps at 25%
            if (reductionPercent > 25)
            {
                reductionPercent = 25;
            }

            reductionPercent = reductionPercent / 100.f;
        }

        return reductionPercent;
    }

    void BindBreakCheck(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        if (PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_BIND))
        {
            uint16 BindBreakChance = 950; // 0-1000 (100.0%) scale. Maybe change to a float later..

            // Previously there was a tiered comparative level check here which gave different rates
            // depending on the level difference between the attacker and the defender.
            // These rates seemed very low, and have been removed, absent true research on retail.
            // EMobDifficulty mobCheck = charutils::CheckMob(PAttacker->GetMLevel(), PDefender->GetMLevel());
            // The level comparison and switch has been removed.

            if (BindBreakChance > xirand::GetRandomNumber(1000))
            {
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_BIND);
            }
        }
    }

    int32 HandleOneForAll(CBattleEntity* PDefender, int32 damage)
    {
        if (damage > 0)
        {
            auto* PEffect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_ONE_FOR_ALL);
            if (PEffect != nullptr)
            {
                damage = std::max(damage - PEffect->GetPower(), 0);
            }
        }
        return damage;
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

    int32 HandleSevereDamage(CBattleEntity* PDefender, int32 damage, bool isPhysical)
    {
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
            int   power  = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_FAN_DANCE)->GetPower();
            float resist = 1.0f - (power / 10000.0f);
            damage       = (int32)(damage * resist);
            if (power > 2000)
            {
                // reduce fan dance effectiveness by 10% each hit, to a min of 20%
                PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_FAN_DANCE)->SetPower(power - 1000);
            }
        }
        return damage;
    }

    void HandleScarletDelirium(CBattleEntity* PDefender, int32 damage)
    {
        // Check for Scarlet Delirium and update Effect Power with bonus from damage
        CStatusEffect* effectScarDel = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SCARLET_DELIRIUM);

        // Damage bonus calculation, update Effect Power
        if (effectScarDel && effectScarDel->GetPower() == 0)
        {
            // Damage to Max HP Ratio
            int8   bonus    = std::floor(((damage * 100) / PDefender->GetMaxHP()) / 2);
            int8   jpValue  = effectScarDel->GetSubPower();
            uint32 duration = 90 + jpValue;

            // Convert status effect from "Absorb damage" mode to "Provide damage bonus" mode
            PDefender->StatusEffectContainer->DelStatusEffectSilent(EFFECT_SCARLET_DELIRIUM);
            PDefender->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_SCARLET_DELIRIUM_1, EFFECT_SCARLET_DELIRIUM_1, bonus, 0, duration), true);
        }
    }

    int32 HandleSevereDamageEffect(CBattleEntity* PDefender, EFFECT effect, int32 damage, bool removeEffect)
    {
        if (PDefender->StatusEffectContainer->HasStatusEffect(effect))
        {
            int32 maxHp = PDefender->GetMaxHP();

            // The Threshold for Damage is Stored in the Effect Power
            float threshold = (PDefender->StatusEffectContainer->GetStatusEffect(effect)->GetPower() / 100.00f);

            // We calcluate the Damage Threshold off of Max HP & the Threshold Percentage
            float damageThreshold = maxHp * threshold;

            // Severe Damage is when the Attack's Damage Exceeds a Certain Threshold
            if (damage > damageThreshold)
            {
                uint16 severeReduction = PDefender->StatusEffectContainer->GetStatusEffect(effect)->GetSubPower();
                severeReduction        = std::clamp((100 - severeReduction), 0, 100) / 100;
                damage                 = damage * severeReduction;

                if (removeEffect)
                {
                    PDefender->StatusEffectContainer->DelStatusEffect(effect);
                }
            }
        }

        return damage;
    }

    /************************************************************************
     *                                                                       *
     *  Handle the /assist command                                           *
     *                                                                       *
     ************************************************************************/

    void assistTarget(CCharEntity* PChar, uint16 TargID)
    {
        // get the entity we want to assist
        CBattleEntity* EntityToAssist = (CBattleEntity*)PChar->GetEntity(TargID, TYPE_MOB | TYPE_PC);
        if (EntityToAssist != nullptr)
        {
            if (EntityToAssist->objtype == TYPE_PC && EntityToAssist->GetBattleTargetID() != 0)
            {
                // get that players engaged target
                CBattleEntity* EntityToLockon = EntityToAssist->GetBattleTarget();
                if (EntityToLockon != nullptr)
                {
                    // lock on to the new target!
                    PChar->pushPacket<CLockOnPacket>(PChar, EntityToLockon);
                }
            }
            else if (EntityToAssist->GetBattleTargetID() != 0)
            {
                // lock on to the new target!
                PChar->pushPacket<CLockOnPacket>(PChar, EntityToAssist->GetBattleTarget());
            }
        }
    }

    uint8 GetSpellAoEType(CBattleEntity* PCaster, CSpell* PSpell)
    {
        // Majesty turns the Cure and Protect spell families into AoE when active
        if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_MAJESTY) &&
            (PSpell->getSpellFamily() == SPELLFAMILY_CURE || PSpell->getSpellFamily() == SPELLFAMILY_PROTECT))
        {
            return SPELLAOE_RADIAL;
        }

        if (PSpell->getAOE() == SPELLAOE_RADIAL_ACCE) // Divine Veil goes here because -na spells have AoE w/ Accession
        {
            if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_ACCESSION) ||
                (PCaster->objtype == TYPE_PC && charutils::hasTrait((CCharEntity*)PCaster, TRAIT_DIVINE_VEIL) && PSpell->isNa() &&
                 (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_DIVINE_SEAL) || xirand::GetRandomNumber(100) < PCaster->getMod(Mod::AOE_NA))))
            {
                return SPELLAOE_RADIAL;
            }
            else
            {
                return SPELLAOE_NONE;
            }
        }

        if (PSpell->getAOE() == SPELLAOE_RADIAL_MANI)
        {
            if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_MANIFESTATION))
            {
                return SPELLAOE_RADIAL;
            }
            else
            {
                return SPELLAOE_NONE;
            }
        }

        if (PSpell->getAOE() == SPELLAOE_PIANISSIMO)
        {
            if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_PIANISSIMO))
            {
                PCaster->StatusEffectContainer->DelStatusEffect(EFFECT_PIANISSIMO);
                return SPELLAOE_NONE;
            }
            else
            {
                return SPELLAOE_RADIAL;
            }
        }

        if (PSpell->getAOE() == SPELLAOE_DIFFUSION)
        {
            if (PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_DIFFUSION))
            {
                return SPELLAOE_RADIAL;
            }
            else
            {
                return SPELLAOE_NONE;
            }
        }

        return PSpell->getAOE();
    }

    ELEMENT GetDayElement()
    {
        DAYTYPE weekday = (DAYTYPE)CVanaTime::getInstance()->getWeekday();
        switch (weekday)
        {
            case FIRESDAY:
                return ELEMENT_FIRE;
            case EARTHSDAY:
                return ELEMENT_EARTH;
            case WATERSDAY:
                return ELEMENT_WATER;
            case WINDSDAY:
                return ELEMENT_WIND;
            case ICEDAY:
                return ELEMENT_ICE;
            case LIGHTNINGDAY:
                return ELEMENT_THUNDER;
            case LIGHTSDAY:
                return ELEMENT_LIGHT;
            case DARKSDAY:
                return ELEMENT_DARK;
            default:
                return ELEMENT_NONE;
        }
    }

    WEATHER GetWeather(CBattleEntity* PEntity, bool ignoreScholar)
    {
        if (PEntity == nullptr || zoneutils::GetZone(PEntity->getZone()) == nullptr)
        {
            return WEATHER_NONE;
        }

        return GetWeather(PEntity, ignoreScholar, zoneutils::GetZone(PEntity->getZone())->GetWeather());
    }

    WEATHER GetWeather(CBattleEntity* PEntity, bool ignoreScholar, uint16 zoneWeather)
    {
        if (PEntity == nullptr)
        {
            return WEATHER_NONE;
        }

        WEATHER scholarSpell = WEATHER_NONE;

        if (!ignoreScholar) // Do not need to check for status effects if we're ignoring scholar spells
        {
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_FIRESTORM))
            {
                scholarSpell = WEATHER_HOT_SPELL;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_RAINSTORM))
            {
                scholarSpell = WEATHER_RAIN;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SANDSTORM))
            {
                scholarSpell = WEATHER_DUST_STORM;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_WINDSTORM))
            {
                scholarSpell = WEATHER_WIND;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_HAILSTORM))
            {
                scholarSpell = WEATHER_SNOW;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_THUNDERSTORM))
            {
                scholarSpell = WEATHER_THUNDER;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_AURORASTORM))
            {
                scholarSpell = WEATHER_AURORAS;
            }
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_VOIDSTORM))
            {
                scholarSpell = WEATHER_GLOOM;
            }
        }

        if (ignoreScholar || scholarSpell == WEATHER_NONE || zoneWeather == (scholarSpell + 1))
        { // Strong weather overwrites scholar spell weak weather
            return (WEATHER)zoneWeather;
        }
        else if (scholarSpell == zoneWeather)
        {
            return (WEATHER)(zoneWeather + 1); // Storm spells stack with weather
        }
        else
        {
            return scholarSpell;
        }
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

    void DrawIn(CBattleEntity* PTarget, position_t pos, float offset, float degrees)
    {
        float      radian     = degrees * (M_PI / 180.0f);
        position_t nearEntity = nearPosition(pos, offset, radian);

        // Make sure we can raycast to that position
        // from the position's "eyeline" to the ground where we want to draw players in to
        if (PTarget->loc.zone->lineOfSight)
        {
            auto entityHeight = 2.0f;
            auto posEyeline   = position_t{ pos.x, pos.y - entityHeight, pos.z, 0, 0 };
            if (auto optHit = PTarget->loc.zone->lineOfSight->Raycast(posEyeline, nearEntity))
            {
                auto hit   = *optHit;
                nearEntity = { hit.x, hit.y, hit.z, 0, 0 };
            }
        }

        // Snap nearEntity to a guaranteed valid position
        if (PTarget->loc.zone->m_navMesh)
        {
            PTarget->loc.zone->m_navMesh->snapToValidPosition(nearEntity);
        }

        // Move the target a little higher, just in case
        nearEntity.y -= 1.0f;

        if (PTarget->status != STATUS_TYPE::CUTSCENE_ONLY)
        {
            // don't draw in dead players for now!
            // see tractor
            if (PTarget->isDead() || PTarget->isMounted())
            {
                // don't do anything
            }
            else
            {
                // draw in!
                PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE_SELF, std::make_unique<CPositionPacket>(PTarget, nearEntity));
                PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE_SELF, std::make_unique<CMessageBasicPacket>(PTarget, PTarget, 0, 0, 232));
            }
        }

        return;
    }

    /************************************************************************
     *                                                                       *
     *  Add the COR Wild Card effect to a specific character                 *
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
        auto RecastsToDelete = xirand::GetRandomNumber(TotalRecasts == 0 ? 1 : TotalRecasts);

        // Restore at least 1 ability (unless none are on recast)
        RecastsToDelete = TotalRecasts == 0 ? 0 : RecastsToDelete == 0 ? 1
                                                                       : RecastsToDelete;

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
     *   Does the random deal effect to a specific character (reset ability) *
     *                                                                       *
     ************************************************************************/
    bool DoRandomDealToEntity(CCharEntity* PChar, CBattleEntity* PTarget)
    {
        std::vector<uint16> resetCandidateList;
        std::vector<uint16> activeCooldownList;

        if (PChar == nullptr || PTarget == nullptr)
        {
            // Invalid User or Target
            return false;
        }

        RecastList_t* recastList = PTarget->PRecastContainer->GetRecastList(RECAST_ABILITY);

        // Get position of abilites and add to the 2 lists
        for (uint8 i = 0; i < recastList->size(); ++i)
        {
            Recast_t* recast = &recastList->at(i);

            // Do not reset 2hrs or Random Deal
            if (recast->ID != 0 && recast->ID != 196)
            {
                resetCandidateList.push_back(i);
                if (recast->RecastTime > 0)
                {
                    activeCooldownList.push_back(i);
                }
            }
        }

        if (resetCandidateList.size() == 0 || activeCooldownList.size() == 0)
        {
            // Evade because we have no abilities that can be reset
            return false;
        }

        uint8 loadedDeck       = PChar->PMeritPoints->GetMeritValue(MERIT_LOADED_DECK, PChar);
        uint8 loadedDeckChance = 50 + loadedDeck;
        uint8 resetTwoChance   = std::min<int8>(PChar->getMod(Mod::RANDOM_DEAL_BONUS), 50);

        if (loadedDeck > 0) // Loaded Deck Merit Version
        {
            if (activeCooldownList.size() > 1)
            {
                // Shuffle active cooldowns and take first (loaded deck)
                std::shuffle(std::begin(activeCooldownList), std::end(activeCooldownList), xirand::rng());
                loadedDeckChance = 100;
            }

            if (loadedDeckChance >= xirand::GetRandomNumber(100))
            {
                PTarget->PRecastContainer->DeleteByIndex(RECAST_ABILITY, activeCooldownList.at(0));

                // Reset 2 abilities by chance
                if (activeCooldownList.size() > 1 && resetTwoChance >= xirand::GetRandomNumber(100))
                {
                    PTarget->PRecastContainer->DeleteByIndex(RECAST_ABILITY, activeCooldownList.at(1));
                }
                if (PChar != PTarget)
                {
                    if (auto PCharTarget = dynamic_cast<CCharEntity*>(PTarget))
                    {
                        // Update target's recast state: caster's will be handled in CCharEntity::OnAbility.
                        PCharTarget->pushPacket<CCharRecastPacket>(PCharTarget);
                    }
                }
                return true;
            }

            // Evade because we failed to reset with loaded deck
            return false;
        }
        else // Standard Version
        {
            if (resetCandidateList.size() > 1)
            {
                // Shuffle if more than 1 ability
                std::shuffle(std::begin(resetCandidateList), std::end(resetCandidateList), xirand::rng());
            }

            // Reset first ability (shuffled or only)
            PTarget->PRecastContainer->DeleteByIndex(RECAST_ABILITY, resetCandidateList.at(0));

            // Reset 2 abilities by chance (could be 2 abilities that don't need resets)
            if (resetCandidateList.size() > 1 && activeCooldownList.size() > 1 && resetTwoChance >= xirand::GetRandomNumber(1, 100))
            {
                PTarget->PRecastContainer->DeleteByIndex(RECAST_ABILITY, resetCandidateList.at(1));
            }

            if (PChar != PTarget)
            {
                if (auto PCharTarget = dynamic_cast<CCharEntity*>(PTarget))
                {
                    // Update target's recast state: caster's will be handled in CCharEntity::OnAbility.
                    PCharTarget->pushPacket<CCharRecastPacket>(PCharTarget);
                }
            }

            return true;
        }
    }

    // turn towards target unless mob behavior ignores this (but can be forced to anyway)
    void turnTowardsTarget(CBaseEntity* PEntity, CBaseEntity* PTarget, bool force)
    {
        // Quick rejects
        if (!PEntity || !PTarget)
        {
            return;
        }

        CMobEntity* PMob = dynamic_cast<CMobEntity*>(PEntity);

        // Big mobs typically should ignore this -- Such as dragons/wyrms or other big things.
        // Some TP moves like Petro Eyes from normal dragons _also_ ignore their standard behavior, so we must allow it sometimes.
        if (PMob && (PMob->m_Behavior & BEHAVIOR_NO_TURN) && !force)
        {
            return;
        }

        PEntity->loc.p.rotation = worldAngle(PEntity->loc.p, PTarget->loc.p);
        PEntity->updatemask |= UPDATE_POS;
        PEntity->loc.zone->UpdateEntityPacket(PTarget, ENTITY_UPDATE, UPDATE_POS);
    }

    /************************************************************************
     *                                                                       *
     *  Reduce input delay by Snapshot and Velocity shot                     *
     *                                                                       *
     ************************************************************************/

    int16 GetRangedDelayReduction(CBattleEntity* battleEntity, int16 delay)
    {
        auto SnapShotReductionPercent{ battleEntity->getMod(Mod::SNAPSHOT) };

        if (auto* PChar = dynamic_cast<CCharEntity*>(battleEntity))
        {
            if (charutils::hasTrait(PChar, TRAIT_SNAPSHOT))
            {
                SnapShotReductionPercent += PChar->PMeritPoints->GetMeritValue(MERIT_SNAPSHOT, PChar);
            }
        }

        // https://www.bg-wiki.com/ffxi/Snapshot
        SnapShotReductionPercent = std::min<int16>(SnapShotReductionPercent, 70); // Cap of 70%

        auto VelocityShotReductionPercent = 0;
        if (battleEntity->StatusEffectContainer->HasStatusEffect(EFFECT_VELOCITY_SHOT))
        {
            VelocityShotReductionPercent = 15 + battleEntity->getMod(Mod::VELOCITY_SNAPSHOT_BONUS);
        }

        return (int16)(delay * ((100 - SnapShotReductionPercent) / 100.f) * ((100 - VelocityShotReductionPercent) / 100.f));
    }

    /************************************************************************
     *                                                                       *
     *  Get any ranged attack bonuses here                                   *
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
     *  Get any ranged accuracy bonuses here                                 *
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
        auto* PChar = dynamic_cast<CCharEntity*>(PEntity);

        for (auto&& PTrait : *traitList)
        {
            if (level >= PTrait->getLevel() && PTrait->getLevel() > 0)
            {
                bool add = true;

                for (std::size_t j = 0; j < PEntity->TraitList.size(); ++j)
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
        if (PTarget == nullptr)
        {
            ShowWarning("PTarget is null.");
            return false;
        }

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

        // clang-format off
        PMaster->ForAlliance([&PTarget, &found](CBattleEntity* PChar)
        {
            if (PChar->id == PTarget->m_OwnerID.id)
            {
                found = true;
            }
        });
        // clang-format on

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
        if (xirand::GetRandomNumber(100) < quickMagicRate)
        {
            PMagicState->SetInstantCast(true);
            return 0;
        }

        bool   applyArts = true;
        uint32 base      = PSpell->getCastTime();
        uint32 cast      = base;

        if (PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_HASSO, EFFECT_SEIGAN }))
        {
            cast = (uint32)(cast * 1.5f);
        }

        if (PSpell->getSpellGroup() == SPELLGROUP_BLACK)
        {
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ALACRITY))
            {
                uint16 bonus = 0;
                // Only apply Alacrity/celerity mod if the spell element matches the weather.
                if (battleutils::WeatherMatchesElement(battleutils::GetWeather(PEntity, false), (uint8)PSpell->getElement()))
                {
                    bonus += PEntity->getMod(Mod::ALACRITY_CELERITY_EFFECT);
                }

                // SCH JP: Stratagem II - 1% reduction in cast time per point
                if (PEntity->objtype == TYPE_PC)
                {
                    auto* PChar = static_cast<CCharEntity*>(PEntity);

                    bonus += PChar->PJobPoints->GetJobPointValue(JP_STRATEGEM_EFFECT_II);
                }

                cast -= (uint32)(base * ((100 - (50 + bonus)) / 100.0f));
                applyArts = false;
            }
            // Add Black & Dark Magic Casting Time -% bonus to Bio, Absorbs, Drain, Aspir, Dread Spikes, Stun, Tractor, Endark
            // https://www.bg-wiki.com/ffxi/Abs._Burgeonet_%2B2
            // https://www.bg-wiki.com/ffxi/Fallen%27s_Burgeonet
            else if (PSpell->getSkillType() == SKILLTYPE::SKILL_DARK_MAGIC)
            {
                cast      = (uint32)(cast * (1.0f + ((PEntity->getMod(Mod::BLACK_MAGIC_CAST) + PEntity->getMod(Mod::DARK_MAGIC_CAST)) / 100.0f)));
                applyArts = false;
            }
            else if (applyArts)
            {
                if (PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_DARK_ARTS, EFFECT_ADDENDUM_BLACK }))
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
                // Only apply Alacrity/celerity mod if the spell element matches the weather.
                if (battleutils::WeatherMatchesElement(battleutils::GetWeather(PEntity, false), (uint8)PSpell->getElement()))
                {
                    bonus += PEntity->getMod(Mod::ALACRITY_CELERITY_EFFECT);
                }

                // SCH JP: Stratagem II - 1% reduction in cast time per point
                if (PEntity->objtype == TYPE_PC)
                {
                    auto* PChar = static_cast<CCharEntity*>(PEntity);

                    bonus += PChar->PJobPoints->GetJobPointValue(JP_STRATEGEM_EFFECT_II);
                }

                cast -= (uint32)(base * ((100 - (50 + bonus)) / 100.0f));
                applyArts = false;
            }
            else if (applyArts)
            {
                if (PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE }))
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
        else if (PSpell->getSpellGroup() == SPELLGROUP_SUMMONING)
        {
            int32 amount = 1000 * PEntity->getMod(Mod::SUMMONING_MAGIC_CAST);

            if (PEntity->objtype == TYPE_PC)
            {
                auto* PChar = static_cast<CCharEntity*>(PEntity);
                amount += static_cast<int32>(base * 0.01 * PChar->PMeritPoints->GetMeritValue(MERIT_SUMMONING_MAGIC_CAST_TIME, PChar));
            }

            if (static_cast<int32>(cast) > amount)
            {
                cast -= static_cast<uint32>(std::max(amount, 0));
            }
            else
            {
                cast = 0;
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
                    xirand::GetRandomNumber(100) < ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_NIGHTINGALE, (CCharEntity*)PEntity) - 25)
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
            cast               = (uint32)(cast * (1.0f - ((songcasting > 50 ? 50 : songcasting) / 100.0f)));
        }
        else if (PSpell->getSpellGroup() == SPELLGROUP_NINJUTSU)
        {
            if (PEntity->objtype == TYPE_PC)
            {
                uint8 jpValue = static_cast<CCharEntity*>(PEntity)->PJobPoints->GetJobPointValue(JP_NINJITSU_CAST_TIME_BONUS);
                cast          = static_cast<uint32>(cast * (1.0f - (0.03f * jpValue)));
            }
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
        else if (PSpell->getSkillType() == SKILLTYPE::SKILL_GEOMANCY && PEntity->objtype == TYPE_PC)
        {
            auto* PChar = static_cast<CCharEntity*>(PEntity);
            fastCast += PChar->PJobPoints->GetJobPointValue(JP_WIDENED_COMPASS_EFFECT);
        }

        fastCast                  = std::clamp<int16>(fastCast, -100, 80);
        int16 uncappedFastCast    = std::clamp<int16>(PEntity->getMod(Mod::UFASTCAST), -100, 100);
        int16 inspirationFastCast = std::clamp<int16>(PEntity->getMod(Mod::INSPIRATION_FAST_CAST), -100, 100);

        // Add in fast cast from Divine Benison
        if (PSpell->isNa())
        {
            uncappedFastCast = std::clamp<int16>(uncappedFastCast + PEntity->getMod(Mod::DIVINE_BENISON), -100, 100);
        }

        float sumFastCast = std::clamp<float>((float)(fastCast + uncappedFastCast + inspirationFastCast), -100.f, 100.f);

        return (uint32)(cast * ((100.0f - sumFastCast) / 100.0f));
    }

    uint16 CalculateSpellCost(CBattleEntity* PEntity, CSpell* PSpell)
    {
        if (PSpell == nullptr)
        {
            ShowWarning("battleutils::CalculateMPCost Spell is nullptr");
            return 0;
        }

        // ninja tools or bard song
        if (!PSpell->hasMPCost())
        {
            return 0;
        }

        bool   applyArts = true;
        uint16 base      = PSpell->getMPCost();
        if (PSpell->getID() == SpellID::Embrava || PSpell->getID() == SpellID::Kaustra) // Embrava/Kaustra
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
        if (xirand::GetRandomNumber(100) < (PEntity->getMod(Mod::NO_SPELL_MP_DEPLETION)))
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

        uint32 base   = PSpell->getRecastTime();
        int32  recast = base;

        // get Fast Cast reduction, caps at 80%/2 = 40% reduction in recast -- https://www.bg-wiki.com/ffxi/Fast_Cast
        float fastCastReduction = std::clamp(static_cast<float>(PEntity->getMod(Mod::FASTCAST)) / 2.0f, 0.0f, 40.0f);
        // no known cap (limited by Inspiration merits + Futhark Trousers augment for a total retail cap value of 60%/2 = 30%)
        float inspirationRecastReduction = static_cast<float>(PEntity->getMod(Mod::INSPIRATION_FAST_CAST)) / 2.0f;

        // Apply Fast Cast & Inspiration
        recast = static_cast<int32>(recast * ((100.0f - (fastCastReduction + inspirationRecastReduction)) / 100.0f));

        // Apply Haste (Magic and Gear)
        int32 hasteMagic = std::clamp<int32>(PEntity->getMod(Mod::HASTE_MAGIC), -10000, 4375); // 43.75% cap -- handle 100% slow for weakness
        int32 hasteGear  = std::clamp<int32>(PEntity->getMod(Mod::HASTE_GEAR), -2500, 2500);   // 25%
        int32 haste      = hasteMagic + hasteGear;
        recast           = static_cast<int32>(recast * ((10000.0f - haste) / 10000.0f));

        if (PSpell->getSpellGroup() == SPELLGROUP_SONG)
        {
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_NIGHTINGALE))
            {
                recast = static_cast<int32>(recast * 0.5f);
            }

            // The following modifiers are not multiplicative - as such they must be applied last.
            if (PEntity->objtype == TYPE_PC)
            {
                if (PSpell->getID() == SpellID::Magic_Finale) // apply Finale recast merits
                {
                    recast -= ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_FINALE_RECAST, (CCharEntity*)PEntity) * 1000;
                }

                if (PSpell->getID() == SpellID::Foe_Lullaby || PSpell->getID() == SpellID::Foe_Lullaby_II || PSpell->getID() == SpellID::Horde_Lullaby ||
                    PSpell->getID() == SpellID::Horde_Lullaby_II) // apply Lullaby recast merits
                {
                    recast -= ((CCharEntity*)PEntity)->PMeritPoints->GetMeritValue(MERIT_LULLABY_RECAST, (CCharEntity*)PEntity) * 1000;
                }
            }
            recast -= PEntity->getMod(Mod::SONG_RECAST_DELAY) * 1000;
        }

        if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_COMPOSURE))
        {
            recast = static_cast<int32>(recast * 1.25f);
        }

        if (PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_HASSO, EFFECT_SEIGAN }))
        {
            recast = static_cast<int32>(recast * 1.5f);
        }

        recast = std::max<int32>(recast, static_cast<int32>(base * 0.2f));

        // Light/Dark arts recast bonus/penalties applies after other bonuses
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
            }
            else if (PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_DARK_ARTS, EFFECT_ADDENDUM_BLACK }))
            {
                // Add any "Grimoire: Reduces spellcasting time" bonuses + Dark Arts bonus
                recast = static_cast<int32>(recast * ((100.0f + PEntity->getMod(Mod::BLACK_MAGIC_RECAST) + PEntity->getMod(Mod::GRIMOIRE_SPELLCASTING)) / 100.0f));
            }
            else
            {
                recast = static_cast<int32>(recast * ((100.0f + PEntity->getMod(Mod::BLACK_MAGIC_RECAST)) / 100.0f));
            }

            recast = std::max<int32>(recast, static_cast<int32>(base * 0.2f)); // recap to 80%

            // https://www.bg-wiki.com/ffxi/Alacrity
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ALACRITY))
            {
                recast = static_cast<int32>(recast * 0.60);                        // 40% reduction from Alacrity alone
                recast = std::max<int32>(recast, static_cast<int32>(base * 0.2f)); // recap to 80%

                // Only apply bonus mod if the spell element matches the weather, this is allowed to go over the 80% cap to a 90% cap.
                if (battleutils::WeatherMatchesElement(battleutils::GetWeather(PEntity, false), static_cast<uint8>(PSpell->getElement())))
                {
                    uint16 bonus = PEntity->getMod(Mod::ALACRITY_CELERITY_EFFECT);

                    recast = static_cast<int32>(recast * ((100 - bonus) / 100.0f));
                    recast = std::max<int32>(recast, static_cast<int32>(base * 0.1f)); // cap to 90% reduction
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
            }

            if (PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE }))
            {
                // Add any "Grimoire: Reduces spellcasting time" bonuses + Light Arts bonus
                recast = static_cast<int32>(recast * ((100.f + PEntity->getMod(Mod::WHITE_MAGIC_RECAST) + PEntity->getMod(Mod::GRIMOIRE_SPELLCASTING)) / 100.0f));
            }
            else
            {
                recast = static_cast<int32>(recast * ((100.0f + PEntity->getMod(Mod::WHITE_MAGIC_RECAST)) / 100.0f));
            }

            recast = std::max<int32>(recast, static_cast<int32>(base * 0.2f)); // recap to 80%

            // https://www.bg-wiki.com/ffxi/Celerity
            if (PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_CELERITY))
            {
                recast = static_cast<int32>(recast * 0.60);                        // 40% reduction from Celerity alone
                recast = std::max<int32>(recast, static_cast<int32>(base * 0.2f)); // recap to 80%

                // Only apply bonus mod if the spell element matches the weather, this is allowed to go over the 80% cap to a 90% cap.
                if (battleutils::WeatherMatchesElement(battleutils::GetWeather(PEntity, false), static_cast<uint8>(PSpell->getElement())))
                {
                    uint16 bonus = PEntity->getMod(Mod::ALACRITY_CELERITY_EFFECT);

                    recast = static_cast<int32>(recast * ((100 - bonus) / 100.0f));
                    recast = std::max<int32>(recast, static_cast<int32>(base * 0.1f)); // cap to 90% reduction
                }
            }
        }

        recast = std::max<int32>(recast, 0);

        return recast / 1000;
    }

    // Calculate TP generated by spell for Occult Acumen trait
    int16 CalculateSpellTP(CBattleEntity* PEntity, CSpell* PSpell)
    {
        // Players only
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
        // apply TP Bonus
        int16 tp = spentTP + PEntity->getMod(Mod::TP_BONUS);

        if (PEntity->objtype == TYPE_PC)
        {
            auto* PChar   = static_cast<CCharEntity*>(PEntity);
            uint8 damslot = SLOT_MAIN;
            if (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 221)
            {
                damslot = SLOT_RANGED;
            }

            // remove TP Bonus from offhand weapon
            // TODO -- don't remove TP bonus if this TP bonus is from an augment (or perhaps add a second TP bonus stat.)
            if (PChar->m_Weapons[SLOT_SUB])
            {
                tp -= battleutils::GetScaledItemModifier(PEntity, PChar->m_Weapons[SLOT_SUB], Mod::TP_BONUS);
            }

            // if ranged WS, remove TP bonus from mainhand weapon
            if (damslot == SLOT_RANGED)
            {
                if (PChar->m_Weapons[SLOT_MAIN])
                {
                    tp -= battleutils::GetScaledItemModifier(PEntity, PChar->m_Weapons[SLOT_MAIN], Mod::TP_BONUS);
                }
            }
            else
            {
                // if melee WS, remove TP bonus from ranged weapon
                // TODO -- don't remove TP bonus if this TP bonus is from an augment (or perhaps add a second TP bonus stat.)
                if (PChar->m_Weapons[SLOT_RANGED])
                {
                    tp -= battleutils::GetScaledItemModifier(PEntity, PChar->m_Weapons[SLOT_RANGED], Mod::TP_BONUS);
                }

                // Add Fencer TP Bonus
                CItemWeapon*    PMain      = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_MAIN]);
                CItemEquipment* PSub       = PChar->getEquip(SLOT_SUB);
                CItemWeapon*    PSubWeapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_SUB]);

                if (PMain && !PMain->isTwoHanded() && !PMain->isHandToHand() &&
                    (!PSub || (PSubWeapon && PSubWeapon->getSkillType() == SKILL_NONE) || PSub->IsShield()))
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
                uint8 loc  = PChar->equipLoc[SLOT_AMMO];
                charutils::UnequipItem(PChar, SLOT_AMMO);
                PChar->RequestPersist(CHAR_PERSIST::EQUIP);
                charutils::UpdateItem(PChar, loc, slot, -quantity);
                PChar->pushPacket<CInventoryFinishPacket>();
                return true;
            }
            else
            {
                charutils::UpdateItem(PChar, PChar->equipLoc[SLOT_AMMO], PChar->equip[SLOT_AMMO], -quantity);
                PChar->pushPacket<CInventoryFinishPacket>();
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
        if (!PEntity || !PItem)
        {
            ShowWarning("battleutils::GetScaledItemModifier() - PEntity or PItem received as null.");
            return 0;
        }

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

    DAMAGE_TYPE GetSpikesDamageType(SUBEFFECT spikesType)
    {
        switch (spikesType)
        {
            // Action packet animation string order
            case SUBEFFECT_BLAZE_SPIKES:
                return DAMAGE_TYPE::FIRE;
            case SUBEFFECT_ICE_SPIKES:
                return DAMAGE_TYPE::ICE;
            case SUBEFFECT_DREAD_SPIKES:
                return DAMAGE_TYPE::DARK;
            case SUBEFFECT_CURSE_SPIKES:
                return DAMAGE_TYPE::NONE;
            case SUBEFFECT_SHOCK_SPIKES:
                return DAMAGE_TYPE::LIGHTNING;
            case SUBEFFECT_REPRISAL:
                return DAMAGE_TYPE::LIGHT;
            case SUBEFFECT_GALE_SPIKES:
                return DAMAGE_TYPE::WIND;
            case SUBEFFECT_CLOD_SPIKES:
                return DAMAGE_TYPE::EARTH;
            case SUBEFFECT_DELUGE_SPIKES:
                return DAMAGE_TYPE::WATER;
            case SUBEFFECT_DEATH_SPIKES:
                return DAMAGE_TYPE::DARK;
            default:
                return DAMAGE_TYPE::NONE;
        }
    }

    DAMAGE_TYPE GetEnspellDamageType(ENSPELL enspellType)
    {
        switch (enspellType)
        {
            case ENSPELL_I_FIRE:
            case ENSPELL_II_FIRE:
                return DAMAGE_TYPE::FIRE;
            case ENSPELL_I_ICE:
            case ENSPELL_II_ICE:
                return DAMAGE_TYPE::ICE;
            case ENSPELL_I_WIND:
            case ENSPELL_II_WIND:
                return DAMAGE_TYPE::WIND;
            case ENSPELL_I_EARTH:
            case ENSPELL_II_EARTH:
                return DAMAGE_TYPE::EARTH;
            case ENSPELL_I_THUNDER:
            case ENSPELL_II_THUNDER:
                return DAMAGE_TYPE::LIGHTNING;
            case ENSPELL_I_WATER:
            case ENSPELL_II_WATER:
                return DAMAGE_TYPE::WATER;
            case ENSPELL_I_LIGHT:
            case ENSPELL_II_LIGHT:
                return DAMAGE_TYPE::LIGHT;
            case ENSPELL_I_DARK:
            case ENSPELL_II_DARK:
                return DAMAGE_TYPE::DARK;
            default:
                return DAMAGE_TYPE::NONE;
        }
    }

    DAMAGE_TYPE GetRuneEnhancementDamageType(EFFECT runeEffect)
    {
        switch (runeEffect)
        {
            case EFFECT_IGNIS:
                return DAMAGE_TYPE::FIRE;
            case EFFECT_GELUS:
                return DAMAGE_TYPE::ICE;
            case EFFECT_FLABRA:
                return DAMAGE_TYPE::WIND;
            case EFFECT_TELLUS:
                return DAMAGE_TYPE::EARTH;
            case EFFECT_SULPOR:
                return DAMAGE_TYPE::LIGHTNING;
            case EFFECT_UNDA:
                return DAMAGE_TYPE::WATER;
            case EFFECT_LUX:
                return DAMAGE_TYPE::LIGHT;
            case EFFECT_TENEBRAE:
                return DAMAGE_TYPE::DARK;
            default:
                return DAMAGE_TYPE::NONE;
        }
    }

    ELEMENT GetRuneEnhancementElement(EFFECT runeEffect)
    {
        switch (runeEffect)
        {
            case EFFECT_IGNIS:
                return ELEMENT_FIRE;
            case EFFECT_GELUS:
                return ELEMENT_ICE;
            case EFFECT_FLABRA:
                return ELEMENT_WIND;
            case EFFECT_TELLUS:
                return ELEMENT_EARTH;
            case EFFECT_SULPOR:
                return ELEMENT_THUNDER;
            case EFFECT_UNDA:
                return ELEMENT_WATER;
            case EFFECT_LUX:
                return ELEMENT_LIGHT;
            case EFFECT_TENEBRAE:
                return ELEMENT_DARK;
            default:
                return ELEMENT_NONE;
        }
    }

    CBattleEntity* GetCoverAbilityUser(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PMob)
    {
        CBattleEntity* PCoverAbilityUser    = nullptr;
        uint32         coverAbilityTargetID = PCoverAbilityTarget->id;

        // If the cover ability target is in a party, try to find a cover ability user
        if (PCoverAbilityTarget->PParty != nullptr)
        {
            for (auto* PMember : PCoverAbilityTarget->PParty->members)
            {
                if (coverAbilityTargetID == PMember->GetLocalVar("COVER_ABILITY_TARGET") &&
                    PMember->StatusEffectContainer->HasStatusEffect(EFFECT_COVER) &&
                    PMember->isAlive())
                {
                    PCoverAbilityUser = PMember;
                    break;
                }
            }

            if (PCoverAbilityUser != nullptr)
            {
                // using same variable names as trick attack function, for consistent understanding
                uint8 angleTAmob = worldAngle(PMob->loc.p, PCoverAbilityUser->loc.p);
                float distTAmob  = distance(PCoverAbilityUser->loc.p, PMob->loc.p);

                // check if cover user is within melee range and that cover target is in-line behind
                if (distTAmob <= static_cast<float>(PMob->GetMeleeRange()) &&        // make sure cover user is within melee range
                    distTAmob >= worldAngleMinDistance &&                            // require closer target not be closer than .5 yalms (.5*.5=.25 distsquared) to mob
                    distTAmob < distance(PCoverAbilityTarget->loc.p, PMob->loc.p) && // make sure cover user is closer to the mob than cover target
                    areInLine(angleTAmob, PMob, PCoverAbilityTarget))
                {
                    return PCoverAbilityUser;
                }
            }
        }
        return nullptr;
    }

    bool IsMagicCovered(CCharEntity* PCoverAbilityUser)
    {
        return PCoverAbilityUser != nullptr && PCoverAbilityUser->getMod(Mod::COVER_MAGIC_AND_RANGED) == 1;
    }

    void ConvertDmgToMP(CBattleEntity* PDefender, int32 damage, bool IsCovered)
    {
        double dmgToMPMods = 0.0;

        // If attack was covered, get cover ability user's COVER_TO_MP mod
        if (IsCovered)
        {
            dmgToMPMods += PDefender->getMod(Mod::COVER_TO_MP);
        }

        // Get ABSORB_PHYSDMG_TO_MP mod
        dmgToMPMods += PDefender->getMod(Mod::ABSORB_PHYSDMG_TO_MP);

        // Calculate final absorbed MP
        int16 absorbedMP = static_cast<int16>(damage * (dmgToMPMods / 100.0));

        if (absorbedMP > 0)
        {
            PDefender->addMP(absorbedMP);
        }
    }

    float CheckLiementAbsorb(CBattleEntity* PBattleEntity, DAMAGE_TYPE DamageType)
    {
        if (PBattleEntity)
        {
            auto* liementEffect = PBattleEntity->StatusEffectContainer->GetStatusEffect(EFFECT_LIEMENT, 0);

            if (liementEffect)
            {
                uint16 absorbPower    = liementEffect->GetPower();
                uint16 absorbTypeBits = liementEffect->GetSubPower();
                uint16 numBits        = sizeof(absorbTypeBits) * 8;

                uint8 runeAbsorbCount = 0;

                for (int i = 0; i < numBits / 4; i++) // unpacking is limited to the size of the return value of GetPower/GetSubPower. If this ever expands more Runes can be packed.
                {
                    DAMAGE_TYPE packedDamageType = (DAMAGE_TYPE)((absorbTypeBits >> i * 4) & 0xF); // unpack damage type 4 bits at a time

                    if (packedDamageType == DamageType)
                    {
                        runeAbsorbCount++;
                    }
                }

                if (runeAbsorbCount > 0)
                {
                    PBattleEntity->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LIEMENT); // Liement absorbs once and disappears.
                    float absorbMultiplier = (85 + runeAbsorbCount * absorbPower) / 100.0;

                    return absorbMultiplier * -1;
                }
            }
        }
        return 1.0;
    }
}; // namespace battleutils
