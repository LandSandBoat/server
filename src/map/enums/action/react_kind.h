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

// result.react_kind in BATTLE2 packet (6 bits)
enum class ActionReactKind : uint8_t
{
    None           = 0,
    BlazeSpikes    = 1,  // 000001
    IceSpikes      = 2,  // 000010
    DreadSpikes    = 3,  // 000011
    CurseSpikes    = 4,  // 000100
    ShockSpikes    = 5,  // 000101
    ReprisalSpikes = 6,  // 000110
    WindSpikes     = 7,  // 000111
    EarthSpikes    = 8,  // 001000
    WaterSpikes    = 9,  // 001001
    DeathSpikes    = 10, // 001010
    Counter        = 63, // 111111 - Also used by Retaliation
};
