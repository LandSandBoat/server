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

auto NpcTradeTransaction::stage(const uint8 tradeSlot, CItem* item, const uint8 invSlot, const uint32 quantity) -> bool
{
    if (tradeSlot >= this->slots_.size() || !item)
    {
        return false;
    }

    auto& slot = this->slots_[tradeSlot];
    if (slot.item)
    {
        ShowErrorFmt("NpcTradeTransaction: {} staged trade slot {} twice", this->player_->getName(), tradeSlot);
        return false;
    }

    if (!enterTx(item))
    {
        return false;
    }

    slot.item     = item;
    slot.itemId   = item->getID();
    slot.invSlot  = invSlot;
    slot.quantity = quantity;

    // Legacy claim, kept in step with the real one until it is deleted outright
    item->setReserve(quantity);

    return true;
}

auto NpcTradeTransaction::item(const uint8 tradeSlot) -> CItem*
{
    if (tradeSlot >= this->slots_.size())
    {
        return nullptr;
    }

    return this->resolve(this->slots_[tradeSlot]);
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
    PItem->setReserve(slot.confirmed);

    return true;
}

void NpcTradeTransaction::releaseUnconfirmed()
{
    for (auto& slot : this->slots_)
    {
        if (slot.item && slot.confirmed == 0)
        {
            this->releaseClaim(slot);
        }
    }
}

// A script may open an event from onTrade and only confirm once it finishes, by which point the
// claim is gone. The offer still names a slot, so the stack is looked up again and taken back
auto NpcTradeTransaction::resolve(Slot& slot) -> CItem*
{
    if (slot.item)
    {
        return slot.item;
    }

    if (slot.invSlot == 0xFF)
    {
        return nullptr;
    }

    CItem* PItem = this->player_->getStorage(LOC_INVENTORY)->GetItem(slot.invSlot);
    if (!PItem || PItem->getID() != slot.itemId)
    {
        return nullptr;
    }

    if (PItem->getReserve() > 0 || !enterTx(PItem))
    {
        return nullptr;
    }

    slot.item = PItem;

    return PItem;
}

auto NpcTradeTransaction::consumeConfirmed() -> bool
{
    for (auto& slot : this->slots_)
    {
        if (slot.confirmed > 0)
        {
            this->consumeSlot(slot, slot.confirmed);
        }
    }

    return this->commit();
}

auto NpcTradeTransaction::consumeAll() -> bool
{
    for (auto& slot : this->slots_)
    {
        if (slot.invSlot != 0xFF)
        {
            this->consumeSlot(slot, slot.quantity);
        }
    }

    return this->commit();
}

void NpcTradeTransaction::consumeSlot(Slot& slot, const uint32 quantity)
{
    const auto invSlot = slot.invSlot;

    if (!this->resolve(slot))
    {
        ShowErrorFmt("NpcTradeTransaction: {} no longer holds the item offered in slot {}", this->player_->getName(), invSlot);
        slot = Slot{};

        return;
    }

    // The reserve is what the stack is holding back, so it has to go before any of it can move
    slot.item->setReserve(0);

    const auto consumed = this->updateItem(this->player_, LOC_INVENTORY, invSlot, -static_cast<int32>(quantity));

    if (!consumed.applied)
    {
        ShowErrorFmt("NpcTradeTransaction: {} kept the item in slot {} after trading it away", this->player_->getName(), invSlot);
    }

    // A stack traded away whole is already gone, so only what survived still needs releasing
    if (consumed.destroyed)
    {
        slot = Slot{};
        return;
    }

    this->releaseSlot(slot);
}

void NpcTradeTransaction::releaseClaim(Slot& slot) const
{
    if (!slot.item)
    {
        return;
    }

    slot.item->setReserve(0);

    exitTx(slot.item);
    slot.item = nullptr;
}

void NpcTradeTransaction::releaseSlot(Slot& slot) const
{
    this->releaseClaim(slot);

    slot = Slot{};
}

void NpcTradeTransaction::releaseAll()
{
    for (auto& slot : this->slots_)
    {
        this->releaseSlot(slot);
    }
}

auto NpcTradeTransaction::holds(const CItem* item) const -> bool
{
    if (!item)
    {
        return false;
    }

    return std::ranges::any_of(this->slots_,
                               [item](const Slot& slot)
                               {
                                   return slot.item == item;
                               });
}

auto NpcTradeTransaction::doCommit() -> bool
{
    this->releaseAll();

    return true;
}

void NpcTradeTransaction::doRollback()
{
    this->releaseAll();
}
