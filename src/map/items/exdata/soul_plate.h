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

namespace Exdata
{
#pragma pack(push, 1)
struct SoulPlate
{
    uint8_t  Signature[14]; // Retail: 18 bytes
    uint16_t ZoneId;        // Retail: does not exist
    uint16_t SuperFamilyId; // Retail: does not exist
    uint16_t PoolId;        // Retail: Stores ID similar to pool IDs in LSB
    uint32_t Level : 7;
    uint32_t FeralSkill : 12;
    uint32_t FeralPoints : 7;
    uint32_t Quality : 6; // Zeni score

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};
#pragma pack(pop)
} // namespace Exdata
