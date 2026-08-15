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
// Subclasses override doCommit/doRollback/holds.
// Derived must call rollbackIfOpen() in destructor else base aborts.
//
// Every step that moves an item - give, take, pay, earn - records how to reverse itself, so
// rolling back undoes the work rather than only letting go of the claims. Committing keeps it.
// A step that destroys a stack reports it through onItemDestroyed, since whatever was holding a
// pointer to it needs to let go before anything tries to release it.

class Transaction
{
public:
    Transaction();
    virtual ~Transaction();

    DISALLOW_COPY_AND_MOVE(Transaction);

    auto id() const -> uint64;
    auto isOpen() const -> bool;

    virtual auto holds(const CItem* item) const -> bool = 0;

    [[nodiscard]] auto commit() -> bool;
    void               rollback();

protected:
    virtual auto doCommit() -> bool = 0;
    virtual void doRollback()       = 0;

    void rollbackIfOpen();

    // Subclass entry points to the badge-gated InTransaction transitions.
    [[nodiscard]] static auto enterTx(CItem* item) -> bool;
    static void               exitTx(CItem* item);

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

    [[nodiscard]] auto pay(CCharEntity* PChar, uint32 gil) -> bool;
    [[nodiscard]] auto earn(CCharEntity* PChar, uint32 gil) -> bool;

    // For work this cannot reverse on its own, such as a row written outside the item tables
    void undoWith(std::function<void()> undo);

    // A step is consuming this stack to nothing. It is still alive here, but will not be for long,
    // so anything holding a pointer to it must let go now
    virtual void onItemDestroyed(CItem* item);

    // Whether steps that already landed can be taken back. A transaction that says no keeps its
    // work on rollback, so abandoning it costs the same as finishing it badly
    virtual auto reversible() const -> bool;

private:
    void runUndos();

    uint64                             id_;
    TransactionState                   state_{ TransactionState::Open };
    std::vector<std::function<void()>> undos_;
};
