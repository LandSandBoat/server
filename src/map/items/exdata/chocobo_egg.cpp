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

#include "chocobo_egg.h"

#include "common/lua.h"

void Exdata::ChocoboEgg::toTable(sol::table& table) const
{
    sol::table dna = lua.create_table();
    dna[1]         = static_cast<uint32_t>(this->DNA1);
    dna[2]         = static_cast<uint32_t>(this->DNA2);
    dna[3]         = static_cast<uint32_t>(this->DNA3);
    table["dna"]   = dna;

    table["ability"] = static_cast<uint32_t>(this->Ability);
    table["plan"]    = static_cast<uint32_t>(this->Plan);
    table["isBred"]  = static_cast<bool>(this->IsBred);
}

void Exdata::ChocoboEgg::fromTable(const sol::table& data)
{
    if (sol::optional<sol::table> dna = data["dna"])
    {
        this->DNA1 = Exdata::get_or<uint32_t>(*dna, 1, this->DNA1);
        this->DNA2 = Exdata::get_or<uint32_t>(*dna, 2, this->DNA2);
        this->DNA3 = Exdata::get_or<uint32_t>(*dna, 3, this->DNA3);
    }

    this->Ability = Exdata::get_or<uint32_t>(data, "ability", this->Ability);
    this->Plan    = Exdata::get_or<uint32_t>(data, "plan", this->Plan);
    this->IsBred  = Exdata::get_or<bool>(data, "isBred", this->IsBred) ? 1 : 0;
}
