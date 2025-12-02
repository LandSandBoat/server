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

#include "0x085_shop_sell_set.h"

#include "common/async.h"
#include "common/settings.h"
#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "packets/s2c/0x009_message.h"
#include "packets/s2c/0x01d_item_same.h"
#include "trade_container.h"
#include "utils/charutils.h"

namespace
{

const auto auditSale = [](CCharEntity* PChar, uint32_t itemId, uint32_t quantity, uint32_t basePrice)
{
    if (settings::get<bool>("map.AUDIT_PLAYER_VENDOR"))
    {
        // clang-format off
            Async::getInstance()->submit([itemId, quantity, seller = PChar->id, sellerName = PChar->getName(), basePrice]()
            {
                auto totalPrice = quantity * basePrice;

                const auto query = "INSERT INTO audit_vendor(itemid, quantity, seller, seller_name, baseprice, totalprice, date) VALUES (?, ?, ?, ?, ?, ?, UNIX_TIMESTAMP())";
                if (!db::preparedStmt(query, itemId, quantity, seller, sellerName, basePrice, totalPrice))
                {
                    ShowErrorFmt("Failed to log vendor sale (item: {}, quantity: {}, seller: {}, totalprice: {})", itemId, quantity, seller, totalPrice);
                }
            });
        // clang-format on
    }
};

} // namespace

auto GP_CLI_COMMAND_SHOP_SELL_SET::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isNotCrafting(PChar)
        .mustEqual(SellFlag, 1, "SellFlag not 1");
}

void GP_CLI_COMMAND_SHOP_SELL_SET::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Retrieve item-to-sell from last slot of the shop's container
    uint32      quantity = PChar->Container->getQuantity(PChar->Container->getExSize());
    uint16      itemId   = PChar->Container->getItemID(PChar->Container->getExSize());
    const uint8 slotId   = PChar->Container->getInvSlotID(PChar->Container->getExSize());

    if (const CItem* PGilItem = PChar->getStorage(LOC_INVENTORY)->GetItem(0); !PGilItem || !PGilItem->isType(ITEM_CURRENCY))
    {
        ShowWarning("GP_CLI_COMMAND_SHOP_SELL_SET: Player %s trying to sell an item without valid gil!", PChar->getName());
        return;
    }

    const CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotId);
    if (!PItem)
    {
        ShowWarning("GP_CLI_COMMAND_SHOP_SELL_SET: Player %s trying to sell an invalid item!", PChar->getName());
        return;
    }

    if (quantity < 1 || quantity > PItem->getStackSize()) // Possible exploit
    {
        ShowWarning("GP_CLI_COMMAND_SHOP_SELL_SET: Player %s trying to sell invalid quantity %u of itemID %u [to VENDOR] ", PChar->getName(), quantity, PItem->getID());
        return;
    }

    if (quantity > PItem->getQuantity())
    {
        ShowWarning("GP_CLI_COMMAND_SHOP_SELL_SET: Player %s trying to sell more items than they have in stack (%u/%u) of itemID %u [to VENDOR] ", PChar->getName(), quantity, PItem->getQuantity());
        return;
    }

    if (itemId != PItem->getID())
    {
        ShowWarning("GP_CLI_COMMAND_SHOP_SELL_SET: Player %s trying to sell an item different than the original ID (original: %u, current %u) [to VENDOR] ", PChar->getName(), itemId, PItem->getID());
        return;
    }

    if (PItem->isSubType(ITEM_LOCKED)) // Possible exploit
    {
        ShowWarning("GP_CLI_COMMAND_SHOP_SELL_SET: Player %s trying to sell %u of a LOCKED item! ID %i [to VENDOR] ", PChar->getName(), quantity, PItem->getID());
        return;
    }

    if (PItem->getReserve() > 0) // Usually caused by bug during synth, trade, etc. reserving the item. We don't want such items sold in this state.
    {
        ShowError("GP_CLI_COMMAND_SHOP_SELL_SET: Player %s trying to sell %u of a RESERVED(%u) item! ID %i [to VENDOR] ", PChar->getName(), quantity, PItem->getReserve(), PItem->getID());
        return;
    }

    const auto cost = quantity * PItem->getBasePrice();

    auditSale(PChar, itemId, quantity, PItem->getBasePrice());

    charutils::UpdateItem(PChar, LOC_INVENTORY, 0, cost);
    charutils::UpdateItem(PChar, LOC_INVENTORY, slotId, -static_cast<int32>(quantity));
    ShowInfo("GP_CLI_COMMAND_SHOP_SELL_SET: Player '%s' sold %u of itemID %u (Total: %u gil) [to VENDOR] ", PChar->getName(), quantity, itemId, cost);
    PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(nullptr, itemId, quantity, MsgStd::Sell);
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
    PChar->Container->setItem(PChar->Container->getSize() - 1, 0, -1, 0);
}
