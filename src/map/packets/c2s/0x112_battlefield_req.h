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

enum class GP_CLI_COMMAND_BATTLEFIELD_REQ_KIND : uint8_t
{
    Both       = 0, // The client is requesting both sidebar and map overlay information.
    Sidebar    = 1, // The client is requesting sidebar information
    MapOverlay = 2, // The client is requesting map overlay information.
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0112
// This packet is sent by the client when requesting extra data about certain battlefield content.
GP_CLI_PACKET(GP_CLI_COMMAND_BATTLEFIELD_REQ,
              uint8_t Kind;      // The packet kind.
              uint8_t padding00; // Padding; unused.
);
