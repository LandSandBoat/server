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

#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "items/item_linkshell.h"
#include "packets/s2c/0x023_item_trade_list.h"
#include "packets/s2c/0x025_item_trade_mylist.h"
#include "universal_container.h"

namespace
{

const auto auditTrade = [](Scheduler& scheduler, CCharEntity* PChar, CCharEntity* PTarget, const CItem* PItem, uint32_t ItemNum)
{
    if (settings::get<bool>("map.AUDIT_PLAYER_TRADES"))
    {
        scheduler.postToWorkerThread(
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
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent, BlockedState::Monstrosity })
        .mustNotEqual(PChar->TradePending.id, 0, "No trade target")
        .range("TradeIndex", this->TradeIndex, 0, 8);
}

void GP_CLI_COMMAND_TRADE_LIST::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PTarget = static_cast<CCharEntity*>(PChar->GetEntity(PChar->TradePending.targid, TYPE_PC));

    if (!PTarget ||
        PTarget->id != PChar->TradePending.id ||
        PChar->id != PTarget->TradePending.id)
    {
        ShowWarningFmt("GP_CLI_COMMAND_TRADE_LIST: Could not find trade targets.");
        return;
    }

    // If updating a filled slot, remove the pending item.
    if (!PChar->UContainer->IsSlotEmpty(this->TradeIndex))
    {
        CItem* PCurrentSlotItem = PChar->UContainer->GetItem(this->TradeIndex);
        if (this->ItemNum != 0)
        {
            ShowError("GP_CLI_COMMAND_TRADE_LIST: Player %s trying to update trade quantity of a RESERVED item! [Item: %i | Trade Slot: %i] ",
                      PChar->getName(),
                      PCurrentSlotItem->getID(),
                      this->TradeIndex);
        }

        PCurrentSlotItem->setReserve(0);
        PChar->UContainer->ClearSlot(this->TradeIndex);
    }

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(this->ItemIndex);

    // Validate that the item exists in sufficient quantity, is not reserved, and is not an EX item.
    if (!PItem ||
        PItem->getID() != this->ItemNo ||
        PItem->hasFlag(ItemFlag::Exclusive) ||
        this->ItemNum + PItem->getReserve() > PItem->getQuantity() ||
        PItem->isSubType(ITEM_LOCKED))
    {
        ShowErrorFmt("GP_CLI_COMMAND_TRADE_LIST: {} trying to add an invalid item/quantity [Item: {} | Trade Slot: {}] ",
                     PChar->getName(),
                     this->ItemNo,
                     this->TradeIndex);
        return;
    }

    // If item count is zero remove from container
    if (this->ItemNum == 0)
    {
        ShowInfo("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade updating trade slot id %d with item %s, quantity 0", PChar->getName(), PTarget->getName(), this->TradeIndex, PItem->getName());
        PItem->setReserve(0);
        PChar->UContainer->SetItem(this->TradeIndex, nullptr);
    }

    if (PItem->isType(ITEM_LINKSHELL))
    {
        auto* PItemLinkshell  = static_cast<CItemLinkshell*>(PItem);
        auto* PItemLinkshell1 = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK1));
        auto* PItemLinkshell2 = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK2));
        if ((!PItemLinkshell1 && !PItemLinkshell2) || ((!PItemLinkshell1 || PItemLinkshell1->GetLSID() != PItemLinkshell->GetLSID()) &&
                                                       (!PItemLinkshell2 || PItemLinkshell2->GetLSID() != PItemLinkshell->GetLSID())))
        {
            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::LinkshellEquipBeforeUsing);
            PItem->setReserve(0);
            PChar->UContainer->SetItem(this->TradeIndex, nullptr);
        }
        else
        {
            ShowInfo("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade updating trade slot id %d with item %s, quantity %d", PChar->getName(), PTarget->getName(), this->TradeIndex, PItem->getName(), this->ItemNum);
            PItem->setReserve(this->ItemNum + PItem->getReserve());
            PChar->UContainer->SetItem(this->TradeIndex, PItem);
        }
    }
    else
    {
        ShowInfo("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade updating trade slot id %d with item %s, quantity %d", PChar->getName(), PTarget->getName(), this->TradeIndex, PItem->getName(), this->ItemNum);
        PItem->setReserve(this->ItemNum + PItem->getReserve());
        PChar->UContainer->SetItem(this->TradeIndex, PItem);
    }

    // TODO: Don't pass around Scheduler& through PSession
    auditTrade(*PSession->scheduler, PChar, PTarget, PItem, this->ItemNum);

    ShowDebug("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade pushing packet to %s", PChar->getName(), PTarget->getName(), PChar->getName());
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_MYLIST>(PItem, this->TradeIndex);

    ShowDebug("GP_CLI_COMMAND_TRADE_LIST: %s->%s trade pushing packet to %s", PChar->getName(), PTarget->getName(), PTarget->getName());
    PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_LIST>(PItem, this->TradeIndex);

    PChar->UContainer->UnLock();
    PTarget->UContainer->UnLock();
}
