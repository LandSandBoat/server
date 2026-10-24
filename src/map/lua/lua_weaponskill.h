/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Team

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

class CWeaponSkill;

class CLuaWeaponSkill
{
    CWeaponSkill* m_PLuaWeaponSkill;

public:
    CLuaWeaponSkill(CWeaponSkill*);

    auto GetWeaponSkill() const -> CWeaponSkill*
    {
        return m_PLuaWeaponSkill;
    }

    friend auto operator<<(std::ostream& out, const CLuaWeaponSkill& weaponskill) -> std::ostream&;

    auto getID() -> uint16;
    auto isAoE() -> bool;
    auto isSingle() -> bool;

    auto operator==(const CLuaWeaponSkill& other) const -> bool
    {
        return this->m_PLuaWeaponSkill == other.m_PLuaWeaponSkill;
    }

    static void Register();
};
