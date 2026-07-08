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

// Clears are packed as 3-bit counts in bytes 0-7: 5 expedition types x 4 levels = 60 bits used.
// Grimoires are zone-locked (Sauromugue or Batallia).
#pragma pack(push, 1)

struct MeebleGrimoire
{
    uint8_t Clears[8]; // 3-bit-per-level bitstream: 5 types x 4 levels = 60 bits
    uint8_t Count;     // Distinct expedition count
    uint8_t padding00[3];
    uint8_t Zone; // 0=Sauromugue, 1=Batallia
    uint8_t padding01[11];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
