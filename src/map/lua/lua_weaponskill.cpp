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

#include "common/lua.h"

#include "sol_bindings.h"

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

auto CLuaWeaponSkill::isSingle() -> bool
{
    return !m_PLuaWeaponSkill->isAoE();
}

auto CLuaWeaponSkill::isAoE() -> bool
{
    return m_PLuaWeaponSkill->isAoE();
}

auto CLuaWeaponSkill::getID() -> uint16
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

auto operator<<(std::ostream& os, const CLuaWeaponSkill& weaponskill) -> std::ostream&
{
    std::string id = weaponskill.m_PLuaWeaponSkill ? std::to_string(weaponskill.m_PLuaWeaponSkill->getID()) : "nullptr";
    return os << "CLuaWeaponSkill(" << id << ")";
}
