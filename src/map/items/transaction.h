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

class CItem;

enum class TransactionState : uint8
{
    Open,
    Committed,
    RolledBack,
};

// Open/commit/rollback wrapper for multistep item interactions (item use, NPC trade, synth, dbox).
// Subclasses override doCommit/doRollback/holds.
// Derived must call rollbackIfOpen() in destructor else base aborts.

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

private:
    uint64           id_;
    TransactionState state_{ TransactionState::Open };
};
