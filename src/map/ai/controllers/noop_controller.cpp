/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include "noop_controller.h"

NoopController::NoopController(CBattleEntity* entity)
: CController(entity)
{
}

void NoopController::Tick(time_point tick)
{
}

void NoopController::Despawn()
{
}

void NoopController::Reset()
{
}

bool NoopController::Cast(uint16 targid, SpellID spellid)
{
    return false;
}

bool NoopController::Engage(uint16 targid)
{
    return false;
}

bool NoopController::ChangeTarget(uint16 targid)
{
    return false;
}

bool NoopController::Disengage()
{
    return false;
}

bool NoopController::WeaponSkill(uint16 targid, uint16 wsid)
{
    return false;
}

bool NoopController::Ability(uint16 targid, uint16 abilityid)
{
    return false;
}

bool NoopController::IsAutoAttackEnabled() const
{
    return false;
}

void NoopController::setAutoAttackEnabled(bool enabled)
{
}

bool NoopController::IsWeaponSkillEnabled() const
{
    return false;
}

void NoopController::SetWeaponSkillEnabled(bool enabled)
{
}

bool NoopController::IsMagicCastingEnabled() const
{
    return false;
}

void NoopController::setMagicCastingEnabled(bool enabled)
{
}
