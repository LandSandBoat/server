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

#include "guild_sell.h"

#include "common/logging.h"

#include "entities/char_entity.h"
#include "item_container.h"
#include "items/item.h"
#include "packets/s2c/0x01d_item_same.h"
#include "utils/charutils.h"

#include <algorithm>
#include <utility>

GuildSellTransaction::GuildSellTransaction(xi::Badge<GuildSellTransaction>, CCharEntity* player, const uint16 itemId)
: player_(player)
, itemId_(itemId)
{
}

GuildSellTransaction::~GuildSellTransaction()
{
    this->rollbackIfOpen();
}

auto GuildSellTransaction::start(CCharEntity* player, const uint16 itemId, const uint8 hintSlot, const uint8 quantity) -> std::unique_ptr<GuildSellTransaction>
{
    if (!player || quantity == 0)
    {
        ShowWarningFmt("GuildSellTransaction::start: null player or zero quantity for item {}", itemId);
        return nullptr;
    }

    const auto* container = player->getStorage(LOC_INVENTORY);
    if (!container)
    {
        ShowWarningFmt("GuildSellTransaction::start: {} has no inventory", player->getName());
        return nullptr;
    }

    auto transaction = std::unique_ptr<GuildSellTransaction>(new GuildSellTransaction(xi::Badge<GuildSellTransaction>{}, player, itemId));

    // The client points at one stack but a sale can span several.
    auto slots = container->SearchItems(itemId);
    std::ranges::stable_partition(slots,
                                  [hintSlot](const uint8 slot)
                                  {
                                      return slot == hintSlot;
                                  });

    for (const auto slot : slots)
    {
        if (transaction->claimed_ >= quantity)
        {
            break;
        }

        auto* item = container->GetItem(slot);

        // Don't claim busy items.
        if (!item || item->isBusy() || item->getQuantity() == 0)
        {
            continue;
        }

        const auto claimed = transaction->claim(player, item);
        if (!claimed.isSet())
        {
            continue;
        }

        const auto take = std::min<uint32>(item->getQuantity(), quantity - transaction->claimed_);

        transaction->lots_.push_back(Lot{ .stack = claimed, .quantity = static_cast<uint8>(take) });
        transaction->claimed_ += static_cast<uint8>(take);
    }

    return transaction;
}

auto GuildSellTransaction::claimed() const -> uint8
{
    return this->claimed_;
}

void GuildSellTransaction::setPayout(const uint8 sold, const uint32 unitPrice)
{
    if (sold > this->claimed_)
    {
        ShowWarningFmt("GuildSellTransaction::setPayout: shop bought {} of item {} but only {} was claimed",
                       sold,
                       this->itemId_,
                       this->claimed_);
    }

    this->sold_      = std::min(sold, this->claimed_);
    this->unitPrice_ = unitPrice;
}

auto GuildSellTransaction::doCommit() -> bool
{
    if (this->sold_ == 0)
    {
        return false;
    }

    uint8 remaining = this->sold_;

    for (auto& lot : this->lots_)
    {
        if (remaining == 0)
        {
            break;
        }

        const uint8 take = std::min(lot.quantity, remaining);
        remaining -= take;

        if (!lot.stack.resolve() || !Transaction::take(this->player_, LOC_INVENTORY, lot.stack.slot, take))
        {
            ShowErrorFmt("GuildSellTransaction: {} kept {} of the goods in slot {}", this->player_->getName(), take, lot.stack.slot);
            return false;
        }
    }

    if (!this->earn(this->player_, this->sold_ * this->unitPrice_))
    {
        ShowErrorFmt("GuildSellTransaction: {} was not paid for the sale", this->player_->getName());
        return false;
    }

    this->player_->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(this->player_);

    return true;
}

// nothing of its own to put back: the base runs the undos and releases the claims
void GuildSellTransaction::doRollback()
{
}
