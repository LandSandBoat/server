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

#include "controller.h"

#include "ai/ai_container.h"
#include "entities/battle_entity.h"

CController::CController(CBattleEntity* _POwner)
: m_Tick(timer::now())
, POwner(_POwner)
{
}

CController::~CController()
{
}

void CController::Despawn()
{
    if (POwner)
    {
        POwner->PAI->Internal_Despawn();
    }
}

void CController::Reset()
{
}

auto CController::Cast(const EntityId target, const SpellID spellid) -> bool
{
    if (POwner)
    {
        return POwner->PAI->Internal_Cast(target, spellid);
    }
    return false;
}

auto CController::Engage(const EntityId& target) -> bool
{
    if (POwner)
    {
        return POwner->PAI->Internal_Engage(target);
    }
    return false;
}

auto CController::ChangeTarget(const uint16 targid) -> bool
{
    if (POwner)
    {
        return POwner->PAI->Internal_ChangeTarget(targid);
    }
    return false;
}

auto CController::Disengage() -> bool
{
    if (POwner)
    {
        return POwner->PAI->Internal_Disengage();
    }
    return false;
}

auto CController::WeaponSkill(const EntityId target, const uint16 wsid) -> bool
{
    if (POwner)
    {
        return POwner->PAI->Internal_WeaponSkill(target, wsid);
    }
    return false;
}

auto CController::RangedAttack(const EntityId target) -> bool
{
    if (POwner)
    {
        return POwner->PAI->Internal_RangedAttack(target);
    }
    return false;
}

auto CController::Ability(EntityId target, uint16 abilityid) -> bool
{
    return false;
}

auto CController::IsAutoAttackEnabled() const -> bool
{
    return m_AutoAttackEnabled;
}

void CController::SetAutoAttackEnabled(const bool enabled)
{
    m_AutoAttackEnabled = enabled;
}

auto CController::IsRangedAttackEnabled() const -> bool
{
    return m_RangedAttackEnabled;
}

void CController::SetRangedAttackEnabled(const bool enabled)
{
    m_RangedAttackEnabled = enabled;
}

auto CController::IsWeaponSkillEnabled() const -> bool
{
    return m_WeaponSkillEnabled;
}

void CController::SetWeaponSkillEnabled(const bool enabled)
{
    m_WeaponSkillEnabled = enabled;
}

auto CController::IsMagicCastingEnabled() const -> bool
{
    return m_MagicCastingEnabled;
}

void CController::SetMagicCastingEnabled(const bool enabled)
{
    m_MagicCastingEnabled = enabled;
}
