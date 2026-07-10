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

#include <vector>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x011C
// This packet is sent by the server in response to the client locking their style.
// (This packet was intended to work similar to packet 0x0117 to inform the client when a piece of gear could not be style locked.)
class GP_SERV_COMMAND_LOCKSTYLE_ERROR final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_LOCKSTYLE_ERROR, GP_SERV_COMMAND_LOCKSTYLE_ERROR>
{
public:
    struct PacketData
    {
        uint8_t  Count;        // PS2: (New; did not exist.)
        uint8_t  padding05[3]; // PS2: (New; did not exist.)
        uint16_t ItemNo[16];   // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_LOCKSTYLE_ERROR(const std::vector<uint16_t>& failedItemIds);
};
