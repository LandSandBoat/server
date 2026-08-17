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

#include "items/item.h"
#include "items/item_usable.h"
#include "utils/charutils.h"

ItemUseTransaction::ItemUseTransaction(xi::Badge<ItemUseTransaction>, CCharEntity* player, CItemUsable* item, TakesCustody takesCustody)
: player_(player)
, item_(player, item)
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

    auto transaction = std::unique_ptr<ItemUseTransaction>(new ItemUseTransaction(xi::Badge<ItemUseTransaction>{}, player, item, takesCustody));

    // claimed after construction so a refusal drops the transaction with nothing held
    if (takesCustody && !transaction->claim(player, item).isSet())
    {
        return nullptr;
    }

    return transaction;
}

// nothing of its own to put back: the base runs the undos and releases the claims
void ItemUseTransaction::doRollback()
{
}

auto ItemUseTransaction::doCommit() -> bool
{
    if (!this->takesCustody_)
    {
        // Charged equipment: nothing to do.
        // OnItemFinish handles the charge decrement through the existing path.
        return true;
    }

    if (!this->item_.resolve())
    {
        return false;
    }

    const uint8 slot = this->item_.slot;

    if (!this->take(this->player_, this->item_.location, slot, 1))
    {
        ShowErrorFmt("ItemUseTransaction: {} kept the item in slot {} after using it", this->player_->getName(), slot);
    }

    return true;
}
