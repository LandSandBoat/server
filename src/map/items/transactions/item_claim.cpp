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
#include "utils/itemutils.h"

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

auto ItemClaimTransaction::claim(const uint8 location, const uint8 slot) -> CItem*
{
    CItem* PItem = this->player_->getStorage(location)->GetItem(slot);
    if (!PItem)
    {
        return nullptr;
    }

    // Claiming the same stack twice would release it on the first exit
    if (this->holds(PItem))
    {
        return PItem;
    }

    if (PItem->getReserve() > 0 || !enterTx(PItem))
    {
        return nullptr;
    }

    this->claims_.push_back(PItem);

    return PItem;
}

auto ItemClaimTransaction::claimGil() -> CItem*
{
    CItem* PGil = this->claim(LOC_INVENTORY, 0);
    if (!PGil || !PGil->isType(ITEM_CURRENCY))
    {
        return nullptr;
    }

    return PGil;
}

auto ItemClaimTransaction::give(const uint8 location, const uint16 itemId, const uint32 quantity) -> bool
{
    const uint8 slot = charutils::AddItem(this->player_, location, itemId, quantity);
    if (slot == ERROR_SLOTID)
    {
        return false;
    }

    this->undoWith([this, location, slot, quantity]()
                   {
                       (void)this->update(location, slot, -static_cast<int32>(quantity));
                   });

    return true;
}

auto ItemClaimTransaction::give(const uint8 location, std::unique_ptr<CItem> item) -> bool
{
    if (!item)
    {
        return false;
    }

    const uint32 quantity = item->getQuantity();

    const uint8 slot = charutils::AddItem(this->player_, location, std::move(item));
    if (slot == ERROR_SLOTID)
    {
        return false;
    }

    this->undoWith([this, location, slot, quantity]()
                   {
                       (void)this->update(location, slot, -static_cast<int32>(quantity));
                   });

    return true;
}

auto ItemClaimTransaction::take(const uint8 location, const uint8 slot, const uint32 quantity) -> bool
{
    CItem* PItem = this->player_->getStorage(location)->GetItem(slot);
    if (!PItem || PItem->getQuantity() < quantity)
    {
        return false;
    }

    // A stack about to vanish is copied first, so putting it back keeps exdata, signature and augments
    std::unique_ptr<CItem> restore;
    if (PItem->getQuantity() == quantity)
    {
        restore = xi::items::clone(*PItem);
    }

    if (!this->update(location, slot, -static_cast<int32>(quantity)).applied)
    {
        return false;
    }

    if (!restore)
    {
        this->undoWith([this, location, slot, quantity]()
                       {
                           (void)this->update(location, slot, static_cast<int32>(quantity));
                       });

        return true;
    }

    restore->setQuantity(quantity);
    restore->setReserve(0);

    this->undoWith([this, location, kept = std::shared_ptr<CItem>(std::move(restore))]()
                   {
                       auto returned = xi::items::clone(*kept);
                       if (!returned)
                       {
                           ShowErrorFmt("ItemClaimTransaction: could not give {} back to {}", kept->getID(), this->player_->getName());
                           return;
                       }

                       (void)charutils::AddItem(this->player_, location, std::move(returned));
                   });

    return true;
}

auto ItemClaimTransaction::pay(const uint32 gil) -> bool
{
    if (!this->claimGil())
    {
        return false;
    }

    return this->take(LOC_INVENTORY, 0, gil);
}

auto ItemClaimTransaction::earn(const uint32 gil) -> bool
{
    if (!this->claimGil())
    {
        return false;
    }

    if (!this->update(LOC_INVENTORY, 0, static_cast<int32>(gil)).applied)
    {
        return false;
    }

    this->undoWith([this, gil]()
                   {
                       (void)this->update(LOC_INVENTORY, 0, -static_cast<int32>(gil));
                   });

    return true;
}

auto ItemClaimTransaction::split(const uint8 fromLocation, const uint8 fromSlot, const uint8 toLocation, const uint32 quantity) -> bool
{
    const CItem* PItem = this->player_->getStorage(fromLocation)->GetItem(fromSlot);
    if (!PItem)
    {
        return false;
    }

    // Taken before it is handed back out, so a failure halfway can never leave both halves
    const uint16 itemId = PItem->getID();

    return this->take(fromLocation, fromSlot, quantity) && this->give(toLocation, itemId, quantity);
}

auto ItemClaimTransaction::moveBetween(const uint8 fromLocation, const uint8 fromSlot, const uint8 toLocation, const uint8 toSlot, const uint32 quantity) -> bool
{
    // The source shrinks first, so a failure halfway can never leave the quantity counted twice
    if (!this->take(fromLocation, fromSlot, quantity))
    {
        return false;
    }

    if (!this->update(toLocation, toSlot, static_cast<int32>(quantity)).applied)
    {
        return false;
    }

    this->undoWith([this, toLocation, toSlot, quantity]()
                   {
                       (void)this->update(toLocation, toSlot, -static_cast<int32>(quantity));
                   });

    return true;
}

void ItemClaimTransaction::undoWith(std::function<void()> undo)
{
    this->undos_.push_back(std::move(undo));
}

auto ItemClaimTransaction::update(const uint8 location, const uint8 slot, const int32 quantity) -> charutils::ItemMutation
{
    CItem* PItem = this->player_->getStorage(location)->GetItem(slot);

    const auto mutation = this->updateItem(this->player_, location, slot, quantity);

    // A stack consumed to nothing is freed, so the claim on it has to go before anything releases it
    if (mutation.destroyed)
    {
        std::erase(this->claims_, PItem);
    }

    return mutation;
}

auto ItemClaimTransaction::holds(const CItem* item) const -> bool
{
    return item && std::ranges::find(this->claims_, item) != this->claims_.end();
}

auto ItemClaimTransaction::doCommit() -> bool
{
    this->undos_.clear();
    this->releaseClaims();

    return true;
}

void ItemClaimTransaction::doRollback()
{
    // Reverse order, and before the claims go, so each undo still owns what it is putting back
    for (auto undo = this->undos_.rbegin(); undo != this->undos_.rend(); ++undo)
    {
        (*undo)();
    }

    this->undos_.clear();
    this->releaseClaims();
}

void ItemClaimTransaction::releaseClaims()
{
    for (auto* claim : this->claims_)
    {
        exitTx(claim);
    }

    this->claims_.clear();
}
