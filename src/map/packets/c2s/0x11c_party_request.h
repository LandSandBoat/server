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

enum class GP_CLI_COMMAND_PARTY_REQUEST_KIND : uint8_t
{
    Add    = 0x00, // Request to join the target players party.
    Remove = 0x01, // Remove request to join the target players party.
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x011C
// This packet is sent by the client when using the party request command. (/partyrequestcmd)
GP_CLI_PACKET(GP_CLI_COMMAND_PARTY_REQUEST,
              uint32_t UniqueNo;  // The server id of the player whos party the client is requesting to join.
              uint16_t ActIndex;  // The target index of the player whos party the client is requesting to join.
              uint8_t  Kind;      // The packet kind.
              uint8_t  padding00; // Padding; unused.
);
