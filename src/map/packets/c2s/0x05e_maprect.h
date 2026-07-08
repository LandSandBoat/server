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

enum class GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT : uint8_t
{
    Default        = 0,
    SandOria       = 1,
    Bastok         = 2,
    Windurst       = 3,
    Jeuno          = 4,
    Whitegate      = 5,
    RonfaureFront  = 6,
    GustabergFront = 7,
    SarutaFront    = 8,
    Adoulin        = 9,
};

enum class GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE : uint8_t
{
    AreaEnteredFrom = 0,
    Option1         = 1, // Select an area to exit to.
    Option2         = 2,
    Option3         = 3,
    Option4         = 4,
    Mog2F           = 125,
    Mog1F           = 126,
    MogGarden       = 127,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x005E
// This packet is sent by the client when requesting to change zones after touching a zone line.
GP_CLI_PACKET(GP_CLI_COMMAND_MAPRECT,
              uint32_t RectID;         // PS2: RectID
              float    x;              // PS2: x
              float    y;              // PS2: y
              float    z;              // PS2: z
              uint16_t ActIndex;       // PS2: ActIndex
              uint8_t  MyRoomExitBit;  // PS2: MyRoomExitBit
              uint8_t  MyRoomExitMode; // PS2: MyRoomExitMode
);
