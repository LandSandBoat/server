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
#include "entities/battleentity.h"

CController::CController(CBattleEntity* _POwner)
: m_Tick(server_clock::now())
, POwner(_POwner)
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

bool CController::Cast(uint16 targid, SpellID spellid)
{
    if (POwner)
    {
        return POwner->PAI->Internal_Cast(targid, spellid);
    }
    return false;
}

bool CController::Engage(uint16 targid)
{
    if (POwner)
    {
        return POwner->PAI->Internal_Engage(targid);
    }
    return false;
}

bool CController::ChangeTarget(uint16 targid)
{
    if (POwner)
    {
        return POwner->PAI->Internal_ChangeTarget(targid);
    }
    return false;
}

bool CController::Disengage()
{
    if (POwner)
    {
        return POwner->PAI->Internal_Disengage();
    }
    return false;
}

bool CController::WeaponSkill(uint16 targid, uint16 wsid)
{
    if (POwner)
    {
        return POwner->PAI->Internal_WeaponSkill(targid, wsid);
    }
    return false;
}

bool CController::IsAutoAttackEnabled() const
{
    return m_AutoAttackEnabled;
}

void CController::SetAutoAttackEnabled(bool enabled)
{
    m_AutoAttackEnabled = enabled;
}

bool CController::IsWeaponSkillEnabled() const
{
    return m_WeaponSkillEnabled;
}

void CController::SetWeaponSkillEnabled(bool enabled)
{
    m_WeaponSkillEnabled = enabled;
}

bool CController::IsMagicCastingEnabled() const
{
    return m_MagicCastingEnabled;
}

void CController::SetMagicCastingEnabled(bool enabled)
{
    m_MagicCastingEnabled = enabled;
}
