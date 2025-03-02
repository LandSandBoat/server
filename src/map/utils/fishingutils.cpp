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

#include "fishingutils.h"

#include <cmath>
#include <cstring>

#include "packets/caught_fish.h"
#include "packets/caught_monster.h"
#include "packets/char_skills.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/chat_message.h"
#include "packets/entity_animation.h"
#include "packets/event.h"
#include "packets/fishing.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "packets/message_special.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/message_text.h"
#include "packets/release.h"

#include "entities/battleentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"

#include "ai/ai_container.h"

#include "enmity_container.h"
#include "item_container.h"
#include "mob_modifier.h"
#include "status_effect_container.h"
#include "trade_container.h"
#include "universal_container.h"

#include "battleutils.h"
#include "charutils.h"
#include "common/vana_time.h"
#include "itemutils.h"
#include "zoneutils.h"

namespace fishingutils
{
    uint16                                            MessageOffset[MAX_ZONEID];
    fishing_area_pool                                 FishingPools[MAX_ZONEID];
    std::map<uint32, fish_t*>                         FishList;
    std::map<uint16, rod_t*>                          FishingRods;
    std::map<uint16, bait_t*>                         FishingBaits;
    std::map<uint16, std::map<uint32, fishmob_t*>>    FishZoneMobList;       // zoneid, mobid, mob
    std::map<uint16, std::map<uint8, fishingarea_t*>> FishingAreaList;       // zoneid, areaid, area
    std::map<uint16, std::map<uint8, uint16>>         FishingCatchLists;     // zoneid, areaid, groupid
    std::map<uint16, std::map<uint32, uint16>>        FishingGroups;         // groupid, fishid, rarity
    std::map<uint16, std::map<uint32, uint8>>         FishingBaitAffinities; // baitid, fishid, power

    uint32 HandleFishingAction(CCharEntity* PChar, CBasicPacket& data)
    {
        uint16 stamina = data.ref<uint16>(0x08);
        uint8  action  = data.ref<uint8>(0x0E);
        uint32 special = data.ref<uint32>(0x10);
        fishingutils::FishingAction(PChar, (FISHACTION)action, stamina, special);

        return 1;
    }

    /************************************************************************
     *                                                                       *
     *                            CATCH POOLS                                *
     *                                                                       *
     ************************************************************************/
    void ReduceFishPool(uint16 zoneId, uint8 areaId, uint16 fishId)
    {
        if (FishList[fishId] && FishList[fishId]->quest_only)
        {
            return;
        }

        if (FishingPools[zoneId].catchPools.count(areaId) && FishingPools[zoneId].catchPools[areaId].stock.count(fishId))
        {
            uint16 qty = FishingPools[zoneId].catchPools[areaId].stock[fishId].quantity;

            if (qty > 0)
            {
                FishingPools[zoneId].catchPools[areaId].stock[fishId].quantity = (qty - 1);
            }
        }
    }

    void RestockFishingAreas()
    {
        for (auto& FishingPool : FishingPools)
        {
            for (auto const& a : FishingPool.catchPools)
            {
                for (auto const& s : a.second.stock)
                {
                    if (s.second.quantity < s.second.maxQuantity)
                    {
                        int qty                                                 = s.second.quantity;
                        int maxqty                                              = s.second.maxQuantity;
                        int restock                                             = s.second.restockRate;
                        FishingPool.catchPools[a.first].stock[s.first].quantity = std::min(maxqty, qty + restock);
                    }
                }
            }
        }
    }

    void CreateFishingPools()
    {
        const char* Query =
            "SELECT fc.zoneid,fc.areaid,fg.fishid,fg.pool_size,fg.restock_rate "
            "FROM fishing_group fg "
            "JOIN fishing_catch fc USING(groupid)";
        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16 zoneId                                                     = (uint16)_sql->GetUIntData(0);
                uint8  areaId                                                     = (uint8)_sql->GetUIntData(1);
                uint16 fishId                                                     = (uint16)_sql->GetUIntData(2);
                uint16 pSize                                                      = (uint16)_sql->GetUIntData(3);
                uint16 rRate                                                      = (uint16)_sql->GetUIntData(4);
                FishingPools[zoneId].catchPools[areaId].stock[fishId].quantity    = pSize;
                FishingPools[zoneId].catchPools[areaId].stock[fishId].maxQuantity = pSize;
                FishingPools[zoneId].catchPools[areaId].stock[fishId].restockRate = rRate;
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *                             CALCULATIONS                              *
     *                                                                       *
     ************************************************************************/
    uint32 GetSundayMidnightTimestamp()
    {
        uint32 timestamp = (uint32)time(nullptr);
        uint32 day       = 6 - CVanaTime::getInstance()->getSysWeekDay();
        uint32 hour      = 23 - CVanaTime::getInstance()->getSysHour();
        uint32 mins      = 59 - CVanaTime::getInstance()->getSysMinute();
        uint32 secs      = 59 - CVanaTime::getInstance()->getSysSecond();
        return timestamp + secs + (mins * 60) + (hour * 3600) + (day * 86400) + 1;
    }

    uint8 GetMoonPhase()
    {
        uint8 phase     = (uint8)CVanaTime::getInstance()->getMoonPhase();
        uint8 direction = CVanaTime::getInstance()->getMoonDirection();

        if (phase <= 5 || (phase <= 10 && direction == 1)) // New Moon
        {
            return MOONPHASE_NEW;
        }
        else if (phase >= 7 && phase <= 38 && direction == 2) // Waxing Crescent
        {
            return MOONPHASE_WAXING_CRESCENT;
        }
        else if (phase >= 40 && phase <= 55 && direction == 2) // First Quarter
        {
            return MOONPHASE_FIRST_QUARTER;
        }
        else if (phase >= 57 && phase <= 88 && direction == 2) // Waxing Gibbous
        {
            return MOONPHASE_WAXING_GIBBOUS;
        }
        else if (phase >= 95 || (phase >= 90 && direction == 2)) // Full Moon
        {
            return MOONPHASE_FULL;
        }
        else if (phase >= 62 && phase <= 93 && direction == 1) // Waning Gibbous
        {
            return MOONPHASE_WANING_GIBBOUS;
        }
        else if (phase >= 45 && phase <= 60 && direction == 1) // Last Quarter
        {
            return MOONPHASE_LAST_QUARTER;
        }
        else if (phase >= 12 && phase < 43 && direction == 1) // Waning Crescent
        {
            return MOONPHASE_WANING_CRESCENT;
        }
        return 0;
    }

    uint8 GetHookTime(CCharEntity* PChar)
    {
        uint8          waitTime  = 13;
        uint8          moonPhase = GetMoonPhase();
        uint8          hour      = (uint8)CVanaTime::getInstance()->getHour();
        fishing_gear_t gear      = GetFishingGear(PChar);

        if (moonPhase == MOONPHASE_NEW || moonPhase == MOONPHASE_FULL)
        {
            waitTime -= 4;
        }

        if (hour == 5 || hour == 17)
        {
            waitTime -= 1;
        }

        if (gear.waist == FISHERS_ROPE)
        {
            waitTime -= 1;
        }

        return std::max<uint16>(7, waitTime);
    }

    float GetMonthlyTidalInfluence(fish_t* fish) // 0.25 to 1.25
    {
        float modifier = 0.5f;
        uint8 month    = (uint8)CVanaTime::getInstance()->getMonth();

        switch (fish->monthPattern)
        {
            case 1:
                modifier = MONTHPATTERN_1(month);
                break;
            case 2:
                modifier = MONTHPATTERN_2(month);
                break;
            case 3:
                modifier = MONTHPATTERN_3(month);
                break;
            case 4:
                modifier = MONTHPATTERN_4(month);
                break;
            case 5:
                modifier = MONTHPATTERN_5(month);
                break;
            case 6:
                modifier = MONTHPATTERN_6(month);
                break;
            case 7:
                modifier = MONTHPATTERN_7(month);
                break;
            case 8:
                modifier = MONTHPATTERN_8(month);
                break;
            case 9:
                modifier = MONTHPATTERN_9(month);
                break;
            case 10:
                modifier = MONTHPATTERN_10(month);
                break;
        }

        return modifier + 0.25f;
    }

    float GetHourlyModifier(fish_t* fish)
    { // 0.25 to 1.25
        float modifier = 0.5f;
        uint8 hour     = (uint8)CVanaTime::getInstance()->getHour();

        switch (fish->hourPattern)
        {
            case 1:
                modifier = HOURPATTERN_1(hour);
                break;
            case 2:
                if (hour != 5 && hour != 17)
                {
                    modifier = 1.0f;
                }
                break;
            case 3:
                if (hour == 5 || hour == 17)
                {
                    modifier = 1.0f;
                }
                break;
            case 4:
                if (hour > 19 || hour < 4)
                {
                    modifier = 1.0f;
                }
                break;
            case 5:
                modifier = HOURPATTERN_2(hour);
                break;
            case 6:
                modifier = HOURPATTERN_3(hour);
                break;
            case 7:
                modifier = HOURPATTERN_4(hour);
                break;
        }

        return modifier + 0.25f;
    }

    float GetMoonModifier(fish_t* fish) // 0.25 to 1.25
    {
        float modifier  = 1.0f;
        uint8 moonPhase = GetMoonPhase();

        switch (fish->moonPattern)
        {
            case 1:
                modifier = MOONPATTERN_1(moonPhase);
                break;
            case 2:
                modifier = MOONPATTERN_2(moonPhase);
                break;
            case 3:
                modifier = MOONPATTERN_3(moonPhase);
                break;
            case 4:
                modifier = MOONPATTERN_4(moonPhase);
                break;
            case 5:
                modifier = MOONPATTERN_4(moonPhase);
                break;
        }

        return modifier + 0.25f;
    }

    uint8 GetLuckyMoonModifier()
    {
        uint8 moonPhase = GetMoonPhase();
        uint8 modifier  = 1 + (uint8)std::floor(MOONPATTERN_1(moonPhase) * 3);

        return modifier;
    }

    float GetWeatherModifier(CCharEntity* PChar)
    {
        WEATHER weather    = zoneutils::GetZone(PChar->getZone())->GetWeather();
        float   weatherMod = 1.0f;

        if (weather == WEATHER_RAIN)
        {
            weatherMod = 1.1f;
        }
        else if (weather == WEATHER_SQUALL)
        {
            weatherMod = 1.2f;
        }

        return weatherMod;
    }

    uint16 CalculateStamina(int skill, uint8 count)
    {
        float multiplier = 1.0f + (0.1f * (count - 1));
        int   modSkill   = (int)std::floor(multiplier * skill);

        return (uint16)std::floor(xirand::GetRandomNumber(95, 105) * ((modSkill + 36) / 2));
    }

    uint16 CalculateAttack(bool legendary, uint8 difficulty, rod_t* rod)
    {
        uint8 bonusAdd = (legendary) ? rod->lgdBonusAtk : 0;

        return (uint16)std::floor(difficulty * (((static_cast<float>(rod->fishAttack) + bonusAdd) / 100.0f)) * 20.0f);
    }

    uint16 CalculateHeal(bool legendary, uint8 difficulty, rod_t* rod)
    {
        uint16 attack = CalculateAttack(legendary, difficulty, rod);

        return (uint16)std::floor((static_cast<float>(attack) / 20.0f) * (static_cast<float>(rod->fishRecovery) / 100.0f)) * 10.0f;
    }

    uint8 CalculateRegen(uint8 fishingSkill, rod_t* rod, FISHINGCATCHTYPE catchType, uint8 sizeType, uint8 catchSkill, bool legendaryCatch, bool NM)
    {
        uint8 regen     = 128;
        uint8 drainDiff = 12;
        uint8 regenDiff = 24;
        uint8 regenMod  = 0;

        if (rod->rodID == EBISU)
        {
            regenMod = 11;
        }

        // +1 for large fish/items/mobs if not using Ebisu
        regen += (sizeType > FISHINGSIZETYPE_SMALL && rod->rodID != EBISU) ? 1 : 0;

        // legendary rod bonuses
        if (rod->rodID == LU_SHANG || rod->rodID == EBISU || rod->rodID == LU_SHANG_1 || rod->rodID == EBISU_1)
        {
            if (legendaryCatch)
            {
                regen -= (rod->rodID == LU_SHANG || rod->rodID == LU_SHANG_1) ? 1 : 2;
            }

            regen -= (catchType == FISHINGCATCHTYPE_MOB) ? 3 : 0;
        }

        // skill bonus/penalty
        if (catchType <= FISHINGCATCHTYPE_MOB && !NM)
        {
            if (catchSkill <= (fishingSkill + regenMod - drainDiff))
            {
                float divMod = 1.5f;

                if (rod->rodID == LU_SHANG || rod->rodID == LU_SHANG_1)
                {
                    divMod = 1.4f;
                }

                if (rod->rodID == EBISU || rod->rodID == EBISU_1)
                {
                    divMod = 1.3f;
                }

                regen -= std::min<uint8>((1 + (uint8)std::floor(((fishingSkill + regenMod) - drainDiff - catchSkill) / divMod)), regen);
            }

            if (catchType < FISHINGCATCHTYPE_ITEM && catchSkill - regenMod >= (fishingSkill + regenDiff))
            {
                float multMod = 0.5f;

                if (rod->rodID == LU_SHANG || rod->rodID == LU_SHANG_1)
                {
                    multMod = 0.45f;
                }

                if (rod->rodID == EBISU || rod->rodID == EBISU_1)
                {
                    multMod = 0.4f;
                }

                regen += (1 + (uint8)std::floor((catchSkill - regenMod - (fishingSkill + regenDiff)) * multMod));
            }
        }

        if (catchType == FISHINGCATCHTYPE_CHEST)
        {
            if (fishingSkill > catchSkill)
            {
                regen -= std::max<uint8>((uint8)xirand::GetRandomNumber(3, 5), regen);
            }
        }

        return std::clamp<uint8>(regen, 0, 182);
    }

    uint8 CalculateHookTime(CCharEntity* PChar, bool legendary, uint32 legendary_flags, uint8 sizeType, rod_t* rod, bait_t* bait)
    {
        uint8 hookTime = rod->fishTime;

        if ((sizeType == FISHINGSIZETYPE_LARGE && rod->rodFlags & RODFLAG_LARGEPENALTY) || (sizeType == FISHINGSIZETYPE_SMALL && rod->rodFlags & RODFLAG_SMALLPENALTY))
        {
            hookTime -= 10;
        }

        if (legendary && rod->rodFlags & RODFLAG_LEGENDARYBONUS)
        {
            hookTime += 10;
        }

        if (charutils::hasKeyItem(PChar, FISHINGKI_MOOCHING) && (bait->baitID == DRILL_CALAMARY || bait->baitID == DWARF_PUGIL))
        {
            hookTime += 30;
        }

        if (PChar->getMod(Mod::ALBATROSS_RING_EFFECT) > 0)
        {
            hookTime += 30;
        }

        if (legendary)
        {
            if ((legendary_flags & FISHINGLEGENDARY_NORODTIMEBONUS) || (legendary_flags & FISHINGLEGENDARY_EBISU_TIME_BONUS_ONLY && rod->rodID == EBISU))
            {
                hookTime += rod->lgdBonusTime;
            }

            if (legendary_flags & FISHINGLEGENDARY_HALFTIME)
            {
                hookTime -= (uint8)std::floor(rod->fishTime / 2);
            }

            if (legendary_flags & FISHINGLEGENDARY_ADDTIMEBONUS)
            {
                hookTime += (rod->multiplier & 10);
            }
        }

        return hookTime;
    }

    uint8 CalculateLuckyTiming(CCharEntity* PChar, uint8 fishingSkill, uint8 catchSkill, uint8 sizeType, rod_t* rod, bait_t* bait, bool legendary)
    {
        uint8          luckyTiming  = 10;
        float          penalty      = 0;
        float          bonus        = 0;
        fishing_gear_t gear         = GetFishingGear(PChar);
        uint8          moonModifier = GetLuckyMoonModifier();

        // Skill modifier
        if (catchSkill > fishingSkill + 7)
        {
            penalty += (uint8)std::floor((catchSkill - (fishingSkill + 7)));
        }
        else if (fishingSkill + 10 > catchSkill)
        {
            bonus += (uint8)std::floor(((fishingSkill + 10) - catchSkill) / 20);
        }

        // Moon modifier
        bonus += (moonModifier * 5) + (moonModifier * xirand::GetRandomNumber(1, 5));

        // Time of Day modifier
        uint32 gameHour = CVanaTime::getInstance()->getHour();

        if ((gameHour == 6 || gameHour == 7) || (gameHour >= 16 && gameHour <= 18))
        {
            bonus += 9;
        }
        else if ((gameHour >= 8 && gameHour <= 15))
        {
            bonus += 3;
        }
        else
        {
            bonus += 6;
        }

        // Rod modifier
        if (legendary && rod->legendary)
        {
            if (rod->rodID == LU_SHANG)
            {
                bonus += 6;
            }
            else if (rod->rodID == EBISU)
            {
                bonus += 8;
            }
            else if (rod->sizeType == sizeType)
            {
                bonus += 4;
            }
            else if (rod->sizeType > sizeType)
            {
                bonus += 2;
            }
        }

        // Gear modifier
        switch (gear.body)
        {
            case FISHERMANS_TUNICA:
                bonus += 0.5f;
                break;
            case ANGLERS_TUNICA:
                bonus += 1;
                break;
            case FISHERMANS_APRON:
            case FISHERMANS_SMOCK:
                bonus += 3;
                break;
        }

        switch (gear.hands)
        {
            case FISHERMANS_GLOVES:
                bonus += 0.5f;
                break;
            case ANGLERS_GLOVES:
                bonus += 1;
                break;
        }

        switch (gear.legs)
        {
            case FISHERMANS_HOSE:
                bonus += 0.5f;
                break;
            case ANGLERS_HOSE:
                bonus += 1;
                break;
        }

        switch (gear.feet)
        {
            case FISHERMANS_BOOTS:
                bonus += 0.5f;
                break;
            case ANGLERS_BOOTS:
                bonus += 1;
                break;
            case WADERS:
                bonus += 2;
                break;
        }

        // Bait modifier
        if (bait->baitFlags & BAITFLAG_GOLD_ARROW_BONUS)
        {
            bonus *= 1.25;
        }

        luckyTiming += (uint8)std::floor(bonus);
        luckyTiming -= (uint8)std::floor((penalty > luckyTiming) ? luckyTiming : penalty);

        return std::max<uint8>(5, luckyTiming);
    }

    uint16 CalculateHookChance(uint8 fishingSkill, fish_t* fish, bait_t* bait, rod_t* rod)
    {
        uint16 hookChance    = 0;
        float  monthModifier = GetMonthlyTidalInfluence(fish);
        float  hourModifier  = GetHourlyModifier(fish) * 2;
        float  moonModifier  = GetMoonModifier(fish) * 3;
        float  modifier      = std::max<float>(0, (moonModifier + hourModifier + monthModifier) / 3);
        hookChance           = (uint16)std::floor(25 * modifier);

        // Bait power
        uint8 baitPower = GetBaitPower(bait, fish);
        switch (baitPower)
        {
            case 1:
                hookChance += (bait->baitType == FISHINGBAITTYPE_LURE) ? 30 : 35;
                break;
            case 2:
                hookChance += (bait->baitType == FISHINGBAITTYPE_LURE) ? 60 : 65;
                break;
            case 3:
                hookChance += (bait->baitType == FISHINGBAITTYPE_LURE) ? 75 : 80;
                break;
        }

        // Level penalty
        if (fish->maxSkill > fishingSkill)
        {
            hookChance -= std::clamp<uint16>((uint16)std::floor((fish->maxSkill - fishingSkill) * 0.25), 0, hookChance);
        }

        // Reverse level penalty
        if (fishingSkill - 10 > fish->maxSkill)
        {
            hookChance -= std::clamp<uint16>((uint16)std::floor((fishingSkill - 10 - fish->maxSkill) * 0.15), 0, hookChance);
        }

        // Rod penalty
        if (!rod->legendary)
        {
            if (fish->sizeType < rod->sizeType)
            {
                hookChance -= std::clamp<uint16>(3, 0, hookChance);
            }
            else if (rod->sizeType < fish->sizeType)
            {
                hookChance -= std::clamp<uint16>(5, 0, hookChance);
            }
        }

        // Bait bonus
        if (bait->baitFlags & BAITFLAG_SHELLFISH_AFFINITY && fish->fishFlags & FISHFLAG_SHELLFISH)
        {
            hookChance += 50;
        }

        // Fish rarity
        if (fish->rarity < 1000)
        {
            float multiplier = fish->rarity / 1000.0f;
            hookChance       = (uint16)std::floor(hookChance * multiplier);
        }

        return std::clamp<uint16>(hookChance, 20, 120);
    }

    uint8 CalculateDelay(CCharEntity* PChar, uint8 baseDelay, uint8 sizeType, rod_t* rod, uint8 count)
    {
        float multiplier = 1.0f + (0.1f * (count - 1.0f));
        uint8 delay      = (uint8)std::floor(baseDelay * multiplier);

        if (sizeType == FISHINGSIZETYPE_SMALL)
        {
            delay += rod->smDelayBonus;
        }
        else
        {
            delay += rod->lgDelayBonus;
        }

        if (PChar->getMod(Mod::PENGUIN_RING_EFFECT) > 0)
        {
            delay += 2;
        }

        return std::min<uint8>(15, delay);
    }

    uint8 CalculateMovement(CCharEntity* PChar, uint8 baseMove, uint8 sizeType, rod_t* rod, uint8 count)
    {
        float multiplier = 1.0f + (0.1f * (count - 1.0f));
        uint8 movement   = (uint8)std::floor(baseMove * multiplier);

        if (sizeType == FISHINGSIZETYPE_SMALL)
        {
            movement += rod->smMoveBonus;
        }
        else
        {
            movement += rod->lgMoveBonus;
        }

        if (PChar->getMod(Mod::PENGUIN_RING_EFFECT) > 0)
        {
            movement += 2;
        }

        return std::min<uint8>(15, movement);
    }

    lsbret_t CalculateLoseChance(uint8 catchType, uint8 fishingSkill, uint8 maxSkill, uint8 sizeType, bool legendary, uint8 ranking, rod_t* rod)
    {
        lsbret_t lsb;
        uint8    tooBigChance   = 0;
        uint8    tooSmallChance = 0;
        uint8    lowSkillChance = 0;
        lsb.failReason          = FISHINGFAILTYPE_NONE;
        lsb.chance              = 0;

        if (!rod->legendary)
        {
            if (sizeType > rod->sizeType && ranking > rod->maxRank)
            {
                tooBigChance = 50;
                if (fishingSkill < maxSkill)
                {
                    tooBigChance += maxSkill - fishingSkill;
                }

                if (fishingSkill > maxSkill)
                {
                    tooBigChance -= fishingSkill - maxSkill;
                }
            }
            else if (sizeType < rod->sizeType && ranking < rod->minRank)
            {
                tooSmallChance = 50;
                if (fishingSkill < maxSkill)
                {
                    tooSmallChance += maxSkill - fishingSkill;
                }

                if (fishingSkill > maxSkill)
                {
                    tooSmallChance -= std::min<uint8>(fishingSkill - maxSkill, tooSmallChance);
                }
            }
        }

        if (catchType < FISHINGCATCHTYPE_ITEM && fishingSkill + 7 < maxSkill)
        {
            uint8 diff     = maxSkill - (fishingSkill + 7);
            float diffAdd  = diff * 0.8f;
            lowSkillChance = (uint8)std::floor(diffAdd); // min 5, max 85
        }

        if (tooBigChance > 0 && tooBigChance > lowSkillChance)
        {
            lsb.failReason = FISHINGFAILTYPE_LOST_TOOBIG;
            lsb.chance     = std::clamp<uint8>(tooBigChance, 0, 50);
        }
        else if (tooSmallChance > 0 && tooSmallChance > lowSkillChance)
        {
            lsb.failReason = FISHINGFAILTYPE_LOST_TOOSMALL;
            lsb.chance     = std::clamp<uint8>(tooSmallChance, 0, 50);
        }
        else if (catchType < FISHINGCATCHTYPE_ITEM && lowSkillChance > 0)
        {
            lsb.failReason = FISHINGFAILTYPE_LOST_LOWSKILL;
            lsb.chance     = std::clamp<uint8>(lowSkillChance, 0, 55);
        }

        return lsb;
    }

    lsbret_t CalculateSnapChance(uint8 catchType, uint8 fishingSkill, uint8 maxSkill, uint8 sizeType, bool legendary, uint8 ranking, rod_t* rod)
    {
        lsbret_t lsb;
        uint8    levelDiffBonus  = 0;
        uint8    sizePenalty     = 0;
        uint8    legendaryBonus  = 0;
        uint8    totalDurability = 0;
        lsb.failReason           = FISHINGFAILTYPE_NONE;
        lsb.chance               = 0;

        if (fishingSkill + 10 > maxSkill)
        {
            levelDiffBonus = 2;
        }

        if (!rod->legendary && sizeType > rod->sizeType)
        {
            sizePenalty = 2;
        }

        if (legendary)
        {
            if (!rod->legendary)
            {
                sizePenalty += 3;
            }
            else
            {
                legendaryBonus = 1;
            }
        }

        totalDurability = rod->maxRank + levelDiffBonus + legendaryBonus - sizePenalty;

        if (ranking > totalDurability)
        {
            uint8 strDuraDiff = ranking - totalDurability;
            lsb.failReason    = FISHINGFAILTYPE_LINESNAP;
            lsb.chance        = std::clamp<uint8>((uint8)std::floor(strDuraDiff * 8.5f), 0, 55);
        }

        return lsb;
    }

    lsbret_t CalculateBreakChance(uint8 catchType, uint8 fishingSkill, uint8 maxSkill, uint8 sizeType, bool legendary, uint8 ranking, rod_t* rod)
    {
        lsbret_t lsb;
        uint8    levelDiffBonus = 0;
        uint8    legendaryBonus = 0;
        uint8    sizePenalty    = 0;
        lsb.failReason          = FISHINGFAILTYPE_NONE;
        lsb.chance              = 0;

        if (!rod->breakable)
        {
            return lsb;
        }

        if (fishingSkill + 10 > maxSkill)
        {
            levelDiffBonus = 2;
        }

        if (!rod->legendary && sizeType > rod->sizeType)
        {
            sizePenalty = 2;
        }
        else if (rod->legendary && sizeType == FISHINGSIZETYPE_LARGE)
        {
            legendaryBonus = 1;
        }

        if (!rod->legendary && legendary)
        {
            sizePenalty = 5;
        }

        if (ranking > rod->maxRank + levelDiffBonus + legendaryBonus)
        {
            uint8 strDuraDiff = ranking - (rod->maxRank + levelDiffBonus + legendaryBonus);
            lsb.failReason    = FISHINGFAILTYPE_RODBREAK;
            lsb.chance        = std::clamp<uint8>((uint8)std::floor((strDuraDiff + sizePenalty) * 1.3f), 0, 55);
        }

        return lsb;
    }

    // TODO: figure out how to pass mobs and items and chests here...

    uint8 CalculateFishSense(CCharEntity* PChar, fishresponse_t* response, uint8 fishingSkill, uint8 catchType, uint8 sizeType,
                             uint8 maxSkill, bool legendary, uint16 minLength, uint16 maxLength, uint8 ranking, rod_t* rod)
    {
        uint8 sense = FISHINGSENSETYPE_GOOD;

        if (catchType == FISHINGCATCHTYPE_BIGFISH)
        {
            big_fish_stats_t bigfishStats = CalculateBigFishStats(minLength, maxLength);
            response->length              = bigfishStats.length;
            response->weight              = bigfishStats.weight;
            response->epic                = bigfishStats.epic;
        }

        lsbret_t lose   = CalculateLoseChance(catchType, fishingSkill, maxSkill, sizeType, legendary, ranking, rod);
        lsbret_t lsnap  = CalculateSnapChance(catchType, fishingSkill, maxSkill, sizeType, legendary, ranking, rod);
        lsbret_t rbreak = CalculateBreakChance(catchType, fishingSkill, maxSkill, sizeType, legendary, ranking, rod);

        if (lose.chance > 0 && lsnap.chance == 0 && rbreak.chance == 0)
        {
            if (lose.failReason == FISHINGFAILTYPE_LOST_TOOSMALL)
            {
                sense = FISHINGSENSETYPE_GOOD;
            }
            else
            {
                if (lose.chance < 20)
                {
                    sense = FISHINGSENSETYPE_NOSKILL_FEELING + (uint8)xirand::GetRandomNumber<uint16>(2);
                }
                else if (lose.chance < 45)
                {
                    sense = FISHINGSENSETYPE_NOSKILL_SURE_FEELING;
                }
                else
                {
                    sense = FISHINGSENSETYPE_NOSKILL_POSITIVEFEELING;
                }
            }
        }
        else if (lsnap.chance > 0 || rbreak.chance > 0)
        {
            if (lsnap.chance < 30 && rbreak.chance < 30)
            {
                sense = FISHINGSENSETYPE_BAD;
            }
            else if (lsnap.chance < 45 && rbreak.chance < 45)
            {
                sense = FISHINGSENSETYPE_BAD + (uint8)xirand::GetRandomNumber<uint16>(2);
            }
            else
            {
                sense = FISHINGSENSETYPE_TERRIBLE;
            }
        }

        response->lose   = lose;
        response->lsnap  = lsnap;
        response->rbreak = rbreak;
        return sense;
    }

    uint16 CalculateCriticalBite(uint8 fishingSkill, uint8 fishSkill, rod_t* rod)
    {
        // TODO: Does gear discerment really help with this?
        // https://wiki.ffo.jp/html/24002.html
        uint16 chance     = 0;
        uint8  ebisuBonus = 0;

        if (rod->rodID == EBISU)
        {
            ebisuBonus = 40;
        }

        if (fishSkill - 4 > fishingSkill + ebisuBonus)
        {
            return 0;
        }

        uint16 fishSkillCheck = (uint16)std::max(0, fishSkill - 4);

        // Base chance
        chance = 5 + (uint16)std::max((fishingSkill + ebisuBonus) - fishSkillCheck, 0) * 2;

        // Moon mod (max + 20)
        float moonModifier = 2 * MOONPATTERN_3(GetMoonPhase());
        chance += (uint16)(10 * (2 - moonModifier));

        return std::clamp<uint16>(chance, 0, 70);
    }

    big_fish_stats_t CalculateBigFishStats(uint16 minLength, uint16 maxLength)
    {
        big_fish_stats_t stats;
        stats.epic   = false;
        stats.length = 0;
        stats.weight = 0;

        if (maxLength > 1)
        {
            float weightRandomizer = xirand::GetRandomNumber<float>(4.65f, 5.15f);
            stats.length           = (xirand::GetRandomNumber<uint16>(minLength, maxLength) + xirand::GetRandomNumber<uint16>(minLength, maxLength)) / 2;
            stats.weight           = (int16)std::floor(stats.length * weightRandomizer);

            if (stats.length > (minLength + maxLength) / 2 && weightRandomizer >= 5)
            {
                stats.epic = true;
            }
        }

        return stats;
    }

    fishmob_modifiers_t CalculateMobModifiers(fishmob_t* mob)
    {
        fishmob_modifiers_t modifiers;
        modifiers.attackPenalty = 0;
        modifiers.healBonus     = 0;
        modifiers.regenBonus    = 0;

        // regen bonus
        if (mob->nmFlags & FISHINGNM_RANDOM_REGEN_EASY)
        {
            modifiers.regenBonus += xirand::GetRandomNumber<uint16>(0, 1);
        }

        if (mob->nmFlags & FISHINGNM_RANDOM_REGEN_DIFFICULT)
        {
            modifiers.regenBonus += xirand::GetRandomNumber<uint16>(1, 2);
        }

        // heal bonus
        if (mob->nmFlags & FISHINGNM_RANDOM_HEAL_EASY)
        {
            modifiers.healBonus += xirand::GetRandomNumber<uint16>(0, 10);
        }

        if (mob->nmFlags & FISHINGNM_RANDOM_HEAL_DIFFICULT)
        {
            modifiers.healBonus += xirand::GetRandomNumber<uint16>(15, 30);
        }

        // attack penalty
        if (mob->nmFlags & FISHINGNM_RANDOM_ATTACK_EASY)
        {
            modifiers.attackPenalty += xirand::GetRandomNumber<uint16>(0, 10);
        }

        if (mob->nmFlags & FISHINGNM_RANDOM_ATTACK_DIFFICULT)
        {
            modifiers.attackPenalty += xirand::GetRandomNumber<uint16>(15, 30);
        }

        return modifiers;
    }

    /************************************************************************
     *                                                                       *
     *                              DATA ACCESS                              *
     *                                                                       *
     ************************************************************************/
    fishing_gear_t GetFishingGear(CCharEntity* PChar)
    {
        fishing_gear_t gear;
        uint32         head  = (PChar->getEquip(SLOT_HEAD) != nullptr) ? PChar->getEquip(SLOT_HEAD)->getID() : 0;
        uint32         neck  = (PChar->getEquip(SLOT_NECK) != nullptr) ? PChar->getEquip(SLOT_NECK)->getID() : 0;
        uint32         body  = (PChar->getEquip(SLOT_BODY) != nullptr) ? PChar->getEquip(SLOT_BODY)->getID() : 0;
        uint32         hands = (PChar->getEquip(SLOT_HANDS) != nullptr) ? PChar->getEquip(SLOT_HANDS)->getID() : 0;
        uint32         waist = (PChar->getEquip(SLOT_WAIST) != nullptr) ? PChar->getEquip(SLOT_WAIST)->getID() : 0;
        uint32         legs  = (PChar->getEquip(SLOT_LEGS) != nullptr) ? PChar->getEquip(SLOT_LEGS)->getID() : 0;
        uint32         feet  = (PChar->getEquip(SLOT_FEET) != nullptr) ? PChar->getEquip(SLOT_FEET)->getID() : 0;
        gear.head            = (head == TLAHTLAMAH_GLASSES || head == TRAINEES_SPECTACLES) ? head : 0;
        gear.neck            = (neck == FISHERS_TORQUE) ? neck : 0;
        gear.body            = (body == FISHERMANS_TUNICA || body == ANGLERS_TUNICA || body == FISHERMANS_APRON || body == FISHERMANS_SMOCK) ? body : 0;
        gear.hands           = (hands == FISHERMANS_GLOVES || hands == ANGLERS_GLOVES) ? hands : 0;
        gear.waist           = (waist == FISHERS_ROPE) ? waist : 0;
        gear.legs            = (legs == FISHERMANS_HOSE || legs == ANGLERS_HOSE) ? legs : 0;
        gear.feet            = (feet == FISHERMANS_BOOTS || feet == ANGLERS_BOOTS) ? feet : 0;
        gear.ring1           = 0;
        gear.ring2           = 0;
        gear.ranged          = 0;
        gear.ammo            = 0;

        return gear;
    }

    bool IsLiveBait(bait_t* bait)
    {
        return (bait->baitID == DRILL_CALAMARY || bait->baitID == DWARF_PUGIL);
    }

    uint8 GetFishingSkill(CCharEntity* PChar)
    {
        return static_cast<uint8>(std::floor(PChar->RealSkills.skill[SKILL_FISHING] / 10) + PChar->getMod(Mod::FISH));
    }

    uint8 GetBaitPower(bait_t* bait, fish_t* fish)
    {
        if (FishingBaitAffinities[bait->baitID][fish->fishID])
        {
            return FishingBaitAffinities[bait->baitID][fish->fishID];
        }

        return 0;
    }

    std::map<fish_t*, uint16> GetFishPool(uint16 zoneID, uint8 areaID, uint16 BaitID)
    {
        std::map<fish_t*, uint16> pool;
        uint16                    groupId = FishingCatchLists[zoneID][areaID];

        for (auto fish : FishingGroups[groupId])
        {
            if ((!FishList[fish.first]->item) && FishingBaitAffinities.count(BaitID) && FishingBaitAffinities[BaitID].count(fish.first))
            {
                pool.insert(std::make_pair(FishList[fish.first], fish.second));
            }
        }

        return pool;
    }

    std::vector<fish_t*> GetItemPool(uint16 zoneID, uint8 areaID)
    {
        std::vector<fish_t*> pool;
        uint16               groupId = FishingCatchLists[zoneID][areaID];

        for (auto fish : FishingGroups[groupId])
        {
            if (FishList[fish.first]->item)
            {
                pool.emplace_back(FishList[fish.first]);
            }
        }

        return pool;
    }

    std::vector<fishmob_t*> GetMobPool(uint16 zoneId)
    {
        std::vector<fishmob_t*> pool;

        if (!FishZoneMobList[zoneId].empty())
        {
            for (auto mob : FishZoneMobList[zoneId])
            {
                if (!mob.second->questOnly)
                {
                    pool.emplace_back(mob.second);
                }
            }
        }

        return pool;
    }

    uint16 GetMessageOffset(uint16 ZoneID)
    {
        return MessageOffset[ZoneID];
    }

    bool IsFish(CItem* fish)
    {
        if (fish != nullptr && !FishList.empty())
        {
            auto f = FishList.find(fish->getID());

            if (f != FishList.end())
            {
                return true;
            }
        }

        return false;
    }

    fish_t* GetFish(uint32 fishId)
    {
        if (!FishList.empty())
        {
            auto f = FishList.find(fishId);

            if (f != FishList.end())
            {
                return f->second;
            }
        }

        return nullptr;
    }

/************************************************************************
 *                                                                       *
 *                         FISHING AREAS                                 *
 *                                                                       *
 ************************************************************************/
#define MAX_POINTS 10000

    // Given three colinear areavector_ts p, q, r, the function checks if
    // areavector_t q lies on line segment 'pr'
    bool onSegment(areavector_t p, areavector_t q, areavector_t r)
    {
        return q.x <= std::max(p.x, r.x) && q.x >= std::min(p.x, r.x) && q.z <= std::max(p.z, r.z) && q.z >= std::min(p.z, r.z);
    }

    // To find orientation of ordered triplet (p, q, r).
    int orientation(areavector_t p, areavector_t q, areavector_t r)
    {
        float val = std::round(q.z - p.z) * (r.x - q.x) - (q.x - p.x) * (r.z - q.z);

        if (val == 0)
        {
            return 0;
        }

        return (val > 0) ? 1 : 2;
    }

    // The function that returns true if line segment 'p1q1' and 'p2q2' intersect.
    bool doIntersect(areavector_t p1, areavector_t q1, areavector_t p2, areavector_t q2)
    {
        int o1 = orientation(p1, q1, p2);
        int o2 = orientation(p1, q1, q2);
        int o3 = orientation(p2, q2, p1);
        int o4 = orientation(p2, q2, q1);

        if (o1 != o2 && o3 != o4)
        {
            return true;
        }

        if (o1 == 0 && onSegment(p1, p2, q1))
        {
            return true;
        }

        if (o2 == 0 && onSegment(p1, q2, q1))
        {
            return true;
        }

        if (o3 == 0 && onSegment(p2, p1, q2))
        {
            return true;
        }

        if (o4 == 0 && onSegment(p2, q1, q2))
        {
            return true;
        }

        return false;
    }

    // Returns true if the areavector_t p lies inside the polygon[] with n vertices
    bool isInsidePoly(areavector_t polygon[], int n, areavector_t p, float posy, uint8 height)
    {
        if (p.y < (posy - (height / 2)) || p.y > (posy + (height / 2)))
        {
            return false;
        }

        if (n < 3)
        {
            return false;
        }

        areavector_t extreme = { MAX_POINTS, p.z, 0 }; // TODO: Verify this "extreme" variable, X = MAX_POINTS, Y = p.z and Z = 0.
        int          count = 0, i = 0;
        do
        {
            int next = (i + 1) % n;
            if (doIntersect(polygon[i], polygon[next], p, extreme))
            {
                if (orientation(polygon[i], p, polygon[next]) == 0)
                {
                    return onSegment(polygon[i], p, polygon[next]);
                }

                count++;
            }
            i = next;
        } while (i != 0);

        return count & 1;
    }

    bool isInsideCylinder(areavector_t center, areavector_t p, uint16 radius, uint8 height)
    {
        if (p.y < (center.y - (height / 2)) || p.y > (center.y + (height / 2)))
        {
            return false;
        }

        float dx = std::abs(p.x - center.x);

        if (dx > radius)
        {
            return false;
        }

        float dz = std::abs(p.z - center.z);

        if (dz > radius)
        {
            return false;
        }

        if (dx + dz <= radius)
        {
            return true;
        }

        return (dx * dx + dz * dz <= radius * radius);
    }

    fishingarea_t* GetFishingArea(CCharEntity* PChar)
    {
        int16        zoneId = PChar->getZone();
        position_t   p      = PChar->loc.p;
        areavector_t loc    = { p.x, p.y, p.z };

        for (auto area : FishingAreaList[zoneId])
        {
            fishingarea_t* fishingArea = FishingAreaList[zoneId][area.first];

            switch (fishingArea->areatype)
            {
                case 0: // Whole Zone
                    return fishingArea;
                    break;
                case 1: // Radial Boundary
                    if (isInsideCylinder(fishingArea->center, loc, fishingArea->radius, fishingArea->height))
                    {
                        return fishingArea;
                    }
                    break;
                case 2: // Poly Boundary
                    if (isInsidePoly(fishingArea->areaBounds, fishingArea->numBounds, loc, fishingArea->center.y, fishingArea->height))
                    {
                        return fishingArea;
                    }
                    break;
            }
        }

        return nullptr;
    }

    bool BaitLoss(CCharEntity* PChar, bool RemoveFly, bool SendUpdate)
    {
        CItemWeapon* PBait = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));

        if (PBait != nullptr)
        {
            if (!PBait->isType(ITEM_WEAPON))
            {
                ShowWarning("PBait is not of Weapon Type.");
                return false;
            }

            if (PBait->getSkillType() != SKILL_FISHING)
            {
                ShowWarning("PBait Skilltype is not Fishing.");
                return false;
            }

            if (!RemoveFly && (PBait->getStackSize() == 1))
            {
                return false;
            }

            if (PChar->hookedFish->successtype != FISHINGSUCCESSTYPE_CATCHITEM)
            {
                if (PBait->getQuantity() == 1)
                {
                    charutils::UnequipItem(PChar, SLOT_AMMO, false);
                }
                charutils::UpdateItem(PChar, PBait->getLocationID(), PBait->getSlotID(), -1);

                if (SendUpdate)
                {
                    PChar->pushPacket<CInventoryFinishPacket>();
                }
            }
        }

        return true;
    }

    void RodBreak(CCharEntity* PChar)
    {
        CItemWeapon* PRanged = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));
        rod_t*       PRod    = FishingRods[PRanged->getID()];

        if (PRanged == nullptr)
        {
            ShowWarning("PRod was null.");
            return;
        }

        if (PRod == nullptr)
        {
            ShowWarning("PRod was null.");
            return;
        }

        if (PRanged != nullptr && PRod != nullptr)
        {
            if (PRod->breakable && PRod->brokenRodId > 0)
            {
                BaitLoss(PChar, true, false);
                charutils::UnequipItem(PChar, SLOT_RANGED, false);
                uint8 location = PRanged->getLocationID();
                charutils::UpdateItem(PChar, location, PRanged->getSlotID(), -1);
                charutils::AddItem(PChar, location, PRod->brokenRodId, 1);
                PChar->pushPacket<CInventoryFinishPacket>();
            }
        }
    }

    bool CanFishMob(CMobEntity* PMob)
    {
        if (PMob == nullptr)
        {
            return false;
        }

        if (PMob->isAlive())
        {
            return false;
        }

        if (PMob->status != STATUS_TYPE::DISAPPEAR)
        {
            return false;
        }

        if (PMob->GetLocalVar("hooked") != 1)
        {
            return false;
        }

        return true;
    }

    int32 LoseCatch(CCharEntity* PChar, uint8 FailType)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        PChar->updatemask |= UPDATE_HP;

        switch (FailType)
        {
            case FISHINGFAILTYPE_LINESNAP:
                PChar->animation = ANIMATION_FISHING_LINE_BREAK;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LINEBREAK);
                break;
            case FISHINGFAILTYPE_RODBREAK:
                PChar->animation = ANIMATION_FISHING_ROD_BREAK;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_RODBREAK);
                break;
            case FISHINGFAILTYPE_RODBREAK_TOOBIG:
                PChar->animation = ANIMATION_FISHING_ROD_BREAK;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_RODBREAK_TOOBIG);
                break;
            case FISHINGFAILTYPE_RODBREAK_TOOHEAVY:
                PChar->animation = ANIMATION_FISHING_ROD_BREAK;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_RODBREAK_TOOHEAVY);
                break;
            case FISHINGFAILTYPE_LOST_TOOSMALL:
                PChar->animation = ANIMATION_FISHING_STOP;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST_TOOSMALL);
                break;
            case FISHINGFAILTYPE_LOST_LOWSKILL:
                PChar->animation = ANIMATION_FISHING_STOP;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST_LOWSKILL);
                break;
            case FISHINGFAILTYPE_LOST_TOOBIG:
                PChar->animation = ANIMATION_FISHING_STOP;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST_TOOBIG);
                break;
            case FISHINGFAILTYPE_LOST:
            case FISHINGFAILTYPE_NONE:
            default:
                PChar->animation = ANIMATION_FISHING_STOP;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST);
                break;
        }

        return 1;
    }

    int32 CatchNothing(CCharEntity* PChar, uint8 FailType)
    {
        uint16 messageOffset = GetMessageOffset(PChar->getZone());
        PChar->animation     = ANIMATION_FISHING_STOP;
        PChar->updatemask |= UPDATE_HP;

        PChar->pushPacket<CMessageTextPacket>(PChar, messageOffset + FISHMESSAGEOFFSET_NOCATCH);

        return 1;
    }

    int32 CatchFish(CCharEntity* PChar, uint16 FishID, bool BigFish, uint16 length, uint16 weight, uint8 Count = 1)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        PChar->animation     = ANIMATION_FISHING_CAUGHT;
        PChar->updatemask |= UPDATE_HP;

        if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0)
        {
            CItemFish* Fish = GetFish(FishID);

            if (Fish == nullptr)
            {
                ShowError("Invalid ItemID %i for fished item\n", FishID);
                PChar->animation = ANIMATION_FISHING_STOP;
                PChar->updatemask |= UPDATE_HP;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST);
                return 0;
            }

            if (BigFish && length > 1 && weight > 1)
            {
                Fish->SetLength(length);
                Fish->SetWeight(weight);
            }

            Fish->setQuantity(Count);
            charutils::AddItem(PChar, LOC_INVENTORY, Fish);

            if (Count > 1)
            {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCaughtFishPacket>(PChar, FishID, MessageOffset + FISHMESSAGEOFFSET_CATCH_MULTI, Count));
            }
            else
            {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCaughtFishPacket>(PChar, FishID, MessageOffset + FISHMESSAGEOFFSET_CATCH, Count));
            }

            return 1;
        }
        else
        {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCaughtFishPacket>(PChar, FishID, MessageOffset + FISHMESSAGEOFFSET_CATCH_INV_FULL, Count));
        }

        return 0;
    }

    int32 CatchItem(CCharEntity* PChar, uint16 ItemID, uint8 Count = 1)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        PChar->animation     = ANIMATION_FISHING_CAUGHT;
        PChar->updatemask |= UPDATE_HP;

        if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0)
        {
            CItem* Item = itemutils::GetItem(ItemID);

            if (Item == nullptr)
            {
                ShowError("Invalid ItemID %i for fished item\n", ItemID);
                PChar->animation = ANIMATION_FISHING_STOP;
                PChar->updatemask |= UPDATE_HP;
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST);
                return 0;
            }

            charutils::AddItem(PChar, LOC_INVENTORY, ItemID, Count);

            if (Count > 1)
            {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCaughtFishPacket>(PChar, ItemID, MessageOffset + FISHMESSAGEOFFSET_CATCH_MULTI, Count));
            }
            else
            {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCaughtFishPacket>(PChar, ItemID, MessageOffset + FISHMESSAGEOFFSET_CATCH, Count));
            }

            return 1;
        }
        else
        {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCaughtFishPacket>(PChar, ItemID, MessageOffset + FISHMESSAGEOFFSET_CATCH_INV_FULL, Count));
        }

        return 0;
    }

    int32 CatchMonster(CCharEntity* PChar, uint32 MobID)
    {
        uint16      MessageOffset = GetMessageOffset(PChar->getZone());
        CMobEntity* PMob          = dynamic_cast<CMobEntity*>(zoneutils::GetEntity(MobID, TYPE_MOB));
        fishmob_t*  mob           = FishZoneMobList[PChar->getZone()][MobID];

        if ((PMob == nullptr) || (mob == nullptr) || PMob->isAlive() || (PMob != nullptr && mob->questOnly && PMob->GetLocalVar("catchable") == 0))
        {
            if (!PMob->isAlive())
            {
                ShowError("Invalid MobID %i for fished monster\n", MobID);
            }

            PChar->animation = ANIMATION_FISHING_STOP;
            PChar->updatemask |= UPDATE_HP;
            PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST);

            return 0;
        }

        PChar->animation = ANIMATION_FISHING_MONSTER;
        PChar->updatemask |= UPDATE_HP;
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCaughtMonsterPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_MONSTER));

        position_t p = PChar->loc.p;
        position_t m;
        double     Radians = p.rotation * M_PI / 128;
        m.x                = p.x - 2.0f * (float)cos(Radians);
        m.y                = p.y - 0.5f;
        m.z                = p.z + 2.0f * (float)sin(Radians);
        m.rotation         = worldAngle(m, p);

        PMob->m_SpawnPoint = m;
        PMob->Spawn();
        PMob->setMobMod(MOBMOD_CHARMABLE, 0);
        PMob->setMobMod(MOBMOD_IDLE_DESPAWN, 180);
        PMob->SetDespawnTime(std::chrono::seconds(180));
        PMob->SetLocalVar("hooked", 0);

        if (mob->maxRespawn > mob->minRespawn)
        {
            PMob->SetLocalVar("respawnTime", xirand::GetRandomNumber<uint32>(mob->minRespawn, mob->maxRespawn));
        }
        else
        {
            PMob->SetLocalVar("respawnTime", mob->maxRespawn);
        }

        // PMob->SetLocalVar("QuestBattleID", PChar->GetLocalVar("QuestBattleID"));
        // PChar->StatusEffectContainer->CopyConfrontationEffect(PMob);
        if ((mob->log < 255 && mob->quest < 255) || mob->questOnly || (PMob->m_TrueDetection && PMob->getMobMod(MOBMOD_DETECTION) & DETECT_SCENT) || !PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK))
        {
            PMob->PAI->Engage(PChar->targid);
            battleutils::ClaimMob(PMob, (CBattleEntity*)PChar);
        }

        return 1;
    }

    int32 CatchChest(CCharEntity* PChar, uint32 NpcID, uint8 distance, int8 angle)
    {
        /* Disabled catching Chests until further notice.

        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        // @todo: get chest npc (i.e. jade etui)
        CNpcEntity* Chest = dynamic_cast<CNpcEntity*>(zoneutils::GetEntity(NpcID, TYPE_NPC));

        if (Chest == nullptr || (Chest != nullptr && Chest->GetLocalVar("catchable") == 0))
        {
            ShowError("Invalid NpcID %i for fished chest\n", NpcID);
            PChar->animation = ANIMATION_FISHING_STOP;
            PChar->updatemask |= UPDATE_HP;
            PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST);
            return 0;
        }

        PChar->animation = ANIMATION_FISHING_CAUGHT;
        PChar->updatemask |= UPDATE_HP;
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCaughtMonsterPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_CATCH_CHEST));

        position_t p = PChar->loc.p;
        position_t m;
        double     Radians = (p.rotation + angle) * M_PI / 128;
        m.x                = p.x - distance * (float)cos(Radians);
        m.y                = p.y;
        m.z                = p.z + distance * (float)sin(Radians);
        m.rotation         = p.rotation; // getangle(m, p);

        Chest->loc.p  = m; // This line is returning an error in CI, and I don't know how to fix it. Probably has to do with that "todo" above.
        Chest->status = STATUS_TYPE::NORMAL;
        Chest->SetLocalVar("owner", PChar->id);
        Chest->updatemask |= UPDATE_COMBAT;
        return 1;
        */

        return 0; // Remove when catching chests is enabled.
    }

    /************************************************************************
     *                                                                       *
     *                             MESSAGING                                 *
     *                                                                       *
     ************************************************************************/
    void SendSenseMessage(CCharEntity* PChar, fishresponse_t* response)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());

        switch (response->sense)
        {
            case FISHINGSENSETYPE_GOOD:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_GOOD_FEELING);
                break;
            case FISHINGSENSETYPE_BAD:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_BAD_FEELING);
                break;
            case FISHINGSENSETYPE_TERRIBLE:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_TERRIBLE_FEELING);
                break;
            case FISHINGSENSETYPE_NOSKILL_FEELING:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_NOSKILL_FEELING);
                break;
            case FISHINGSENSETYPE_NOSKILL_SURE_FEELING:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_NOSKILL_SURE_FEELING);
                break;
            case FISHINGSENSETYPE_NOSKILL_POSITIVEFEELING:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_NOSKILL_POSITIVE_FEELING);
                break;
            case FISHINGSENSETYPE_KEEN_ANGLERS_SENSE:
                PChar->pushPacket<CMessageSpecialPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_KEEN_ANGLERS_SENSE, response->catchid, 3, 3, 3);
                break;
            case FISHINGSENSETYPE_EPIC_CATCH:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_EPIC_CATCH);
                break;
        }
    }

    bool SendHookResponse(CCharEntity* PChar, fishresponse_t* response, bool cancelOnMobLoadFail)
    {
        uint16 MessageOffset = GetMessageOffset(PChar->getZone());

        switch (response->catchtype)
        {
            case FISHINGCATCHTYPE_SMALLFISH:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_SMALL_FISH);
                break;
            case FISHINGCATCHTYPE_BIGFISH:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_LARGE_FISH);
                break;
            case FISHINGCATCHTYPE_ITEM:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_ITEM);
                break;
            case FISHINGCATCHTYPE_MOB:
            {
                CMobEntity* PMob = dynamic_cast<CMobEntity*>(zoneutils::GetEntity(PChar->hookedFish->catchid, TYPE_MOB));

                if (CanFishMob(PMob))
                {
                    PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_MONSTER);
                }
                else
                {
                    if (cancelOnMobLoadFail)
                    {
                        CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                        return false;
                    }
                }
            }
            break;
            case FISHINGCATCHTYPE_CHEST:
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_HOOKED_ITEM);
                break;
        }
        return true;
    }

    /************************************************************************
     *                                                                       *
     *                               SKILL UP                                *
     *                                                                       *
     ************************************************************************/

    void FishingSkillup(CCharEntity* PChar, uint8 catchLevel, uint8 successType)
    {
        if (successType == FISHINGSUCCESSTYPE_NONE)
        {
            return;
        }

        uint8        skillRank       = PChar->RealSkills.rank[SKILL_FISHING];
        uint16       maxSkill        = (skillRank + 1) * 100;
        int32        charSkill       = PChar->RealSkills.skill[SKILL_FISHING];
        int32        charSkillLevel  = (uint32)std::floor(PChar->RealSkills.skill[SKILL_FISHING] / 10);
        uint8        levelDifference = 0;
        int          maxSkillAmount  = 1;
        CItemWeapon* Rod             = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));

        if (catchLevel > charSkillLevel)
        {
            levelDifference = catchLevel - charSkillLevel;
        }

        // No skillup if fish level not between char level and 50 levels higher
        if (catchLevel <= charSkillLevel || (levelDifference > 50))
        {
            return;
        }

        int skillRoll       = 90;
        int maxChance       = 0;
        int bonusChanceRoll = 8;

        // Lu shang rod under level 50 penalty
        if (Rod != nullptr && charSkillLevel < 50 && Rod->getID() == LU_SHANG)
        {
            skillRoll += 20;
        }

        // Generate a normal distribution favoring fish 10 levels higher in skill
        // with 5 levels of deviation on either side
        double normDist          = exp(-0.5 * log(2 * M_PI) - log(5) - pow(levelDifference - 11, 2) / 50);
        int    distMod           = (int)std::floor(normDist * 200);
        int    lowerLevelBonus   = (int)std::floor((100 - charSkillLevel) / 10);
        int    skillLevelPenalty = (int)std::floor(charSkillLevel / 10);

        // Minimum 4% chance
        maxChance = std::max(4, distMod + lowerLevelBonus - skillLevelPenalty);

        // Configuration multiplier.
        maxChance = maxChance * settings::get<float>("map.FISHING_SKILL_MULTIPLIER");

        // Moon phase skillup modifiers
        uint8 phase         = CVanaTime::getInstance()->getMoonPhase();
        uint8 moonDirection = CVanaTime::getInstance()->getMoonDirection();
        switch (moonDirection)
        {
            case 0: // None
                if (phase == 0)
                {
                    skillRoll -= 20;
                    bonusChanceRoll -= 3;
                }
                else if (phase == 100)
                {
                    skillRoll += 10;
                    bonusChanceRoll += 3;
                }
                break;

            case 1: // Waning (decending)
                if (phase <= 10)
                {
                    skillRoll -= 15;
                    bonusChanceRoll -= 2;
                }
                else if (phase >= 95 && phase <= 100)
                {
                    skillRoll += 5;
                    bonusChanceRoll += 2;
                }
                break;

            case 2: // Waxing (increasing)
                if (phase <= 5)
                {
                    skillRoll -= 10;
                    bonusChanceRoll -= 1;
                }
                else if (phase >= 90 && phase <= 100)
                {
                    bonusChanceRoll += 1;
                }
                break;
        }

        // Not in City bonus
        CZone* PZone = zoneutils::GetZone(PChar->getZone());
        if (!(PZone && PZone->GetTypeMask() & ZONE_TYPE::CITY))
        {
            skillRoll -= 10;
        }

        if (charSkillLevel < 50)
        {
            skillRoll -= (20 - (uint8)std::floor(charSkillLevel / 3));
        }

        // Max skill amount increases as level difference gets higher
        const int skillAmountAdd = 1 + (int)std::floor(levelDifference / 5);
        maxSkillAmount           = std::min(skillAmountAdd, 3);

        if (xirand::GetRandomNumber(skillRoll) < maxChance)
        {
            int32 skillAmount = 1;

            // Bonus points
            if (xirand::GetRandomNumber(bonusChanceRoll) == 1)
            {
                skillAmount = xirand::GetRandomNumber(1, maxSkillAmount);
            }

            if ((skillAmount + charSkill) > maxSkill)
            {
                skillAmount = maxSkill - charSkill;
            }

            if (skillAmount > 0)
            {
                PChar->RealSkills.skill[SKILL_FISHING] += skillAmount;
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, SKILL_FISHING, skillAmount, 38);

                if ((charSkill / 10) < (charSkill + skillAmount) / 10)
                {
                    PChar->WorkingSkills.skill[SKILL_FISHING] += 0x20;

                    if (PChar->RealSkills.skill[SKILL_FISHING] >= maxSkill)
                    {
                        PChar->WorkingSkills.skill[SKILL_FISHING] |= 0x8000; // blue capped text
                    }

                    PChar->pushPacket<CCharSkillsPacket>(PChar);
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, SKILL_FISHING, (charSkill + skillAmount) / 10, 53);
                }

                charutils::SaveCharSkills(PChar, SKILL_FISHING);
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *                              FISHING                                  *
     *                                                                       *
     ************************************************************************/
    void InterruptFishing(CCharEntity* PChar)
    {
        if (PChar->animation == ANIMATION_FISHING_FISH)
        {
            BaitLoss(PChar, false, true);
        }

        PChar->animation = ANIMATION_NONE;
        PChar->updatemask |= UPDATE_ALL_CHAR;
        UnhookMob(PChar, false);

        if (PChar->hookedFish != nullptr)
        {
            destroy(PChar->hookedFish);
            PChar->hookedFish = nullptr;
        }

        PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);
    }

    void StartFishing(CCharEntity* PChar)
    {
        if (!settings::get<bool>("map.FISHING_ENABLE"))
        {
            ShowWarning("Fishing is currently disabled");
            PChar->pushPacket<CChatMessagePacket>(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Fishing is currently disabled");
            PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);
            return;
        }

        if (PChar->GetMLevel() < settings::get<uint8>("map.FISHING_MIN_LEVEL"))
        {
            PChar->pushPacket<CChatMessagePacket>(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Your level is too low to fish.");
            PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);
            return;
        }

        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_INVISIBLE);
        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_HIDE);
        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_CAMOUFLAGE);
        uint16       MessageOffset = GetMessageOffset(PChar->getZone());
        CItemWeapon* Rod           = nullptr;
        CItemWeapon* Bait          = nullptr;
        uint8        FishingAreaID = 0;
        uint32       vanaTime      = CVanaTime::getInstance()->getVanaTime();

        if (PChar->nextFishTime > vanaTime)
        {
            PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_CANNOTFISH_MOMENT);
            PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);
            return;
        }
        else
        {
            auto secs = std::chrono::duration_cast<std::chrono::seconds>(server_clock::now().time_since_epoch());
            PChar->setCharVar("[Fish]LastCastTime", secs.count());
            PChar->lastCastTime = vanaTime;
            PChar->nextFishTime = PChar->lastCastTime + 5;
        }

        fishingarea_t* Area = GetFishingArea(PChar);

        if (Area != nullptr)
        {
            FishingAreaID = Area->areaId;
        }

        if (FishingAreaID > 0)
        {
            PChar->fishingToken = 1 + xirand::GetRandomNumber(9999);
            destroy(PChar->hookedFish);

            PChar->hookedFish              = new fishresponse_t();
            PChar->hookedFish->hooked      = false;
            PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;

            // If in the middle of something else, can't fish
            if (PChar->animation != ANIMATION_NONE)
            {
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_CANNOTFISH_MOMENT);
                PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotUseCommandAtTheMoment);
                PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);

                return;
            }

            Rod  = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));
            Bait = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));

            // If no rod, then can't fish
            if ((Rod == nullptr) || !(Rod->isType(ITEM_WEAPON)) || (Rod->getSkillType() != SKILL_FISHING))
            {
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_NOROD);
                PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);

                return;
            }

            // If no bait, then can't fish
            if ((Bait == nullptr) || !(Bait->isType(ITEM_WEAPON)) || (Bait->getSkillType() != SKILL_FISHING))
            {
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_NOBAIT);
                PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);

                return;
            }

            rod_t*  rod  = FishingRods[Rod->getID()];
            bait_t* bait = FishingBaits[Bait->getID()];

            if (rod != nullptr && bait != nullptr)
            {
                PChar->hookDelay = GetHookTime(PChar);
                PChar->animation = ANIMATION_FISHING_START;
                PChar->updatemask |= UPDATE_HP;
            }
            else
            {
                PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotUseCommandAtTheMoment);
                PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);
            }
        }
        else
        {
            PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotUseCommandAtTheMoment);
            PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::FISHING);

            return;
        }
    }

    void ReelInCatch(CCharEntity* PChar)
    {
        if (PChar->hookedFish != nullptr)
        {
            switch (PChar->hookedFish->catchtype)
            {
                case FISHINGCATCHTYPE_NONE:
                    PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                    break;
                case FISHINGCATCHTYPE_SMALLFISH:
                    PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHSMALL;
                    CatchFish(PChar, PChar->hookedFish->catchid, false, 0, 0, PChar->hookedFish->count);
                    break;
                case FISHINGCATCHTYPE_BIGFISH:
                    PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHLARGE;
                    CatchFish(PChar, PChar->hookedFish->catchid, true, PChar->hookedFish->length, PChar->hookedFish->weight, PChar->hookedFish->count);
                    break;
                case FISHINGCATCHTYPE_ITEM:
                    PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHITEM;
                    CatchItem(PChar, PChar->hookedFish->catchid, PChar->hookedFish->count);
                    break;
                case FISHINGCATCHTYPE_MOB:
                    PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHMOB;
                    CatchMonster(PChar, PChar->hookedFish->catchid);
                    break;
                case FISHINGCATCHTYPE_CHEST:
                    PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_CATCHCHEST;

                    // TODO: Below function is currently not implemented.
                    // CatchChest(PChar, PChar->hookedFish->catchid, PChar->hookedFish->distance, PChar->hookedFish->angle);
                    break;
            }
        }
    }

    uint8 UnhookMob(CCharEntity* PChar, bool lost)
    {
        if (PChar->hookedFish != nullptr && PChar->hookedFish->catchtype == FISHINGCATCHTYPE_MOB)
        {
            CMobEntity* PMob = dynamic_cast<CMobEntity*>(zoneutils::GetEntity(PChar->hookedFish->catchid, TYPE_MOB));

            if (PMob != nullptr)
            {
                PMob->SetLocalVar("hooked", 0);

                if (lost && PChar->hookedFish->nm && PChar->hookedFish->nmFlags & FISHINGNM_RESET_RESPAWN_ON_FAIL)
                {
                    PMob->SetLocalVar("lastTOD", (uint32)time(nullptr));
                }
            }
        }

        return 0;
    }

    fishresponse_t* FishingCheck(CCharEntity* PChar, uint8 fishingSkill, rod_t* rod, bait_t* bait, fishingarea_t* area)
    {
        fishresponse_t* response    = new fishresponse_t();
        response->angle             = 0;
        response->distance          = 2;
        response->catchdifficulty   = 0;
        response->catchsizeType     = 0;
        response->legendary         = 0;
        response->count             = 0;
        response->stamina           = 0;
        response->delay             = 0;
        response->regen             = 0;
        response->attackdmg         = 0;
        response->heal              = 0;
        response->timelimit         = 0;
        response->sense             = 0;
        response->hooksense         = 0;
        response->special           = 0;
        response->successtype       = 0;
        response->length            = 0;
        response->weight            = 0;
        response->ranking           = 0;
        response->epic              = 0;
        response->lose.failReason   = 0;
        response->lose.chance       = 0;
        response->rbreak.failReason = 0;
        response->rbreak.chance     = 0;
        response->lsnap.failReason  = 0;
        response->lsnap.chance      = 0;
        response->nm                = 0;
        response->nmFlags           = 0;
        response->response          = 0;

        uint16 FishPoolWeight       = 0;
        uint16 ItemPoolWeight       = 0;
        uint16 MobPoolWeight        = 0;
        uint16 ChestPoolWeight      = 0;
        uint16 NoCatchWeight        = 0;
        float  fishPoolMoonModifier = MOONPATTERN_4(GetMoonPhase());
        float  itemPoolMoonModifier = MOONPATTERN_2(GetMoonPhase());
        float  mobPoolMoonModifier  = MOONPATTERN_3(GetMoonPhase());
        float  noCatchMoonModifier  = MOONPATTERN_5(GetMoonPhase());

        CZone* PZone = zoneutils::GetZone(PChar->getZone());
        if (PZone && PZone->GetTypeMask() & ZONE_TYPE::CITY)
        {
            FishPoolWeight = (uint16)std::floor(15 * fishPoolMoonModifier);
            ItemPoolWeight = 25 + (uint16)std::floor(20 * itemPoolMoonModifier);
            MobPoolWeight  = 0;
            NoCatchWeight  = 30 + (uint16)std::floor(15 * noCatchMoonModifier);
        }
        else
        {
            FishPoolWeight = (uint16)std::floor(25 * fishPoolMoonModifier);
            ItemPoolWeight = 10 + (uint16)std::floor(15 * itemPoolMoonModifier);
            MobPoolWeight  = 15 + (uint16)std::floor(15 * mobPoolMoonModifier);
            NoCatchWeight  = 15 + (uint16)std::floor(20 * noCatchMoonModifier);
        }

        uint16 FishHookChanceTotal = 0;
        uint16 ItemHookChanceTotal = 0;

        std::map<fish_t*, uint16> FishHookPool;
        fish_t*                   FishSelection = nullptr;

        std::map<fish_t*, uint16> ItemHookPool;
        fish_t*                   ItemSelection = nullptr;

        std::map<fishmob_t*, uint16> MobHookPool;
        fishmob_t*                   MobSelection = nullptr;

        uint32 ChestSelection = 0;
        int8   ChestAngle     = 0;

        // Get Fish and Item Lists
        std::map<fish_t*, uint16>                FishPool;
        std::vector<fish_t*>                     ItemPool;
        std::vector<fishmob_t*>                  MobPool;
        std::map<uint32, std::map<uint16, int8>> ChestPool;

        FishPool.clear();
        ItemPool.clear();
        MobPool.clear();
        ChestPool.clear();

        FishPool = GetFishPool(PChar->getZone(), area->areaId, bait->baitID);
        ItemPool = GetItemPool(PChar->getZone(), area->areaId);
        MobPool  = GetMobPool(PChar->getZone());
        ChestPool.clear();

        std::set<uint32> RemoveList;
        RemoveList.clear();

        std::set<uint32> NoCatchList;
        NoCatchList.clear();

        // Build Hookable Fish Pool
        if (!FishPool.empty())
        {
            uint16 maxChance = 0;

            for (auto fish : FishPool)
            {
                fish_t* fishIter = fish.first;

                if (RemoveList.count(fishIter->fishID) > 0)
                {
                    continue;
                }

                // uint16 baitPower = fish.second; //@TODO: implement this in later patch
                if ((fishingSkill >= fishIter->maxSkill || fishIter->maxSkill - fishingSkill <= 100) && (!fishIter->reqKeyItem || charutils::hasKeyItem(PChar, fishIter->reqKeyItem)))
                { // Key item okay
                    if (!fishIter->quest_only && FishingPools[PChar->getZone()].catchPools[area->areaId].stock[fishIter->fishID].quantity == 0)
                    {
                        NoCatchList.insert(fishIter->fishID);
                    }

                    uint16 hookChance = CalculateHookChance(fishingSkill, fishIter, bait, rod);
                    FishHookPool.insert(std::make_pair(fishIter, hookChance));
                    FishHookChanceTotal += hookChance;
                    maxChance = (hookChance > maxChance) ? hookChance : maxChance;
                }
            }

            FishPoolWeight = std::clamp<uint16>(maxChance + FishPoolWeight, 10, 120);
        }

        // Build Hookable Item Pool
        if (!ItemPool.empty())
        {
            for (auto* item : ItemPool)
            {
                if (RemoveList.count(item->fishID) > 0)
                {
                    continue;
                }

                if (item->quest_only || !item->reqKeyItem || charutils::hasKeyItem(PChar, item->reqKeyItem))
                { // Key item okay
                    uint16 hookChance = 100;
                    if (item->quest < 255 && item->log < 255)
                    {
                        if (charutils::getQuestStatus(PChar, item->log, item->quest) == QUEST_ACCEPTED)
                        {
                            ItemHookPool.insert(std::make_pair(item, 100));
                            ItemPoolWeight += 1000;
                        }
                    }
                    else
                    {
                        if (!item->quest_only && FishingPools[PChar->getZone()].catchPools[area->areaId].stock[item->fishID].quantity == 0)
                        {
                            NoCatchList.insert(item->fishID);
                        }

                        float  chanceMultiplier = (float)item->rarity / 1000.0f;
                        uint16 actualHookChance = (uint16)std::floor(hookChance * chanceMultiplier);
                        ItemHookChanceTotal += actualHookChance;
                        ItemHookPool.insert(std::make_pair(item, actualHookChance));
                    }
                }
            }
        }

        // Build Hookable Mob Pool
        if (!MobPool.empty())
        {
            for (auto* mob : MobPool)
            {
                if (RemoveList.count(mob->mobId) > 0)
                {
                    continue;
                }

                CMobEntity* PMob = dynamic_cast<CMobEntity*>(zoneutils::GetEntity(mob->mobId, TYPE_MOB));
                if (PMob != nullptr && PMob->GetLocalVar("hooked") == 0 && !PMob->isAlive())
                {
                    if (mob->nm && (mob->areaId == 0 || mob->areaId == area->areaId) && ((mob->reqBaitId == 0 || mob->reqBaitId == bait->baitID) || (mob->altBaitId > 0 && mob->altBaitId == bait->baitID)))
                    {
                        bool mobAdd = false;
                        if (mob->quest < 255 && mob->log < 255)
                        {
                            if (charutils::getQuestStatus(PChar, mob->log, mob->quest) == QUEST_ACCEPTED)
                            {
                                mobAdd = true;
                                MobPoolWeight += 1000;
                            }
                        }
                        else if (mob->rarity < 1000)
                        {
                            uint16 randomizer = xirand::GetRandomNumber(1, 1000);
                            randomizer -= std::clamp<uint16>((uint16)std::floor((1 - MOONPATTERN_2(GetMoonPhase())) * 100), 0, randomizer);
                            if (randomizer <= mob->rarity)
                            {
                                mobAdd = true;
                                MobPoolWeight += 50;
                            }
                        }
                        else if (mob->maxRespawn > 0)
                        {
                            uint32 respawnTime = PMob->GetLocalVar("lastTOD") + PMob->GetLocalVar("respawnTime");
                            if ((uint32)time(nullptr) > respawnTime)
                            {
                                mobAdd = true;
                                MobPoolWeight += 50;
                            }
                        }
                        else
                        {
                            mobAdd = true;
                        }

                        if (mobAdd)
                        {
                            MobHookPool.insert(std::make_pair(mob, 100));
                        }
                    }
                    else if (!mob->nm && (mob->areaId == 0 || mob->areaId == area->areaId))
                    {
                        MobHookPool.insert(std::make_pair(mob, 100));
                    }
                }
            }
        }

        FishPoolWeight = (uint16)std::floor(FishPoolWeight * GetWeatherModifier(PChar));

        if (area->difficulty > 0)
        {
            NoCatchWeight += (area->difficulty * xirand::GetRandomNumber<uint16>(20, 30));
        }

        // Modify weights based on various factors

        /* @todo: UPDATE MOGHANCEMENT SYSTEM

        if (PChar->hasMoghancement(MOGHANCEMENT_FISHING_ITEM))
        {
            uint8 moghancementStrength = PChar->getMoghancementAuraStrength(
                PChar->getMoghancementElementStrength());
            switch (moghancementStrength)
            {
                case 0: // overwhelming
                    ItemPoolWeight += (uint16)std::floor(ItemPoolWeight * 0.9f);
                    break;
                case 1: // powerful
                    ItemPoolWeight += (uint16)std::floor(ItemPoolWeight * 0.7f);
                    break;
                case 2: // normal
                    ItemPoolWeight += (uint16)std::floor(ItemPoolWeight * 0.5f);
                    break;
            }
        }
        */

        fishing_gear_t gear = GetFishingGear(PChar);

        if ((gear.body == FISHERMANS_APRON || gear.body == FISHERMANS_SMOCK) && ItemPoolWeight > 0)
        {
            uint16 sub = (uint16)std::floor(ItemPoolWeight * 0.25f);

            if (sub > 0)
            {
                ItemPoolWeight -= sub;
                NoCatchWeight += sub;
            }
        }

        if (bait->baitFlags & BAITFLAG_POOR_FISH && FishPoolWeight > 0)
        {
            FishPoolWeight -= (uint16)std::floor(FishPoolWeight * 0.25f);
            ItemPoolWeight = FishPoolWeight + (uint16)std::floor(FishPoolWeight * 0.10f);
            NoCatchWeight += (uint16)std::floor(NoCatchWeight * 0.25f);
        }

        // Select fish
        if (!FishHookPool.empty())
        {
            uint16 hookChanceAggregate = 0;
            uint16 hookSelect          = xirand::GetRandomNumber<uint16>(FishHookChanceTotal);

            for (auto fishIter : FishHookPool)
            {
                fish_t* fish       = fishIter.first;
                uint16  hookChance = fishIter.second;
                hookChanceAggregate += hookChance;

                if (hookSelect < hookChanceAggregate && NoCatchList.count(fish->fishID) == 0)
                {
                    FishSelection   = fish;
                    uint8 skilldiff = 0;

                    if ((rod->rodID == LU_SHANG || rod->rodID == EBISU) && fishingSkill > fish->maxSkill + 7)
                    {
                        skilldiff             = fishingSkill - fish->maxSkill;
                        uint8 initialBonus    = (rod->rodID == LU_SHANG) ? 10 : 15;
                        uint8 divisor         = (rod->rodID == LU_SHANG) ? 15 : 13;
                        uint8 skillmultiplier = 1 + (uint8)std::floor<uint8>(skilldiff / divisor);
                        FishPoolWeight += initialBonus + (uint8)std::floor<uint8>((skilldiff * skillmultiplier) / (fish->sizeType + 1));
                    }

                    break;
                }
            }
        }
        else
        {
            NoCatchWeight += FishPoolWeight / 2;
            FishPoolWeight = 0;
        }

        // Select item
        if (!ItemHookPool.empty())
        {
            uint16 hookChanceAggregate = 0;
            uint16 hookSelect          = xirand::GetRandomNumber<uint16>(ItemHookChanceTotal);

            for (auto itemIter : ItemHookPool)
            {
                fish_t* item       = itemIter.first;
                uint16  hookChance = itemIter.second;
                hookChanceAggregate += hookChance;

                if (hookSelect < hookChanceAggregate && NoCatchList.count(item->fishID) == 0)
                {
                    ItemSelection = item;
                    break;
                }
            }
        }
        else
        {
            NoCatchWeight += ItemPoolWeight / 2;
            ItemPoolWeight = 0;
        }

        // Select mob
        if (!MobHookPool.empty())
        {
            uint16 hookSelect = xirand::GetRandomNumber((uint16)MobHookPool.size());
            auto   mobItr     = MobHookPool.begin();
            std::advance(mobItr, hookSelect);
            MobSelection = mobItr->first;
        }
        else
        {
            NoCatchWeight += MobPoolWeight / 2;
            MobPoolWeight = 0;
        }

        if (!ChestPool.empty())
        {
            uint16 hookSelect = xirand::GetRandomNumber((uint16)ChestPool.size());
            auto   chestItr   = ChestPool.begin();
            std::advance(chestItr, hookSelect);
            ChestSelection = chestItr->first;
            ChestAngle     = chestItr->second.begin()->second;
        }
        else
        {
            NoCatchWeight += ChestPoolWeight;
            ChestPoolWeight = 0;
        }

        if (FishPoolWeight == 0 && ItemPoolWeight == 0 && MobPoolWeight == 0 && ChestPoolWeight == 0)
        {
            NoCatchWeight = 1000;
        }

        uint16 totalWeight = FishPoolWeight + ItemPoolWeight + MobPoolWeight + ChestPoolWeight + NoCatchWeight;
        uint16 selector    = xirand::GetRandomNumber(totalWeight);

        // Pick what we're hooking
        if (FishSelection != nullptr && selector < FishPoolWeight)
        { // Hooked fish
            response->hooked          = true;
            response->catchid         = FishSelection->fishID;
            response->catchtype       = FishSelection->sizeType == FISHINGSIZETYPE_SMALL ? FISHINGCATCHTYPE_SMALLFISH : FISHINGCATCHTYPE_BIGFISH;
            response->catchlevel      = FishSelection->maxSkill;
            response->catchdifficulty = FishSelection->difficulty;
            response->catchsizeType   = FishSelection->sizeType;
            response->legendary       = FishSelection->legendary;

            if (FishSelection->maxhook > 1 && bait->maxhook > 1)
            {
                response->count = (uint8)xirand::GetRandomNumber<uint16>(1, bait->maxhook);
            }
            else
            {
                response->count = 1;
            }

            response->stamina   = CalculateStamina(FishSelection->maxSkill, response->count);
            response->delay     = CalculateDelay(PChar, FishSelection->baseDelay, FishSelection->sizeType, rod, response->count);
            response->regen     = CalculateRegen(fishingSkill, rod, (FISHINGCATCHTYPE)response->catchtype, FishSelection->sizeType, FishSelection->maxSkill, FishSelection->legendary, false);
            response->response  = CalculateMovement(PChar, FishSelection->baseMove, FishSelection->sizeType, rod, response->count);
            response->attackdmg = CalculateAttack(FishSelection->legendary, FishSelection->difficulty, rod);
            response->heal      = CalculateHeal(FishSelection->legendary, FishSelection->difficulty, rod);
            response->timelimit = CalculateHookTime(PChar, FishSelection->legendary, FishSelection->legendary_flags, FishSelection->sizeType, rod, bait);
            response->sense     = CalculateFishSense(PChar, response, fishingSkill, (FISHINGCATCHTYPE)response->catchtype, FishSelection->sizeType, FishSelection->maxSkill,
                                                     FishSelection->legendary, FishSelection->minLength, FishSelection->maxLength, FishSelection->ranking, rod);
            response->hooksense = FishSelection->sizeType == FISHINGSIZETYPE_SMALL ? FISHINGHOOKSENSETYPE_SMALL : FISHINGHOOKSENSETYPE_LARGE;

            if (response->catchsizeType == FISHINGSIZETYPE_LARGE)
            {
                big_fish_stats_t bigFishStats = CalculateBigFishStats(FishSelection->minLength, FishSelection->maxLength);
                response->length              = bigFishStats.length;
                response->weight              = bigFishStats.weight;

                if (bigFishStats.epic)
                {
                    response->sense = FISHINGSENSETYPE_EPIC_CATCH;
                }
            }

            if (response->sense == FISHINGSENSETYPE_GOOD)
            {
                if (xirand::GetRandomNumber<uint16>(100) < CalculateCriticalBite(fishingSkill, FishSelection->maxSkill, rod))
                {
                    response->hooksense += 2;
                    response->sense = FISHINGSENSETYPE_KEEN_ANGLERS_SENSE;
                }
            }

            response->special = CalculateLuckyTiming(PChar, fishingSkill, FishSelection->maxSkill, FishSelection->sizeType, rod, bait, FishSelection->legendary);

            if (response->sense == FISHINGSENSETYPE_KEEN_ANGLERS_SENSE)
            {
                response->special += 50;
                response->heal = (uint16)std::floor(response->heal * 0.7f);
            }
        }
        else if (ItemSelection != nullptr && selector < ItemPoolWeight + FishPoolWeight)
        { // Hooked item
            response->hooked          = true;
            response->catchid         = ItemSelection->fishID;
            response->catchtype       = FISHINGCATCHTYPE_ITEM;
            response->catchlevel      = ItemSelection->maxSkill;
            response->catchdifficulty = ItemSelection->difficulty;
            response->catchsizeType   = ItemSelection->sizeType;
            response->legendary       = 0;
            response->count           = 1;
            response->stamina         = CalculateStamina(ItemSelection->maxSkill, 1);
            response->delay           = CalculateDelay(PChar, ItemSelection->baseDelay, ItemSelection->sizeType, rod, 1);
            response->regen           = CalculateRegen(fishingSkill, rod, (FISHINGCATCHTYPE)response->catchtype, ItemSelection->sizeType, ItemSelection->maxSkill, false, false);
            response->response        = CalculateMovement(PChar, ItemSelection->baseMove, ItemSelection->sizeType, rod, 1);
            response->attackdmg       = CalculateAttack(ItemSelection->legendary, ItemSelection->difficulty, rod);
            response->heal            = CalculateHeal(ItemSelection->legendary, ItemSelection->difficulty, rod);
            response->timelimit       = CalculateHookTime(PChar, ItemSelection->legendary, ItemSelection->legendary_flags, ItemSelection->sizeType, rod, bait);
            response->sense           = CalculateFishSense(PChar, response, fishingSkill, (FISHINGCATCHTYPE)response->catchtype, ItemSelection->sizeType,
                                                           ItemSelection->maxSkill, false, ItemSelection->minLength, ItemSelection->maxLength, ItemSelection->ranking, rod);
            response->hooksense       = ItemSelection->sizeType == FISHINGSIZETYPE_SMALL ? FISHINGHOOKSENSETYPE_SMALL : FISHINGHOOKSENSETYPE_LARGE;
            response->special         = CalculateLuckyTiming(PChar, fishingSkill, ItemSelection->maxSkill, ItemSelection->sizeType, rod, bait, false);
        }
        else if (MobSelection != nullptr && selector < ItemPoolWeight + FishPoolWeight + MobPoolWeight)
        { // Hooked mob
            CMobEntity* PMob = dynamic_cast<CMobEntity*>(zoneutils::GetEntity(MobSelection->mobId, TYPE_MOB));

            if (PMob != nullptr && PMob->GetLocalVar("hooked") == 0)
            {
                PMob->SetLocalVar("hooked", 1);
                PMob->SetLocalVar("hookedTime", (uint32)time(nullptr));

                response->hooked              = true;
                response->catchid             = MobSelection->mobId;
                response->catchtype           = FISHINGCATCHTYPE_MOB;
                response->catchlevel          = MobSelection->level;
                response->catchdifficulty     = MobSelection->difficulty;
                response->catchsizeType       = FISHINGSIZETYPE_LARGE;
                response->legendary           = 0;
                response->count               = 1;
                response->stamina             = CalculateStamina(MobSelection->level, 1);
                response->delay               = CalculateDelay(PChar, MobSelection->baseDelay, response->catchsizeType, rod, 1);
                response->regen               = CalculateRegen(fishingSkill, rod, (FISHINGCATCHTYPE)response->catchtype, response->catchsizeType, MobSelection->level, false, MobSelection->nm);
                response->response            = CalculateMovement(PChar, MobSelection->baseMove, response->catchsizeType, rod, 1);
                response->attackdmg           = CalculateAttack(false, MobSelection->difficulty, rod);
                response->heal                = CalculateHeal(false, MobSelection->difficulty, rod);
                response->timelimit           = CalculateHookTime(PChar, 0, 0, response->catchsizeType, rod, bait);
                response->sense               = CalculateFishSense(PChar, response, fishingSkill, FISHINGCATCHTYPE_MOB, FISHINGSIZETYPE_LARGE, MobSelection->level, false,
                                                                   MobSelection->minLength, MobSelection->maxLength, MobSelection->ranking, rod);
                response->hooksense           = FISHINGHOOKSENSETYPE_LARGE;
                response->special             = CalculateLuckyTiming(PChar, fishingSkill, MobSelection->level, FISHINGSIZETYPE_LARGE, rod, bait, false);
                fishmob_modifiers_t modifiers = CalculateMobModifiers(MobSelection);
                response->regen += modifiers.regenBonus;
                response->attackdmg -= modifiers.attackPenalty;
                response->heal += modifiers.healBonus;
            }
            else
            {
                response->hooked     = false;
                response->catchid    = 0;
                response->catchtype  = FISHINGCATCHTYPE_NONE;
                response->catchlevel = 0;
            }
        }
        else if (ChestSelection > 0 && selector < ItemPoolWeight + FishPoolWeight + MobPoolWeight + ChestPoolWeight)
        { // Hooked chest
            response->hooked          = true;
            response->catchid         = ChestSelection;
            response->catchtype       = FISHINGCATCHTYPE_CHEST;
            response->catchlevel      = 1;
            response->catchdifficulty = 1;
            response->catchsizeType   = FISHINGSIZETYPE_LARGE;
            response->legendary       = 0;
            response->count           = 1;
            response->stamina         = CalculateStamina(-14, 1);
            response->delay           = CalculateDelay(PChar, 10, response->catchsizeType, rod, 1);
            response->regen           = CalculateRegen(fishingSkill, rod, (FISHINGCATCHTYPE)response->catchtype, response->catchsizeType, 1, false, false);
            response->response        = CalculateMovement(PChar, 15, response->catchsizeType, rod, 1);
            response->attackdmg       = CalculateAttack(false, 16, rod);
            response->heal            = CalculateHeal(false, 16, rod);
            response->timelimit       = CalculateHookTime(PChar, 0, 0, response->catchsizeType, rod, bait);
            response->sense           = CalculateFishSense(PChar, response, fishingSkill, FISHINGCATCHTYPE_CHEST, FISHINGSIZETYPE_LARGE, 1, false, 1, 1, 1, rod);
            response->angle           = ChestAngle;
            response->hooksense       = FISHINGHOOKSENSETYPE_LARGE;
            response->special         = CalculateLuckyTiming(PChar, fishingSkill, 16, FISHINGSIZETYPE_LARGE, rod, bait, false);
        }
        else
        { // Hooked nothing
            response->hooked     = false;
            response->catchid    = 0;
            response->catchtype  = FISHINGCATCHTYPE_NONE;
            response->catchlevel = 0;
        }

        response->areaid       = area->areaId;
        response->fishingToken = PChar->fishingToken;

        return response;
    }

    catchresponse_t* ReelCheck(CCharEntity* PChar, fishresponse_t* fishResponse, rod_t* rod)
    {
        catchresponse_t* catchResponse = new catchresponse_t();
        catchResponse->caught          = true;
        catchResponse->failReason      = FISHINGFAILTYPE_NONE;
        catchResponse->fishingToken    = fishResponse->fishingToken;
        catchResponse->linebreak       = false;
        catchResponse->rodbreak        = false;

        if (xirand::GetRandomNumber(100) < fishResponse->lose.chance)
        {
            catchResponse->caught     = false;
            catchResponse->failReason = fishResponse->lose.failReason;
        }
        else if (xirand::GetRandomNumber(100) < fishResponse->lsnap.chance)
        {
            catchResponse->caught     = false;
            catchResponse->linebreak  = true;
            catchResponse->failReason = fishResponse->lsnap.failReason;
        }
        else if (xirand::GetRandomNumber(100) < fishResponse->rbreak.chance)
        {
            catchResponse->caught     = false;
            catchResponse->rodbreak   = true;
            catchResponse->failReason = fishResponse->rbreak.failReason;
        }

        return catchResponse;
    }

    void FishingAction(CCharEntity* PChar, FISHACTION action, uint16 stamina, uint32 special)
    {
        if (!settings::get<bool>("map.FISHING_ENABLE") || PChar->GetMLevel() < settings::get<uint8>("map.FISHING_MIN_LEVEL"))
        {
            ShowWarning("Fishing is currently disabled, but somehow we have someone commencing a fishing action");
            // Unlikely anyone can get here legit, since we already disabled "startFishing"
            PChar->animation = ANIMATION_FISHING_STOP;
            return;
        }

        uint16 MessageOffset = GetMessageOffset(PChar->getZone());
        uint32 vanaTime      = CVanaTime::getInstance()->getVanaTime();

        switch (action)
        {
            case FISHACTION_CHECK:
            {
                if (vanaTime < PChar->lastCastTime + PChar->hookDelay - 2)
                {
                    CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                    return;
                }

                fishingarea_t*  fishingArea = GetFishingArea(PChar);
                fishresponse_t* response    = nullptr;

                if (PChar->hookedFish != nullptr)
                {
                    destroy(PChar->hookedFish);
                    PChar->hookedFish = nullptr;
                }

                if (fishingArea != nullptr)
                {
                    CItemWeapon* Rod  = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));
                    CItemWeapon* Bait = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));

                    if (Rod != nullptr && Bait != nullptr)
                    {
                        rod_t*  FishingRod  = FishingRods[Rod->getID()];
                        bait_t* FishingBait = FishingBaits[Bait->getID()];

                        if (FishingRod != nullptr && FishingBait != nullptr)
                        {
                            uint8 fishingSkill = GetFishingSkill(PChar);
                            response           = FishingCheck(PChar, fishingSkill, FishingRod, FishingBait, fishingArea);
                            PChar->hookedFish  = response;

                            if (response->catchtype > FISHINGCATCHTYPE_NONE && response->catchtype < FISHINGCATCHTYPE_MOB)
                            {
                                ReduceFishPool(PChar->getZone(), fishingArea->areaId, response->catchid);
                            }
                        }
                    }
                }

                if (response == nullptr || fishingArea == nullptr || response->fishingToken != PChar->fishingToken)
                {
                    CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                    PChar->pushPacket<CCharStatusPacket>(PChar);
                    PChar->pushPacket<CCharSyncPacket>(PChar);
                }
                else if (response->hooked && response->catchtype > 0 && response->catchid > 0)
                {
                    // send catch message
                    if (!SendHookResponse(PChar, response, true))
                    {
                        return;
                    }

                    // send then response sense message
                    SendSenseMessage(PChar, response);
                    // play the sweating animation
                    PChar->pushPacket<CEntityAnimationPacket>(PChar, PChar, "hitl");
                    PChar->updatemask |= UPDATE_HP;
                    // send the fishing packet
                    PChar->animation = ANIMATION_FISHING_FISH;
                    PChar->pushPacket<CFishingPacket>(response->stamina, response->regen, response->response, response->attackdmg, response->delay, response->heal, response->timelimit, response->hooksense, response->special);
                }
                else
                {
                    CatchNothing(PChar, FISHINGFAILTYPE_NONE);
                }
            }
            break;

            case FISHACTION_FINISH:
            {
                if (stamina <= 4)
                {
                    CItemWeapon* Rod = nullptr;
                    Rod              = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));

                    if (PChar->hookedFish == nullptr || Rod == nullptr)
                    {
                        LoseCatch(PChar, FISHINGFAILTYPE_NONE);
                        UnhookMob(PChar, true);
                        BaitLoss(PChar, false, true);
                    }
                    else
                    {
                        rod_t*           FishingRod = FishingRods[Rod->getID()];
                        catchresponse_t* response   = ReelCheck(PChar, PChar->hookedFish, FishingRod);

                        if (response->fishingToken != PChar->fishingToken || PChar->hookedFish->special != special)
                        {
                            LoseCatch(PChar, FISHINGFAILTYPE_NONE);
                            UnhookMob(PChar, true);
                            BaitLoss(PChar, false, true);
                        }
                        else if (response->caught)
                        {
                            PChar->fishingToken = 0;
                            ReelInCatch(PChar);
                            BaitLoss(PChar, false, true);
                        }
                        else
                        {
                            if (response->linebreak)
                            {
                                BaitLoss(PChar, true, true);
                                PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_LINEBREAK;
                            }
                            else if (response->rodbreak)
                            {
                                RodBreak(PChar);
                                PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_RODBREAK;
                            }

                            LoseCatch(PChar, response->failReason);
                            UnhookMob(PChar, !response->caught);
                        }

                        if (response != nullptr)
                        {
                            destroy(response);
                            response = nullptr;
                        }
                    }
                }
                else if (stamina <= 0x14)
                {
                    // you lost the catch due to lack of skill
                    // lose bait but keep lure
                    PChar->animation = ANIMATION_FISHING_LINE_BREAK;
                    PChar->updatemask |= UPDATE_HP;
                    BaitLoss(PChar, false, true);
                    PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST_LOWSKILL);

                    if (PChar->hookedFish)
                    {
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                }
                else if (stamina <= 0x64)
                {
                    // message: "Your line breaks!"
                    PChar->animation = ANIMATION_FISHING_LINE_BREAK;
                    PChar->updatemask |= UPDATE_HP;
                    BaitLoss(PChar, true, true);
                    PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LINEBREAK);

                    if (PChar->hookedFish)
                    {
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                }
                else if (stamina <= 0x100)
                {
                    // message: "You give up!"
                    PChar->animation = ANIMATION_FISHING_STOP;
                    PChar->updatemask |= UPDATE_HP;
                    PChar->lastCastTime = 0;

                    if (PChar->hookedFish && PChar->hookedFish->hooked && BaitLoss(PChar, false, true))
                    {
                        PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_GIVEUP_BAITLOSS);
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                    else if (PChar->hookedFish && !PChar->hookedFish->hooked)
                    {
                        PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_GIVEUP);
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                }
                else
                {
                    // message: "You lost your catch!"
                    PChar->animation = ANIMATION_FISHING_STOP;
                    PChar->updatemask |= UPDATE_HP;
                    BaitLoss(PChar, false, true);
                    PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_LOST);

                    if (PChar->hookedFish)
                    {
                        PChar->hookedFish->successtype = FISHINGSUCCESSTYPE_NONE;
                    }
                }
            }
            break;

            case FISHACTION_WARNING:
            {
                // message: "You don't know how much longer you can keep this one on the line..."
                PChar->pushPacket<CMessageTextPacket>(PChar, MessageOffset + FISHMESSAGEOFFSET_WARNING);
                return;
            }
            break;

            default:
            case FISHACTION_END:
            {
                if (PChar->hookedFish != nullptr)
                {
                    UnhookMob(PChar, false);

                    // No skillups for items or mobs.
                    if (PChar->hookedFish->catchtype == FISHINGCATCHTYPE_SMALLFISH || PChar->hookedFish->catchtype == FISHINGCATCHTYPE_BIGFISH)
                    {
                        uint16 skillUpChances = 1 + PChar->getMod(Mod::PELICAN_RING_EFFECT);

                        for (int i = 0; i < skillUpChances; i++)
                        {
                            FishingSkillup(PChar, PChar->hookedFish->catchlevel, PChar->hookedFish->successtype);
                        }
                    }

                    destroy(PChar->hookedFish);
                    PChar->hookedFish = nullptr;
                }

                PChar->animation = ANIMATION_NONE;
                PChar->updatemask |= UPDATE_HP;
            }

            break;
        }
    }

    CItemFish* GetFish(uint16 itemid)
    {
        CItem* PItem = itemutils::GetItemPointer(itemid);

        if (PItem && FishList[itemid])
        {
            // CItemFish constructor uses `const CItem&` input so this is ok
            return new CItemFish(*PItem);
        }
        return nullptr;
    }

    /************************************************************************
     *                                                                       *
     *                            INITIALIZATION                             *
     *                                                                       *
     ************************************************************************/
    void LoadFishingMessages()
    {
        // clang-format off
        zoneutils::ForEachZone([](CZone* PZone)
        {
            MessageOffset[PZone->GetID()] = luautils::GetTextIDVariable(PZone->GetID(), "FISHING_MESSAGE_OFFSET");
        });
        // clang-format on
    }

    void LoadFishingAreas()
    {
        const char* Query = "SELECT "
                            "fa.areaid, "       // 0
                            "fa.bound_type, "   // 1
                            "fa.bound_height, " // 2
                            "fa.bounds, "       // 3
                            "fa.center_x, "     // 4
                            "fa.center_y, "     // 5
                            "fa.center_z, "     // 6
                            "fa.bound_radius, " // 7
                            "fa.name, "         // 8
                            "fa.zoneid, "       // 9
                            "fz.difficulty "    // 10
                            "FROM `fishing_area` fa "
                            "LEFT JOIN fishing_zone fz "
                            "ON fz.zoneid = fa.zoneid";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                size_t         length      = 0;
                char*          bounds      = nullptr;
                fishingarea_t* fishingArea = new fishingarea_t();

                fishingArea->areaId   = _sql->GetUIntData(0);
                fishingArea->areatype = (uint8)_sql->GetUIntData(1);
                fishingArea->height   = (uint8)_sql->GetUIntData(2);

                _sql->GetData(3, &bounds, &length);

                if (length > 0)
                {
                    fishingArea->numBounds  = (uint8)length / sizeof(areavector_t);
                    fishingArea->areaBounds = new areavector_t[fishingArea->numBounds];

                    for (int i = 0; i < fishingArea->numBounds; i++)
                    {
                        std::memcpy((void*)&fishingArea->areaBounds[i], &bounds[i * sizeof(areavector_t)], sizeof(areavector_t));
                    }
                }
                else
                {
                    fishingArea->numBounds  = 0;
                    fishingArea->areaBounds = nullptr;
                }

                fishingArea->center.x = _sql->GetFloatData(4);
                fishingArea->center.y = _sql->GetFloatData(5);
                fishingArea->center.z = _sql->GetFloatData(6);
                fishingArea->radius   = (uint8)_sql->GetUIntData(7);
                fishingArea->areaName.clear();
                fishingArea->areaName.insert(0, (const char*)_sql->GetData(8));
                fishingArea->zoneId     = (uint16)_sql->GetUIntData(9);
                fishingArea->difficulty = (uint8)_sql->GetUIntData(10);

                FishingAreaList[fishingArea->zoneId][fishingArea->areaId] = fishingArea;
            }
        }
    }

    void LoadFishItems()
    {
        const char* Query = "SELECT "
                            "distinct "
                            "ff.fishid, "           // 0
                            "ff.name, "             // 1
                            "ff.skill_level, "      // 2
                            "ff.difficulty, "       // 3
                            "ff.base_delay, "       // 4
                            "ff.base_move, "        // 5
                            "ff.min_length, "       // 6
                            "ff.max_length, "       // 7
                            "ff.size_type, "        // 8
                            "ff.water_type, "       // 9
                            "ff.log, "              // 10
                            "ff.quest, "            // 11
                            "ff.flags, "            // 12
                            "ff.legendary, "        // 13
                            "ff.legendary_flags, "  // 14
                            "ff.item, "             // 15
                            "ff.max_hook, "         // 16
                            "ff.rarity, "           // 17
                            "ff.required_keyitem, " // 18
                            "ff.required_catches, " // 19
                            "ff.quest_status, "     // 20
                            "ff.quest_only, "       // 21
                            "ff.ranking, "          // 22
                            "ff.contest "
                            "FROM fishing_fish ff "
                            "WHERE ff.disabled = 0 AND ff.ranking < 99";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                fish_t* fish = new fish_t();

                fish->fishID = (uint16)_sql->GetUIntData(0);
                fish->fishName.insert(0, (const char*)_sql->GetData(1));
                fish->maxSkill        = (uint8)_sql->GetUIntData(2);
                fish->difficulty      = (uint8)_sql->GetUIntData(3);
                fish->baseDelay       = (uint8)_sql->GetUIntData(4);
                fish->baseMove        = (uint8)_sql->GetUIntData(5);
                fish->minLength       = (uint16)_sql->GetUIntData(6);
                fish->maxLength       = (uint16)_sql->GetUIntData(7);
                fish->sizeType        = (uint8)_sql->GetUIntData(8);
                fish->waterType       = (uint8)_sql->GetUIntData(9);
                fish->log             = (uint8)_sql->GetUIntData(10);
                fish->quest           = (uint8)_sql->GetUIntData(11);
                fish->fishFlags       = _sql->GetUIntData(12);
                fish->legendary       = ((uint8)_sql->GetUIntData(13) == 1);
                fish->legendary_flags = _sql->GetUIntData(14);
                fish->item            = ((uint8)_sql->GetUIntData(15) == 1);
                fish->maxhook         = (uint8)_sql->GetUIntData(16);
                fish->rarity          = (uint16)_sql->GetUIntData(17);
                fish->reqKeyItem      = (uint16)_sql->GetUIntData(18);

                size_t length  = 0;
                char*  reqFish = nullptr;
                _sql->GetData(19, &reqFish, &length);

                fish->reqFish = new std::vector<uint16>();

                if (length > 0)
                {
                    uint8 numFish = (uint8)length / sizeof(uint16);
                    fish->reqFish->clear();

                    for (int i = 0; i < numFish; i++)
                    {
                        uint16 fishid = 0;
                        std::memcpy(&fishid, &reqFish[i * sizeof(uint16)], sizeof(uint16));
                        fish->reqFish->emplace_back(fishid);
                    }
                }

                fish->quest_status = (uint8)_sql->GetUIntData(20);
                fish->quest_only   = ((uint8)_sql->GetUIntData(21) == 1);
                fish->ranking      = (uint8)_sql->GetUIntData(22);
                fish->contest      = ((uint8)_sql->GetUIntData(23) == 1);

                FishList[fish->fishID] = fish;
            }
        }
    }

    void LoadFishMobs()
    {
        const char* Query = "SELECT "
                            "mobid, "             // 0
                            "name, "              // 1
                            "level, "             // 2
                            "difficulty, "        // 3
                            "base_delay, "        // 4
                            "base_move, "         // 5
                            "log, "               // 6
                            "quest, "             // 7
                            "nm, "                // 8
                            "nm_flags, "          // 9
                            "rarity, "            // 10
                            "min_respawn, "       // 11
                            "required_keyitem, "  // 12
                            "required_baitid, "   // 13
                            "areaid, "            // 14
                            "zoneid, "            // 15
                            "quest_only, "        // 16
                            "min_length, "        // 17
                            "max_length, "        // 18
                            "ranking, "           // 19
                            "max_respawn, "       // 20
                            "alternative_baitid " // 21
                            "FROM fishing_mob "
                            "WHERE disabled=0 "
                            "ORDER BY mobid ASC";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                fishmob_t* mob = new fishmob_t();

                mob->mobId = _sql->GetUIntData(0);
                mob->mobName.insert(0, (const char*)_sql->GetData(1));
                mob->level      = (uint8)_sql->GetUIntData(2);
                mob->difficulty = (uint8)_sql->GetUIntData(3);
                mob->baseDelay  = (uint8)_sql->GetUIntData(4);
                mob->baseMove   = (uint8)_sql->GetUIntData(5);
                mob->log        = (uint8)_sql->GetUIntData(6);
                mob->quest      = (uint8)_sql->GetUIntData(7);
                mob->nm         = ((uint8)_sql->GetUIntData(8) == 1);
                mob->nmFlags    = _sql->GetUIntData(9);
                mob->rarity     = (uint16)_sql->GetUIntData(10);
                mob->minRespawn = (uint16)_sql->GetUIntData(11);
                mob->reqKeyItem = (uint16)_sql->GetUIntData(12);
                mob->reqBaitId  = (uint16)_sql->GetUIntData(13);
                mob->areaId     = (uint8)_sql->GetUIntData(14);
                mob->zoneId     = (uint16)_sql->GetUIntData(15);
                mob->questOnly  = ((uint8)_sql->GetUIntData(16) == 1);
                mob->minLength  = (uint16)_sql->GetUIntData(17);
                mob->maxLength  = (uint16)_sql->GetUIntData(18);
                mob->ranking    = (uint8)_sql->GetUIntData(19);
                mob->maxRespawn = (uint16)_sql->GetUIntData(20);
                mob->altBaitId  = (uint16)_sql->GetUIntData(21);

                FishZoneMobList[mob->zoneId][mob->mobId] = mob;
            }
        }
    }

    void LoadFishingRods()
    {
        const char* Query = "SELECT "
                            "rodid, "            // 0
                            "name, "             // 1
                            "material, "         // 2
                            "size_type, "        // 3
                            "fish_attack, "      // 4
                            "lgd_bonus_attack, " // 5
                            "fish_recovery, "    // 6
                            "fish_time, "        // 7
                            "lgd_bonus_time, "   // 8
                            "sm_delay_Bonus, "   // 9
                            "sm_move_bonus, "    // 10
                            "lg_delay_bonus, "   // 11
                            "lg_move_bonus, "    // 12
                            "multiplier, "       // 13
                            "breakable, "        // 14
                            "broken_rodid, "     // 15
                            "mmm, "              // 16
                            "flags, "            // 17
                            "legendary, "        // 18
                            "min_rank, "         // 19
                            "max_rank "          // 20
                            "FROM fishing_rod";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                rod_t* rod = new rod_t();

                rod->rodID = (uint16)_sql->GetUIntData(0);
                rod->rodName.insert(0, (const char*)_sql->GetData(1));
                rod->material     = (uint8)_sql->GetUIntData(2);
                rod->sizeType     = (uint8)_sql->GetUIntData(3);
                rod->fishAttack   = (uint8)_sql->GetUIntData(4);
                rod->lgdBonusAtk  = (uint8)_sql->GetUIntData(5);
                rod->fishRecovery = (uint8)_sql->GetUIntData(6);
                rod->fishTime     = (uint8)_sql->GetUIntData(7);
                rod->lgdBonusTime = (uint8)_sql->GetUIntData(8);
                rod->smDelayBonus = (uint8)_sql->GetUIntData(9);
                rod->smMoveBonus  = (uint8)_sql->GetUIntData(10);
                rod->lgDelayBonus = (uint8)_sql->GetUIntData(11);
                rod->lgMoveBonus  = (uint8)_sql->GetUIntData(12);
                rod->multiplier   = (uint8)_sql->GetUIntData(13);
                rod->breakable    = ((uint8)_sql->GetUIntData(14) == 1);
                rod->brokenRodId  = (uint16)_sql->GetUIntData(15);
                rod->isMMM        = ((uint8)_sql->GetUIntData(16) == 1);
                rod->rodFlags     = _sql->GetUIntData(17);
                rod->legendary    = ((uint8)_sql->GetUIntData(18) == 1);
                rod->minRank      = (uint16)_sql->GetUIntData(19);
                rod->maxRank      = (uint16)_sql->GetUIntData(20);

                FishingRods[rod->rodID] = rod;
            }
        }
    }

    void LoadFishingBaits()
    {
        const char* Query = "SELECT "
                            "baitid, "  // 0
                            "name, "    // 1
                            "type, "    // 2
                            "maxhook, " // 3
                            "losable, " // 4
                            "flags, "   // 5
                            "mmm, "     // 6
                            "rankmod "  // 7
                            "FROM fishing_bait";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                bait_t* bait = new bait_t();

                bait->baitID = (uint16)_sql->GetUIntData(0);
                bait->baitName.insert(0, (const char*)_sql->GetData(1));
                bait->baitType  = (uint8)_sql->GetUIntData(2);
                bait->maxhook   = (uint8)_sql->GetUIntData(3);
                bait->losable   = ((uint8)_sql->GetUIntData(4) == 1);
                bait->baitFlags = _sql->GetUIntData(5);
                bait->isMMM     = ((uint8)_sql->GetUIntData(6) == 1);
                bait->rankMod   = (uint8)_sql->GetUIntData(7);

                FishingBaits[bait->baitID] = bait;
            }
        }
    }

    void LoadFishingBaitAffinities()
    {
        const char* Query = "SELECT "
                            "baitid, " // 0
                            "fishid, " // 1
                            "power "   // 2
                            "FROM fishing_bait_affinity";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                FishingBaitAffinities[(uint16)_sql->GetUIntData(0)]
                                     [_sql->GetUIntData(1)] = (uint8)_sql->GetUIntData(2);
            }
        }
    }

    void LoadFishGroups()
    {
        const char* Query = "SELECT "
                            "groupid, " // 0
                            "fishid, "  // 1
                            "rarity "   // 2
                            "FROM fishing_group";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                FishingGroups[(uint16)_sql->GetUIntData(0)]
                             [_sql->GetUIntData(1)] = (uint16)_sql->GetUIntData(2);
            }
        }
    }

    void LoadFishingCatchLists()
    {
        const char* Query = "SELECT "
                            "zoneid, " // 0
                            "areaid, " // 1
                            "groupid " // 2
                            "FROM fishing_catch";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                FishingCatchLists[(uint16)_sql->GetUIntData(0)]
                                 [(uint8)_sql->GetUIntData(1)] = (uint16)_sql->GetUIntData(2);
            }
        }
    }

    void InitializeFishingSystem()
    {
        LoadFishingMessages();
        LoadFishItems();
        LoadFishMobs();
        LoadFishingRods();
        LoadFishingBaits();
        LoadFishingBaitAffinities();
        LoadFishingAreas();
        LoadFishGroups();
        LoadFishingCatchLists();
        CreateFishingPools();
    }

    void CleanupFishing()
    {
        for (auto fish : FishList)
        {
            destroy(fish.second->reqFish);
            destroy(fish.second);
        }
        FishList.clear();

        for (auto rod : FishingRods)
        {
            destroy(rod.second);
        }
        FishingRods.clear();

        for (auto bait : FishingBaits)
        {
            destroy(bait.second);
        }
        FishingBaits.clear();

        for (auto fishmoblist : FishZoneMobList)
        {
            for (auto fishmob : fishmoblist.second)
            {
                destroy(fishmob.second);
            }
            fishmoblist.second.clear();
        }
        FishZoneMobList.clear();

        for (auto fishArealist : FishingAreaList)
        {
            for (auto fishArea : fishArealist.second)
            {
                destroy_arr(fishArea.second->areaBounds);
                destroy(fishArea.second);
            }
            fishArealist.second.clear();
        }
        FishingAreaList.clear();

        for (auto fish : FishList)
        {
            destroy(fish.second);
        }
        FishList.clear();
    };
} // namespace fishingutils
