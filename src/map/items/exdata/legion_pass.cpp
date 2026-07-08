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

#include "legion_pass.h"

void Exdata::LegionPass::toTable(sol::table& table) const
{
    table["timestamp"] = this->Timestamp;
    table["title"]     = this->Title;
    table["signature"] = Exdata::decodeSignature(this->Signature);
}

void Exdata::LegionPass::fromTable(const sol::table& data)
{
    this->Timestamp = Exdata::get_or<uint32_t>(data, "timestamp", this->Timestamp);
    this->Title     = Exdata::get_or<uint32_t>(data, "title", this->Title);

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
