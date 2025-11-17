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

#include "0x020_item_attr.h"

#include "common/vana_time.h"
#include "enums/item_lockflg.h"
#include "items/item_linkshell.h"
#include "utils/itemutils.h"

#include <cstring>

GP_SERV_COMMAND_ITEM_ATTR::GP_SERV_COMMAND_ITEM_ATTR(CItem* PItem, const CONTAINER_ID locationId, const uint8_t slotId, CItem* staleItem)
{
    auto& packet = this->data();

    packet.Category  = locationId;
    packet.ItemIndex = slotId;

    if (PItem != nullptr)
    {
        packet.ItemNum = PItem->getQuantity();
        packet.Price   = PItem->getCharPrice();
        packet.ItemNo  = PItem->getID();
        std::memcpy(packet.Attr, PItem->m_extra, sizeof(PItem->m_extra));

        if (PItem->isSubType(ITEM_CHARGED))
        {
            packet.Attr[0] = 0x01;

            uint8 flags = 0x80; // Tests showed high bit always set.
            if (static_cast<CItemUsable*>(PItem)->getCurrentCharges() < static_cast<CItemUsable*>(PItem)->getMaxCharges())
            {
                flags |= 0x10; // Partial charges mask
            }

            if (static_cast<CItemUsable*>(PItem)->getCurrentCharges() > 0)
            {
                if (static_cast<CItemUsable*>(PItem)->getReuseTime() == 0s)
                {
                    flags |= 0x40; // Ready to use
                }
                else
                {
                    const timer::time_point nextUseTime = static_cast<CItemUsable*>(PItem)->getNextUseTime();
                    const uint32_t          timestamp   = earth_time::vanadiel_timestamp(timer::to_utc(nextUseTime));
                    packet.Attr[4]                      = timestamp & 0xFF;
                    packet.Attr[5]                      = (timestamp >> 8) & 0xFF;
                    packet.Attr[6]                      = (timestamp >> 16) & 0xFF;
                    packet.Attr[7]                      = (timestamp >> 24) & 0xFF;

                    // Not sent if the item is unequipped.
                    const uint32_t delayTimestamp = static_cast<uint32_t>(timer::count_seconds(static_cast<CItemUsable*>(PItem)->getUseDelay()) + earth_time::vanadiel_timestamp());
                    packet.Attr[8]                = delayTimestamp & 0xFF;
                    packet.Attr[9]                = (delayTimestamp >> 8) & 0xFF;
                    packet.Attr[10]               = (delayTimestamp >> 16) & 0xFF;
                    packet.Attr[11]               = (delayTimestamp >> 24) & 0xFF;
                }
            }
            else
            {
                flags |= 0x20; // Empty charges
            }
            packet.Attr[3] = flags;
        }

        if (PItem->isType(ITEM_WEAPON) && static_cast<CItemWeapon*>(PItem)->isUnlockable())
        {
            packet.Attr[0] = 0;
            packet.Attr[1] = 0;
        }

        if (PItem->getCharPrice() != 0)
        {
            packet.LockFlg = ItemLockFlg::Unknown0;
        }
        else if (PItem->isSubType(ITEM_LOCKED))
        {
            if (PItem->isType(ITEM_LINKSHELL))
            {
                packet.LockFlg = ItemLockFlg::Linkshell;
            }
            else
            {
                packet.LockFlg = ItemLockFlg::NoDrop;
            }
        }
        else
        {
            packet.LockFlg = ItemLockFlg::Normal;
        }

        if (PItem->isType(ITEM_LINKSHELL))
        {
            packet.Attr[8] = static_cast<CItemLinkshell*>(PItem)->GetLSType();
        }
    }
    else if (staleItem && settings::get<bool>("map.LEAK_EXT_DATA_ON_ITEM_MOVE")) // Yes, retail copies the previously moved item's extdata which leaks information about weaponskill points.
    {
        std::memcpy(packet.Attr, staleItem->m_extra, sizeof(staleItem->m_extra));
    }
}
