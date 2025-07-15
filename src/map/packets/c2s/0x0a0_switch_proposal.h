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

enum class GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND : uint8_t
{
    Party      = 0x01,
    Linkshell1 = 0x02,
    Linkshell2 = 0x03,
    Say        = 0x05,
    Shout      = 0x06,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00A0
// This packet is sent by the client when making a proposal. (via /nominate or /propose)
GP_CLI_PACKET(GP_CLI_COMMAND_SWITCH_PROPOSAL,
              uint8_t Kind;     // PS2: Kind
              uint8_t Str[128]; // PS2: Str
);
