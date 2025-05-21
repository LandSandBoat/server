/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "world_pass.h"

#include <cinttypes>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0059
// PS2: GP_SERV_FRIENDPASS
struct GP_SERV_FRIENDPASS
{
    uint16_t id : 9;
    uint16_t size : 7;
    uint16_t sync;
    int32_t  leftNum;    // PS2: leftNum
    int32_t  leftDays;   // PS2: leftDays
    int32_t  passPop;    // PS2: passPop
    char     String[16]; // PS2: String
    char     Type;       // PS2: Type
    char     unknown21;  // PS2: (New; did not exist.)
    uint16_t padding00;  // PS2: (New; did not exist.)
};

CWorldPassPacket::CWorldPassPacket(uint32 WorldPass)
{
    this->setType(0x59);
    this->setSize(0x24);

    ref<uint32>(0x0C) = 10000; // price

    ref<uint8>(0x1C) = 0xD0;
    ref<uint8>(0x1D) = 0x19;
    ref<uint8>(0x20) = 0x03;
    ref<uint8>(0x21) = 0x01;

    if (WorldPass != 0)
    {
        ref<uint8>(0x04) = 1;   // number of uses left
        ref<uint8>(0x08) = 167; // pass becomes invalid in (hours)

        ref<uint8>(0x20) = 0x06;

        // Force to be 10 digits
        std::string strbuff = fmt::format("{:0>10}", WorldPass);

        std::memset(buffer_.data() + 0x10, 0, 10);
        std::memcpy(buffer_.data() + 0x10, strbuff.c_str(), strbuff.length());
    }
}
