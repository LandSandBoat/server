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

#include "common/logging.h"

#include "entities/char_entity.h"
#include "items/item.h"
#include "utils/charutils.h"

#include <algorithm>

NpcTradeTransaction::NpcTradeTransaction(xi::Badge<NpcTradeTransaction>, CCharEntity* player)
: player_(player)
{
}

NpcTradeTransaction::~NpcTradeTransaction()
{
    this->rollbackIfOpen();
}

auto NpcTradeTransaction::start(CCharEntity* player) -> std::unique_ptr<NpcTradeTransaction>
{
    if (!player)
    {
        return nullptr;
    }

    return std::unique_ptr<NpcTradeTransaction>(new NpcTradeTransaction(xi::Badge<NpcTradeTransaction>{}, player));
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

auto NpcTradeTransaction::confirmedQuantity(const uint8 tradeSlot) const -> uint32
{
    if (tradeSlot >= this->slots_.size())
    {
        return 0;
    }

    return this->slots_[tradeSlot].confirmed;
}

auto NpcTradeTransaction::confirm(const uint8 tradeSlot, const uint32 quantity) -> bool
{
    if (tradeSlot >= this->slots_.size())
    {
        return false;
    }

    auto& slot  = this->slots_[tradeSlot];
    auto* PItem = this->resolve(slot);

    if (!PItem || PItem->getQuantity() < quantity)
    {
        return false;
    }

    slot.confirmed = std::min(quantity, PItem->getQuantity());

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
        // The offer stays, so a script can still confirm it during a later event
        if (slot.confirmed == 0)
        {
            this->release(slot.offered);
        }
    }
}

// A script may open an event from onTrade and only confirm once it finishes, by which point the
// claim is gone. The offer still names a slot, so the stack is looked up again and taken back
auto NpcTradeTransaction::resolve(Slot& slot) -> CItem*
{
    // Resolved by identity, so a lookalike sitting in the slot is not the thing that was offered
    CItem* PItem = slot.offered.resolve();
    if (!PItem)
    {
        return nullptr;
    }

    // Re-claimed if the claim was let go after onTrade, though the offer never stopped naming it
    return this->claim(this->player_, PItem).isSet() ? PItem : nullptr;
}

auto NpcTradeTransaction::consumeConfirmed() -> bool
{
    bool tookEverything = true;

    for (auto& slot : this->slots_)
    {
        if (slot.confirmed > 0 && !this->consumeSlot(slot, slot.confirmed))
        {
            tookEverything = false;
        }
    }

    // Committing what did land, while telling the caller the offer was not honoured in full
    return this->commit() && tookEverything;
}

auto NpcTradeTransaction::consumeAll() -> bool
{
    bool tookEverything = true;

    for (auto& slot : this->slots_)
    {
        if (slot.offered.isSet() && !this->consumeSlot(slot, slot.quantity))
        {
            tookEverything = false;
        }
    }

    // Committing what did land, while telling the caller the offer was not honoured in full
    return this->commit() && tookEverything;
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

auto NpcTradeTransaction::doCommit() -> bool
{
    return true;
}

void NpcTradeTransaction::doRollback()
{
}
