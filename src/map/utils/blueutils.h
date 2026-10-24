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

#pragma once

#include "common/cbasetypes.h"

#include "entities/char_entity.h"
#include "entities/mob_entity.h"

#include "blue_spell.h"
#include "spell.h"

namespace blueutils
{

void SetBlueSpell(CCharEntity* PChar, CBlueSpell* PSpell, uint8 slotIndex, bool addingSpell);
auto HasEnoughSetPoints(CCharEntity* PChar, CBlueSpell* PSpellToAdd, uint8 slotToPut) -> bool;
void TryLearningSpells(CCharEntity* PChar, CMobEntity* PMob);
void UnequipAllBlueSpells(CCharEntity* PChar);
auto IsSpellSet(CCharEntity* PChar, CBlueSpell* PSpell) -> bool;
void CompactSpells(CCharEntity* PChar);
void CheckSpellLevels(CCharEntity* PChar);
auto GetTotalSlots(CCharEntity* PChar) -> uint8;
auto GetTotalBlueMagicPoints(CCharEntity* PChar) -> uint8;
void SaveSetSpells(CCharEntity* PChar);
void LoadSetSpells(CCharEntity* PChar);
void ValidateBlueSpells(CCharEntity* PChar);
void CalculateTraits(CCharEntity* PChar);

}; // namespace blueutils
