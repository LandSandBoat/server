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

// What became of the stack a step just mutated
struct ItemMutation
{
    uint16 itemId{ 0 };
    bool   applied{ false };

    // What the stack actually moved by, which is not the amount asked for when it hit its ceiling
    int32 delta{ 0 };

    // Set when the stack was consumed to nothing. It is kept alive only as long as this result is,
    // so anything still pointing at it must let go while it is here
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
// A transaction claims the stacks it means to touch, and only it may mutate them until it closes.
// The claims are held here rather than by each subclass, so closing always lets go of everything,
// however the work turned out.
//
// Every step that moves an item - give, take, pay, earn - records how to reverse itself, so
// rolling back undoes the work rather than only letting go of the claims. Committing keeps it.
// A claim is an ItemId rather than a pointer, so a stack consumed to nothing simply stops
// resolving rather than leaving something dangling behind to trip over.

class Transaction
{
public:
    Transaction();
    virtual ~Transaction();

    DISALLOW_COPY_AND_MOVE(Transaction);

    auto id() const -> uint64;
    auto isOpen() const -> bool;

    // Whether this transaction is the one allowed to mutate a stack
    auto holds(const CItem* item) const -> bool;

    [[nodiscard]] auto commit() -> bool;
    void               rollback();

protected:
    virtual auto doCommit() -> bool = 0;
    virtual void doRollback()       = 0;

    void rollbackIfOpen();

    // Claims a stack, so nothing else can spend, sell or bazaar it until this closes. False if it
    // is already spoken for. Claiming the same stack twice is the same claim, not a second one
    [[nodiscard]] auto claim(const CCharEntity* owner, CItem* item) -> ItemId;

    // Lets one claim go early, for an offer a script may still confirm after the claim is gone
    void release(const ItemId& claimed);

    // What is still claimed. Everything left is released when the transaction closes
    auto claims() const -> const std::vector<ItemId>&;

    // Mutating an item this transaction holds, which is refused to everyone else
    [[nodiscard]] auto updateItem(CCharEntity* PChar, uint8 locationId, uint8 slotId, int32 quantity) -> ItemMutation;

    // Handing an item out. ERROR_SLOTID if it could not be placed
    [[nodiscard]] auto addItem(CCharEntity* PChar, uint8 locationId, std::unique_ptr<CItem> item, Silence silence = Silence::No) -> uint8;
    [[nodiscard]] auto addItem(CCharEntity* PChar, uint8 locationId, uint16 itemId, uint32 quantity, Silence silence = Silence::No) -> uint8;

    // Hands a stack over, reporting where it landed. Reversed by taking it back
    [[nodiscard]] auto give(CCharEntity* PChar, uint8 location, uint16 itemId, uint32 quantity, Silence silence = Silence::No) -> std::optional<uint8>;
    [[nodiscard]] auto give(CCharEntity* PChar, uint8 location, std::unique_ptr<CItem> item, Silence silence = Silence::No) -> std::optional<uint8>;

    // Takes from a stack. Reversed by putting back what was taken, exdata and all
    [[nodiscard]] auto take(CCharEntity* PChar, uint8 location, uint8 slot, uint32 quantity) -> bool;

    // Both claim the gil stack before touching it, so it stays this transaction's until it closes
    [[nodiscard]] auto pay(CCharEntity* PChar, uint32 gil) -> bool;
    [[nodiscard]] auto earn(CCharEntity* PChar, uint32 gil) -> bool;

    // For work this cannot reverse on its own, such as a row written outside the item tables
    void undoWith(std::function<void()> undo);

    // Whether steps that already landed can be taken back. A transaction that says no keeps its
    // work on rollback, so abandoning it costs the same as finishing it badly
    virtual auto reversible() const -> bool;

private:
    [[nodiscard]] auto claimGil(CCharEntity* PChar) -> bool;

    void runUndos();
    void releaseAll();

    // The badge-gated InTransaction transitions. Only claiming and releasing may reach them
    [[nodiscard]] static auto enterTx(CItem* item) -> bool;
    static void               exitTx(CItem* item);

    uint64                             id_;
    TransactionState                   state_{ TransactionState::Open };
    std::vector<ItemId>                claims_;
    std::vector<std::function<void()>> undos_;
};
