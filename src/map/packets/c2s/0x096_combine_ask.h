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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0096
// This packet is sent by the client when requesting to synthesize an item.
GP_CLI_PACKET(GP_CLI_COMMAND_COMBINE_ASK,
              uint8_t  HashNo;     // PS2: HashNo
              uint8_t  padding00;  // PS2: (New; did not exist.)
              uint16_t Crystal;    // PS2: Crystal
              uint8_t  CrystalIdx; // PS2: CrystalIdx
              uint8_t  Items;      // PS2: Items
              uint16_t ItemNo[8];  // PS2: ItemNo
              uint8_t  TableNo[8]; // PS2: TableNo
);
