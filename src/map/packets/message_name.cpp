/*
===========================================================================

  Copyright (c) 2010-2018 Darkstar Dev Teams

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

#include "message_name.h"

#include "entities/baseentity.h"

CMessageNamePacket::CMessageNamePacket(CBaseEntity* PActor, uint16 messageID, CBaseEntity* PNameActor /* = nullptr*/, int32 param0 /* = 0*/,
                                       int32 param1 /* = 0*/, int32 param2 /* = 0*/, int32 param3 /* = 0*/, int32 chatType /* = 4*/,
                                       bool showSender /* = false*/)
{
    this->setType(0x27);
    this->setSize(0x70);

    ref<int32>(0x04)  = PActor->id;
    ref<uint16>(0x08) = PActor->targid;

    if (!showSender)
    {
        messageID |= 0x8000;
    }

    ref<uint16>(0x0A) = messageID;

    ref<int32>(0x0C) = chatType;
    ref<int32>(0x10) = param0;
    ref<int32>(0x14) = param1;
    ref<int32>(0x18) = param2;
    ref<int32>(0x1C) = param3;

    CBaseEntity* PNameEntity = PNameActor ? PNameActor : PActor;
    std::memcpy(buffer_.data() + 0x20, PNameEntity->getName().c_str(), PNameEntity->getName().size());
}
