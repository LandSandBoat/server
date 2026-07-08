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

#include "serialized.h"

void Exdata::Serialized::toTable(sol::table& table) const
{
    table["augmentKind"]    = static_cast<uint8_t>(this->AugmentKind);
    table["augmentSubKind"] = static_cast<uint8_t>(this->AugmentSubKind);
    table["serverIndex"]    = this->ServerIndex;
    table["serialNumber"]   = this->SerialNumber;
    table["signature"]      = Exdata::decodeSignature(this->Signature);
}

void Exdata::Serialized::fromTable(const sol::table& data)
{
    this->AugmentKind    = AugmentKindFlags::HasAugments;
    this->AugmentSubKind = AugmentSubKindFlags::Serialized;
    this->ServerIndex    = Exdata::get_or<uint8_t>(data, "serverIndex", this->ServerIndex);
    this->SerialNumber   = Exdata::get_or<uint16_t>(data, "serialNumber", this->SerialNumber);

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
