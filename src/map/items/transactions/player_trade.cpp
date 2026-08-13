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

#include "common/logging.h"

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

} // namespace

PlayerTradeTransaction::PlayerTradeTransaction(xi::Badge<PlayerTradeTransaction>, CCharEntity* initiator, CCharEntity* target)
{
    this->sides_[0].PChar = initiator;
    this->sides_[1].PChar = target;
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

auto PlayerTradeTransaction::holds(const CItem* item) const -> bool
{
    if (!item)
    {
        return false;
    }

    for (const auto& side : this->sides_)
    {
        for (const auto& slot : side.slots)
        {
            if (slot.item == item)
            {
                return true;
            }
        }
    }

    return false;
}

auto PlayerTradeTransaction::sideOf(const CCharEntity* who) -> Side*
{
    if (!who)
    {
        return nullptr;
    }

    if (this->sides_[0].PChar == who)
    {
        return &this->sides_[0];
    }

    if (this->sides_[1].PChar == who)
    {
        return &this->sides_[1];
    }

    return nullptr;
}

auto PlayerTradeTransaction::partnerOf(const CCharEntity* who) const -> CCharEntity*
{
    if (this->sides_[0].PChar == who)
    {
        return this->sides_[1].PChar;
    }

    if (this->sides_[1].PChar == who)
    {
        return this->sides_[0].PChar;
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

// Runs from the destructor too, so it must not touch either character
void PlayerTradeTransaction::releaseSlot(Slot& slot) const
{
    if (!slot.item)
    {
        return;
    }

    exitTx(slot.item);
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
        auto* released = target.item;

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
            if (candidate.item && candidate.invSlot == fromInvSlot)
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
    const bool qtyExceeds    = item && qty + item->getReserve() > item->getQuantity();
    const bool rareOnPartner = item && item->hasFlag(ItemFlag::Rare) && charutils::HasItem(other, item->getID());

    if (wrongItem || exclusiveItem || qtyExceeds || rareOnPartner || !enterTx(item))
    {
        pushSlotView(transactionSlot);
        return nullptr;
    }

    who->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(item, ItemLockFlg::NoSelect);
    slot = Slot{ .item = item, .invSlot = inventorySlot, .qty = qty };
    pushSlotView(transactionSlot, item, qty);
    return item;
}

void PlayerTradeTransaction::closeAndRemove()
{
    auto* initiator = this->sides_[0].PChar;
    auto* target    = this->sides_[1].PChar;

    initiator->TradePending.clean();
    target->TradePending.clean();

    this->rollbackIfOpen();
    initiator->removeTransaction(this);
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
    auto* initiator = this->sides_[0].PChar;
    auto* target    = this->sides_[1].PChar;

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
        if (!slot.item)
        {
            continue;
        }

        ++slotsNeeded;

        if (slot.item->isType(ITEM_CURRENCY))
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
                                    return slot.item && slot.item->hasFlag(ItemFlag::Rare) && charutils::HasItem(receiver, slot.item->getID());
                                });
}

// Deliver to both sides before consuming either, so a failed delivery can be undone
auto PlayerTradeTransaction::doCommit() -> bool
{
    auto* initiator = this->sides_[0].PChar;
    auto* target    = this->sides_[1].PChar;

    const bool bothAccepted   = this->sides_[0].accepted && this->sides_[1].accepted;
    const bool partnerCanRecv = canReceive(this->sides_[0], target) && canReceive(this->sides_[1], initiator);
    const bool stillInRange   = withinTradeRange(initiator, target);

    if (!bothAccepted || !partnerCanRecv || !stillInRange)
    {
        return false;
    }

    struct Delivery
    {
        CCharEntity* receiver{};
        uint8        invSlot{};
        uint32       qty{};
    };

    std::vector<Delivery> delivered;
    delivered.reserve(MaxSlots * 2);

    const auto deliverSide = [&](const Side& sender, CCharEntity* receiver) -> bool
    {
        for (const auto& slot : sender.slots)
        {
            if (!slot.item)
            {
                continue;
            }

            // Cloned rather than spawned by id so exdata, signature and augments survive the trade
            auto clone = xi::items::clone(*slot.item);
            if (!clone)
            {
                return false;
            }

            clone->setQuantity(slot.qty);
            clone->setReserve(0);

            const uint8 deliveredSlot = charutils::AddItem(receiver, LOC_INVENTORY, std::move(clone));
            if (deliveredSlot == ERROR_SLOTID)
            {
                return false;
            }

            delivered.push_back({ .receiver = receiver, .invSlot = deliveredSlot, .qty = slot.qty });
        }

        return true;
    };

    const auto undoDeliveries = [&]()
    {
        for (const auto& delivery : delivered)
        {
            charutils::UpdateItem(delivery.receiver, LOC_INVENTORY, delivery.invSlot, -static_cast<int32>(delivery.qty));
        }
    };

    const auto consumeSide = [&](Side& sender)
    {
        for (auto& slot : sender.slots)
        {
            if (!slot.item)
            {
                continue;
            }

            const auto invSlot = slot.invSlot;
            const auto qty     = slot.qty;
            const auto itemID  = slot.item->getID();

            this->releaseSlot(slot);

            if (charutils::UpdateItem(sender.PChar, LOC_INVENTORY, invSlot, -static_cast<int32>(qty)) == 0)
            {
                ShowErrorFmt("PlayerTradeTransaction::doCommit: {} kept item {} after it was handed over", sender.PChar->getName(), itemID);
            }
        }
    };

    if (!deliverSide(this->sides_[0], target) || !deliverSide(this->sides_[1], initiator))
    {
        undoDeliveries();
        return false;
    }

    consumeSide(this->sides_[0]);
    consumeSide(this->sides_[1]);

    return true;
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
