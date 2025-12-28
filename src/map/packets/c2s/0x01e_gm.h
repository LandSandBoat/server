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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x001E
// This packet is sent by the client when using GM commands.
// Note: The system to actually make use of this packet is no longer implemented in the retail client. However, the functions that send this packet still exist.
// Note: /volunteer is what generates this packet.
GP_CLI_PACKET(GP_CLI_COMMAND_GM,
              uint8_t Command[115]; // PS2: Command
);
