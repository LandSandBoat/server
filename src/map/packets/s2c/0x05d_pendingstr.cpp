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

#include "0x05d_pendingstr.h"

#include <cstring>

// TODO: std::array
GP_SERV_COMMAND_PENDINGSTR::GP_SERV_COMMAND_PENDINGSTR(
    const std::string& string0,
    const std::string& string1,
    const std::string& string2,
    const std::string& string3,
    const uint32_t     param0,
    const uint32_t     param1,
    const uint32_t     param2,
    const uint32_t     param3,
    const uint32_t     param4,
    const uint32_t     param5,
    const uint32_t     param6,
    const uint32_t     param7,
    const uint32_t     param8)
{
    auto& packet = this->data();

    packet.num[0] = static_cast<int32_t>(param0);
    packet.num[1] = static_cast<int32_t>(param1);
    packet.num[2] = static_cast<int32_t>(param2);
    packet.num[3] = static_cast<int32_t>(param3);
    packet.num[4] = static_cast<int32_t>(param4);
    packet.num[5] = static_cast<int32_t>(param5);
    packet.num[6] = static_cast<int32_t>(param6);
    packet.num[7] = static_cast<int32_t>(param7);
    packet.num[8] = static_cast<int32_t>(param8);

    std::memcpy(packet.string1, string0.c_str(), std::min<size_t>(string0.size(), sizeof(packet.string1) - 1));
    std::memcpy(packet.string2, string1.c_str(), std::min<size_t>(string1.size(), sizeof(packet.string2) - 1));
    std::memcpy(packet.string3, string2.c_str(), std::min<size_t>(string2.size(), sizeof(packet.string3) - 1));
    std::memcpy(packet.string4, string3.c_str(), std::min<size_t>(string3.size(), sizeof(packet.string4) - 1));
}
