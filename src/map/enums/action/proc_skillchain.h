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

#include "common/logging.h"

#include <cstdint>

// result.proc_kind (6 bits)
enum class ActionProcSkillChain : uint8_t
{
    None          = 0,  // 000000
    Light         = 1,  // 000001
    Darkness      = 2,  // 000010
    Gravitation   = 3,  // 000011
    Fragmentation = 4,  // 000100
    Distortion    = 5,  // 000101
    Fusion        = 6,  // 000110
    Compression   = 7,  // 000111
    Liquefaction  = 8,  // 001000
    Induration    = 9,  // 001001
    Reverberation = 10, // 001010
    Transfixion   = 11, // 001011
    Scission      = 12, // 001100
    Detonation    = 13, // 001101
    Impaction     = 14, // 001110
    Radiance      = 15, // 001111
    Umbra         = 16, // 010000
};
