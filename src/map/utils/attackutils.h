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

#ifndef _ATTACKUTILS_H
#define _ATTACKUTILS_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include "entities/charentity.h"
#include "entities/mobentity.h"

enum class PHYSICAL_ATTACK_TYPE;

namespace attackutils
{
    uint8  getHitCount(uint8 hits); // The multihit calculator.
    uint32 CheckForDamageMultiplier(CCharEntity* PChar, CItemWeapon* PWeapon, uint32 damage, PHYSICAL_ATTACK_TYPE attackType, uint8 weapnSlot);

    bool IsParried(CBattleEntity* PAttacker, CBattleEntity* PDefender); // Is the attack parried.
    bool IsGuarded(CBattleEntity* PAttacker, CBattleEntity* PDefender); // Is the attack guarded.
    bool IsBlocked(CBattleEntity* PAttacker, CBattleEntity* PDefender); // Is the attack blocked.
};                                                                      // namespace attackutils

#endif
