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

#include <cstring>

#include "guild_menu_sell.h"

#include "entities/charentity.h"
#include "item_container.h"

#include "items/item_shop.h"

CGuildMenuSellPacket::CGuildMenuSellPacket(CCharEntity* PChar, CItemContainer* PGuild)
{
    this->setType(0x85);
    this->setSize(0xF8);

    if (PChar == nullptr || PGuild == nullptr)
    {
        ShowError("CGuildMenuSellPacket::CGuildMenuSellPacket() - PChar or PGuild was null.");
        return;
    }

    uint8 ItemCount   = 0;
    uint8 PacketCount = 0;

    for (uint8 SlotID = 1; SlotID <= PGuild->GetSize(); ++SlotID)
    {
        CItemShop* PItem = (CItemShop*)PGuild->GetItem(SlotID);

        if (PItem == nullptr)
        {
            ShowError("CGuildMenuSellPacket::CGuildMenuSellPacket() - PItem was null for SlotID: %d", SlotID);
            return;
        }

        if (ItemCount == 30)
        {
            ref<uint8>(0xF4) = ItemCount;
            ref<uint8>(0xF5) = (PacketCount == 0 ? 0x40 : PacketCount);

            PChar->pushPacket(this->copy());

            ItemCount = 0;
            PacketCount++;

            std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 8);
        }
        ref<uint16>(0x08 * ItemCount + 0x04) = PItem->getID();
        ref<uint8>(0x08 * ItemCount + 0x06)  = PItem->getQuantity();
        ref<uint8>(0x08 * ItemCount + 0x07)  = PItem->getStackSize();
        ref<uint32>(0x08 * ItemCount + 0x08) = PItem->getSellPrice();

        ItemCount++;
    }
    ref<uint8>(0xF4) = ItemCount;
    ref<uint8>(0xF5) = PacketCount + 0x80;
}
