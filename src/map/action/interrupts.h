/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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
#include "action.h"

class CSpell;
class CPetSkill;
class CBattleEntity;

// Helpers to build specific action packet interruption flows
// Baby chocobos will die if you make changes without a proper test with retail captures
namespace ActionInterrupts
{
void AbilityInterrupt(CBattleEntity* PEntity);

void AvatarOutOfRange(CBattleEntity* PAvatar, const CPetSkill* PSkill, const CBattleEntity* PTarget);
void WyvernOutOfRange(CBattleEntity* PWyvern, const CPetSkill* PSkill, const CBattleEntity* PTarget);
void WyvernSkillReady(CBattleEntity* PWyvern);

void MobSkillNoTargetInRange(CBattleEntity* PEntity);
void MobSkillOutOfRange(CBattleEntity* PEntity, const CBattleEntity* PTarget);

void WeaponSkillOutOfRange(CBattleEntity* PEntity, const CBattleEntity* PTarget);

void RangedInterrupt(CBattleEntity* PEntity);
void RangedParalyzed(CBattleEntity* PEntity);

void AttackParalyzed(CBattleEntity* PEntity, const CBattleEntity* PTarget);
void AttackIntimidated(CBattleEntity* PEntity, const CBattleEntity* PTarget);

void AbilityParalyzed(CBattleEntity* PEntity, const CBattleEntity* PTarget);

void ItemInterrupt(CBattleEntity* PEntity);
void ItemParalyzed(CBattleEntity* PEntity, const CBattleEntity* PTarget);
void ItemIntimidated(CBattleEntity* PEntity, const CBattleEntity* PTarget);

void MagicInterrupt(CBattleEntity* PEntity, CSpell* PSpell);
void MagicParalyzed(CBattleEntity* PEntity, CSpell* PSpell, const CBattleEntity* PTarget);
void MagicIntimidated(CBattleEntity* PEntity, CSpell* PSpell, const CBattleEntity* PTarget);
}; // namespace ActionInterrupts
