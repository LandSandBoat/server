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

enum class GP_CLI_COMMAND_EVENTEND_MODE : uint16_t
{
    End           = 0,
    UpdatePending = 1,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x005B
// This packet is sent by the client when ending an event or updating a pending event status.
GP_CLI_PACKET(GP_CLI_COMMAND_EVENTEND,
              uint32_t UniqueNo;  // PS2: UniqueNo
              uint32_t EndPara;   // PS2: EndPara
              uint16_t ActIndex;  // PS2: ActIndex
              uint16_t Mode;      // PS2: Mode
              uint16_t EventNum;  // PS2: EventNum
              uint16_t EventPara; // PS2: EventPara
);
