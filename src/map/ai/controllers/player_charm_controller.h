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

#include "player_controller.h"

class CCharEntity;

class CPlayerCharmController : public CPlayerController
{
public:
    CPlayerCharmController(CCharEntity*);
    ~CPlayerCharmController() override;

    auto Tick(timer::time_point tick) -> Task<void> override;
    auto Cast(EntityId target, SpellID spellid) -> bool override;
    auto ChangeTarget(uint16 targid) -> bool override;
    auto WeaponSkill(EntityId target, uint16 wsid) -> bool override;
    auto Ability(EntityId target, uint16 abilityid) -> bool override;
    auto RangedAttack(EntityId target) -> bool override;

private:
    static constexpr float RoamDistance{ 2.1f };
    void                   DoCombatTick(timer::time_point tick) const;
    void                   DoRoamTick(timer::time_point tick) const;
};
