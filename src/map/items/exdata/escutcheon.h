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

#pragma once

#include "base.h"

#include "enums/exdata.h"

namespace Exdata
{

#pragma pack(push, 1)

struct Escutcheon
{
    AugmentKindFlags    AugmentKind;
    AugmentSubKindFlags AugmentSubKind;
    uint16_t            padding00;
    uint8_t             Status;                  // 0 = no craftsmanship data. TODO: unreversed, values 3/4/8 observed
    uint8_t             BonusObjective;          // Bonus objective granting extra Craftsmanship
    uint16_t            Craftsmanship;           // Raw craftsmanship value, each tier has a different cap
    uint32_t            Stage : 4;               // Upgrade stage (1=Aspis, 2=Ecu, 3=Scutum, 4=Shield)
    uint32_t            SuccessDownPenalty : 16; // Accumulated penalty. Scutum only. Client rate = (value-128)/3, capped -30. Unused for other tiers.
    uint32_t            padding01 : 12;
    uint8_t             Signature[12];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
