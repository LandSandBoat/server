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

struct equipsetitem_t
{
    uint8_t ItemIndex;
    uint8_t EquipKind;
    uint8_t Category;
    uint8_t padding00;
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0051
// This packet is sent by the client when equipping an equipset.
GP_CLI_PACKET(GP_CLI_COMMAND_EQUIPSET_SET,
              uint8_t        Count;         // The number of slots populated in the Equipment array.
              uint8_t        padding00[3];  // Padding; unused.
              equipsetitem_t Equipment[16]; // The array of items the client is attempting to equip.
);
