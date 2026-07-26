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

#include "controller.h"

class CCharEntity;
class CWeaponSkill;

class CPlayerController : public CController
{
public:
    CPlayerController(CCharEntity*);

    virtual ~CPlayerController();

    auto Tick(timer::time_point tick) -> Task<void> override;
    auto Cast(EntityId target, SpellID spellid) -> bool override;
    auto Engage(uint16 targid) -> bool override;
    auto ChangeTarget(uint16 targid) -> bool override;
    auto Disengage() -> bool override;
    auto WeaponSkill(EntityId target, uint16 wsid) -> bool override;
    auto Ability(EntityId target, uint16 abilityid) -> bool override;
    auto RangedAttack(EntityId target) -> bool override;
    auto UseItem(const EntityId& target, uint8 loc, uint8 slotid) -> bool;

    auto getLastAttackTime() -> timer::time_point;
    void setLastAttackTime(timer::time_point);

    auto getLastSpellFinishedTime() -> timer::time_point;
    void setLastSpellFinishedTime(timer::time_point);

    void setLastErrMsgTime(timer::time_point);
    auto getLastErrMsgTime() -> timer::time_point;

    auto getLastWeaponSkill() -> CWeaponSkill*;

    auto canAct() -> bool;

protected:
    timer::time_point m_lastAttackTime{ timer::now() };
    timer::time_point m_spellFinishedTime{ timer::now() };
    timer::time_point m_errMsgTime{ timer::now() };
    CWeaponSkill*     m_lastWeaponSkill{ nullptr };
};
