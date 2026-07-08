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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0064
// This packet is sent by the client when viewing a key item that has not been viewed before.
// (This marks the key item as 'seen' by the client to remove the yellow bubble when looking at the menu in the future. ie. 'Mark as Read')
GP_CLI_PACKET(GP_CLI_COMMAND_SCENARIOITEM,
              uint32_t UniqueNo;         // PS2: UniqueNo
              uint32_t LookItemFlag[16]; // PS2: para
              uint16_t ActIndex;         // PS2: ActIndex
              uint16_t TableIndex;       // PS2: Dammy
);
