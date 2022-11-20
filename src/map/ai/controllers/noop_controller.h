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

#ifndef SERVER_NOOP_CONTROLLER_H
#define SERVER_NOOP_CONTROLLER_H

#include "../../entities/battleentity.h"
#include "../common/cbasetypes.h"
#include "../map/spell.h"

#include "controller.h"

/**
 * NoopController is an implementation of CController that
 * does nothing in each of its methods. This can be useful when
 * intending to disable the AI Controller for an entity.
 * i.e: When someone is jailed.
 */
class NoopController : public CController
{
public:
    NoopController(CBattleEntity* entity);
    void Tick(time_point tick);
    void Despawn();
    void Reset();
    bool Cast(uint16 targid, SpellID spellid);
    bool Engage(uint16 targid);
    bool ChangeTarget(uint16 targid);
    bool Disengage();
    bool WeaponSkill(uint16 targid, uint16 wsid);
    bool Ability(uint16 targid, uint16 abilityid);
    bool IsAutoAttackEnabled() const;
    void setAutoAttackEnabled(bool enabled);
    bool IsWeaponSkillEnabled() const;
    void SetWeaponSkillEnabled(bool enabled);
    bool IsMagicCastingEnabled() const;
    void setMagicCastingEnabled(bool enabled);
    bool canUpdate{ false };
};

#endif // SERVER_NOOP_CONTROLLER_H
