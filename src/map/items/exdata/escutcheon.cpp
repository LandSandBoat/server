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

#include "escutcheon.h"

void Exdata::Escutcheon::toTable(sol::table& table) const
{
    table["status"]             = this->Status;
    table["bonusObjective"]     = this->BonusObjective;
    table["craftsmanship"]      = this->Craftsmanship;
    table["stage"]              = static_cast<uint32_t>(this->Stage);
    table["successDownPenalty"] = static_cast<uint32_t>(this->SuccessDownPenalty);
    table["signature"]          = Exdata::decodeSignature(this->Signature);
}

void Exdata::Escutcheon::fromTable(const sol::table& data)
{
    this->AugmentKind        = AugmentKindFlags::HasAugments;
    this->AugmentSubKind     = AugmentSubKindFlags::Escutcheon | AugmentSubKindFlags::Standard;
    this->Status             = Exdata::get_or<uint8_t>(data, "status", this->Status);
    this->BonusObjective     = Exdata::get_or<uint8_t>(data, "bonusObjective", this->BonusObjective);
    this->Craftsmanship      = Exdata::get_or<uint16_t>(data, "craftsmanship", this->Craftsmanship);
    this->Stage              = Exdata::get_or<uint32_t>(data, "stage", this->Stage);
    this->SuccessDownPenalty = Exdata::get_or<uint32_t>(data, "successDownPenalty", this->SuccessDownPenalty);

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
