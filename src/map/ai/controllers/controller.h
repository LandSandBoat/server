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
#include "common/mmo.h"
#include "common/scheduler.h"
#include "common/timer.h"
#include "spell.h"

class CBattleEntity;

class CController
{
public:
    using IgnoreRecastsAndCosts = xi::Flag<struct IgnoreRecastsAndCostsTag>;

    CController(CBattleEntity* _POwner);

    virtual ~CController();

    virtual auto Tick(timer::time_point tick) -> Task<void> = 0;
    virtual void Despawn();
    virtual void Reset();
    virtual auto Cast(uint16 targid, SpellID spellid) -> bool;
    virtual auto Engage(uint16 targid) -> bool;
    virtual auto ChangeTarget(uint16 targid) -> bool;
    virtual auto Disengage() -> bool;
    virtual auto WeaponSkill(uint16 targid, uint16 wsid) -> bool;
    virtual auto RangedAttack(uint16 targid) -> bool;

    virtual auto Ability(uint16 targid, uint16 abilityid) -> bool;

    auto IsAutoAttackEnabled() const -> bool;
    void SetAutoAttackEnabled(bool);
    auto IsRangedAttackEnabled() const -> bool;
    void SetRangedAttackEnabled(bool);
    auto IsWeaponSkillEnabled() const -> bool;
    void SetWeaponSkillEnabled(bool);
    auto IsMagicCastingEnabled() const -> bool;
    void SetMagicCastingEnabled(bool);

    bool canUpdate{ true };

protected:
    timer::time_point m_Tick;
    CBattleEntity*    POwner;
    bool              m_AutoAttackEnabled{ true };
    bool              m_RangedAttackEnabled{ false };
    bool              m_WeaponSkillEnabled{ true };
    bool              m_MagicCastingEnabled{ true };
};
