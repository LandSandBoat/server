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

enum class GP_CLI_COMMAND_SUBCONTAINER_KIND : uint32_t
{
    Equip      = 1,
    Unequip    = 2,
    UnequipAll = 5,
};

enum class GP_CLI_COMMAND_SUBCONTAINER_CONTAINERINDEX : uint32_t
{
    MainWeapon   = 0,
    SubWeapon    = 1,
    RangedWeapon = 2,
    Head         = 3,
    Body         = 4,
    Hands        = 5,
    Legs         = 6,
    Feet         = 7,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x003B
// This packet is sent by the client when interacting with a sub-container item. (ie. Mannequins)
GP_CLI_PACKET(GP_CLI_COMMAND_SUBCONTAINER,
              uint32_t Kind;           // The mode of the packet.
              uint32_t Category1;      // The container that holds the sub-container item being interacted with.
              uint8_t  ItemIndex1;     // The index within the container that holds the sub-container item.
              uint8_t  ContainerIndex; // The index within the sub-container that is being interacted with.
              uint16_t padding00;      // Padding; unused.
              uint32_t Category2;      // The container that holds the item that will be used with the sub-container.
              uint8_t  ItemIndex2;     // The index within the container that holds the item.
              uint8_t  padding01[3];   // Padding; unused.
              uint32_t unknown00;      // Unknown
              uint8_t  unknown01;      // Unknown
              uint8_t  padding02[3];   // Padding; unused.
);
