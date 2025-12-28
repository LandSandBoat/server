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

#include "0x083_guild_buylist.h"

#include "entities/charentity.h"
#include "item_container.h"
#include "items/item_shop.h"

#include <cstring>

GP_SERV_COMMAND_GUILD_BUYLIST::GP_SERV_COMMAND_GUILD_BUYLIST(CCharEntity* PChar, const CItemContainer* PGuild)
{
    if (PChar == nullptr || PGuild == nullptr)
    {
        ShowError("GP_SERV_COMMAND_GUILD_BUYLIST - PChar or PGuild was null.");
        return;
    }

    auto& packet = this->data();

    uint8 ItemCount   = 0;
    uint8 PacketCount = 0;

    for (uint8 SlotID = 1; SlotID <= PGuild->GetSize(); ++SlotID)
    {
        CItemShop* PItem = (CItemShop*)PGuild->GetItem(SlotID);

        if (PItem == nullptr)
        {
            ShowError("GP_SERV_COMMAND_GUILD_BUYLIST - PItem was null for SlotID: %d", SlotID);
            return;
        }

        if (PItem->IsInMenu())
        {
            if (ItemCount == 30)
            {
                packet.Count = ItemCount;
                packet.Stat  = (PacketCount == 0 ? 0x40 : PacketCount);

                PChar->pushPacket(this->copy());

                ItemCount = 0;
                PacketCount++;

                std::memset(&packet, 0, sizeof(PacketData));
            }

            packet.List[ItemCount].ItemNo = PItem->getID();
            packet.List[ItemCount].Count  = PItem->getQuantity();
            packet.List[ItemCount].Max    = PItem->getStackSize();
            packet.List[ItemCount].Price  = PItem->getBasePrice();

            ItemCount++;
        }
    }

    packet.Count = ItemCount;
    packet.Stat  = PacketCount + 0x80;
}
