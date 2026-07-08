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
#include "base.h"

enum class GP_CLI_COMMAND_FISHING_2_MODE : uint8_t
{
    RequestCheckHook        = 2,
    RequestEndMiniGame      = 3,
    RequestRelease          = 4,
    RequestPotentialTimeout = 5,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0110
// This packet is sent by the client when interacting with the fishing mini-game system.
// Note: 0x066 handles the old fishing system, while 0x110 handles the new fishing mini-game.
// However, both packets use the exact same structure and are processed the same way.
// Note that 0x066 packet is aliased to this struct.
GP_CLI_PACKET(GP_CLI_COMMAND_FISHING_2,
              uint32_t UniqueNo;  // PS2: UniqueNo
              int32_t  para;      // PS2: para
              uint16_t ActIndex;  // PS2: ActIndex
              int8_t   mode;      // PS2: mode
              uint8_t  unknown00; // PS2: dammy
              int32_t  para2;     // PS2: (New; did not exist.)
);
