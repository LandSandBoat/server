/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "common/cbasetypes.h"

enum class JobPointCategory : uint16
{
    WAR = 0x020,
    MNK = 0x040,
    WHM = 0x060,
    BLM = 0x080,
    RDM = 0x0A0,
    THF = 0x0C0,
    PLD = 0x0E0,
    DRK = 0x100,
    BST = 0x120,
    BRD = 0x140,
    RNG = 0x160,
    SAM = 0x180,
    NIN = 0x1A0,
    DRG = 0x1C0,
    SMN = 0x1E0,
    BLU = 0x200,
    COR = 0x220,
    PUP = 0x240,
    DNC = 0x260,
    SCH = 0x280,
    GEO = 0x2A0,
    RUN = 0x2C0,
};

constexpr auto operator+(JobPointCategory cat, const uint16 offset) -> uint16
{
    return static_cast<uint16>(cat) + offset;
}
