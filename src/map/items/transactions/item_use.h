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

#include "common/types/badge.h"
#include "common/types/flag.h"
#include "items/transaction.h"

#include <memory>

class CCharEntity;
class CItem;
class CItemUsable;

using TakesCustody = xi::Flag<struct TakesCustodyTag>;

// Tx for one item-use (potion, scroll, charged equipment).
//
// Consumables: stamped InTransaction; doCommit decrements the stack, doRollback releases the stamp.
// Charged equipment: no stamp; commit/rollback are no-ops (the charge decrement runs in OnItemFinish).

class ItemUseTransaction : public Transaction
{
public:
    static auto start(CCharEntity* player, CItemUsable* item) -> std::unique_ptr<ItemUseTransaction>;

    ItemUseTransaction(xi::Badge<ItemUseTransaction>, CCharEntity* player, CItemUsable* item, TakesCustody takesCustody);

    ~ItemUseTransaction() override
    {
        this->rollbackIfOpen();
    }

    DISALLOW_COPY_AND_MOVE(ItemUseTransaction);

    auto holds(const CItem* item) const -> bool override;

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

private:
    CCharEntity* player_{};
    CItemUsable* item_{};
    TakesCustody takesCustody_{ TakesCustody::No };
};
