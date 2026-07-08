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

struct equipsetrequestitem_t
{
    uint8_t  HasItemFlg : 1;    // PS2: (New; did not exist.)
    uint8_t  RemoveItemFlg : 1; // PS2: (New; did not exist.)
    uint8_t  Category : 6;      // PS2: (New; did not exist.)
    uint8_t  ItemIndex;         // PS2: (New; did not exist.)
    uint16_t ItemNo;            // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0052
// This packet is sent by the client when changing items in an equipset.
GP_CLI_PACKET(GP_CLI_COMMAND_EQUIPSET_CHECK,
              uint8_t               EquipKind;     // PS2: (New; did not exist.)
              uint8_t               padding00[3];  // PS2: (New; did not exist.)
              equipsetrequestitem_t ItemChange;    // PS2: (New; did not exist.)
              equipsetrequestitem_t Equipment[16]; // PS2: (New; did not exist.)
);
