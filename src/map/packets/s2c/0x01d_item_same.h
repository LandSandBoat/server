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

enum CONTAINER_ID : uint8;

enum class GP_SERV_COMMAND_ITEM_SAME_STATE : uint8_t
{
    StillLoading = 0,
    AllLoaded    = 1,
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x001D
// This packet is sent by the server to inform the client of inventory container updates and if all containers have been loaded/updated.
class GP_SERV_COMMAND_ITEM_SAME final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_ITEM_SAME, GP_SERV_COMMAND_ITEM_SAME>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_ITEM_SAME_STATE State;        // PS2: State
        uint8_t                         padding00[3]; // PS2: (New; did not exist)
        uint32_t                        Flags;        // PS2: (New; did not exist)
    };

    GP_SERV_COMMAND_ITEM_SAME();
    GP_SERV_COMMAND_ITEM_SAME(CONTAINER_ID id);
};
