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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00FA
// This packet is sent by the client when rearranging furniture in their mog house.
// (The client will also send this packet when exiting the Layout menu.)
GP_CLI_PACKET(GP_CLI_COMMAND_MYROOM_LAYOUT,
              uint16_t MyroomItemNo;    // PS2: MyroomItemNo
              uint8_t  MyroomItemIndex; // PS2: MyroomItemIndex
              uint8_t  MyroomCategory;  // PS2: (New; did not exist.)
              uint8_t  MyroomFloorFlg;  // PS2: (New; did not exist.)
              uint8_t  x;               // PS2: x
              uint8_t  y;               // PS2: y
              uint8_t  z;               // PS2: z
              uint8_t  v;               // PS2: v
              uint8_t  padding00[3];    // PS2: (New; did not exist.)
);
