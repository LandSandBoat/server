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

#include "0x059_friendpass.h"

GP_SERV_COMMAND_FRIENDPASS::GP_SERV_COMMAND_FRIENDPASS(const uint8_t type, const int32_t leftNum, const int32_t leftHours, const int32_t price, const std::string& code)
{
    auto& packet = this->data();

    packet.leftNum   = leftNum;
    packet.leftHours = leftHours;
    packet.passPop   = price;
    packet.Type      = type;
    packet.unknown21 = 0x01;

    std::memcpy(packet.String, code.data(), std::min(code.size(), sizeof(packet.String) - 1));
}
