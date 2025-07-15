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

enum class GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE_ACTIVEFLG : uint8_t
{
    Unequip       = 0,
    EquipOrCreate = 1,
};

enum class GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE_LINKSHELLID : uint8_t
{
    Linkshell1 = 1,
    Linkshell2 = 2,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00C4
// This packet is sent by the client when requesting to create a linkshell or when equipping/unequipping a linkshell item.
GP_CLI_PACKET(GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE,
              uint16_t r : 4;            // PS2: r
              uint16_t g : 4;            // PS2: g
              uint16_t b : 4;            // PS2: b
              uint16_t a : 4;            // PS2: a
              uint8_t  ItemIndex;        // PS2: ItemIndex
              uint8_t  Category;         // PS2: (New; did not exist.)
              uint8_t  ActiveFlg;        // PS2: ActiveFlg
              uint8_t  padding00[3];     // PS2: (New; did not exist.)
              uint8_t  sComLinkName[15]; // PS2: sComLinkName
              uint8_t  LinkshellId;      // PS2: (New; did not exist.)
);
