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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x000C
// This packet is sent by the client when the client is in a state, after zoning, that is ready to begin obtaining additional packets from the server.
GP_CLI_PACKET(GP_CLI_COMMAND_GAMEOK,
              uint32_t ClientState;        // PS2: ClientState
              uint32_t DebugClientFlg : 1; // PS2: DebugClientFlg
              uint32_t unused : 31;        // PS2: unused
);
