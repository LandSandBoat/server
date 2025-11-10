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
#include <string>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x005D
// This packet is sent by the server to update the clients event parameters.
class GP_SERV_COMMAND_PENDINGSTR final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_PENDINGSTR, GP_SERV_COMMAND_PENDINGSTR>
{
public:
    struct PacketData
    {
        int32_t num[9];
        char    string1[16];
        char    string2[16];
        char    string3[16];
        char    string4[16];
    };

    GP_SERV_COMMAND_PENDINGSTR(
        const std::string& string0 = "",
        const std::string& string1 = "",
        const std::string& string2 = "",
        const std::string& string3 = "",
        uint32_t           param0  = 0,
        uint32_t           param1  = 0,
        uint32_t           param2  = 0,
        uint32_t           param3  = 0,
        uint32_t           param4  = 0,
        uint32_t           param5  = 0,
        uint32_t           param6  = 0,
        uint32_t           param7  = 0,
        uint32_t           param8  = 0);
};
