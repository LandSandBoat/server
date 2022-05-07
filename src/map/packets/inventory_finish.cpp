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

#include "inventory_finish.h"

CInventoryFinishPacket::CInventoryFinishPacket()
{
    this->setType(0x1D);
    this->setSize(0x0C);

    ref<uint8>(0x04) = 1; // "Finished" flag
    ref<uint8>(0x05) = CONTAINER_ID::MAX_CONTAINER_ID;
    ref<uint8>(0x06) = 0x00;
    ref<uint8>(0x07) = 0x00;
    ref<uint8>(0x08) = 0xFF;
    ref<uint8>(0x09) = 0xFF;
    ref<uint8>(0x0A) = 0x03;
    ref<uint8>(0x0B) = 0x00;
}

CInventoryFinishPacket::CInventoryFinishPacket(CONTAINER_ID id)
{
    this->setType(0x1D);
    this->setSize(0x0C);

    ref<uint8>(0x04) = 0; // "Finished" flag
    ref<uint8>(0x05) = id;
}
