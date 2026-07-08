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

#include "timer_info.h"

void Exdata::ItemTimerInfo::toTable(sol::table& table) const
{
    table["remainingCharges"] = this->RemainingCharges;
    table["flags"]            = this->Flags;
    table["timeValue1"]       = this->TimeValue1;
    table["timeValue2"]       = this->TimeValue2;
    table["signature"]        = Exdata::decodeSignature(this->Signature);
}

void Exdata::ItemTimerInfo::fromTable(const sol::table& data)
{
    this->Header           = 1; // Must be 1 for client to recognize timer data
    this->RemainingCharges = Exdata::get_or<uint8_t>(data, "remainingCharges", this->RemainingCharges);
    this->Flags            = Exdata::get_or<uint16_t>(data, "flags", this->Flags);
    this->TimeValue1       = Exdata::get_or<uint32_t>(data, "timeValue1", this->TimeValue1);
    this->TimeValue2       = Exdata::get_or<uint32_t>(data, "timeValue2", this->TimeValue2);

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
