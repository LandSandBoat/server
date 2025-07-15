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

enum class GP_CLI_COMMAND_REQLOGOUT_MODE : uint16_t
{
    Toggle     = 0x00,
    LogoutOn   = 0x01, // Mode: on (Used with /logout on)
    Off        = 0x02, // Mode: off (Used with both /logout off and /shutdown off)
    ShutdownOn = 0x03, // Mode: on (Used with: /shutdown on)
};

enum class GP_CLI_COMMAND_REQLOGOUT_KIND : uint16_t
{
    Logout   = 0x01,
    Shutdown = 0x03,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00E7
// This packet is sent by the client when requesting to logout or shutdown.
GP_CLI_PACKET(GP_CLI_COMMAND_REQLOGOUT,
              uint16_t Mode; // PS2: Mode
              uint16_t Kind; // PS2: (New; did not exist.)
);
