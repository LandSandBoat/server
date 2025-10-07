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
#include "packets/c2s/0x03d_black_edit.h"

#include <vector>

class GP_SERV_COMMAND_BLACK_LIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_BLACK_LIST, GP_SERV_COMMAND_BLACK_LIST>
{
public:
    struct PacketData
    {
        SAVE_BLACK List[12];  // PS2: List
        int8_t     Stat;      // PS2: Stat
        int8_t     Num;       // PS2: Num
        uint16_t   padding00; // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_BLACK_LIST(std::vector<std::pair<uint32, std::string>> blacklist, bool resetClientBlist, bool lastBlistPacket);
};
