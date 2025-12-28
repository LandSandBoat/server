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

enum class GP_CLI_COMMAND_ASSIST_CHANNEL_KIND : uint8_t
{
    GiveThumbsUp       = 0x24,
    IssueWarning       = 0x25,
    AddToMuteList      = 0x26,
    RemoveFromMuteList = 0x27,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00B7
// This packet is sent by the client when interacting with the newer Assist channel mentor features. (Thumbs Up, Warning, Mute, Unmute)
GP_CLI_PACKET(GP_CLI_COMMAND_ASSIST_CHANNEL,
              uint8_t Kind;
              uint8_t unknown00;
              uint8_t sName[15];
              uint8_t Mes[1]; // Always set to single space character
);
