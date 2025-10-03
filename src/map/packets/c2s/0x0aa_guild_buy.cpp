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

#include "0x0aa_guild_buy.h"

#include "entities/charentity.h"
#include "items/item.h"
#include "items/item_shop.h"
#include "packets/guild_menu_buy_update.h"
#include "packets/s2c/0x01d_item_same.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

auto GP_CLI_COMMAND_GUILD_BUY::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(PChar->PGuildShop, nullptr, "Character does not have a guild shop")
        .range("ItemNum", ItemNum, 1, 99)
        .mustEqual(PropertyItemIndex, 0, "PropertyItemIndex not 0");
}

void GP_CLI_COMMAND_GUILD_BUY::process(MapSession* PSession, CCharEntity* PChar) const
{
    uint8 quantity = ItemNum;

    const CItem* PItem = itemutils::GetItemPointer(ItemNo);
    if (!PItem)
    {
        ShowWarning("User '%s' attempting to buy an invalid item from guild vendor!", PChar->getName());
        return;
    }

    const uint8 shopSlotId = PChar->PGuildShop->SearchItem(ItemNo);

    if (shopSlotId == ERROR_SLOTID)
    {
        ShowWarning("User '%s' attempting to buy an item not in guild vendor: %u", PChar->getName(), ItemNo);
        return;
    }

    const auto   item = static_cast<CItemShop*>(PChar->PGuildShop->GetItem(shopSlotId));
    const CItem* gil  = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

    if (!gil || !gil->isType(ITEM_CURRENCY) || gil->getReserve() != 0 || !item)
    {
        return;
    }

    // Prevent purchasing larger stacks than the actual stack size in database.
    if (quantity > PItem->getStackSize())
    {
        quantity = PItem->getStackSize();
    }

    if (item->getQuantity() >= quantity)
    {
        if (gil->getQuantity() > (item->getBasePrice() * quantity))
        {
            if (charutils::AddItem(PChar, LOC_INVENTORY, ItemNo, quantity) != ERROR_SLOTID)
            {
                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -static_cast<int32>(item->getBasePrice() * quantity));
                ShowInfo("GP_CLI_COMMAND_GUILD_BUY: Player '%s' purchased %u of itemID %u [from GUILD] ", PChar->getName(), quantity, ItemNo);
                PChar->PGuildShop->GetItem(shopSlotId)->setQuantity(PChar->PGuildShop->GetItem(shopSlotId)->getQuantity() - quantity);
                PChar->pushPacket<CGuildMenuBuyUpdatePacket>(PChar, PChar->PGuildShop->GetItem(PChar->PGuildShop->SearchItem(ItemNo))->getQuantity(), ItemNo, quantity);
                PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
            }
        }
    }
    // TODO: error messages!
}
