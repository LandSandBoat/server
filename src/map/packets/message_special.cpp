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
#include "common/utils.h"

#include <cstring>

#include "message_special.h"

#include "entities/baseentity.h"

CMessageSpecialPacket::CMessageSpecialPacket(CBaseEntity* PEntity, uint16 messageID, uint32 param0, uint32 param1, uint32 param2, uint32 param3, bool ShowName)
{
    this->setType(0x2A);
    this->setSize(0x20);

    ref<uint32>(0x04) = PEntity->id;

    ref<uint32>(0x08) = param0;
    ref<uint32>(0x0C) = param1;
    ref<uint32>(0x10) = param2;
    ref<uint32>(0x14) = param3;

    ref<uint16>(0x18) = PEntity->targid;

    if (ShowName)
    {
        this->setSize(0x30);
        std::memcpy(buffer_.data() + 0x1E, PEntity->getName().c_str(), std::min<size_t>(PEntity->getName().size(), PacketNameLength));
    }
    else if (PEntity->objtype == TYPE_PC)
    {
        messageID += 0x8000;
    }

    ref<uint16>(0x1A) = messageID;
}
