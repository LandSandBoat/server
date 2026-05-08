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

#include "item_use.h"

#include "entities/charentity.h"
#include "items/item.h"
#include "items/item_usable.h"
#include "utils/charutils.h"

ItemUseTransaction::ItemUseTransaction(xi::Badge<ItemUseTransaction>, CCharEntity* player, CItemUsable* item, TakesCustody takesCustody)
: player_(player)
, item_(item)
, takesCustody_(takesCustody)
{
}

auto ItemUseTransaction::start(CCharEntity* player, CItemUsable* item) -> std::unique_ptr<ItemUseTransaction>
{
    if (player == nullptr || item == nullptr)
    {
        return nullptr;
    }

    // Equipment with charges stays in its Equipped role during use; the
    // tx just carries the state machine and commit/rollback are no-ops.
    const auto takesCustody = item->isType(ITEM_EQUIPMENT) ? TakesCustody::No : TakesCustody::Yes;

    auto tx = std::unique_ptr<ItemUseTransaction>(new ItemUseTransaction(xi::Badge<ItemUseTransaction>{}, player, item, takesCustody));
    if (takesCustody && !enterTx(item))
    {
        // Item wasn't Free; refuse to start the tx.
        return nullptr;
    }

    return tx;
}

auto ItemUseTransaction::holds(const CItem* item) const -> bool
{
    return this->isOpen() && this->takesCustody_ && item != nullptr && this->item_ == item;
}

void ItemUseTransaction::doRollback()
{
    if (this->takesCustody_ && this->item_ != nullptr)
    {
        exitTx(this->item_);
        // Clear ITEM_LOCKED here so dtor-only paths (disconnect that skips
        // CItemState::Cleanup) don't leave the item wedged.
        this->item_->setSubType(ITEM_UNLOCKED);
        this->item_ = nullptr;
    }
}

auto ItemUseTransaction::doCommit() -> bool
{
    if (!this->takesCustody_)
    {
        // Charged equipment: nothing to do.
        // OnItemFinish handles the charge decrement through the existing path.
        return true;
    }

    if (this->item_ == nullptr)
    {
        return false;
    }

    // exitTx before UpdateItem: UpdateItem may free the CItem.
    const uint8 location = this->item_->getLocationID();
    const uint8 slot     = this->item_->getSlotID();

    exitTx(this->item_);

    // Unlock so a partial-consume remainder is reusable.
    this->item_->setSubType(ITEM_UNLOCKED);

    charutils::UpdateItem(this->player_, location, slot, -1, true);
    this->item_ = nullptr;
    return true;
}
