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

#include "instance_entry.h"

#include "entities/baseentity.h"

CInstanceEntryPacket::CInstanceEntryPacket(CBaseEntity* PEntrance, uint32 response)
{
    this->setType(0xBF);
    this->setSize(0x1C);

    ref<uint8>(0x06)  = response;
    ref<uint16>(0x0C) = PEntrance->targid;
}
