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

#include "message_system.h"

CMessageSystemPacket::CMessageSystemPacket(uint32 param0, uint32 param1, uint16 messageID)
{
    this->type = 0x53;
    this->size = 0x08;

    ref<uint32>(0x04) = param0;
    ref<uint32>(0x08) = param1;
    ref<uint16>(0x0C) = messageID;
}
