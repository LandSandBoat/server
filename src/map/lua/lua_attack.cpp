/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "lua_attack.h"

#include "attack.h"

CLuaAttack::CLuaAttack(CAttack* attack)
: m_PLuaAttack(attack)
{
    if (m_PLuaAttack == nullptr)
    {
        ShowError("CLuaAttack created with nullptr instead of valid CAttack*!");
    }
}

CBattleEntity* CLuaAttack::getAttacker()
{
    return m_PLuaAttack->GetAttacker();
}

CBattleEntity* CLuaAttack::getVictim()
{
    return m_PLuaAttack->GetVictim(); 
}

CBattleEntity* CLuaAttack::getTAEntity()
{
    return m_PLuaAttack->GetTAEntity(); 
}

bool CLuaAttack::isH2H()
{
    return m_PLuaAttack->IsH2H(); 
}

uint8 CLuaAttack::getWeaponSlot()
{
    return m_PLuaAttack->GetWeaponSlot(); 
}

bool CLuaAttack::isFirstSwing() const
{
    return m_PLuaAttack->IsFirstSwing();
}

bool CLuaAttack::isSA() const
{
    return m_PLuaAttack->IsSA();
}

void CLuaAttack::setSA(bool val)
{
    m_PLuaAttack->SetSA(val);
}

bool CLuaAttack::isTA() const
{
    return m_PLuaAttack->IsTA();
}

void CLuaAttack::setTA(bool val)
{
    m_PLuaAttack->SetTA(val);
}

PHYSICAL_ATTACK_TYPE CLuaAttack::getAttackType() const
{
    return m_PLuaAttack->GetAttackType(); 
}

void CLuaAttack::setAttackType(PHYSICAL_ATTACK_TYPE type)
{
    return m_PLuaAttack->SetAttackType(type); 
}

float CLuaAttack::getDamageRatio() const
{
    return m_PLuaAttack->GetDamageRatio(); 
}

bool CLuaAttack::isCritical() const
{
    return m_PLuaAttack->IsCritical();
}

void CLuaAttack::setCritical(bool critical)
{
    m_PLuaAttack->SetCritical(critical);
}

//==========================================================//

void CLuaAttack::Register()
{
    SOL_USERTYPE("CAttack", CLuaAttack);
    
    SOL_REGISTER("getAttacker", CLuaAttack::getAttacker);
    SOL_REGISTER("getVictim", CLuaAttack::getVictim);
    SOL_REGISTER("getTAEntity", CLuaAttack::getTAEntity);
    
    SOL_REGISTER("isH2H", CLuaAttack::isH2H);
    SOL_REGISTER("getWeaponSlot", CLuaAttack::getWeaponSlot);
    SOL_REGISTER("isFirstSwing", CLuaAttack::isFirstSwing);

    SOL_REGISTER("isSA", CLuaAttack::isSA);
    SOL_REGISTER("setSA", CLuaAttack::setSA);

    SOL_REGISTER("isTA", CLuaAttack::isTA);
    SOL_REGISTER("setTA", CLuaAttack::setTA);

    SOL_REGISTER("getAttackType", CLuaAttack::getAttackType);
    SOL_REGISTER("setAttackType", CLuaAttack::setAttackType);

    SOL_REGISTER("getDamageRatio", CLuaAttack::getDamageRatio);

    SOL_REGISTER("isCritical", CLuaAttack::isCritical);
    SOL_REGISTER("setCritical", CLuaAttack::setCritical);
}

std::ostream& operator<<(std::ostream& os, const CLuaAttack& attack)
{
    // TODO: Whats a sane log value for this?
    std::string id = attack.m_PLuaAttack ? "" : "nullptr";
    return os << "CLuaAttack(" << id << ")";
}

//==========================================================//
