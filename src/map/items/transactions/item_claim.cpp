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

#include "item_claim.h"

#include "entities/char_entity.h"
#include "item_container.h"
#include "items/item.h"
#include "utils/charutils.h"

#include <algorithm>

ItemClaimTransaction::ItemClaimTransaction(xi::Badge<ItemClaimTransaction>, CCharEntity* player)
: player_(player)
{
}

ItemClaimTransaction::~ItemClaimTransaction()
{
    this->rollbackIfOpen();
}

auto ItemClaimTransaction::start(CCharEntity* player) -> std::unique_ptr<ItemClaimTransaction>
{
    if (!player)
    {
        return nullptr;
    }

    return std::unique_ptr<ItemClaimTransaction>(new ItemClaimTransaction(xi::Badge<ItemClaimTransaction>{}, player));
}

auto ItemClaimTransaction::claimSlot(const uint8 location, const uint8 slot) -> CItem*
{
    CItem* PItem = this->player_->getStorage(location)->GetItem(slot);

    return Transaction::claim(this->player_, PItem).isSet() ? PItem : nullptr;
}

auto ItemClaimTransaction::give(const uint8 location, const uint16 itemId, const uint32 quantity, const Silence silence) -> std::optional<uint8>
{
    return Transaction::give(this->player_, location, itemId, quantity, silence);
}

auto ItemClaimTransaction::give(const uint8 location, std::unique_ptr<CItem> item, const Silence silence) -> std::optional<uint8>
{
    return Transaction::give(this->player_, location, std::move(item), silence);
}

auto ItemClaimTransaction::take(const uint8 location, const uint8 slot, const uint32 quantity) -> bool
{
    return Transaction::take(this->player_, location, slot, quantity);
}

auto ItemClaimTransaction::pay(const uint32 gil) -> bool
{
    return Transaction::pay(this->player_, gil);
}

auto ItemClaimTransaction::earn(const uint32 gil) -> bool
{
    return Transaction::earn(this->player_, gil);
}

auto ItemClaimTransaction::split(const uint8 fromLocation, const uint8 fromSlot, const uint8 toLocation, const uint32 quantity) -> bool
{
    const CItem* PItem = this->player_->getStorage(fromLocation)->GetItem(fromSlot);
    if (!PItem)
    {
        return false;
    }

    const uint16 itemId = PItem->getID();

    // take first: giving first would leave both halves in the inventory if the take then failed
    return this->take(fromLocation, fromSlot, quantity) && this->give(toLocation, itemId, quantity).has_value();
}

auto ItemClaimTransaction::moveBetween(const uint8 fromLocation, const uint8 fromSlot, const uint8 toLocation, const uint8 toSlot, const uint32 quantity) -> bool
{
    // take first: merging first would count the quantity twice if the take then failed
    if (!this->take(fromLocation, fromSlot, quantity))
    {
        return false;
    }

    return this->mergeInto(this->player_, toLocation, toSlot, quantity);
}

// the work is the caller's steps, and the base releases the claims
auto ItemClaimTransaction::doCommit() -> bool
{
    return true;
}

// nothing of its own to put back: the base runs the undos and releases the claims
void ItemClaimTransaction::doRollback()
{
}
