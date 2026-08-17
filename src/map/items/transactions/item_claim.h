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

// give, take, pay, earn and their undos all come from Transaction; the overloads here only save the caller passing the same player to every one of them.

class ItemClaimTransaction final : public Transaction
{
public:
    static auto start(CCharEntity* player) -> std::unique_ptr<ItemClaimTransaction>;

    ItemClaimTransaction(xi::Badge<ItemClaimTransaction>, CCharEntity* player);
    ~ItemClaimTransaction() override;

    DISALLOW_COPY_AND_MOVE(ItemClaimTransaction);

    // Null if the slot is empty or the item is already busy
    [[nodiscard]] auto claimSlot(uint8 location, uint8 slot) -> CItem*;

    // same as Transaction's, with the player implied
    [[nodiscard]] auto give(uint8 location, uint16 itemId, uint32 quantity, Silence silence = Silence::No) -> std::optional<uint8>;
    [[nodiscard]] auto give(uint8 location, std::unique_ptr<CItem> item, Silence silence = Silence::No) -> std::optional<uint8>;
    [[nodiscard]] auto take(uint8 location, uint8 slot, uint32 quantity) -> bool;
    [[nodiscard]] auto pay(uint32 gil) -> bool;
    [[nodiscard]] auto earn(uint32 gil) -> bool;

    // undone as a unit
    [[nodiscard]] auto split(uint8 fromLocation, uint8 fromSlot, uint8 toLocation, uint32 quantity) -> bool;

    // undone as a unit
    [[nodiscard]] auto moveBetween(uint8 fromLocation, uint8 fromSlot, uint8 toLocation, uint8 toSlot, uint32 quantity) -> bool;

    // undo for work outside the item tables, run in reverse order on rollback
    using Transaction::undoWith;

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

private:
    CCharEntity* player_{};
};
