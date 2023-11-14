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

#include "attackutils.h"
#include "../ai/ai_container.h"
#include "../attack.h"
#include "../items/item_weapon.h"
#include "../status_effect_container.h"
#include "battleutils.h"
#include "common/utils.h"

namespace attackutils
{
    uint8 TryAnticipate(CBattleEntity* PDefender, CBattleEntity* PAttacker, PHYSICAL_ATTACK_TYPE physicalAttackType)
    {
        uint8 result = (uint8)ANTICIPATE_RESULT::FAIL;

        if (PDefender == nullptr || PAttacker == nullptr)
        {
            return result;
        }

        if (PDefender->StatusEffectContainer->HasPreventActionEffect(true))
        {
            return result;
        }

        if (physicalAttackType == PHYSICAL_ATTACK_TYPE::DAKEN)
        {
            return result;
        }

        auto effect = PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_THIRD_EYE, 0);
        auto isCrit = (xirand::GetRandomNumber(100) <= battleutils::GetCritHitRate(PDefender, PAttacker, false));

        if (effect == nullptr)
        {
            return result;
        }

        // Sample item https://www.bg-wiki.com/ffxi/Saotome_Haidate
        auto thirdEyeCounterRateAugment = PDefender->getMod(Mod::THIRD_EYE_COUNTER_RATE);

        if (!PDefender->StatusEffectContainer->HasStatusEffect(EFFECT_SEIGAN, 0)) // Handles third eye when not seigan.
        {
            // we don't have seigan, so we lose third eye
            PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_THIRD_EYE);

            // check for counter augment proc
            if (thirdEyeCounterRateAugment > 0 && xirand::GetRandomNumber(100) <= thirdEyeCounterRateAugment)
            {
                if (isCrit)
                {
                    result = (uint8)ANTICIPATE_RESULT::CRITICALCOUNTER;
                }
                else
                {
                    result = (uint8)ANTICIPATE_RESULT::COUNTER;
                }
            }
            else
            {
                result = (uint8)ANTICIPATE_RESULT::ANTICIPATE;
            }
        }
        else // Handles third eye under seigan.
        {
            // Sample item https://www.bg-wiki.com/ffxi/Kogarasumaru_(Level_75) according to japanese info it reduces
            // the rate at which third eye has a chance to be lost when anticipating or countering by 50%
            float powerMod = 1 - (std::clamp((int)PDefender->getMod(Mod::THIRD_EYE_ANTICIPATE_RATE), 0, 100) / 100.0f);

            // power stores (1 x anticipation) + (2x counter)
            auto power = effect->GetPower();

            // first 4-6 seconds gives us very high chance to anticipate
            auto tickCount = effect->GetElapsedTickCount() - 1;
            if (tickCount < 0)
            {
                tickCount = 0;
            }

            float powerMulti = std::clamp((32.0f - power * powerMod) / 32.0f, 0.f, 1.f);
            float tickMulti  = std::clamp((127.0f - tickCount * 8) / 128.0f, 0.f, 1.f);
            float keepChance = std::clamp((tickMulti * powerMulti) / 1.6f, 0.f, 1.f);
            float random     = xirand::GetRandomNumber(1.0f);

            // chance to counter - 25% base plus augment and not preventing action and is facing
            if (xirand::GetRandomNumber(100) <= 25 + thirdEyeCounterRateAugment &&
                !PDefender->StatusEffectContainer->HasPreventActionEffect() &&
                PDefender->PAI->IsEngaged() &&
                facing(PDefender->loc.p, PAttacker->loc.p, 42))
            {
                // counter increases power by 2
                effect->SetPower(power + 2);

                // The defender is the attacker on counter
                if (isCrit)
                {
                    result = (uint8)ANTICIPATE_RESULT::CRITICALCOUNTER;
                }
                else
                {
                    result = (uint8)ANTICIPATE_RESULT::COUNTER;
                }
            }
            else
            {
                // anticipate increases power by 1
                effect->SetPower(power + 1);
                result = (uint8)ANTICIPATE_RESULT::ANTICIPATE;
            }

            // check if we should lose third eye
            if (keepChance < random)
            {
                // we lost our third eye roll, remove the buff
                PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_THIRD_EYE);
            }
        }

        return result;
    }

    /************************************************************************
     *                                                                       *
     *  Multihit calculator.                                                    *
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
        return std::min<uint8>(num, 8); // не более восьми ударов за одну атаку
    }

    /************************************************************************
     *                                                                       *
     *  Is parried.                                                         *
     *                                                                       *
     ************************************************************************/
    bool IsParried(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        if (!PDefender->StatusEffectContainer->HasPreventActionEffect() && facing(PDefender->loc.p, PAttacker->loc.p, 64))
        {
            return (xirand::GetRandomNumber(100) < battleutils::GetParryRate(PAttacker, PDefender));
        }
        return false;
    }

    /************************************************************************
     *                                                                       *
     *  Is guarded.                                                         *
     *                                                                       *
     ************************************************************************/
    bool IsGuarded(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        // Per testing done by Genome guard can proc when petrified, stunned, or asleep
        // https://genomeffxi.livejournal.com/18269.html
        if (facing(PDefender->loc.p, PAttacker->loc.p, 64))
        {
            return (xirand::GetRandomNumber(100) < battleutils::GetGuardRate(PAttacker, PDefender));
        }
        return false;
    }

    /************************************************************************
     *                                                                       *
     *  Is blocked.                                                         *
     *                                                                       *
     ************************************************************************/
    bool IsBlocked(CBattleEntity* PAttacker, CBattleEntity* PDefender)
    {
        if (!PDefender->StatusEffectContainer->HasPreventActionEffect() && facing(PDefender->loc.p, PAttacker->loc.p, 64))
        {
            return (xirand::GetRandomNumber<float>(100) < battleutils::GetBlockRate(PAttacker, PDefender));
        }
        return false;
    }

    /************************************************************************
     *                                                                       *
     *  Handles damage multiplier, relic weapons etc.                        *
     *                                                                       *
     *  Param: allowRelicProc used to gate relic dmg procs.                  *
     ************************************************************************/
    uint32 CheckForDamageMultiplier(CCharEntity* PChar, CItemWeapon* PWeapon, uint32 damage, PHYSICAL_ATTACK_TYPE attackType, uint8 weaponSlot, bool allowRelicProc)
    {
        if (PWeapon == nullptr)
        {
            return damage;
        }

        uint32 originalDamage    = damage;
        int16  occ_do_triple_dmg = 0;
        int16  occ_do_double_dmg = 0;

        switch (attackType)
        {
            case PHYSICAL_ATTACK_TYPE::RANGED:
            case PHYSICAL_ATTACK_TYPE::RAPID_SHOT:
                occ_do_triple_dmg = PChar->getMod(Mod::REM_OCC_DO_TRIPLE_DMG_RANGED) / 10;
                occ_do_double_dmg = PChar->getMod(Mod::REM_OCC_DO_DOUBLE_DMG_RANGED) / 10;
                break;
            case PHYSICAL_ATTACK_TYPE::NORMAL:
                if (weaponSlot == SLOT_MAIN) // Only applies to mainhand
                {
                    occ_do_triple_dmg = PChar->getMod(Mod::REM_OCC_DO_TRIPLE_DMG) / 10;
                    occ_do_double_dmg = PChar->getMod(Mod::REM_OCC_DO_DOUBLE_DMG) / 10;
                }
                break;
            default:
                break;
        }

        float occ_extra_dmg        = battleutils::GetScaledItemModifier(PChar, PWeapon, Mod::OCC_DO_EXTRA_DMG) / 100.f;
        int16 occ_extra_dmg_chance = battleutils::GetScaledItemModifier(PChar, PWeapon, Mod::EXTRA_DMG_CHANCE) / 10;

        if (allowRelicProc)
        {
            if (occ_extra_dmg > 3.f && occ_extra_dmg_chance > 0 && xirand::GetRandomNumber(100) <= occ_extra_dmg_chance)
            {
                return (uint32)(damage * occ_extra_dmg);
            }
            else if (occ_do_triple_dmg > 0 && xirand::GetRandomNumber(100) <= occ_do_triple_dmg)
            {
                return (uint32)(damage * 3.f);
            }
            else if (occ_extra_dmg > 2.f && occ_extra_dmg_chance > 0 && xirand::GetRandomNumber(100) <= occ_extra_dmg_chance)
            {
                return (uint32)(damage * occ_extra_dmg);
            }
            else if (occ_do_double_dmg > 0 && xirand::GetRandomNumber(100) <= occ_do_double_dmg)
            {
                return (uint32)(damage * 2.f);
            }
            else if (occ_extra_dmg > 0 && occ_extra_dmg_chance > 0 && xirand::GetRandomNumber(100) <= occ_extra_dmg_chance)
            {
                return (uint32)(damage * occ_extra_dmg);
            }
        }

        switch (attackType)
        {
            case PHYSICAL_ATTACK_TYPE::ZANSHIN:
                if (xirand::GetRandomNumber(100) < PChar->getMod(Mod::ZANSHIN_DOUBLE_DAMAGE))
                {
                    return originalDamage * 2;
                }
                break;
            case PHYSICAL_ATTACK_TYPE::TRIPLE:
                if (xirand::GetRandomNumber(100) < PChar->getMod(Mod::TA_TRIPLE_DMG_RATE))
                {
                    return originalDamage * 3;
                }
                break;
            case PHYSICAL_ATTACK_TYPE::DOUBLE:
                if (xirand::GetRandomNumber(100) < PChar->getMod(Mod::DA_DOUBLE_DMG_RATE))
                {
                    return originalDamage * 2;
                }
                break;
            case PHYSICAL_ATTACK_TYPE::RAPID_SHOT:
                if (xirand::GetRandomNumber(100) < PChar->getMod(Mod::RAPID_SHOT_DOUBLE_DAMAGE))
                {
                    return originalDamage * 2;
                }
                break;
            case PHYSICAL_ATTACK_TYPE::SAMBA:
                if (xirand::GetRandomNumber(100) < PChar->getMod(Mod::SAMBA_DOUBLE_DAMAGE))
                {
                    return originalDamage * 2;
                }
                break;
            default:
                break;
        }
        return originalDamage;
    }

} // namespace attackutils
