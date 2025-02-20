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

#include "entities/baseentity.h"

#include "entity_visual.h"

CEntityVisualPacket::CEntityVisualPacket(CBaseEntity* PEntity, const char type[4])
{
    this->setType(0x39);
    this->setSize(0x14);

    if (PEntity)
    {
        ref<uint32>(0x04) = PEntity->id;
        ref<uint32>(0x08) = PEntity->id;

        ref<uint16>(0x10) = PEntity->targid;
        ref<uint16>(0x12) = PEntity->targid;
    }
    std::memcpy(buffer_.data() + 0x0C, type, 4);
}
