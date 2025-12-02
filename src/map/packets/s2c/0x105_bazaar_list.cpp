/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "0x105_bazaar_list.h"

#include "common/utils.h"
#include "common/vana_time.h"
#include "items/item_usable.h"
#include "utils/itemutils.h"

GP_SERV_COMMAND_BAZAAR_LIST::GP_SERV_COMMAND_BAZAAR_LIST(CItem* PItem, const uint8 slotId, const uint16 tax)
{
    auto& packet = this->data();

    packet.ItemIndex = slotId;

    if (PItem != nullptr)
    {
        packet.Price   = PItem->getCharPrice();
        packet.ItemNum = PItem->getQuantity();
        packet.TaxRate = tax;
        packet.ItemNo  = PItem->getID();

        if (PItem->isSubType(ITEM_CHARGED) && PItem->isType(ITEM_USABLE))
        {
            const timer::time_point currentTime = timer::now();
            const timer::time_point nextUseTime = static_cast<CItemUsable*>(PItem)->getNextUseTime();

            packet.Attr[0] = 0x01; // ITEM_CHARGED flag
            packet.Attr[1] = static_cast<CItemUsable*>(PItem)->getCurrentCharges();
            packet.Attr[3] = (nextUseTime > currentTime ? 0x90 : 0xD0);

            const uint32_t nextUseTimestamp = earth_time::vanadiel_timestamp(timer::to_utc(nextUseTime));
            std::memcpy(&packet.Attr[4], &nextUseTimestamp, sizeof(uint32_t));
            const uint32_t delayTimestamp = static_cast<uint32>(timer::count_seconds(static_cast<CItemUsable*>(PItem)->getUseDelay()) + earth_time::vanadiel_timestamp());
            std::memcpy(&packet.Attr[8], &delayTimestamp, sizeof(uint32_t));
        }
        else
        {
            std::memcpy(packet.Attr, PItem->m_extra, std::min<size_t>(CItem::extra_size, sizeof(packet.Attr)));
        }
    }
}
