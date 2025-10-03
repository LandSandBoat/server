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

enum class Weather : uint16_t
{
    None          = 0,
    Sunshine      = 1,
    Clouds        = 2,
    Fog           = 3,
    HotSpell      = 4,
    HeatWave      = 5,
    Rain          = 6,
    Squall        = 7,
    DustStorm     = 8,
    SandStorm     = 9,
    Wind          = 10,
    Gales         = 11,
    Snow          = 12,
    Blizzards     = 13,
    Thunder       = 14,
    Thunderstorms = 15,
    Auroras       = 16,
    StellarGlare  = 17,
    Gloom         = 18,
    Darkness      = 19,
    // There's a repeating set 0x14-0x27 according to XiPackets but their usage is unknown.
};
