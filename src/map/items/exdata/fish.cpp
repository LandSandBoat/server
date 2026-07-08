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

#include "fish.h"

void Exdata::Fish::toTable(sol::table& table) const
{
    table["size"]     = this->Size;
    table["weight"]   = this->Weight;
    table["isRanked"] = static_cast<bool>(this->IsRanked);
}

void Exdata::Fish::fromTable(const sol::table& data)
{
    this->Size   = Exdata::get_or<uint16_t>(data, "size", this->Size);
    this->Weight = Exdata::get_or<uint16_t>(data, "weight", this->Weight);

    this->IsRanked = Exdata::get_or<bool>(data, "isRanked", this->IsRanked) ? 1 : 0;
}
