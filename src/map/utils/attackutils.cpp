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
#include "attack.h"
#include "battleutils.h"
#include "common/utils.h"
#include "items/item_weapon.h"
#include "status_effect_container.h"

namespace attackutils
{
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
        if (facing(PDefender->loc.p, PAttacker->loc.p, 64))
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
        if (facing(PDefender->loc.p, PAttacker->loc.p, 64) && !PDefender->StatusEffectContainer->HasPreventActionEffect())
        {
            return (xirand::GetRandomNumber<float>(100) < battleutils::GetBlockRate(PAttacker, PDefender));
        }
        return false;
    }

    /************************************************************************
     *                                                                       *
     *  Handles damage multiplier, relic weapons etc.                        *
     *                                                                       *
     ************************************************************************/
    uint32 CheckForDamageMultiplier(CCharEntity* PChar, CItemWeapon* PWeapon, uint32 damage, PHYSICAL_ATTACK_TYPE attackType, uint8 weaponSlot)
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
