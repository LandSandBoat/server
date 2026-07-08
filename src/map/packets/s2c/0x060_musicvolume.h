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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0060
// This packet is sent by the server to update the clients music volume.
class GP_SERV_COMMAND_MUSICVOLUME final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MUSICVOLUME, GP_SERV_COMMAND_MUSICVOLUME>
{
public:
    struct PacketData
    {
        uint16_t time;   // PS2: (New; did not exist.)
        uint16_t volume; // PS2: (New; did not exist.)
    };

    // TODO: Unimplemented
    GP_SERV_COMMAND_MUSICVOLUME() = default;
};
