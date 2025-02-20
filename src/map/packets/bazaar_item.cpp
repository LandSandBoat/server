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

#include "bazaar_item.h"

#include "common/socket.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <cstring>

#include "utils/itemutils.h"

CBazaarItemPacket::CBazaarItemPacket(CItem* PItem, uint8 SlotID, uint16 Tax)
{
    this->setType(0x105);
    this->setSize(0x2E);

    ref<uint8>(0x10) = SlotID;

    if (PItem != nullptr)
    {
        ref<uint32>(0x04) = PItem->getCharPrice();
        ref<uint32>(0x08) = PItem->getQuantity();
        ref<uint16>(0x0C) = Tax;
        ref<uint16>(0x0E) = PItem->getID();

        if (PItem->isSubType(ITEM_CHARGED) && PItem->isType(ITEM_USABLE))
        {
            uint32 currentTime = CVanaTime::getInstance()->getVanaTime();
            uint32 nextUseTime = ((CItemUsable*)PItem)->getLastUseTime() + ((CItemUsable*)PItem)->getReuseDelay();

            ref<uint8>(0x11) = 0x01; // ITEM_CHARGED flag
            ref<uint8>(0x12) = ((CItemUsable*)PItem)->getCurrentCharges();
            ref<uint8>(0x14) = (nextUseTime > currentTime ? 0x90 : 0xD0);

            ref<uint32>(0x15) = nextUseTime;
            ref<uint32>(0x19) = ((CItemUsable*)PItem)->getUseDelay() + currentTime;
        }
        // 12? characters? seems a bit short. TODO: research this.
        std::memcpy(buffer_.data() + 0x1D, PItem->getSignature().c_str(), std::min<size_t>(PItem->getSignature().size(), 12));
    }
}
