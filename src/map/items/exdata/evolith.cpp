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

#include "evolith.h"

void Exdata::Evolith::toTable(sol::table& table) const
{
    table["augment"]   = static_cast<uint32_t>(this->Augment);
    table["shape"]     = static_cast<uint32_t>(this->Shape);
    table["element"]   = static_cast<uint32_t>(this->Element);
    table["bonus"]     = static_cast<uint32_t>(this->Bonus);
    table["signature"] = Exdata::decodeSignature(this->Signature);
}

void Exdata::Evolith::fromTable(const sol::table& data)
{
    this->Augment = Exdata::get_or<uint32_t>(data, "augment", this->Augment);
    this->Shape   = Exdata::get_or<uint32_t>(data, "shape", this->Shape);
    this->Element = Exdata::get_or<uint32_t>(data, "element", this->Element);
    this->Bonus   = Exdata::get_or<uint32_t>(data, "bonus", this->Bonus);

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
