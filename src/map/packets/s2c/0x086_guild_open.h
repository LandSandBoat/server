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

#include "common/cbasetypes.h"

#include "base.h"

enum class GP_SERV_COMMAND_GUILD_OPEN_STAT : uint8
{
    Open    = 0,
    Close   = 1,
    Holiday = 2
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0086
// This packet is sent by the server to respond to the client requesting to open a guild shop menu.
class GP_SERV_COMMAND_GUILD_OPEN final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_GUILD_OPEN, GP_SERV_COMMAND_GUILD_OPEN>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_GUILD_OPEN_STAT Stat;
        uint8_t                         padding00[3];
        uint32_t                        Time;
    };

    GP_SERV_COMMAND_GUILD_OPEN(GP_SERV_COMMAND_GUILD_OPEN_STAT status, uint8 open, uint8 close, uint8 holiday);
};
