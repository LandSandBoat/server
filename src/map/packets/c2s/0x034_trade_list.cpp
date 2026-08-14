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

#include "entities/char_entity.h"
#include "enums/msg_std.h"
#include "items.h"
#include "items/item_linkshell.h"
#include "items/transactions/player_trade.h"

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

const auto hasLinkshellEquipped = [](const CCharEntity* PChar, CItemLinkshell* POffered) -> bool
{
    const auto asLinkshell = [](CItemEquipment* PEquipped) -> CItemLinkshell*
    {
        auto* PLinkshell = reinterpret_cast<CItemLinkshell*>(PEquipped);
        if (!PLinkshell || !PLinkshell->isType(ITEM_LINKSHELL))
        {
            return nullptr;
        }

        return PLinkshell;
    };

    for (const auto slot : { SLOT_LINK1, SLOT_LINK2 })
    {
        auto* PEquipped = asLinkshell(PChar->getEquip(slot));
        if (PEquipped && PEquipped->GetLSID() == POffered->GetLSID())
        {
            return true;
        }
    }

    return false;
};

} // namespace

auto GP_CLI_COMMAND_TRADE_LIST::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent, BlockedState::Monstrosity })
        .mustNotEqual(PChar->TradePending.UniqueNo, 0, "No trade target")
        .range("TradeIndex", this->TradeIndex, 0, 8)
        .custom([&](PacketValidator& v)
                {
                    v.mustEqual(this->ItemNo == static_cast<uint16>(ITEMID::GIL),
                                this->TradeIndex == PlayerTradeTransaction::GilSlot,
                                "Gil belongs in the gil trade slot");
                });
}

void GP_CLI_COMMAND_TRADE_LIST::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PTarget     = PChar->tradePartner();
    auto* transaction = PChar->activePlayerTradeTransaction();
    if (!PTarget || !transaction)
    {
        ShowWarningFmt("GP_CLI_COMMAND_TRADE_LIST: no active player trade for {}", PChar->getName());
        return;
    }

    // Must have the relevant linkshell equipping to offer a pearl
    auto* POffered = PChar->getStorage(LOC_INVENTORY)->GetItem(this->ItemIndex);
    if (this->ItemNum > 0 && POffered && POffered->isType(ITEM_LINKSHELL) && !hasLinkshellEquipped(PChar, static_cast<CItemLinkshell*>(POffered)))
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::LinkshellEquipBeforeUsing);
        return;
    }

    if (const auto* PItem = transaction->setSlot(PChar, this->TradeIndex, this->ItemIndex, this->ItemNo, this->ItemNum))
    {
        // TODO: Don't pass around Scheduler& through PSession
        auditTrade(*PSession->scheduler, PChar, PTarget, PItem, this->ItemNum);
    }
}
