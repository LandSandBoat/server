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

#include "perpetual_hourglass.h"

void Exdata::PerpetualHourglass::toTable(sol::table& table) const
{
    table["flags"]     = this->Flags;
    table["startTime"] = this->StartTime;
    table["endTime"]   = this->EndTime;
    table["zoneId"]    = this->ZoneId;
}

void Exdata::PerpetualHourglass::fromTable(const sol::table& data)
{
    this->Flags     = Exdata::get_or<uint8_t>(data, "flags", this->Flags);
    this->StartTime = Exdata::get_or<uint32_t>(data, "startTime", this->StartTime);
    this->EndTime   = Exdata::get_or<uint32_t>(data, "endTime", this->EndTime);
    this->ZoneId    = Exdata::get_or<uint16_t>(data, "zoneId", this->ZoneId);
}
