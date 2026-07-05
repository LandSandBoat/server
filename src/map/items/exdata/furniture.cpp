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

#include "furniture.h"

void Exdata::Furniture::toTable(sol::table& table) const
{
    table["on2ndFloor"] = static_cast<bool>(this->On2ndFloor);
    table["installed"]  = static_cast<bool>(this->Installed);
    table["x"]          = this->X;
    table["z"]          = this->Z;
    table["y"]          = this->Y;
    table["rotation"]   = this->Rotation;
    table["signature"]  = Exdata::decodeSignature(this->Signature);
}

void Exdata::Furniture::fromTable(const sol::table& data)
{
    this->On2ndFloor = Exdata::get_or<bool>(data, "on2ndFloor", this->On2ndFloor) ? 1 : 0;
    this->Installed  = Exdata::get_or<bool>(data, "installed", this->Installed) ? 1 : 0;
    this->X          = Exdata::get_or<uint8_t>(data, "x", this->X);
    this->Z          = Exdata::get_or<uint8_t>(data, "z", this->Z);
    this->Y          = Exdata::get_or<uint8_t>(data, "y", this->Y);
    this->Rotation   = Exdata::get_or<uint8_t>(data, "rotation", this->Rotation);

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
