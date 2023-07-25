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

#include "utils/itemutils.h"

#include "inventory_assign.h"

CInventoryAssignPacket::CInventoryAssignPacket(CItem* PItem, uint8 Flag)
{
    this->setType(0x1F);
    this->setSize(0x10);

    ref<uint32>(0x04) = PItem->getQuantity();
    ref<uint16>(0x08) = PItem->getID();
    ref<uint8>(0x0A)  = PItem->getLocationID();
    ref<uint8>(0x0B)  = PItem->getSlotID();
    ref<uint8>(0x0C)  = Flag;
}
