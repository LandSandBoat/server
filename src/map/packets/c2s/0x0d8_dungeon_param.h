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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00D8
// This packet is sent by the client when interacting with or changing parameters related to a private dungeon system, such as the Moblin Maze Mongers tablet item.
GP_CLI_PACKET(GP_CLI_COMMAND_DUNGEON_PARAM,
              uint16_t ActIndex;     // The clients target index.
              uint16_t Param1;       // This value is populated from an event VM script.
              uint8_t  Param2;       // This value is populated from an event VM script.
              uint8_t  padding00[3]; // Padding; unused.
              uint32_t UniqueNo;     // The clients server id.
              uint8_t  Data[24];     // This array holds the various bit packed data related to the dungeon information being updated.
);
