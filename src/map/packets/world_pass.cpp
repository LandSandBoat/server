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

#include "world_pass.h"


CWorldPassPacket::CWorldPassPacket(uint32 WorldPass)
{
	this->type = 0x59;
	this->size = 0x12;

    ref<uint32>(0x0C) = 10000;       // price

    ref<uint8>(0x1C) = 0xD0;
    ref<uint8>(0x1D) = 0x19;
    ref<uint8>(0x20) = 0x03;
    ref<uint8>(0x21) = 0x01;

    if (WorldPass != 0)
    {
        ref<uint8>(0x04) =   1;     // number of uses left
        ref<uint8>(0x08) = 167;     // pass becomes invalid in (hours)

        ref<uint8>(0x20) = 0x06;
        snprintf((char*)data+(0x10), 10, "%u", WorldPass);
    }
}
