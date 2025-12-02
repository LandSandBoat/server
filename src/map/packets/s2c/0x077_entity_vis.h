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

#include <vector>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0077
class GP_SERV_COMMAND_ENTITY_VIS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_ENTITY_VIS, GP_SERV_COMMAND_ENTITY_VIS>
{
public:
    struct PacketData
    {
        uint8_t  Flags;        // PS2: (New; did not exist.)
        uint8_t  padding05[3]; // PS2: (New; did not exist.)
        uint32_t UniqueNo[32]; // PS2: (New; did not exist.) - Documented as uint8_t[128] on XiPackets
    };

    GP_SERV_COMMAND_ENTITY_VIS(const std::vector<uint32>& list);
};
