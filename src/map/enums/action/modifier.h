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

// result.bit (31 bits)
enum class ActionModifier : uint32_t
{
    None        = 0x00,
    Cover       = 0x01,
    Resist      = 0x02,
    MagicBurst  = 0x04, // Currently known to be used for Swipe/Lunge only
    Immunobreak = 0x08,
    CriticalHit = 0x10,
};
