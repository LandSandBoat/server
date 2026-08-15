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

#include "items/item_id.h"
#include "items/transaction.h"

#include <memory>
#include <optional>
#include <vector>

class CCharEntity;
class CItem;

// One operation's claim over the stacks it touches, for work that needs no bookkeeping of its own.
//
// claim() stamps a stack InTransaction so nothing else can spend, sell or bazaar it while the
// operation runs. The steps themselves - give, take, pay, earn, and their reversal - come from
// Transaction; these overloads only spare the caller naming the player every time.

class ItemClaimTransaction final : public Transaction
{
public:
    static auto start(CCharEntity* player) -> std::unique_ptr<ItemClaimTransaction>;

    ItemClaimTransaction(xi::Badge<ItemClaimTransaction>, CCharEntity* player);
    ~ItemClaimTransaction() override;

    DISALLOW_COPY_AND_MOVE(ItemClaimTransaction);

    // Claims the stack in a slot, refusing one that is already spoken for. Null if it cannot be had
    [[nodiscard]] auto claim(uint8 location, uint8 slot) -> CItem*;

    // The player's gil, claimed for the operation. Only needed to read the balance before acting,
    // since pay() and earn() claim it themselves. Null if slot 0 does not hold spendable currency
    [[nodiscard]] auto claimGil() -> CItem*;

    // The operation's own player is implied, which is all these ever act on
    [[nodiscard]] auto give(uint8 location, uint16 itemId, uint32 quantity, Silence silence = Silence::No) -> std::optional<uint8>;
    [[nodiscard]] auto give(uint8 location, std::unique_ptr<CItem> item, Silence silence = Silence::No) -> std::optional<uint8>;
    [[nodiscard]] auto take(uint8 location, uint8 slot, uint32 quantity) -> bool;
    [[nodiscard]] auto pay(uint32 gil) -> bool;
    [[nodiscard]] auto earn(uint32 gil) -> bool;

    // Peels quantity off a stack into a new one. Reversed as a whole
    [[nodiscard]] auto split(uint8 fromLocation, uint8 fromSlot, uint8 toLocation, uint32 quantity) -> bool;

    // Moves quantity between two stacks of the same item. Reversed as a whole
    [[nodiscard]] auto moveBetween(uint8 fromLocation, uint8 fromSlot, uint8 toLocation, uint8 toSlot, uint32 quantity) -> bool;

    // For work this cannot reverse on its own, such as a row written outside the item tables
    using Transaction::undoWith;

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

private:
    CCharEntity* player_{};
};
