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

#include "0x034_trade_list.h"

#include "common/async.h"
#include "entities/charentity.h"
#include "items/item_linkshell.h"
#include "packets/s2c/0x023_item_trade_list.h"
#include "packets/s2c/0x025_item_trade_mylist.h"
#include "universal_container.h"

namespace
{
    const auto auditTrade = [](CCharEntity* PChar, CCharEntity* PTarget, const CItem* PItem, uint32_t ItemNum)
    {
        if (settings::get<bool>("map.AUDIT_PLAYER_TRADES"))
        {
            Async::getInstance()->submit(
                [itemID        = PItem->getID(),
                 quantity      = ItemNum,
                 sender        = PChar->id,
                 sender_name   = PChar->getName(),
                 receiver      = PTarget->id,
                 receiver_name = PTarget->getName(),
                 date          = earth_time::timestamp()]()
                {
                    const auto query = "INSERT INTO audit_trade(itemid, quantity, sender, sender_name, receiver, receiver_name, date) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    if (!db::preparedStmt(query, itemID, quantity, sender, sender_name, receiver, receiver_name, date))
                    {
                        ShowErrorFmt("Failed to log trade transaction (item: {}, quantity: {}, sender: {}, receiver: {}, date: {})", itemID, quantity, sender, receiver, date);
                    }
                });
        }
    };
} // namespace

auto GP_CLI_COMMAND_TRADE_LIST::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(PChar->TradePending.id, 0, "No trade target")
        .range("TradeIndex", TradeIndex, 0, 8)
        .isNotMonstrosity(PChar);
}

void GP_CLI_COMMAND_TRADE_LIST::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PTarget = static_cast<CCharEntity*>(PChar->GetEntity(PChar->TradePending.targid, TYPE_PC));

    if (!PTarget ||
        PTarget->id != PChar->TradePending.id ||
        PChar->TradePending.id != PTarget->id)
    {
        ShowWarningFmt("GP_CLI_COMMAND_TRADE_LIST: Could not find trade targets.");
        return;
    }

    // If updating a filled slot, remove the pending item.
    if (!PChar->UContainer->IsSlotEmpty(TradeIndex))
    {
        CItem* PCurrentSlotItem = PChar->UContainer->GetItem(TradeIndex);
        if (ItemNum != 0)
        {
            ShowError("GP_CLI_COMMAND_TRADE_LIST: Player %s trying to update trade quantity of a RESERVED item! [Item: %i | Trade Slot: %i] ",
                      PChar->getName(), PCurrentSlotItem->getID(), TradeIndex);
        }

        PCurrentSlotItem->setReserve(0);
        PChar->UContainer->ClearSlot(TradeIndex);
    }

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(ItemIndex);

    // Validate that the item exists in sufficient quantity, is not reserved, and is not an EX item.
    if (!PItem ||
        PItem->getID() != ItemNo ||
        PItem->getFlag() & ITEM_FLAG_EX ||
        ItemNum + PItem->getReserve() > PItem->getQuantity() ||
        PItem->isSubType(ITEM_LOCKED))
    {
        ShowErrorFmt("GP_CLI_COMMAND_TRADE_LIST: {} trying to add an invalid item/quantity [Item: {} | Trade Slot: {}] ",
                     PChar->getName(), ItemNo, TradeIndex);
        return;
    }

    // If item count is zero remove from container
    if (ItemNum == 0)
    {
        ShowInfo("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade updating trade slot id %d with item %s, quantity 0", PChar->getName(), PTarget->getName(),
                 TradeIndex, PItem->getName());
        PItem->setReserve(0);
        PChar->UContainer->SetItem(TradeIndex, nullptr);
    }

    if (PItem->isType(ITEM_LINKSHELL))
    {
        auto* PItemLinkshell  = static_cast<CItemLinkshell*>(PItem);
        auto* PItemLinkshell1 = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK1));
        auto* PItemLinkshell2 = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK2));
        if ((!PItemLinkshell1 && !PItemLinkshell2) || ((!PItemLinkshell1 || PItemLinkshell1->GetLSID() != PItemLinkshell->GetLSID()) &&
                                                       (!PItemLinkshell2 || PItemLinkshell2->GetLSID() != PItemLinkshell->GetLSID())))
        {
            PChar->pushPacket<CMessageStandardPacket>(MsgStd::LinkshellEquipBeforeUsing);
            PItem->setReserve(0);
            PChar->UContainer->SetItem(TradeIndex, nullptr);
        }
        else
        {
            ShowInfo("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade updating trade slot id %d with item %s, quantity %d", PChar->getName(), PTarget->getName(),
                     TradeIndex, PItem->getName(), ItemNum);
            PItem->setReserve(ItemNum + PItem->getReserve());
            PChar->UContainer->SetItem(TradeIndex, PItem);
        }
    }
    else
    {
        ShowInfo("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade updating trade slot id %d with item %s, quantity %d", PChar->getName(), PTarget->getName(),
                 TradeIndex, PItem->getName(), ItemNum);
        PItem->setReserve(ItemNum + PItem->getReserve());
        PChar->UContainer->SetItem(TradeIndex, PItem);
    }

    auditTrade(PChar, PTarget, PItem, ItemNum);

    ShowDebug("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade pushing packet to %s", PChar->getName(), PTarget->getName(), PChar->getName());
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_MYLIST>(PItem, TradeIndex);

    ShowDebug("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade pushing packet to %s", PChar->getName(), PTarget->getName(), PTarget->getName());
    PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_LIST>(PItem, TradeIndex);

    PChar->UContainer->UnLock();
    PTarget->UContainer->UnLock();
}
