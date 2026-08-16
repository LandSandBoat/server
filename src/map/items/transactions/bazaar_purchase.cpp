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

#include "bazaar_purchase.h"

#include "common/logging.h"

#include "entities/char_entity.h"
#include "enums/item_state.h"
#include "item_container.h"
#include "items/item.h"
#include "items/item_access.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

BazaarPurchaseTransaction::BazaarPurchaseTransaction(xi::Badge<BazaarPurchaseTransaction>, CCharEntity* buyer, CCharEntity* seller, const uint8 bazaarSlot, const uint32 quantity, const uint32 price, const uint32 priceWithTax)
: buyer_(buyer)
, seller_(seller)
, bazaarSlot_(bazaarSlot)
, quantity_(quantity)
, price_(price)
, priceWithTax_(priceWithTax)
{
}

BazaarPurchaseTransaction::~BazaarPurchaseTransaction()
{
    this->rollbackIfOpen();
}

auto BazaarPurchaseTransaction::start(CCharEntity* buyer, CCharEntity* seller, const uint8 bazaarSlot, const uint32 quantity, const uint32 price, const uint32 priceWithTax) -> std::unique_ptr<BazaarPurchaseTransaction>
{
    if (!buyer || !seller || buyer == seller)
    {
        return nullptr;
    }

    auto transaction = std::unique_ptr<BazaarPurchaseTransaction>(
        new BazaarPurchaseTransaction(xi::Badge<BazaarPurchaseTransaction>{}, buyer, seller, bazaarSlot, quantity, price, priceWithTax));

    if (!transaction->claimListing())
    {
        return nullptr;
    }

    return transaction;
}

// pay() and earn() claim the gil, so only the listing needs claiming here
auto BazaarPurchaseTransaction::claimListing() -> bool
{
    auto* PListing = this->seller_->getStorage(LOC_INVENTORY)->GetItem(this->bazaarSlot_);
    if (!PListing)
    {
        return false;
    }

    // a listed item is ItemState::Bazaar, which has to come off before it can be claimed
    if (PListing->state() == ItemState::Bazaar && !xi::items::mark(PListing, ItemState::Free))
    {
        return false;
    }

    this->listing_ = this->claim(this->seller_, PListing);

    return this->listing_.isSet();
}

void BazaarPurchaseTransaction::restoreDisplay()
{
    // the claim has to go first, since Bazaar can only be set on a Free item
    this->release(this->listing_);

    // looked up again because a full buyout leaves nothing to put back
    auto* PRemaining = this->seller_->getStorage(LOC_INVENTORY)->GetItem(this->bazaarSlot_);
    if (!PRemaining || PRemaining->getCharPrice() == 0)
    {
        return;
    }

    if (!xi::items::mark(PRemaining, ItemState::Bazaar))
    {
        ShowWarningFmt("BazaarPurchaseTransaction: could not put item {} back on display for {}", PRemaining->getID(), this->seller_->getName());
    }
}

auto BazaarPurchaseTransaction::deliveredSlot() const -> std::optional<uint8>
{
    return this->deliveredSlot_;
}

auto BazaarPurchaseTransaction::doCommit() -> bool
{
    const CItem* PListing = this->listing_.resolve();
    if (!PListing)
    {
        return false;
    }

    auto clone = xi::items::clone(*PListing);
    if (!clone)
    {
        return false;
    }

    clone->setCharPrice(0);
    clone->setQuantity(this->quantity_);

    // each step below records an undo, so a later failure unwinds the earlier ones
    const auto delivered = this->give(this->buyer_, LOC_INVENTORY, std::move(clone));
    if (!delivered)
    {
        return false;
    }

    this->deliveredSlot_ = delivered;

    if (!this->pay(this->buyer_, this->priceWithTax_))
    {
        ShowWarningFmt("BazaarPurchaseTransaction: {} could not pay {}", this->buyer_->getName(), this->priceWithTax_);
        this->deliveredSlot_.reset();

        return false;
    }

    if (!this->earn(this->seller_, this->price_))
    {
        ShowErrorFmt("BazaarPurchaseTransaction: {} was not paid {} for the sale", this->seller_->getName(), this->price_);
        this->deliveredSlot_.reset();

        return false;
    }

    if (!this->take(this->seller_, LOC_INVENTORY, this->bazaarSlot_, this->quantity_))
    {
        ShowErrorFmt("BazaarPurchaseTransaction: {} kept item in slot {} after it was sold", this->seller_->getName(), this->bazaarSlot_);
        this->deliveredSlot_.reset();

        return false;
    }

    this->restoreDisplay();

    return true;
}

void BazaarPurchaseTransaction::doRollback()
{
    this->restoreDisplay();
}
