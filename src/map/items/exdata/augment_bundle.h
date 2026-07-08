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

// Bundled augments (Odyssey, JSE necks, Unity belts).
// Augments referenced by DAT table index (see xi.data.augments.bundles).
// MaxRankTier (2 bits): 0=15, 1=20, 2=25, 3=30.
// RPCurve selects the RP-per-rank table (see xi.data.augments.rpCurves).
struct AugmentBundle
{
    AugmentKindFlags    AugmentKind;
    AugmentSubKindFlags AugmentSubKind;
    uint16_t            padding00{};
    uint32_t            Type : 2;
    uint32_t            AccumulatedRP : 16;
    uint32_t            Rank : 5;
    uint32_t            MaxRankTier : 2;
    uint32_t            padding01 : 1;
    uint32_t            RPCurve : 2; // RP per rank client table
    uint32_t            padding02 : 4;
    uint32_t            AugmentIndex;
    uint8_t             Signature[12];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
