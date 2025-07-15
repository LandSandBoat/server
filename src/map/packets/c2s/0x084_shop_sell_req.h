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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0084
// This packet is sent by the client when requesting to sell an item to a shop.
// This packet is used to appraise the item to determine the price it is worth prior to actually selling it.
GP_CLI_PACKET(GP_CLI_COMMAND_SHOP_SELL_REQ,
              uint32_t ItemNum;   // PS2: ItemNum
              uint16_t ItemNo;    // PS2: ItemNo
              uint8_t  ItemIndex; // PS2: ItemIndex
              uint8_t  padding00; // PS2: dammy
);
