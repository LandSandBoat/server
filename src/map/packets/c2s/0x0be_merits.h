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

enum class GP_CLI_COMMAND_MERITS_KIND : uint8_t
{
    ChangeMode = 2, // Change Mode (EXP/Limit)
    EditMode   = 3, // Edit Mode (Increase/Decrease Merit Point)
};

enum class GP_CLI_COMMAND_MERITS_PARAM1 : uint8_t
{
    Lower = 0, // This also means changing to EXP Mode when Kind is ChangeMode
    Raise = 1, // This also means changing to Limit Points Mode when Kind is ChangeMode
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00BE
// This packet is sent by the client when interacting with the merit system.
GP_CLI_PACKET(GP_CLI_COMMAND_MERITS,
              uint8_t  Kind;   // The packet kind
              uint8_t  Param1; // The packet parameter. (1)
              uint16_t Param2; // The packet parameter. (2)
              uint32_t Param3; // The packet parameter. (3)
);
