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

#include "augment_bundle.h"

void Exdata::AugmentBundle::toTable(sol::table& table) const
{
    table["augmentKind"]    = static_cast<uint8_t>(this->AugmentKind);
    table["augmentSubKind"] = static_cast<uint8_t>(this->AugmentSubKind);
    table["type"]           = static_cast<uint32_t>(this->Type);
    table["rank"]           = static_cast<uint32_t>(this->Rank);
    table["accumulatedRP"]  = static_cast<uint32_t>(this->AccumulatedRP);
    table["maxRankTier"]    = static_cast<uint32_t>(this->MaxRankTier);
    table["rpCurve"]        = static_cast<uint32_t>(this->RPCurve);
    table["augmentIndex"]   = this->AugmentIndex;
    table["signature"]      = Exdata::decodeSignature(this->Signature);
}

void Exdata::AugmentBundle::fromTable(const sol::table& data)
{
    this->AugmentKind    = AugmentKindFlags::Bundled;
    this->AugmentSubKind = AugmentSubKindFlags::Standard | AugmentSubKindFlags::Evolith;
    this->Type           = Exdata::get_or<uint32_t>(data, "type", this->Type);
    this->Rank           = Exdata::get_or<uint32_t>(data, "rank", this->Rank);
    this->AccumulatedRP  = Exdata::get_or<uint32_t>(data, "accumulatedRP", this->AccumulatedRP);
    this->MaxRankTier    = Exdata::get_or<uint32_t>(data, "maxRankTier", this->MaxRankTier);
    this->RPCurve        = Exdata::get_or<uint32_t>(data, "rpCurve", this->RPCurve);
    this->AugmentIndex   = Exdata::get_or<uint32_t>(data, "augmentIndex", this->AugmentIndex);

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
