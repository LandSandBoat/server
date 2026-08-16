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

// Both sides' gil is claimed by the payment itself, so the sale only has to secure the goods
auto BazaarPurchaseTransaction::claimListing() -> bool
{
    auto* PListing = this->seller_->getStorage(LOC_INVENTORY)->GetItem(this->bazaarSlot_);
    if (!PListing)
    {
        return false;
    }

    // The listing is claimed by the bazaar, so take it off display before the sale claims it
    if (PListing->state() == ItemState::Bazaar && !xi::items::mark(PListing, ItemState::Free))
    {
        return false;
    }

    this->listing_ = this->claim(this->seller_, PListing);

    return this->listing_.isSet();
}

void BazaarPurchaseTransaction::restoreDisplay()
{
    // Nothing can go back on display while this still holds it
    this->release(this->listing_);

    // The stack may have been consumed entirely, so look it up again rather than trusting the pointer
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

auto BazaarPurchaseTransaction::deliveredSlot() const -> uint8
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

    // Every step reverses itself, so a failure here rolls the sale back and restores the display
    const auto delivered = this->give(this->buyer_, LOC_INVENTORY, std::move(clone));
    if (!delivered)
    {
        return false;
    }

    this->deliveredSlot_ = *delivered;

    if (!this->pay(this->buyer_, this->priceWithTax_))
    {
        ShowWarningFmt("BazaarPurchaseTransaction: {} could not pay {}", this->buyer_->getName(), this->priceWithTax_);
        this->deliveredSlot_ = ERROR_SLOTID;

        return false;
    }

    if (!this->earn(this->seller_, this->price_))
    {
        ShowErrorFmt("BazaarPurchaseTransaction: {} was not paid {} for the sale", this->seller_->getName(), this->price_);
        this->deliveredSlot_ = ERROR_SLOTID;

        return false;
    }

    if (!this->take(this->seller_, LOC_INVENTORY, this->bazaarSlot_, this->quantity_))
    {
        ShowErrorFmt("BazaarPurchaseTransaction: {} kept item in slot {} after it was sold", this->seller_->getName(), this->bazaarSlot_);
        this->deliveredSlot_ = ERROR_SLOTID;

        return false;
    }

    this->restoreDisplay();

    return true;
}

void BazaarPurchaseTransaction::doRollback()
{
    this->restoreDisplay();
}
