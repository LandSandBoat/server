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

#include "trade_item.h"

CTradeItemPacket::CTradeItemPacket(CItem* PItem, uint8 slot)
{
    this->setType(0x25);
    this->setSize(0x0C);

    uint32 amount = PItem->getReserve();

    ref<uint32>(0x04) = amount == 0 ? 0 : amount;
    ref<uint16>(0x08) = amount == 0 ? 0 : PItem->getID();
    ref<uint8>(0x0A)  = slot;
    ref<uint8>(0x0B)  = amount == 0 ? 0 : PItem->getSlotID();
}
