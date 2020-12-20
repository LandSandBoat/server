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

#include <cstring>

#include "../entities/charentity.h"
#include "event_string.h"

CEventStringPacket::CEventStringPacket(CCharEntity* PChar, uint16 EventID, const std::string& string0, const std::string& string1, const std::string& string2,
                                       const std::string& string3, uint32 param0, uint32 param1, uint32 param2, uint32 param3, uint32 param4, uint32 param5,
                                       uint32 param6, uint32 param7)
{
    this->type = 0x33;
    this->size = 0x38;

    ref<uint32>(0x04) = PChar->id;
    ref<uint16>(0x08) = PChar->m_TargID;
    ref<uint16>(0x0A) = PChar->getZone();
    ref<uint16>(0x0C) = EventID;
    ref<uint8>(0x0E)  = 8; // camera "jumps" behind the character if < 8 params

    memcpy(data + (0x10), string0.c_str(), string0.size());
    memcpy(data + (0x20), string1.c_str(), string1.size());
    memcpy(data + (0x30), string2.c_str(), string2.size());
    memcpy(data + (0x40), string3.c_str(), string3.size());

    ref<uint32>(0x50) = param0;
    ref<uint32>(0x54) = param1;
    ref<uint32>(0x58) = param2;
    ref<uint32>(0x5C) = param3;
    ref<uint32>(0x60) = param4;
    ref<uint32>(0x64) = param5;
    ref<uint32>(0x68) = param6;
    ref<uint32>(0x6C) = param7;

    PChar->m_event.EventID = EventID;
}
