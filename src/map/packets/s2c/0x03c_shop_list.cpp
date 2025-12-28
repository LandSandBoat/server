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

#include "0x03c_shop_list.h"

#include "entities/charentity.h"
#include "trade_container.h"

GP_SERV_COMMAND_SHOP_LIST::GP_SERV_COMMAND_SHOP_LIST(CCharEntity* PChar)
{
    const uint8 itemsCount = PChar->Container->getItemsCount();
    auto&       packet     = this->data();

    uint8  i          = 0;
    uint16 itemOffset = 0;

    for (uint8 slotID = 0; slotID < itemsCount; ++slotID)
    {
        if (i == 19)
        {
            // Set offset, flags and size for full packet (19 items)
            packet.ShopItemOffsetIndex = itemOffset;
            packet.Flags               = 0x00; // More packets to come
            this->setSize(0x08 + (19 * sizeof(GP_SHOP)));
            PChar->pushPacket(this->copy());

            i = 0;
            itemOffset += 19;
            std::memset(&packet, 0, sizeof(packet));
        }

        packet.ShopItemTbl[i].ItemPrice = PChar->Container->getQuantity(slotID);
        packet.ShopItemTbl[i].ItemNo    = PChar->Container->getItemID(slotID);
        packet.ShopItemTbl[i].ShopIndex = slotID;
        packet.ShopItemTbl[i].Skill     = PChar->Container->getGuildID(slotID);
        packet.ShopItemTbl[i].GuildInfo = (PChar->Container->getGuildRank(slotID) + 1) * 100;
        i++;
    }

    // Set offset, flags and size for final packet
    packet.ShopItemOffsetIndex = itemOffset;
    packet.Flags               = 0x89; // Indicates last packet
    this->setSize(0x08 + (i * sizeof(GP_SHOP)));
}
