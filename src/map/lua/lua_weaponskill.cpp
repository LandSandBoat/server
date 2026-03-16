/*
===========================================================================

  opyright (c) 2026 LandSandBoat Dev Team

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

#include "common/logging.h"

#include "lua_weaponskill.h"
#include "weapon_skill.h"

CLuaWeaponSkill::CLuaWeaponSkill(CWeaponSkill* PSkill)
: m_PLuaWeaponSkill(PSkill)
{
    if (PSkill == nullptr)
    {
        ShowError("CLuaWeaponSkill created with nullptr instead of valid CWeaponSkill*!");
    }
}

bool CLuaWeaponSkill::isSingle()
{
    return !m_PLuaWeaponSkill->isAoE();
}

bool CLuaWeaponSkill::isAoE()
{
    return m_PLuaWeaponSkill->isAoE();
}

uint16 CLuaWeaponSkill::getID()
{
    return m_PLuaWeaponSkill->getID();
}

void CLuaWeaponSkill::Register()
{
    SOL_USERTYPE("CWeaponSkill", CLuaWeaponSkill);
    SOL_REGISTER("isAoE", CLuaWeaponSkill::isAoE);
    SOL_REGISTER("isSingle", CLuaWeaponSkill::isSingle);
    SOL_REGISTER("getID", CLuaWeaponSkill::getID);
}

std::ostream& operator<<(std::ostream& os, const CLuaWeaponSkill& weaponskill)
{
    std::string id = weaponskill.m_PLuaWeaponSkill ? std::to_string(weaponskill.m_PLuaWeaponSkill->getID()) : "nullptr";
    return os << "CLuaWeaponSkill(" << id << ")";
}
