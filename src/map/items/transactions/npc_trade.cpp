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

#include "npc_trade.h"

#include "common/earth_time.h"
#include "common/logging.h"
#include "common/settings.h"

#include "entities/base_entity.h"
#include "entities/char_entity.h"
#include "items/item.h"
#include "utils/charutils.h"

#include <algorithm>

namespace
{

const auto auditTrade = [](CCharEntity* PChar, const uint32 npcId, const std::string& npcName, const uint16 itemId, const uint32 quantity)
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
         receiver      = npcId,
         receiver_name = npcName,
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

NpcTradeTransaction::NpcTradeTransaction(xi::Badge<NpcTradeTransaction>, CCharEntity* player, const CBaseEntity* npc)
: player_(player)
, npcId_(npc->id)
, npcName_(npc->getName())
{
}

NpcTradeTransaction::~NpcTradeTransaction()
{
    this->rollbackIfOpen();
}

auto NpcTradeTransaction::start(CCharEntity* player, const CBaseEntity* npc) -> std::unique_ptr<NpcTradeTransaction>
{
    if (!player || !npc)
    {
        return nullptr;
    }

    return std::unique_ptr<NpcTradeTransaction>(new NpcTradeTransaction(xi::Badge<NpcTradeTransaction>{}, player, npc));
}

auto NpcTradeTransaction::stage(const uint8 tradeSlot, CItem* item, const uint32 quantity) -> bool
{
    if (tradeSlot >= this->slots_.size() || !item)
    {
        return false;
    }

    auto& slot = this->slots_[tradeSlot];
    if (slot.offered.isSet())
    {
        ShowErrorFmt("NpcTradeTransaction: {} staged trade slot {} twice", this->player_->getName(), tradeSlot);
        return false;
    }

    slot.offered  = this->claim(this->player_, item);
    slot.quantity = quantity;

    return slot.offered.isSet();
}

auto NpcTradeTransaction::item(const uint8 tradeSlot) -> CItem*
{
    if (tradeSlot >= this->slots_.size())
    {
        return nullptr;
    }

    return this->resolve(this->slots_[tradeSlot]);
}

auto NpcTradeTransaction::quantity(const uint8 tradeSlot) const -> uint32
{
    if (tradeSlot >= this->slots_.size())
    {
        return 0;
    }

    return this->slots_[tradeSlot].quantity;
}

auto NpcTradeTransaction::confirm(const uint8 tradeSlot, const uint32 quantity) -> bool
{
    if (tradeSlot >= this->slots_.size())
    {
        return false;
    }

    auto& slot  = this->slots_[tradeSlot];
    auto* PItem = this->resolve(slot);

    // bounded by the offer as well as the stack, so a script cannot reach past what was traded
    if (!PItem || quantity > slot.quantity || PItem->getQuantity() < quantity)
    {
        return false;
    }

    slot.confirmed = quantity;

    return true;
}

auto NpcTradeTransaction::confirmById(const uint16 itemId, const uint32 quantity) -> bool
{
    for (uint8 tradeSlot = 0; tradeSlot < this->slots_.size(); ++tradeSlot)
    {
        if (this->slots_[tradeSlot].offered.itemId == itemId)
        {
            return this->confirm(tradeSlot, quantity);
        }
    }

    return false;
}

void NpcTradeTransaction::releaseUnconfirmed()
{
    for (auto& slot : this->slots_)
    {
        // the offer is kept, so a script can still confirm it during a later event
        if (slot.confirmed == 0)
        {
            this->release(slot.offered);
        }
    }
}

// releaseUnconfirmed may already have dropped the claim, so this re-takes it.
// Needed when a script opens an event from onTrade and confirms only once that event finishes
auto NpcTradeTransaction::resolve(Slot& slot) -> CItem*
{
    // by uid, so a different stack that has since taken the slot is not mistaken for the offer
    CItem* PItem = slot.offered.resolve();
    if (!PItem)
    {
        return nullptr;
    }

    // claim() returns the existing claim if it was never released
    return this->claim(this->player_, PItem).isSet() ? PItem : nullptr;
}

auto NpcTradeTransaction::consumeConfirmed() -> bool
{
    // consumeSlot wipes the slots, so we need a way to save what changed hands now and log it only once the trade is successful
    const auto traded = this->tradedItems(true);

    for (auto& slot : this->slots_)
    {
        // all or nothing: a partial take rolls back rather than leaving the offer half consumed
        if (slot.confirmed > 0 && !this->consumeSlot(slot, slot.confirmed))
        {
            this->rollback();

            return false;
        }
    }

    if (!this->commit())
    {
        return false;
    }

    // Log every item if it was successful AFTER the trade has been completed
    for (const auto& item : traded)
    {
        auditTrade(this->player_, this->npcId_, this->npcName_, item.itemId, item.qty);
    }

    return true;
}

auto NpcTradeTransaction::consumeAll() -> bool
{
    // consumeSlot wipes the slots, so we need a way to save what changed hands now and log it only once the trade is successful
    const auto traded = this->tradedItems(false);

    for (auto& slot : this->slots_)
    {
        if (slot.offered.isSet() && !this->consumeSlot(slot, slot.quantity))
        {
            this->rollback();

            return false;
        }
    }

    if (!this->commit())
    {
        return false;
    }

    // Log every item if it was successful AFTER the trade has been completed
    for (const auto& item : traded)
    {
        auditTrade(this->player_, this->npcId_, this->npcName_, item.itemId, item.qty);
    }

    return true;
}

auto NpcTradeTransaction::tradedItems(const bool confirmedOnly) const -> std::vector<TradedItem>
{
    std::vector<TradedItem> traded;

    for (const auto& slot : this->slots_)
    {
        const auto qty = [&]() -> uint32
        {
            if (confirmedOnly)
            {
                return slot.confirmed;
            }

            return slot.quantity;
        }();

        const CItem* PStaged = slot.offered.resolve();
        if (qty > 0 && PStaged)
        {
            traded.push_back({ .itemId = PStaged->getID(), .qty = qty });
        }
    }

    return traded;
}

auto NpcTradeTransaction::consumeSlot(Slot& slot, const uint32 quantity) -> bool
{
    const auto invSlot = slot.offered.slot;

    if (!this->resolve(slot))
    {
        ShowErrorFmt("NpcTradeTransaction: {} no longer holds the item offered in slot {}", this->player_->getName(), invSlot);
        slot = Slot{};

        return false;
    }

    if (!this->take(this->player_, LOC_INVENTORY, invSlot, quantity))
    {
        ShowErrorFmt("NpcTradeTransaction: {} kept the item in slot {} after trading it away", this->player_->getName(), invSlot);
        return false;
    }

    slot = Slot{};

    return true;
}

// the work is the caller's steps, and the base releases the claims
auto NpcTradeTransaction::doCommit() -> bool
{
    return true;
}

// nothing of its own to put back: the base runs the undos and releases the claims
void NpcTradeTransaction::doRollback()
{
}
