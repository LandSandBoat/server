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

#include "linkshell_message.h"

#include <cstring>

CLinkshellMessagePacket::CLinkshellMessagePacket(const std::string& poster, const std::string& message, const std::string& lsname, uint32 posttime, bool ls1)
{
    this->setType(id);
    this->setSize(0xB0);

    ref<uint8>(0x04) = 0x03;
    ref<uint8>(0x05) = 0x90;

    ref<uint8>(0x04) = 0x70;
    ref<uint8>(0x05) = 0x06;

    if (!ls1)
    {
        ref<uint8>(0x05) |= 0x40; // LS2
    }

    std::memcpy(buffer_.data() + 0x08, message.c_str(), std::min<size_t>(message.size(), 128));
    std::memcpy(buffer_.data() + 0x8C, poster.c_str(), std::min<size_t>(poster.size(), 15));
    std::memcpy(buffer_.data() + 0xA0, lsname.c_str(), std::min<size_t>(lsname.size(), 16));

    ref<uint32>(0x88) = posttime;

    ref<uint32>(0x9C) = 0x02;
}
