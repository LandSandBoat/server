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

struct Tabula
{
    uint32_t Voucher : 7;

    // 25-bit mask for the 5x5 grid. Bit 24 = pos 0, bit 0 = pos 24.
    // Set bits mark which grid positions have runes.
    // Runes in RuneStream are stored in the order the set bits appear (left to right, top to bottom).
    //
    //   +---+---+---+---+---+
    //   |   | A |   | B |   |  AnchorBits = 01010_00001_01000_00000_00100
    //   +---+---+---+---+---+               pos: 1,3,9,11,22
    //   |   |   |   |   | C |
    //   +---+---+---+---+---+  RuneStream slot 0 -> A (pos 1)
    //   |   | D |   |   |   |  RuneStream slot 1 -> B (pos 3)
    //   +---+---+---+---+---+  RuneStream slot 2 -> C (pos 9)
    //   |   |   |   |   |   |  RuneStream slot 3 -> D (pos 11)
    //   +---+---+---+---+---+  RuneStream slot 4 -> E (pos 22)
    //   |   |   | E |   |   |
    //   +---+---+---+---+---+
    //
    uint32_t AnchorBits : 25;

    // 160 bits: [12x 9-bit rune IDs][12x 2-bit rotations][7-bit uses (R Tabulas only)]
    uint8_t RuneStream[20];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
