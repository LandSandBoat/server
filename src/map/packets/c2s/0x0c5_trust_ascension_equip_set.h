/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

// This packet is sent by the client when changing the Trust equipment of one category.
// It always carries the full 10 slots of that category; the client waits for 0x08F to show the change.
GP_CLI_PACKET(GP_CLI_COMMAND_TRUST_ASCENSION_EQUIP_SET,
              uint8_t Category;  // 1-6
              uint8_t Slots[10]; // Item id - 29424 per slot, 0 = empty
              uint8_t padding00;);
