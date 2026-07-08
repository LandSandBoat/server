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

// Mezzotint augments (Delve, Geas Fete).
// 3 augment slots using client LUT indices (see xi.mezzotint.augment).

struct AugmentSlot
{
    uint8_t Index;
    uint8_t Value;
};

struct AugmentMezzotint
{
    AugmentKindFlags    AugmentKind;
    AugmentSubKindFlags AugmentSubKind;
    uint8_t             Type : 2;
    uint8_t             Rank : 5;
    uint8_t             padding00 : 1;
    uint8_t             padding01;
    uint16_t            AccumulatedRP;
    AugmentSlot         Augments[3];
    uint8_t             Signature[12];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
