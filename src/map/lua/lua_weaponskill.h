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
#include "luautils.h"

class CWeaponSkill;

class CLuaWeaponSkill
{
    CWeaponSkill* m_PLuaWeaponSkill;

public:
    CLuaWeaponSkill(CWeaponSkill*);

    CWeaponSkill* GetWeaponSkill() const
    {
        return m_PLuaWeaponSkill;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaWeaponSkill& weaponskill);

    uint16 getID();
    bool   isAoE();
    bool   isSingle();

    bool operator==(const CLuaWeaponSkill& other) const
    {
        return this->m_PLuaWeaponSkill == other.m_PLuaWeaponSkill;
    }

    static void Register();
};
