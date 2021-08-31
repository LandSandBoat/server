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

#include "../../common/socket.h"

#include "linkshell_message.h"

#include <cstring>

CLinkshellMessagePacket::CLinkshellMessagePacket(const int8* poster, const int8* message, const int8* lsname, uint32 posttime, bool ls1)
{
    CBasicPacket::id(id);
    this->size = 0x58;

    ref<uint8>(0x04) = 0x03;
    ref<uint8>(0x05) = 0x90;

    ref<uint8>(0x04) = 0x70;
    ref<uint8>(0x05) = 0x06;

    if (!ls1)
    {
        ref<uint8>(0x05) |= 0x40; // LS2
    }
    if (message)
    {
        memcpy(data + (0x08), message, std::min<size_t>(strlen((const char*)message), 115));
        memcpy(data + (0x8C), poster, std::min<size_t>(strlen((const char*)poster), 15));
        memcpy(data + (0xA0), lsname, std::min<size_t>(strlen((const char*)lsname), 16));

        ref<uint32>(0x88) = posttime;
    }
    ref<uint32>(0x9C) = 0x02;
}
