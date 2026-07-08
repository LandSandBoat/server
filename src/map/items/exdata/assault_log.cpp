/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "assault_log.h"

#include "common/lua.h"

void Exdata::AssaultLog::toTable(sol::table& table) const
{
    sol::table flags = lua.create_table();
    flags[1]         = static_cast<bool>(this->Flag1);
    flags[2]         = static_cast<bool>(this->Flag2);
    flags[3]         = static_cast<bool>(this->Flag3);
    flags[4]         = static_cast<bool>(this->Flag4);
    flags[5]         = static_cast<bool>(this->Flag5);
    flags[6]         = static_cast<bool>(this->Flag6);
    flags[7]         = static_cast<bool>(this->Flag7);
    flags[8]         = static_cast<bool>(this->Flag8);
    flags[9]         = static_cast<bool>(this->Flag9);
    flags[10]        = static_cast<bool>(this->Flag10);
    table["flags"]   = flags;
}

void Exdata::AssaultLog::fromTable(const sol::table& data)
{
    if (sol::optional<sol::table> flags = data["flags"])
    {
        auto& f      = *flags;
        this->Flag1  = Exdata::get_or<bool>(f[1], this->Flag1);
        this->Flag2  = Exdata::get_or<bool>(f[2], this->Flag2);
        this->Flag3  = Exdata::get_or<bool>(f[3], this->Flag3);
        this->Flag4  = Exdata::get_or<bool>(f[4], this->Flag4);
        this->Flag5  = Exdata::get_or<bool>(f[5], this->Flag5);
        this->Flag6  = Exdata::get_or<bool>(f[6], this->Flag6);
        this->Flag7  = Exdata::get_or<bool>(f[7], this->Flag7);
        this->Flag8  = Exdata::get_or<bool>(f[8], this->Flag8);
        this->Flag9  = Exdata::get_or<bool>(f[9], this->Flag9);
        this->Flag10 = Exdata::get_or<bool>(f[10], this->Flag10);
    }
}
