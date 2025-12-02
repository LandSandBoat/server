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

#include "0x023_item_trade_list.h"

#include "common/utils.h"
#include "items/item_linkshell.h"
#include "utils/itemutils.h"

GP_SERV_COMMAND_ITEM_TRADE_LIST::GP_SERV_COMMAND_ITEM_TRADE_LIST(CItem* PItem, const uint8 slotId)
{
    auto& packet = this->data();

    const uint32 amount = PItem->getReserve();

    packet.ItemNum    = amount;
    packet.ItemNo     = amount == 0 ? 0 : PItem->getID();
    packet.TradeIndex = slotId;

    if (PItem->isSubType(ITEM_CHARGED))
    {
        packet.Attr[0] = 0x01;

        if (static_cast<CItemUsable*>(PItem)->getCurrentCharges() > 0)
        {
            packet.Attr[1] = static_cast<CItemUsable*>(PItem)->getCurrentCharges();
        }
    }
    else if (PItem->isType(ITEM_LINKSHELL))
    {
        const uint32 lsid    = static_cast<CItemLinkshell*>(PItem)->GetLSID();
        const uint16 lscolor = static_cast<CItemLinkshell*>(PItem)->GetLSRawColor();

        std::memcpy(&packet.Attr[0], &lsid, 4);
        std::memcpy(&packet.Attr[6], &lscolor, 2);
        packet.Attr[8] = static_cast<CItemLinkshell*>(PItem)->GetLSType();

        std::memcpy(&packet.Attr[9], PItem->getSignature().c_str(), std::min<size_t>(PItem->getSignature().size(), 15));
    }
    else
    {
        std::memcpy(&packet.Attr[0], PItem->m_extra, std::min<size_t>(CItem::extra_size, 24));
    }
}
