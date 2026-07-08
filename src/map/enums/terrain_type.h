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

#include "common/cbasetypes.h"

enum class TerrainType : uint8
{
    Object       = 0,
    Path         = 1,
    Grass        = 2,
    Sand         = 3,
    Snow         = 4,
    Stone        = 5,
    Metal        = 6,
    Wood         = 7,
    ShallowWater = 8,
    DeepWater    = 9,
    Unknown      = 10,
    None         = 0xFF,
};
