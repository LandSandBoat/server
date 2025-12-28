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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0015
// This packet is sent by the client to update its position, and other general status information, with the server.
GP_CLI_PACKET(GP_CLI_COMMAND_POS,
              float    x;              // PS2: x
              float    z;              // PS2: z
              float    y;              // PS2: y
              uint16_t MovTime;        // PS2: MovTime
              uint16_t MoveFlame;      // PS2: MoveFlame
              int8_t   dir;            // PS2: dir
              uint8_t  TargetMode : 1; // PS2: TargetMode
              uint8_t  RunMode : 1;    // PS2: RunMode
              uint8_t  GroundMode : 1; // PS2: GroundMode
              uint8_t  unused : 5;     // PS2: dummy
              uint16_t facetarget;     // PS2: facetarget
              uint32_t TimeNow;        // PS2: TimeNow
);
