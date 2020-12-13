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

#include "../../common/showmsg.h"
#include "../../common/socket.h"
#include "../../common/utils.h"

#include <string.h>

#include "action.h"

#include "../entities/battleentity.h"
#include "../spell.h"
#include "../weapon_skill.h"
#include "../ability.h"
#include "../mobskill.h"
#include "../utils/battleutils.h"
#include "../items/item_weapon.h"

/************************************************************************
*																		*
*  ActionTargetID содержит ID цели, над которой производится действие,	*
*  Если над целью необходимо произвести несколько действий, то в		*
*  последующих структурах это поле оставляется пустым (равным нулю),	*
*  это говорит о том, что это действие над ранее указанной целью		*
*																		*
************************************************************************/

CActionPacket::CActionPacket(action_t& action)
{
    this->type = 0x28;
    this->size = 0x12;

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
        packBitsBE(data, action.actionid, 86, 10);
    }
    break;
    case ACTION_JOBABILITY_START:
    {

    }
    break;
    case ACTION_DANCE:
    case ACTION_JOBABILITY_FINISH:
    {
        packBitsBE(data, action.actionid, 86, 10);
        packBitsBE(data, action.recast, 118, 10);
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

        //higher number of bits than anything else that we know of. CAP OF 4095 (2300ish is abyssea tp moves)!
        packBitsBE(data, id, 86, 12);
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
        packBitsBE(data, action.actionid, 86, 16);
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
        ref<uint8>(0x0A) = 0xE0;
        ref<uint8>(0x0B) = 0x58;

        switch (action.spellgroup)
        {
        case SPELLGROUP_WHITE:
        {
            ref<uint8>(0x0C) = 0xD8;
            ref<uint8>(0x0D) = 0x1D;
            ref<uint8>(0x0E) = 0x1A;
        }
        break;
        case SPELLGROUP_BLACK:
        {
            ref<uint8>(0x0C) = 0x98;
            ref<uint8>(0x0D) = 0xD8;
            ref<uint8>(0x0E) = 0x1A;
        }
        break;
        case SPELLGROUP_BLUE:
        {
            ref<uint8>(0x0C) = 0x98;
            ref<uint8>(0x0D) = 0x18;
            ref<uint8>(0x0E) = 0x1B;
        }
        break;
        case SPELLGROUP_SONG:
        {
            ref<uint8>(0x0C) = 0xD8;
            ref<uint8>(0x0D) = 0xDC;
            ref<uint8>(0x0E) = 0x1B;
        }
        break;
        case SPELLGROUP_NINJUTSU:
        {
            ref<uint8>(0x0C) = 0x98;
            ref<uint8>(0x0D) = 0x9B;
            ref<uint8>(0x0E) = 0x1A;
        }
        break;
        case SPELLGROUP_SUMMONING:
        {
            ref<uint8>(0x0C) = 0xD8;
            ref<uint8>(0x0D) = 0x5C;
            ref<uint8>(0x0E) = 0x1B;
        }
        break;
        case SPELLGROUP_GEOMANCY:
        {
            ref<uint8>(0x0C) = 0xD8;
            ref<uint8>(0x0D) = 0x59;
            ref<uint8>(0x0E) = 0x19;
        }
        break;
        case SPELLGROUP_TRUST:
        {
            ref<uint8>(0x0C) = 0x98;
            ref<uint8>(0x0D) = 0x59;
            ref<uint8>(0x0E) = 0x18;
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
        packBitsBE(data, action.actionid, 86, 10);
        //either this way or enumerate all recast timers and compare the spell id.
        packBitsBE(data, action.recast, 118, 10);
    }
    break;
    case ACTION_MAGIC_INTERRUPT:
    {
        ref<uint8>(0x0A) = 0xE0;
        ref<uint8>(0x0B) = 0x1C;

        switch (action.spellgroup)
        {
        case SPELLGROUP_WHITE:
        {
            ref<uint8>(0x0C) = 0xDC;
            ref<uint8>(0x0D) = 0x1D;
            ref<uint8>(0x0E) = 0x1A;
        }
        break;
        case SPELLGROUP_BLACK:
        {
            ref<uint8>(0x0C) = 0x9C;
            ref<uint8>(0x0D) = 0xD8;
            ref<uint8>(0x0E) = 0x1A;
        }
        break;
        case SPELLGROUP_BLUE:
        {
            ref<uint8>(0x0C) = 0x9C;
            ref<uint8>(0x0D) = 0x18;
            ref<uint8>(0x0E) = 0x1B;
        }
        break;
        case SPELLGROUP_SONG:
        {
            ref<uint8>(0x0C) = 0xDC;
            ref<uint8>(0x0D) = 0xDC;
            ref<uint8>(0x0E) = 0x1B;
        }
        break;
        case SPELLGROUP_NINJUTSU:
        {
            ref<uint8>(0x0C) = 0x9C;
            ref<uint8>(0x0D) = 0x9B;
            ref<uint8>(0x0E) = 0x1A;
        }
        break;
        case SPELLGROUP_SUMMONING:
        {
            ref<uint8>(0x0C) = 0xDC;
            ref<uint8>(0x0D) = 0x5C;
            ref<uint8>(0x0E) = 0x1B;
        }
        break;
        case SPELLGROUP_GEOMANCY:
        {
            ref<uint8>(0x0C) = 0xDC;
            ref<uint8>(0x0D) = 0x59;
            ref<uint8>(0x0E) = 0x19;
        }
        break;
        case SPELLGROUP_TRUST:
        {
            ref<uint8>(0x0C) = 0x9C;
            ref<uint8>(0x0D) = 0x59;
            ref<uint8>(0x0E) = 0x18;
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

    uint32 bitOffset = packBitsBE(data, ActionType, 82, 4);
    auto targets = 0;
    auto actions = 0;

    bitOffset += 64;

    for (auto&& list : action.actionLists)
    {
        if (actions >= 8)
            break;
        bitOffset = packBitsBE(data, list.ActionTargetID, bitOffset, 32);
        bitOffset = packBitsBE(data, list.actionTargets.size(), bitOffset, 4);

        for (auto&& target : list.actionTargets)
        {
            bitOffset = packBitsBE(data, static_cast<uint64>(target.reaction), bitOffset, 5);				// Physical reaction to damage
            bitOffset = packBitsBE(data, target.animation, bitOffset, 12);	                                // анимация специальных эффектов (monster TP animations are 1800+)
            bitOffset = packBitsBE(data, static_cast<uint64>(target.speceffect), bitOffset, 7);			    // specialEffect
            bitOffset = packBitsBE(data, target.knockback, bitOffset, 3);                                   // knockback amount (mobskill only)
            bitOffset = packBitsBE(data, target.param, bitOffset, 17);					                    // параметр сообщения (урон)
            bitOffset = packBitsBE(data, target.messageID, bitOffset, 10);				                    // сообщение
            bitOffset += 31;


            if (target.additionalEffect != SUBEFFECT_NONE)
            {
                bitOffset = packBitsBE(data, 1, bitOffset, 1);
                bitOffset = packBitsBE(data, target.additionalEffect, bitOffset, 10);
                bitOffset = packBitsBE(data, target.addEffectParam, bitOffset, 17);
                bitOffset = packBitsBE(data, target.addEffectMessage, bitOffset, 10);
            }
            else
            {
                bitOffset += 1;
            }
            if (target.spikesEffect != SUBEFFECT_NONE)
            {
                bitOffset = packBitsBE(data, 1, bitOffset, 1);
                bitOffset = packBitsBE(data, target.spikesEffect, bitOffset, 10);
                bitOffset = packBitsBE(data, target.spikesParam, bitOffset, 14);
                bitOffset = packBitsBE(data, target.spikesMessage, bitOffset, 10);
            }
            else
            {
                bitOffset += 1;
            }
            if (++actions >= 8)
                break;
        }
        ++targets;
    }
    ref<uint8>(0x09) = targets;
    uint8 WorkSize = ((bitOffset >> 3) + (bitOffset % 8 != 0));

    this->size = ((((WorkSize + 7) >> 1) + 1) & -2);

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
//									 -11.00111000.001110- ActionInterrupt
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
