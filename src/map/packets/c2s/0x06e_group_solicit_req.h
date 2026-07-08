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

enum class PartyKind : uint8_t;

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x006E
// This packet is sent by the client when sending party or alliance invites to other players.
GP_CLI_PACKET(GP_CLI_COMMAND_GROUP_SOLICIT_REQ,
              uint32_t  UniqueNo;  // PS2: UniqueNo
              uint16_t  ActIndex;  // PS2: ActIndex
              PartyKind Kind;      // PS2: Kind
              uint8_t   padding00; // PS2: dammy2
);
