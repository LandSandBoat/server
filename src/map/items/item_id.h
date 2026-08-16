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

#include "entities/entity_id.h"

class CCharEntity;
class CItem;

// A reference to an item that can outlive the item itself.
// A CItem* cannot: a stack consumed to nothing is freed, and its slot can be refilled by a different stack of the same item.
struct ItemId
{
    ItemId() = default;
    ItemId(const CCharEntity* owner, const CItem* PItem);

    void clean();
    auto isSet() const -> bool;

    auto operator==(const ItemId& other) const -> bool;
    auto operator==(const CItem* PItem) const -> bool;

    EntityId owner{};          // Whose stack it is.
    uint64   uid{ 0 };         // Never-reused per-process counter, telling this stack from a lookalike.
    uint16   itemId{ 0 };      // What it was, so a refusal can say what went missing.
    uint8    location{ 0xFF }; // Container it sat in.
    uint8    slot{ 0xFF };     // Slot within that container.

    // Looks the item up again. Null if it is gone, or if another stack now occupies the slot
    [[nodiscard]] auto resolve() const -> CItem*;
};
