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

#include "augment_mezzotint.h"

#include "common/lua.h"

void Exdata::AugmentMezzotint::toTable(sol::table& table) const
{
    table["augmentKind"]    = static_cast<uint8_t>(this->AugmentKind);
    table["augmentSubKind"] = static_cast<uint8_t>(this->AugmentSubKind);
    table["type"]           = static_cast<uint8_t>(this->Type);
    table["rank"]           = static_cast<uint8_t>(this->Rank);
    table["accumulatedRP"]  = this->AccumulatedRP;

    sol::table augments = lua.create_table();
    for (size_t i = 0; i < std::size(this->Augments); ++i)
    {
        sol::table aug  = lua.create_table();
        aug["index"]    = this->Augments[i].Index;
        aug["value"]    = this->Augments[i].Value;
        augments[i + 1] = aug;
    }
    table["augments"]  = augments;
    table["signature"] = Exdata::decodeSignature(this->Signature);
}

void Exdata::AugmentMezzotint::fromTable(const sol::table& data)
{
    this->AugmentKind    = Exdata::get_or<AugmentKindFlags>(data, "augmentKind", this->AugmentKind);
    this->AugmentSubKind = Exdata::get_or<AugmentSubKindFlags>(data, "augmentSubKind", this->AugmentSubKind);
    this->Type           = Exdata::get_or<uint8_t>(data, "type", this->Type);
    this->Rank           = Exdata::get_or<uint8_t>(data, "rank", this->Rank);
    this->AccumulatedRP  = Exdata::get_or<uint16_t>(data, "accumulatedRP", this->AccumulatedRP);

    if (sol::optional<sol::table> augments = data["augments"])
    {
        for (size_t i = 0; i < std::size(this->Augments); ++i)
        {
            if (sol::optional<sol::table> entry = (*augments)[i + 1])
            {
                this->Augments[i].Index = Exdata::get_or<uint8_t>(*entry, "index", this->Augments[i].Index);
                this->Augments[i].Value = Exdata::get_or<uint8_t>(*entry, "value", this->Augments[i].Value);
            }
        }
    }

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
