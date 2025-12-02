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

enum SLOTTYPE : uint8;
enum CONTAINER_ID : uint8;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0050
// This packet is sent by the server when a piece of equipment is equipped or unequipped by the player.
class GP_SERV_COMMAND_EQUIP_LIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EQUIP_LIST, GP_SERV_COMMAND_EQUIP_LIST>
{
public:
    struct PacketData
    {
        uint8_t      PropertyItemIndex; // PS2: PropertyItemIndex
        SLOTTYPE     EquipKind;         // PS2: EquipKind
        CONTAINER_ID Category;          // PS2: Category
        uint8_t      padding00;         // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_EQUIP_LIST(uint8_t slotId, SLOTTYPE equipSlot, CONTAINER_ID containerId);
};
