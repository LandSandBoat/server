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

#pragma once

#include <iosfwd>

class CAttack;

class CLuaAttack
{
    CAttack* m_PLuaAttack;

public:
    CLuaAttack(CAttack*);

    auto GetAttack() const -> CAttack*
    {
        return m_PLuaAttack;
    }

    auto isCritical() const -> bool;
    void setCritical(bool critical);

    friend auto operator<<(std::ostream& out, const CLuaAttack& action) -> std::ostream&;

    auto operator==(const CLuaAttack& other) const -> bool
    {
        return this->m_PLuaAttack == other.m_PLuaAttack;
    }

    static void Register();
};
