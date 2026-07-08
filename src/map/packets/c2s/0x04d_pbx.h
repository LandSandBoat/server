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

enum class GP_CLI_COMMAND_PBX_COMMAND : uint8_t
{
    Work      = 0x01,
    Set       = 0x02,
    Send      = 0x03,
    Cancel    = 0x04,
    Check     = 0x05,
    Recv      = 0x06,
    Confirm   = 0x07,
    Accept    = 0x08,
    Reject    = 0x09,
    Get       = 0x0A,
    Clear     = 0x0B,
    Query     = 0x0C,
    DeliOpen  = 0x0D, // Request Enter Delivery Mode
    PostOpen  = 0x0E, // Request Enter Post Mode
    PostClose = 0x0F  // Request Exit Delivery/Post Mode
};

enum class GP_CLI_COMMAND_PBX_BOXNO : int8_t
{
    None     = -1,
    Incoming = 1,
    Outgoing = 2
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x004D
// This packet is sent by the client when interacting with the delivery box system.
GP_CLI_PACKET(GP_CLI_COMMAND_PBX,
              uint8_t Command;        // PS2: Command
              int8_t  BoxNo;          // PS2: BoxNo
              int8_t  PostWorkNo;     // PS2: PostWorkNo
              int8_t  ItemWorkNo;     // PS2: ItemWorkNo
              int32_t ItemStacks;     // PS2: ItemStacks
              int8_t  Result;         // PS2: Result
              int8_t  ResParam1;      // PS2: ResParam1
              int8_t  ResParam2;      // PS2: ResParam2
              int8_t  ResParam3;      // PS2: ResParam3
              uint8_t TargetName[16]; // PS2: TargetName
);
