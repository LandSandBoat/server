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
#include "common/utils.h"

#include <cstring>

#include "action.h"

#include "ability.h"
#include "entities/battleentity.h"
#include "items/item_weapon.h"
#include "mobskill.h"
#include "spell.h"
#include "utils/battleutils.h"
#include "weapon_skill.h"

/************************************************************************
 *
 * ActionTargetID Contains the target ID on which the action is performed
 * If you need to make several actions, then in
 * Subsequent structures this field is left blank (equal to zero),
 * This suggests that this action on the previously specified purpose
 *
 *************************************************************************/

CActionPacket::CActionPacket(action_t& action)
{
    this->setType(0x28);
    this->setSize(0x24);

    ref<uint32>(0x05) = action.id;

    ACTIONTYPE ActionType = action.actiontype;

    switch (ActionType)
    {
        case ACTION_ATTACK:
        {
            ref<uint8>(0x0A) = 0x44;
            ref<uint8>(0x0B) = 0x18;
            ref<uint8>(0x0C) = 0xDD;
            ref<uint8>(0x0D) = 0x1A;
            ref<uint8>(0x0E) = 0x0C;
        }
        break;
        case ACTION_WEAPONSKILL_FINISH:
        {
            packBitsBE(buffer_.data(), action.actionid, 86, 16);
        }
        break;
        case ACTION_JOBABILITY_START:
        {
        }
        break;
        // Only currently used for Wyvern Breaths when going out of range and/or otherwise interrupted.
        case ACTION_JOBABILITY_INTERRUPT:
        {
            // This block was observed on a "Too far away" wyvern healing breath.
            // Is this different for different breaths -- remove/offensive breaths?
            // Do Automatons use this?
            ActionType = ACTION_WEAPONSKILL_START;

            // Magic numbers?
            packBitsBE(buffer_.data(), 28787, 86, 16);
            ref<uint8>(0x0D) = 0x5D;
            ref<uint8>(0x0E) = 0x19;
        }
        break;
        case ACTION_DANCE:
        case ACTION_JOBABILITY_FINISH:
        {
            packBitsBE(buffer_.data(), action.actionid, 86, 10);
            packBitsBE(buffer_.data(), action.recast, 118, 10);
        }
        break;
        case ACTION_RUN_WARD_EFFUSION:
        {
            packBitsBE(buffer_.data(), action.actionid, 86, 10);
        }
        break;
        case ACTION_WEAPONSKILL_START:
        case ACTION_MOBABILITY_START:
        {
            ref<uint8>(0x0A) = 0xDC;
            ref<uint8>(0x0B) = 0x58;
            ref<uint8>(0x0C) = 0x18;
            ref<uint8>(0x0D) = 0x5D;
            ref<uint8>(0x0E) = 0x19;

            ActionType = ACTION_WEAPONSKILL_START;
        }
        break;
        case ACTION_MOBABILITY_INTERRUPT:
        {
            ref<uint8>(0x0A) = 0xDC;
            ref<uint8>(0x0B) = 0x1C;
            ref<uint8>(0x0C) = 0x1C;
            ref<uint8>(0x0D) = 0x5D;
            ref<uint8>(0x0E) = 0x19;

            ActionType = ACTION_WEAPONSKILL_START;
        }
        break;
        case ACTION_MOBABILITY_FINISH:
        case ACTION_PET_MOBABILITY_FINISH:
        {
            uint16 id = action.actionid;

            // higher number of bits than anything else that we know of. CAP OF 8191 (2300ish is abyssea tp moves)!
            packBitsBE(buffer_.data(), id, 86, 13);
        }
        break;
        case ACTION_ITEM_START:
        {
            ref<uint8>(0x0A) = 0xE4;
            ref<uint8>(0x0B) = 0x58;
            ref<uint8>(0x0C) = 0x58;
            ref<uint8>(0x0D) = 0x1A;
            ref<uint8>(0x0E) = 0x1D;
        }
        break;
        case ACTION_ITEM_INTERRUPT:
        {
            ref<uint8>(0x0A) = 0xE4;
            ref<uint8>(0x0B) = 0x1C;
            ref<uint8>(0x0C) = 0x5C;
            ref<uint8>(0x0D) = 0x1A;
            ref<uint8>(0x0E) = 0x1D;

            ActionType = ACTION_ITEM_START;
        }
        break;
        case ACTION_ITEM_FINISH:
        {
            packBitsBE(buffer_.data(), action.actionid, 86, 16);
        }
        break;
        case ACTION_RANGED_START:
        {
            ref<uint8>(0x0A) = 0xF0;
            ref<uint8>(0x0B) = 0x58;
            ref<uint8>(0x0C) = 0x18;
            ref<uint8>(0x0D) = 0xDB;
            ref<uint8>(0x0E) = 0x19;
        }
        break;
        case ACTION_RANGED_FINISH:
        {
            ref<uint8>(0x0A) = 0xC8;
            ref<uint8>(0x0B) = 0x1C;
            ref<uint8>(0x0C) = 0x1A;
            ref<uint8>(0x0D) = 0xDB;
            ref<uint8>(0x0E) = 0x19;
        }
        break;
        case ACTION_RANGED_INTERRUPT:
        {
            ref<uint8>(0x0A) = 0xF0;
            ref<uint8>(0x0B) = 0x1C;
            ref<uint8>(0x0C) = 0x1C;
            ref<uint8>(0x0D) = 0xDB;
            ref<uint8>(0x0E) = 0x19;

            ActionType = ACTION_RANGED_START;
        }
        break;
        case ACTION_RAISE_MENU_SELECTION:
        {
            ref<uint8>(0x0A) = 0x10;

            ActionType = ACTION_MAGIC_FINISH;
        }
        break;
        case ACTION_MAGIC_START:
        {
            // FourCC command "ca" - cast
            packBitsBE(buffer_.data(), 0x6163, 86, 16);

            switch (action.spellgroup)
            {
                case SPELLGROUP_WHITE:
                {
                    packBitsBE(buffer_.data(), 0x6877, 102, 16); // "wh" - white magic
                }
                break;
                case SPELLGROUP_BLACK:
                {
                    packBitsBE(buffer_.data(), 0x6B62, 102, 16); // "bk" - black magic
                }
                break;
                case SPELLGROUP_BLUE:
                {
                    packBitsBE(buffer_.data(), 0x6C62, 102, 16); // "bl" - blue magic
                }
                break;
                case SPELLGROUP_SONG:
                {
                    packBitsBE(buffer_.data(), 0x6F73, 102, 16); // "so" - song
                }
                break;
                case SPELLGROUP_NINJUTSU:
                {
                    packBitsBE(buffer_.data(), 0x6A6E, 102, 16); // "nj" - ninjutsu
                }
                break;
                case SPELLGROUP_SUMMONING:
                {
                    packBitsBE(buffer_.data(), 0x6D73, 102, 16); // "sm" - summoning magic
                }
                break;
                case SPELLGROUP_GEOMANCY:
                {
                    packBitsBE(buffer_.data(), 0x6567, 102, 16); // "ge" - geomancy
                }
                break;
                case SPELLGROUP_TRUST:
                {
                    packBitsBE(buffer_.data(), 0x6166, 102, 16); // "fa" - faith aka trust
                }
                break;
                default:
                {
                    break;
                }
            }
        }
        break;
        case ACTION_MAGIC_FINISH:
        {
            packBitsBE(buffer_.data(), action.actionid, 86, 10);
            // either this way or enumerate all recast timers and compare the spell id.
            packBitsBE(buffer_.data(), action.recast, 118, 10);
        }
        break;
        case ACTION_MAGIC_INTERRUPT:
        {
            packBitsBE(buffer_.data(), action.recast, 118, 16);

            // FourCC command "sp" - interrupt
            packBitsBE(buffer_.data(), 0x7073, 86, 16);

            switch (action.spellgroup)
            {
                case SPELLGROUP_WHITE:
                {
                    packBitsBE(buffer_.data(), 0x6877, 102, 16); // "wh" - white magic
                }
                break;
                case SPELLGROUP_BLACK:
                {
                    packBitsBE(buffer_.data(), 0x6B62, 102, 16); // "bk" - black magic
                }
                break;
                case SPELLGROUP_BLUE:
                {
                    packBitsBE(buffer_.data(), 0x6C62, 102, 16); // "bl" - blue magic
                }
                break;
                case SPELLGROUP_SONG:
                {
                    packBitsBE(buffer_.data(), 0x6F73, 102, 16); // "so" - song
                }
                break;
                case SPELLGROUP_NINJUTSU:
                {
                    packBitsBE(buffer_.data(), 0x6A6E, 102, 16); // "nj" - ninjutsu
                }
                break;
                case SPELLGROUP_SUMMONING:
                {
                    packBitsBE(buffer_.data(), 0x6D73, 102, 16); // "sm" - summoning magic
                }
                break;
                case SPELLGROUP_GEOMANCY:
                {
                    packBitsBE(buffer_.data(), 0x6567, 102, 16); // "ge" - geomancy
                }
                break;
                case SPELLGROUP_TRUST:
                {
                    packBitsBE(buffer_.data(), 0x6166, 102, 16); // "fa" - faith aka trust
                }
                break;
                default:
                {
                    break;
                }
            }
            ActionType = ACTION_MAGIC_START;
        }
        break;
        default:
        {
            break;
        }
    }

    uint32 bitOffset = packBitsBE(buffer_.data(), ActionType, 82, 4);
    auto   targets   = 0;
    auto   actions   = 0;

    bitOffset += 64;

    for (auto&& list : action.actionLists)
    {
        if (actions >= 8)
        {
            break;
        }
        bitOffset = packBitsBE(buffer_.data(), list.ActionTargetID, bitOffset, 32);
        bitOffset = packBitsBE(buffer_.data(), list.actionTargets.size(), bitOffset, 4);

        for (auto&& target : list.actionTargets)
        {
            bitOffset = packBitsBE(buffer_.data(), static_cast<uint64>(target.reaction), bitOffset, 5);   // Physical reaction to damage
            bitOffset = packBitsBE(buffer_.data(), target.animation, bitOffset, 12);                      // animation ID
            bitOffset = packBitsBE(buffer_.data(), static_cast<uint64>(target.speceffect), bitOffset, 7); // specialEffect
            bitOffset = packBitsBE(buffer_.data(), target.knockback, bitOffset, 3);                       // knockback amount (mobskill only)
            bitOffset = packBitsBE(buffer_.data(), target.param, bitOffset, 17);                          // message parameter (damage/healing)
            bitOffset = packBitsBE(buffer_.data(), target.messageID, bitOffset, 10);                      // message
            bitOffset = packBitsBE(buffer_.data(), static_cast<uint64>(target.modifier), bitOffset, 31);  // "Resist!", Immunobreak, MB for Swipe/Lunge, Cover message modifiers.
                                                                                                          // 4 bits are currently used, with the other bits unknown

            if (target.additionalEffect != SUBEFFECT_NONE)
            {
                bitOffset = packBitsBE(buffer_.data(), 1, bitOffset, 1);
                bitOffset = packBitsBE(buffer_.data(), target.additionalEffect, bitOffset, 10);
                bitOffset = packBitsBE(buffer_.data(), target.addEffectParam, bitOffset, 17);
                bitOffset = packBitsBE(buffer_.data(), target.addEffectMessage, bitOffset, 10);
            }
            else
            {
                bitOffset += 1;
            }
            if (target.spikesEffect != SUBEFFECT_NONE)
            {
                bitOffset = packBitsBE(buffer_.data(), 1, bitOffset, 1);
                bitOffset = packBitsBE(buffer_.data(), target.spikesEffect, bitOffset, 10);
                bitOffset = packBitsBE(buffer_.data(), target.spikesParam, bitOffset, 14);
                bitOffset = packBitsBE(buffer_.data(), target.spikesMessage, bitOffset, 10);
            }
            else
            {
                bitOffset += 1;
            }
            if (++actions >= 8)
            {
                break;
            }
        }
        ++targets;
    }
    ref<uint8>(0x09) = targets;
    uint8 WorkSize   = ((bitOffset >> 3) + (bitOffset % 8 != 0));

    // TODO: Verify and improve math on this
    this->setSize(((((WorkSize + 7) >> 1) + 1) & -2) * 2);

    ref<uint8>(0x04) = WorkSize;
}

// 0xE0 0x58 0xD8 0x1D 0x1A - White Magic Start
// 0xE0 0x58 0x98 0xD8 0x1A - Dark Magic Start
// 0xE0 0x58 0x98 0x9B 0x1A - Ninjutsu Start
// 0xE0 0x58 0x98 0x18 0x1B - Blue Magic Start
// 0xE0 0x58 0xD8 0xDC 0x1B - Song Start

// 0xE0 0x1C 0xDC 0x1D 0x1A - White Magic Interrupt
// 0xE0 0x1C 0x9C 0xD8 0x1A - Dark Magic Interrupt
// 0xE0 0x1C 0x9C 0x9B 0x1A - Ninjutsu Interrupt
// 0xE0 0x1C 0x9C 0x18 0x1B - Blue Magic Interrupt
// 0xE0 0x1C 0xDC 0xDC 0x1B - Song Interrupt

//                                   -11.00011010.000110- ActionStart
//                                   -11.00111000.001110- ActionInterrupt
//                                   -11.00111000.010110- ActionFinish

// 0xE0 0x58 0xD8 0x1D 0x1A - 00-0001-11.00011010.000110-11.10111000.01-011000 - White Magic Start
// 0xE0 0x58 0x98 0xD8 0x1A - 00-0001-11.00011010.000110-01.00011011.01-011000 - Dark Magic Start
// 0xE0 0x58 0x98 0x9B 0x1A - 00-0001-11.00011010.000110-01.11011001.01-011000 - Ninjutsu Start
// 0xE0 0x58 0x98 0x18 0x1B - 00-0001-11.00011010.000110-01.00011000.11-011000 - Blue Magic Start
// 0xE0 0x58 0xD8 0xDC 0x1B - 00-0001-11.00011010.000110-11.00111011.11-011000 - Song Start

// 0xE0 0x1C 0xDC 0x1D 0x1A - 00-0001-11.00111000.001110-11.10111000.01-011000 - White Magic Interrupt
// 0xE0 0x1C 0x9C 0xD8 0x1A - 00-0001-11.00111000.001110-01.00011011.01-011000 - Dark Magic Interrupt
// 0xE0 0x1C 0x9C 0x9B 0x1A - 00-0001-11.00111000.001110-01.11011001.01-011000 - Ninjutsu Interrupt
// 0xE0 0x1C 0x9C 0x18 0x1B - 00-0001-11.00111000.001110-01.00011000.11-011000 - Blue Magic Interrupt
// 0xE0 0x1C 0xDC 0xDC 0x1B - 00-0001-11.00111000.001110-11.00111011.11-011000 - Song Interrupt

// 0xF0 0x58 0x18 0xDB 0x19 - 00-0011-11.00011010.000110-00.11011011.10-011000 - ACTION_RANGED_START
// 0xC8 0x1C 0x1A 0xDB 0x19 - 00-0100-11.00111000.010110-00.11011011.10-011000 - ACTION_RANGED_FINISH
// 0xF0 0x1C 0x1C 0xDB 0x19 - 00-0011-11.00111000.001110-00.11011011.10-011000 - ACTION_RANGED_INTERRUPT

// 0xE4 0x58 0x58 0x1A 0x1D - 00-1001-11.00011010.000110-10.01011000.10-111000 - ACTION_ITEM_START

// 0x44 0x18 0xDD 0x1A 0x0C - 00-1000-10.00011000.101110-11.01011000.00-110000 - ACTION_ATTACK
