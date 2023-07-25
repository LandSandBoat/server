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

#include "message_basic.h"

#include "entities/baseentity.h"

CMessageBasicPacket::CMessageBasicPacket(CBaseEntity* PSender, CBaseEntity* PTarget, int32 param, int32 value, uint16 messageID)
{
    this->setType(0x29);
    this->setSize(0x1C);

    ref<uint32>(0x04) = PSender->id;
    ref<uint32>(0x08) = PTarget->id;

    ref<uint16>(0x14) = PSender->targid;
    ref<uint16>(0x16) = PTarget->targid;

    ref<uint32>(0x0C) = param;
    ref<uint32>(0x10) = value;
    ref<uint16>(0x18) = messageID;
}

uint16 CMessageBasicPacket::getMessageID()
{
    return ref<uint16>(0x18);
}
