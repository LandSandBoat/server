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

#ifndef _BLUEUTILS_H
#define _BLUEUTILS_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include "entities/charentity.h"
#include "entities/mobentity.h"

#include "blue_spell.h"
#include "spell.h"

namespace blueutils
{
    void  SetBlueSpell(CCharEntity* PChar, CBlueSpell* PSpell, uint8 slotIndex, bool addingSpell);
    bool  HasEnoughSetPoints(CCharEntity* PChar, CBlueSpell* PSpellToAdd, uint8 slotToPut);
    void  TryLearningSpells(CCharEntity* PChar, CMobEntity* PMob);
    void  UnequipAllBlueSpells(CCharEntity* PChar);
    bool  IsSpellSet(CCharEntity* PChar, CBlueSpell* PSpell);
    void  CompactSpells(CCharEntity* PChar);
    void  CheckSpellLevels(CCharEntity* PChar);
    uint8 GetTotalSlots(CCharEntity* PChar);
    uint8 GetTotalBlueMagicPoints(CCharEntity* PChar);
    void  SaveSetSpells(CCharEntity* PChar);
    void  LoadSetSpells(CCharEntity* PChar);
    void  ValidateBlueSpells(CCharEntity* PChar);
    void  CalculateTraits(CCharEntity* PChar);
}; // namespace blueutils

#endif
