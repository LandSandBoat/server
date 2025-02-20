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

#include "common/socket.h"

#include <cstring>

#include "entities/charentity.h"
#include "event_update_string.h"

CEventUpdateStringPacket::CEventUpdateStringPacket(std::string const& string0, std::string const& string1, std::string const& string2,
                                                   std::string const& string3, uint32 param0, uint32 param1, uint32 param2, uint32 param3, uint32 param4,
                                                   uint32 param5, uint32 param6, uint32 param7, uint32 param8)
{
    this->setType(0x5D);
    this->setSize(0x68);

    ref<uint32>(0x04) = param0;
    ref<uint32>(0x08) = param1;
    ref<uint32>(0x0C) = param2;
    ref<uint32>(0x10) = param3;
    ref<uint32>(0x14) = param4;
    ref<uint32>(0x18) = param5;
    ref<uint32>(0x1C) = param6;
    ref<uint32>(0x20) = param7;
    ref<uint32>(0x24) = param8;

    std::memcpy(buffer_.data() + 0x28, string0.c_str(), 15);
    std::memcpy(buffer_.data() + 0x38, string1.c_str(), 15);
    std::memcpy(buffer_.data() + 0x48, string2.c_str(), 15);
    std::memcpy(buffer_.data() + 0x58, string3.c_str(), 15);
}
