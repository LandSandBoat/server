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

enum class GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL : uint8_t
{
    Linkshell = 0, // Linkshell owner can set the message.
    Pearlsack = 1, // Pearlsack owners can set the message.
    Linkpearl = 2, // Linkpearl owners can set the message.
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00E2
// This packet is sent by the client when altering the linkshell message or linkshell message access level.
GP_CLI_PACKET(GP_CLI_COMMAND_SET_LSMSG,
              uint8_t  unknown00 : 4;    // PS2: stat
              uint8_t  unknown01 : 1;    // PS2: attr (Was originally a single 4 bit value.)
              uint8_t  unknown02 : 1;    // PS2: attr (Was originally a single 4 bit value.)
              uint8_t  unknown03 : 1;    // PS2: attr (Was originally a single 4 bit value.)
              uint8_t  unknown04 : 1;    // PS2: attr (Was originally a single 4 bit value.)
              uint8_t  readLevel : 2;    // PS2: readLevel
              uint8_t  writeLevel : 2;   // PS2: writeLevel
              uint8_t  pubEditLevel : 2; // PS2: pubEditLevel
              uint8_t  LinkshellId : 2;  // PS2: dummyBits
              uint8_t  Category;         // PS2: (New; did not exist.)
              uint8_t  ItemIndex;        // PS2: (New; did not exist.)
              uint8_t  padding00[2];     // PS2: (New; did not exist.)
              uint16_t seqId;            // PS2: seqId
              uint32_t uniqNo;           // PS2: uniqNo
              uint8_t  sMessage[128];    // PS2: sMessage
);
