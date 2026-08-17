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

#pragma once

#include "common/cbasetypes.h"
#include "common/types/badge.h"

#include "item_container.h"
#include "items/item_id.h"
#include "items/transaction.h"

#include <memory>
#include <optional>

class CCharEntity;
class CItem;

// start() takes the listing off display and claims it.
// Committing delivers a copy to the buyer, moves the gil both ways and consumes the seller's stack; a failure at any step undoes the earlier ones.
// What is left of the listing goes back on display either way.

class BazaarPurchaseTransaction : public Transaction
{
public:
    static auto start(CCharEntity* buyer, CCharEntity* seller, uint8 bazaarSlot, uint32 quantity, uint32 price, uint32 priceWithTax) -> std::unique_ptr<BazaarPurchaseTransaction>;

    BazaarPurchaseTransaction(xi::Badge<BazaarPurchaseTransaction>, CCharEntity* buyer, CCharEntity* seller, uint8 bazaarSlot, uint32 quantity, uint32 price, uint32 priceWithTax);
    ~BazaarPurchaseTransaction() override;

    DISALLOW_COPY_AND_MOVE(BazaarPurchaseTransaction);

    // slot the buyer received the goods in, set once the sale has gone through
    auto deliveredSlot() const -> std::optional<uint8>;

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

private:
    auto claimListing() -> bool;
    void restoreDisplay();

    CCharEntity*         buyer_{};
    CCharEntity*         seller_{};
    ItemId               listing_{};
    uint8                bazaarSlot_{};
    uint32               quantity_{};
    uint32               price_{};
    uint32               priceWithTax_{};
    std::optional<uint8> deliveredSlot_{};
};
