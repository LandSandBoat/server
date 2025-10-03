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

#include "0x083_shop_buy.h"

#include "entities/charentity.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x03f_shop_buy.h"
#include "trade_container.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

auto GP_CLI_COMMAND_SHOP_BUY::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(PropertyItemIndex, 0, "PropertyItemIndex not 0");
}

void GP_CLI_COMMAND_SHOP_BUY::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto quantity = ItemNum;

    // Prevent users from buying from invalid container slots
    if (ShopItemIndex > PChar->Container->getExSize() - 1)
    {
        ShowError("User '%s' attempting to buy vendor item from an invalid slot!", PChar->getName());
        return;
    }

    const uint16 itemId = PChar->Container->getItemID(ShopItemIndex);
    const uint32 price  = PChar->Container->getQuantity(ShopItemIndex); // We used the "quantity" to store the item's sale price

    const CItem* PItem = itemutils::GetItemPointer(itemId);
    if (!PItem)
    {
        ShowWarning("User '%s' attempting to buy an invalid item from vendor!", PChar->getName());
        return;
    }

    // Prevent purchasing larger stacks than the actual stack size in database.
    if (quantity > PItem->getStackSize())
    {
        quantity = PItem->getStackSize();
    }

    const CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

    if (!gil || !gil->isType(ITEM_CURRENCY) || gil->getReserve() != 0)
    {
        ShowError("User '%s' has invalid gil", PChar->getName());
        return;
    }

    if (gil->getQuantity() >= (price * quantity))
    {
        if (charutils::AddItem(PChar, LOC_INVENTORY, itemId, quantity) != ERROR_SLOTID)
        {
            charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -static_cast<int32>(price * quantity));
            ShowInfo("User '%s' purchased %u of item of ID %u [from VENDOR] ", PChar->getName(), quantity, itemId);
            PChar->pushPacket<GP_SERV_COMMAND_SHOP_BUY>(ShopItemIndex, quantity);
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
        }
    }
}
