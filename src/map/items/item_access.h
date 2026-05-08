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

#include "common/logging.h"
#include "common/types/badge.h"

#include "map/enums/item_state.h"
#include "map/items/item.h"

#include <magic_enum/magic_enum.hpp>

class Transaction;

namespace xi::items::detail
{
struct ItemAccess
{
    // Privileged InTransaction transitions, only callable from Transaction subclasses.
    [[nodiscard]] static auto enterTransaction(CItem* item, xi::Badge<Transaction>) -> bool
    {
        if (item == nullptr)
        {
            ShowErrorFmt("ItemAccess::enterTransaction: null item");
            return false;
        }

        if (item->state() != ItemState::Free)
        {
            ShowErrorFmt("ItemAccess::enterTransaction: item {} not Free (current={})",
                         item->getID(),
                         magic_enum::enum_name(item->state()));
            return false;
        }

        item->setState(ItemState::InTransaction, xi::Badge<ItemAccess>{});
        return true;
    }

    static void exitTransaction(CItem* item, xi::Badge<Transaction>)
    {
        if (item == nullptr)
        {
            ShowErrorFmt("ItemAccess::exitTransaction: null item");
            return;
        }

        item->setState(ItemState::Free, xi::Badge<ItemAccess>{});
    }

    [[nodiscard]] static auto mark(CItem* item, const ItemState target) -> bool
    {
        if (item == nullptr)
        {
            ShowErrorFmt("ItemAccess::mark: null item, target={}", magic_enum::enum_name(target));
            return false;
        }

        // InTransaction transitions go through the tx commit/rollback path.
        // Refuse on either side of the transition.
        if (target == ItemState::InTransaction || item->state() == ItemState::InTransaction)
        {
            ShowErrorFmt("ItemAccess::mark: illegal tx transition for item {} (current={}, target={}) - use tx commit/rollback path",
                         item->getID(),
                         magic_enum::enum_name(item->state()),
                         magic_enum::enum_name(target));
            return false;
        }

        // Releasing back to Free is always allowed.
        if (target == ItemState::Free)
        {
            item->setState(ItemState::Free, xi::Badge<ItemAccess>{});
            return true;
        }

        // Acquiring a role: item must currently be Free.
        if (item->isBusy())
        {
            ShowErrorFmt("ItemAccess::mark: item {} not Free, cannot acquire role (current={}, target={})",
                         item->getID(),
                         magic_enum::enum_name(item->state()),
                         magic_enum::enum_name(target));
            return false;
        }

        item->setState(target, xi::Badge<ItemAccess>{});
        return true;
    }
};
} // namespace xi::items::detail

namespace xi::items
{
[[nodiscard]] inline auto mark(CItem* item, const ItemState target) -> bool
{
    return detail::ItemAccess::mark(item, target);
}
} // namespace xi::items
