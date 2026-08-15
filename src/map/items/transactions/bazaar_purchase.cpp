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

    if (!transaction->claimAll())
    {
        return nullptr;
    }

    return transaction;
}

// Members are only set once the claim succeeds, so a partial failure releases exactly what it took
auto BazaarPurchaseTransaction::claimAll() -> bool
{
    auto* PListing   = this->seller_->getStorage(LOC_INVENTORY)->GetItem(this->bazaarSlot_);
    auto* PBuyerGil  = this->buyer_->getStorage(LOC_INVENTORY)->GetItem(0);
    auto* PSellerGil = this->seller_->getStorage(LOC_INVENTORY)->GetItem(0);

    if (!PListing || !PBuyerGil || !PSellerGil)
    {
        return false;
    }

    // The listing is claimed by the bazaar, so take it off display before the sale claims it
    if (PListing->state() == ItemState::Bazaar && !xi::items::mark(PListing, ItemState::Free))
    {
        return false;
    }

    if (!enterTx(PListing))
    {
        return false;
    }

    this->listing_ = PListing;

    if (!enterTx(PBuyerGil))
    {
        return false;
    }

    this->buyerGil_ = PBuyerGil;

    if (!enterTx(PSellerGil))
    {
        return false;
    }

    this->sellerGil_ = PSellerGil;

    return true;
}

// Clearing each pointer keeps a second release from touching claims this no longer owns
void BazaarPurchaseTransaction::releaseClaims()
{
    if (this->listing_)
    {
        exitTx(this->listing_);
        this->listing_ = nullptr;
    }

    if (this->buyerGil_)
    {
        exitTx(this->buyerGil_);
        this->buyerGil_ = nullptr;
    }

    if (this->sellerGil_)
    {
        exitTx(this->sellerGil_);
        this->sellerGil_ = nullptr;
    }
}

void BazaarPurchaseTransaction::restoreDisplay()
{
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

auto BazaarPurchaseTransaction::holds(const CItem* item) const -> bool
{
    return item && (item == this->listing_ || item == this->buyerGil_ || item == this->sellerGil_);
}

auto BazaarPurchaseTransaction::deliveredSlot() const -> uint8
{
    return this->deliveredSlot_;
}

auto BazaarPurchaseTransaction::doCommit() -> bool
{
    if (!this->listing_)
    {
        return false;
    }

    auto clone = xi::items::clone(*this->listing_);
    if (!clone)
    {
        return false;
    }

    clone->setCharPrice(0);
    clone->setQuantity(this->quantity_);
    clone->setReserve(0);

    // Failures below leave the claims in place, so the rollback puts the listing back on display
    this->deliveredSlot_ = charutils::AddItem(this->buyer_, LOC_INVENTORY, std::move(clone));
    if (this->deliveredSlot_ == ERROR_SLOTID)
    {
        return false;
    }

    if (!this->updateItem(this->buyer_, LOC_INVENTORY, 0, -static_cast<int32>(this->priceWithTax_)).applied)
    {
        ShowWarningFmt("BazaarPurchaseTransaction: {} could not pay {}, taking the goods back", this->buyer_->getName(), this->priceWithTax_);

        (void)this->updateItem(this->buyer_, LOC_INVENTORY, this->deliveredSlot_, -static_cast<int32>(this->quantity_));
        this->deliveredSlot_ = ERROR_SLOTID;

        return false;
    }

    if (!this->updateItem(this->seller_, LOC_INVENTORY, 0, static_cast<int32>(this->price_)).applied)
    {
        ShowErrorFmt("BazaarPurchaseTransaction: {} was not paid {} for the sale", this->seller_->getName(), this->price_);
    }

    const auto sold = this->updateItem(this->seller_, LOC_INVENTORY, this->bazaarSlot_, -static_cast<int32>(this->quantity_));
    if (!sold.applied)
    {
        ShowErrorFmt("BazaarPurchaseTransaction: {} kept item in slot {} after it was sold", this->seller_->getName(), this->bazaarSlot_);
    }

    // A stack bought out entirely no longer exists, so there is nothing left to release
    if (sold.destroyed)
    {
        this->listing_ = nullptr;
    }

    this->releaseClaims();
    this->restoreDisplay();

    return true;
}

void BazaarPurchaseTransaction::doRollback()
{
    this->releaseClaims();
    this->restoreDisplay();
}
