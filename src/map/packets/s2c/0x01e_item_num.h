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

enum class ItemLockFlg : uint8_t;
enum CONTAINER_ID : uint8;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x001E
// This packet is sent by the server to inform the client that an item change has happened within a container.
class GP_SERV_COMMAND_ITEM_NUM final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_ITEM_NUM, GP_SERV_COMMAND_ITEM_NUM>
{
public:
    struct PacketData
    {
        uint32_t     ItemNum;   // PS2: ItemNum
        CONTAINER_ID Category;  // PS2: Category
        uint8_t      ItemIndex; // PS2: ItemIndex
        ItemLockFlg  LockFlg;   // PS2: LockFlg
        uint8_t      padding00; // Undocumented padding? 0x00 or 0xFF seen.
    };

    GP_SERV_COMMAND_ITEM_NUM(CONTAINER_ID locationId, uint8_t slotId, uint32_t quantity);
};
