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

#include <cstdint>

enum class SearchType : uint8_t
{
    Name          = 0x00, // 00000
    Area          = 0x01, // 00001
    Nation        = 0x02, // 00010
    Job           = 0x03, // 00011
    Level         = 0x04, // 00100
    Race          = 0x05, // 00101
    Flags1        = 0x06, // 00110
    Id            = 0x08, // 01000
    Party         = 0x0A, // 01010
    Linkshell     = 0x0B, // 01011
    Friend        = 0x0C, // 01100
    LinkshellRank = 0x0D, // 01101
    Unknown0E     = 0x0E, // 01110
    Rank          = 0x10, // 10000
    Comment       = 0x11, // 10001
    Linkshell2    = 0x13, // 10011
    Flags2        = 0x16, // 10110
    Language      = 0x17, // 10111
};
