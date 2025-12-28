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

enum class GP_CLI_COMMAND_CHAT_STD_KIND : uint8_t
{
    Say          = 0x00,
    Shout        = 0x01,
    Party        = 0x04,
    Linkshell1   = 0x05,
    Emote        = 0x08,
    LinkshellPvp = 0x18, // Ballista
    Yell         = 0x1A,
    Linkshell2   = 0x1B,
    Unity        = 0x21,
    AssistJ      = 0x22,
    AssistE      = 0x23,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00B5
// This packet is sent by the client when sending chat messages.
GP_CLI_PACKET(GP_CLI_COMMAND_CHAT_STD,
              uint8_t Kind;      // Kind
              uint8_t unknown00; // Dammy
              uint8_t Str[128];  // Str
);
