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

enum class GP_CLI_COMMAND_SUBMAPCHANGE_STATE : uint16_t
{
    General = 0x01, // When the client is moving around the world freely, it will make use of State value 0x01 any time it enters a different sub-region within the map.
    Event   = 0x02, // The only time State value 0x02 is used is during events that cause the player to be moved between sub-regions.
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00F2
// This packet is sent by the client when updating their sub-map region.
GP_CLI_PACKET(GP_CLI_COMMAND_SUBMAPCHANGE,
              uint16_t State;        // PS2: State
              uint16_t SubMapNumber; // PS2: SubMapNumber
);
