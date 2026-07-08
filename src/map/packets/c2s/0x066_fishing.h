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

struct GP_CLI_COMMAND_FISHING_2;

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0066
// This packet is sent by the client when interacting with the fishing mini-game system.
// Note: 0x066 handles the old fishing system, while 0x110 handles the new fishing mini-game.
// However, both packets use the exact same structure and are processed the same way.
// There is a strong chance that this packet is deprecated and not legitimately usable by the client.
using GP_CLI_COMMAND_FISHING = GP_CLI_COMMAND_FISHING_2;
