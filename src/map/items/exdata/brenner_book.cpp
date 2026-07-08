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

#include "brenner_book.h"

void Exdata::BrennerBook::toTable(sol::table& table) const
{
    table["timeValue"] = this->TimeValue;
    table["level"]     = this->Level;
}

void Exdata::BrennerBook::fromTable(const sol::table& data)
{
    this->Mode      = 1; // Always Mode 1
    this->TimeValue = Exdata::get_or<uint32_t>(data, "timeValue", this->TimeValue);
    this->Level     = Exdata::get_or<uint32_t>(data, "level", this->Level);
}
