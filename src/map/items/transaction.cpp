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

#include "transaction.h"

#include "common/cbasetypes.h"
#include "common/logging.h"
#include "common/types/badge.h"
#include "items/item_access.h"

#include <magic_enum/magic_enum.hpp>

#include <atomic>
#include <cstdlib>

namespace
{
auto allocTxId() -> uint64
{
    static std::atomic<uint64> counter{ 1 };
    return counter.fetch_add(1, std::memory_order_relaxed);
}
} // namespace

Transaction::Transaction()
: id_(allocTxId())
{
}

Transaction::~Transaction()
{
    if (this->state_ == TransactionState::Open)
    {
        ShowErrorFmt("Transaction::~Transaction: tx {} still Open - subclass dtor must call rollbackIfOpen()", this->id_);
        std::abort();
    }
}

auto Transaction::id() const -> uint64
{
    return this->id_;
}

auto Transaction::isOpen() const -> bool
{
    return this->state_ == TransactionState::Open;
}

auto Transaction::commit() -> bool
{
    if (this->state_ != TransactionState::Open)
    {
        ShowWarningFmt("Transaction::commit: tx {} not Open (state={})", this->id_, magic_enum::enum_name(this->state_));
        return false;
    }

    if (!this->doCommit())
    {
        ShowWarningFmt("Transaction::commit: doCommit rejected for tx {}", this->id_);
        return false;
    }

    this->state_ = TransactionState::Committed;
    return true;
}

void Transaction::rollback()
{
    if (this->state_ != TransactionState::Open)
    {
        ShowWarningFmt("Transaction::rollback: tx {} not Open (state={})", this->id_, magic_enum::enum_name(this->state_));
        return;
    }

    this->doRollback();
    this->state_ = TransactionState::RolledBack;
}

void Transaction::rollbackIfOpen()
{
    if (this->state_ == TransactionState::Open)
    {
        this->rollback();
    }
}

auto Transaction::enterTx(CItem* item) -> bool
{
    return xi::items::detail::ItemAccess::enterTransaction(item, xi::Badge<Transaction>{});
}

void Transaction::exitTx(CItem* item)
{
    xi::items::detail::ItemAccess::exitTransaction(item, xi::Badge<Transaction>{});
}
