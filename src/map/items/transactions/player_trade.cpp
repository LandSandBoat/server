/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "player_trade.h"

#include "common/earth_time.h"
#include "common/logging.h"
#include "common/settings.h"

#include "entities/char_entity.h"
#include "enums/item_flag.h"
#include "enums/item_lockflg.h"
#include "enums/msg_std.h"
#include "item_container.h"
#include "items/item.h"
#include "packets/s2c/0x009_message.h"
#include "packets/s2c/0x01f_item_list.h"
#include "packets/s2c/0x022_item_trade_res.h"
#include "packets/s2c/0x023_item_trade_list.h"
#include "packets/s2c/0x025_item_trade_mylist.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

#include <algorithm>
#include <memory>
#include <vector>

namespace
{

// The client cancels on its own at this range, so this only catches one that does not
constexpr float TradeRange = 6.0f;

auto withinTradeRange(const CCharEntity* initiator, const CCharEntity* target) -> bool
{
    return distance(initiator->loc.p, target->loc.p) <= TradeRange && initiator->m_moghouseID == target->m_moghouseID;
}

const auto auditTrade = [](CCharEntity* PChar, const CCharEntity* PTarget, const uint16 itemId, const uint32 quantity)
{
    // TODO: Don't pass around Scheduler& through PSession
    if (!settings::get<bool>("map.AUDIT_PLAYER_TRADES") || !PChar->PSession || !PChar->PSession->scheduler)
    {
        return;
    }

    PChar->PSession->scheduler->postToWorkerThread(
        [itemId,
         quantity,
         sender        = PChar->id,
         sender_name   = PChar->getName(),
         receiver      = PTarget->id,
         receiver_name = PTarget->getName(),
         date          = earth_time::timestamp()]()
        {
            const auto query = "INSERT INTO audit_trade(itemid, quantity, sender, sender_name, receiver, receiver_name, date) VALUES (?, ?, ?, ?, ?, ?, ?)";
            if (!db::preparedStmt(query, itemId, quantity, sender, sender_name, receiver, receiver_name, date))
            {
                ShowErrorFmt("Failed to log trade transaction (item: {}, quantity: {}, sender: {}, receiver: {}, date: {})", itemId, quantity, sender, receiver, date);
            }
        });
};

} // namespace

PlayerTradeTransaction::PlayerTradeTransaction(xi::Badge<PlayerTradeTransaction>, CCharEntity* initiator, CCharEntity* target)
{
    this->sides_[0].who = EntityId(initiator);
    this->sides_[1].who = EntityId(target);
}

PlayerTradeTransaction::~PlayerTradeTransaction()
{
    this->rollbackIfOpen();
}

auto PlayerTradeTransaction::start(CCharEntity* initiator, CCharEntity* target) -> PlayerTradeTransaction*
{
    const bool invalidPlayers = !initiator || !target || initiator == target;
    const bool eitherInTrade  = !invalidPlayers && (initiator->activePlayerTradeTransaction() || target->activePlayerTradeTransaction());
    const bool outOfReach     = !invalidPlayers && !withinTradeRange(initiator, target);

    if (invalidPlayers || eitherInTrade || outOfReach)
    {
        return nullptr;
    }

    auto transaction = std::unique_ptr<PlayerTradeTransaction>(
        new PlayerTradeTransaction(xi::Badge<PlayerTradeTransaction>{}, initiator, target));
    return initiator->addTransaction(std::move(transaction));
}

void PlayerTradeTransaction::cancel(CCharEntity* leaving)
{
    if (auto* transaction = leaving->activePlayerTradeTransaction())
    {
        transaction->abort(leaving);
        return;
    }

    auto* partner = leaving->tradePartner();
    if (!partner)
    {
        return;
    }

    leaving->TradePending.clean();
    partner->TradePending.clean();
    partner->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(leaving, GP_ITEM_TRADE_RES_KIND::Cancell);
}

auto PlayerTradeTransaction::sideOf(const CCharEntity* who) -> Side*
{
    if (!who)
    {
        return nullptr;
    }

    if (this->sides_[0].who == who)
    {
        return &this->sides_[0];
    }

    if (this->sides_[1].who == who)
    {
        return &this->sides_[1];
    }

    return nullptr;
}

auto PlayerTradeTransaction::charOf(const Side& side) -> CCharEntity*
{
    return side.who.resolve<CCharEntity>();
}

auto PlayerTradeTransaction::partnerOf(const CCharEntity* who) const -> CCharEntity*
{
    if (this->sides_[0].who == who)
    {
        return charOf(this->sides_[1]);
    }

    if (this->sides_[1].who == who)
    {
        return charOf(this->sides_[0]);
    }

    return nullptr;
}

auto PlayerTradeTransaction::accept(const CCharEntity* who) -> bool
{
    if (auto* side = this->sideOf(who))
    {
        side->accepted = true;
    }

    return this->sides_[0].accepted && this->sides_[1].accepted;
}

// also runs from the destructor, so it must not touch either character
void PlayerTradeTransaction::releaseSlot(Slot& slot)
{
    this->release(slot.staged);

    slot = Slot{};
}

auto PlayerTradeTransaction::setSlot(CCharEntity* who, const uint8 transactionSlot, const uint8 inventorySlot, const uint16 expectedItemId, const uint32 qty) -> CItem*
{
    if (transactionSlot >= MaxSlots)
    {
        return nullptr;
    }

    auto* side  = this->sideOf(who);
    auto* other = this->partnerOf(who);
    if (!side || !other)
    {
        return nullptr;
    }

    // Send the packet to both sides
    const auto pushSlotView = [&](uint8 slot, CItem* item = nullptr, uint32 viewQty = 0)
    {
        who->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_MYLIST>(item, slot, viewQty);
        other->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_LIST>(item, slot, viewQty);
    };

    const auto releaseAndRestore = [&](Slot& target)
    {
        auto* released = target.staged.resolve();

        this->releaseSlot(target);

        if (released)
        {
            who->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(released, ItemLockFlg::Normal);
        }
    };

    // Any slot mutation invalidates both sides' Make
    this->sides_[0].accepted = false;
    this->sides_[1].accepted = false;

    auto& slot = side->slots[transactionSlot];
    releaseAndRestore(slot);

    if (qty == 0)
    {
        pushSlotView(transactionSlot);
        return nullptr;
    }

    const auto findOtherSlotStaging = [&](const uint8 fromInvSlot) -> Slot*
    {
        for (uint8 slotIdx = 0; slotIdx < MaxSlots; ++slotIdx)
        {
            if (slotIdx == transactionSlot)
            {
                continue;
            }

            auto& candidate = side->slots[slotIdx];
            if (candidate.staged.isSet() && candidate.staged.slot == fromInvSlot)
            {
                return &candidate;
            }
        }

        return nullptr;
    };

    // Retail drops the earlier stage and refuses the new one when the same inv slot is staged twice
    if (auto* alreadyStaged = findOtherSlotStaging(inventorySlot))
    {
        const auto stagedTxSlot = static_cast<uint8>(alreadyStaged - side->slots.data());

        releaseAndRestore(*alreadyStaged);
        pushSlotView(stagedTxSlot);
        pushSlotView(transactionSlot);
        return nullptr;
    }

    auto* item = who->getStorage(LOC_INVENTORY)->GetItem(inventorySlot);

    const bool wrongItem     = !item || item->getID() != expectedItemId;
    const bool exclusiveItem = item && item->hasFlag(ItemFlag::Exclusive);
    const bool qtyExceeds    = item && qty > item->getQuantity();
    const bool rareOnPartner = item && item->hasFlag(ItemFlag::Rare) && charutils::HasItem(other, item->getID());

    const auto staged = (wrongItem || exclusiveItem || qtyExceeds || rareOnPartner) ? ItemId{} : this->claim(who, item);

    if (!staged.isSet())
    {
        pushSlotView(transactionSlot);
        return nullptr;
    }

    who->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(item, ItemLockFlg::NoSelect);
    slot = Slot{ .staged = staged, .qty = qty };
    pushSlotView(transactionSlot, item, qty);
    return item;
}

void PlayerTradeTransaction::closeAndRemove()
{
    auto* initiator = charOf(this->sides_[0]);

    // a side that no longer resolves has nothing to clean up; the other side still does
    for (const auto& side : this->sides_)
    {
        auto* PChar = charOf(side);
        if (!PChar)
        {
            continue;
        }

        PChar->TradePending.clean();

        // staging greys the item out on the client, so it has to be told when the trade ends
        for (const auto& slot : side.slots)
        {
            if (auto* PItem = slot.staged.resolve())
            {
                PChar->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PItem, ItemLockFlg::Normal);
            }
        }
    }

    this->rollbackIfOpen();

    // owned by the initiator, so if they are gone the transaction went with them
    if (initiator)
    {
        initiator->removeTransaction(this);
    }
}

void PlayerTradeTransaction::abort(CCharEntity* leaving)
{
    if (auto* other = this->partnerOf(leaving))
    {
        other->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(leaving, GP_ITEM_TRADE_RES_KIND::Cancell);
    }
    else
    {
        ShowWarningFmt("PlayerTradeTransaction::abort: {} is not part of this trade", leaving->getName());
    }

    this->closeAndRemove();
}

void PlayerTradeTransaction::commitAndClose()
{
    auto* initiator = charOf(this->sides_[0]);
    auto* target    = charOf(this->sides_[1]);

    if (!initiator || !target)
    {
        ShowWarningFmt("PlayerTradeTransaction::commitAndClose: a side left before the trade closed");
        this->closeAndRemove();

        return;
    }

    const bool ok = this->commit();
    if (!ok)
    {
        ShowInfoFmt("PlayerTradeTransaction::commitAndClose: trade refused ({} <-> {})", initiator->getName(), target->getName());
    }

    const auto kind = [ok]()
    {
        if (ok)
        {
            return GP_ITEM_TRADE_RES_KIND::End;
        }

        return GP_ITEM_TRADE_RES_KIND::Cancell;
    }();

    if (!ok)
    {
        initiator->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::TradeCanceled);
        target->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::TradeCanceled);
    }

    initiator->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(target, kind);
    target->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(initiator, kind);

    this->closeAndRemove();
}

auto PlayerTradeTransaction::canReceive(const Side& sender, CCharEntity* receiver) -> bool
{
    uint8  slotsNeeded = 0;
    uint32 gilOffered  = 0;
    for (const auto& slot : sender.slots)
    {
        if (!slot.staged.isSet())
        {
            continue;
        }

        ++slotsNeeded;

        if (slot.staged.itemId == 0xFFFF)
        {
            gilOffered += slot.qty;
        }
    }

    if (slotsNeeded == 0)
    {
        return true;
    }

    if (receiver->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() < slotsNeeded)
    {
        return false;
    }

    // Existing gil plus the offer has to fit in one stack
    if (gilOffered > 0)
    {
        const auto* receiverGil   = receiver->getStorage(LOC_INVENTORY)->GetItem(0);
        const bool  noReceiverGil = !receiverGil;
        const bool  wouldOverflow = !noReceiverGil &&
                                    static_cast<uint64>(receiverGil->getQuantity()) + gilOffered > receiverGil->getStackSize();

        if (noReceiverGil || wouldOverflow)
        {
            return false;
        }
    }

    return std::ranges::none_of(sender.slots,
                                [receiver](const Slot& slot)
                                {
                                    const CItem* PStaged = slot.staged.resolve();

                                    return PStaged && PStaged->hasFlag(ItemFlag::Rare) && charutils::HasItem(receiver, PStaged->getID());
                                });
}

// Deliver to both sides before consuming either, so a failed delivery can be undone
auto PlayerTradeTransaction::doCommit() -> bool
{
    auto* initiator = charOf(this->sides_[0]);
    auto* target    = charOf(this->sides_[1]);

    // one side no longer resolves, so there is nothing to exchange
    if (!initiator || !target)
    {
        return false;
    }

    const bool bothAccepted   = this->sides_[0].accepted && this->sides_[1].accepted;
    const bool partnerCanRecv = canReceive(this->sides_[0], target) && canReceive(this->sides_[1], initiator);
    const bool stillInRange   = withinTradeRange(initiator, target);

    if (!bothAccepted || !partnerCanRecv || !stillInRange)
    {
        return false;
    }

    const auto deliverSide = [&](const Side& sender, CCharEntity* receiver) -> bool
    {
        for (const auto& slot : sender.slots)
        {
            const CItem* PStaged = slot.staged.resolve();
            if (!PStaged)
            {
                continue;
            }

            // cloned rather than spawned by id, so exdata, signature and augments survive the trade
            auto clone = xi::items::clone(*PStaged);
            if (!clone)
            {
                return false;
            }

            clone->setQuantity(slot.qty);

            if (!this->give(receiver, LOC_INVENTORY, std::move(clone)))
            {
                return false;
            }
        }

        return true;
    };

    const auto consumeSide = [&](Side& sender) -> bool
    {
        for (auto& slot : sender.slots)
        {
            if (!slot.staged.isSet())
            {
                continue;
            }

            auto* PSender = charOf(sender);
            if (!PSender || !slot.staged.resolve() || !this->take(PSender, LOC_INVENTORY, slot.staged.slot, slot.qty))
            {
                ShowErrorFmt("PlayerTradeTransaction::doCommit: {} kept item {} after it was handed over", PSender ? PSender->getName() : "?", slot.staged.itemId);
                return false;
            }

            this->releaseSlot(slot);
        }

        return true;
    };

    // consumeSide wipes the slots, so we need a way to save what changed hands now and log it only once the trade is successful
    const auto traded = this->tradedItems(initiator, target);

    // is the trade successfully executed?
    const auto exchanged = deliverSide(this->sides_[0], target) &&
                           deliverSide(this->sides_[1], initiator) &&
                           consumeSide(this->sides_[0]) &&
                           consumeSide(this->sides_[1]);

    // If anything is not successful, trade fails
    if (!exchanged)
    {
        return false;
    }

    // Log every item if it was successful AFTER the trade has been completed
    for (const auto& item : traded)
    {
        auditTrade(item.sender, item.receiver, item.itemId, item.qty);
    }

    return true;
}

auto PlayerTradeTransaction::tradedItems(CCharEntity* initiator, CCharEntity* target) const -> std::vector<TradedItem>
{
    std::vector<TradedItem> traded;

    const auto collect = [&](const Side& side, CCharEntity* sender, CCharEntity* receiver)
    {
        for (const auto& slot : side.slots)
        {
            if (const CItem* PStaged = slot.staged.resolve())
            {
                traded.push_back({ .sender = sender, .receiver = receiver, .itemId = PStaged->getID(), .qty = slot.qty });
            }
        }
    };

    collect(this->sides_[0], initiator, target);
    collect(this->sides_[1], target, initiator);

    return traded;
}

void PlayerTradeTransaction::doRollback()
{
    for (auto& side : this->sides_)
    {
        for (auto& slot : side.slots)
        {
            this->releaseSlot(slot);
        }
    }
}
