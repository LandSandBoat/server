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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x001C
// The purpose of this packet is currently unknown.
// The client will send this packet each time the player uses a job ability while having a pet active.
GP_CLI_PACKET(GP_CLI_COMMAND_UNKNOWN,
              uint16_t unknown00; // This value is always set to the local players target index.
              uint16_t padding00; // Padding; unused.
              uint32_t unknown01; // Unknown. This value is always set to 1.
);
