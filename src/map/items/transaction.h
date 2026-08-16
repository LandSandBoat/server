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
#include "common/macros.h"
#include "common/types/flag.h"

#include "items/item_id.h"

#include <functional>
#include <memory>
#include <optional>
#include <vector>

class CItem;
class CCharEntity;

// Result of a quantity change
struct ItemMutation
{
    uint16 itemId{ 0 };
    bool   applied{ false };

    // actual change applied, which is less than requested when the stack hits its size limit
    int32 delta{ 0 };

    // set when the quantity reached 0 and the item left its container. Owns it until this result dies
    std::unique_ptr<CItem> removed;
};

enum class TransactionState : uint8
{
    Open,
    Committed,
    RolledBack,
};

// Open/commit/rollback wrapper for multistep item interactions (item use, NPC trade, synth, dbox).
// Subclasses override doCommit/doRollback.
// Derived must call rollbackIfOpen() in destructor else base aborts.
//
// Claimed stacks are stamped InTransaction and may only be mutated by the transaction holding them.
// The claim list lives here rather than in each subclass so that commit and rollback both release.
//
// give/take/pay/earn each record an undo, so a rollback reverses the work as well as dropping the
// claims. Claims are held as ItemId rather than CItem*, since a step can free the stack it touched.

class Transaction
{
public:
    Transaction();
    virtual ~Transaction();

    DISALLOW_COPY_AND_MOVE(Transaction);

    auto id() const -> uint64;
    auto isOpen() const -> bool;

    // whether this transaction is the one allowed to mutate the item
    auto holds(const CItem* item) const -> bool;

    [[nodiscard]] auto commit() -> bool;
    void               rollback();

protected:
    virtual auto doCommit() -> bool = 0;
    virtual void doRollback()       = 0;

    void rollbackIfOpen();

    // Stamps the item InTransaction, blocking equip, sale, bazaar and mutation by anything else.
    // Unset if it is already busy. Claiming the same stack twice returns the existing claim
    [[nodiscard]] auto claim(const CCharEntity* owner, CItem* item) -> ItemId;

    // releases a single claim before the transaction closes
    void release(const ItemId& claimed);

    // claims not yet released
    auto claims() const -> const std::vector<ItemId>&;

    // quantity change. Refused for a busy item this transaction does not hold
    [[nodiscard]] auto updateItem(CCharEntity* PChar, uint8 locationId, uint8 slotId, int32 quantity) -> ItemMutation;

    // ERROR_SLOTID if the item could not be placed
    [[nodiscard]] auto addItem(CCharEntity* PChar, uint8 locationId, std::unique_ptr<CItem> item, Silence silence = Silence::No) -> uint8;
    [[nodiscard]] auto addItem(CCharEntity* PChar, uint8 locationId, uint16 itemId, uint32 quantity, Silence silence = Silence::No) -> uint8;

    // adds to a container and returns the slot. Undo takes it back
    [[nodiscard]] auto give(CCharEntity* PChar, uint8 location, uint16 itemId, uint32 quantity, Silence silence = Silence::No) -> std::optional<uint8>;
    [[nodiscard]] auto give(CCharEntity* PChar, uint8 location, std::unique_ptr<CItem> item, Silence silence = Silence::No) -> std::optional<uint8>;

    // removes from a stack. Undo restores it, exdata and signature included
    [[nodiscard]] auto take(CCharEntity* PChar, uint8 location, uint8 slot, uint32 quantity) -> bool;

    // both claim the gil stack first, so it stays held for the rest of the transaction
    [[nodiscard]] auto pay(CCharEntity* PChar, uint32 gil) -> bool;
    [[nodiscard]] auto earn(CCharEntity* PChar, uint32 gil) -> bool;

    // undo for work outside the item tables, run in reverse order on rollback
    void undoWith(std::function<void()> undo);

    // false keeps completed work on rollback instead of undoing it. Synth relies on this so that
    // disconnecting mid-craft costs the same as a failed synth
    virtual auto reversible() const -> bool;

private:
    [[nodiscard]] auto claimGil(CCharEntity* PChar) -> bool;

    void runUndos();
    void releaseAll();

    // badge-gated ItemState transitions, reachable only through claim and release
    [[nodiscard]] static auto enterTx(CItem* item) -> bool;
    static void               exitTx(CItem* item);

    uint64                             id_;
    TransactionState                   state_{ TransactionState::Open };
    std::vector<ItemId>                claims_;
    std::vector<std::function<void()>> undos_;
};
