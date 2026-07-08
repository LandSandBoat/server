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

#include <cstdint>

// action.cmd_no
// 4 bits
enum class ActionCategory : uint8_t
{
    None           = 0,  // 0000
    BasicAttack    = 1,  // 0001
    RangedFinish   = 2,  // 0010
    SkillFinish    = 3,  // 0011
    MagicFinish    = 4,  // 0100
    ItemFinish     = 5,  // 0101
    AbilityFinish  = 6,  // 0110
    SkillStart     = 7,  // 0111
    MagicStart     = 8,  // 1000
    ItemStart      = 9,  // 1001
    AbilityStart   = 10, // 1010
    MobSkillFinish = 11, // 1011
    RangedStart    = 12, // 1100
    PetSkillFinish = 13, // 1101
    Dancer         = 14, // 1110
    RuneFencer     = 15, // 1111
};
