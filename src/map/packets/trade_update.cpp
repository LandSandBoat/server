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

#include "trade_update.h"

#include "common/socket.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <cstring>

#include "utils/itemutils.h"

CTradeUpdatePacket::CTradeUpdatePacket(CItem* PItem, uint8 SlotID)
{
    this->setType(0x23);
    this->setSize(0x28);

    uint32 amount = PItem->getReserve();

    ref<uint32>(0x04) = amount;
    ref<uint16>(0x0A) = amount == 0 ? 0 : PItem->getID();
    ref<uint8>(0x0D)  = SlotID;

    if (PItem->isSubType(ITEM_CHARGED))
    {
        ref<uint8>(0x0E) = 0x01;

        if (((CItemUsable*)PItem)->getCurrentCharges() > 0)
        {
            ref<uint8>(0x0F) = ((CItemUsable*)PItem)->getCurrentCharges();
        }
    }
    if (PItem->isType(ITEM_LINKSHELL))
    {
        ref<uint32>(0x0E) = ((CItemLinkshell*)PItem)->GetLSID();
        ref<uint16>(0x14) = ((CItemLinkshell*)PItem)->GetLSRawColor();
        ref<uint8>(0x16)  = ((CItemLinkshell*)PItem)->GetLSType();

        std::memcpy(buffer_.data() + 0x17, PItem->getSignature().c_str(), std::min<size_t>(PItem->getSignature().size(), 15));
    }
    else
    {
        std::memcpy(buffer_.data() + 0x1A, PItem->getSignature().c_str(), std::min<size_t>(PItem->getSignature().size(), 12));
    }
}
