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

#include "lottery_ticket.h"

void Exdata::LotteryTicket::toTable(sol::table& table) const
{
    table["number"] = static_cast<uint32_t>(this->Number);
    table["title"]  = static_cast<uint8_t>(this->Title);
}

void Exdata::LotteryTicket::fromTable(const sol::table& data)
{
    this->Number = Exdata::get_or<uint32_t>(data, "number", this->Number);
    this->Title  = Exdata::get_or<uint32_t>(data, "title", this->Title);
}
