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
#include "common/xi.h"
#include "item_container.h"

#include <set>
#include <vector>

enum SLOTTYPE : uint8;
class CItem;

using Equipping = xi::Flag<struct EquippingTag>;

struct equip_change_t
{
    CONTAINER_ID container;       // Container where the item is located
    uint8        containerSlotId; // Item slot in container (0 for unequip)
    SLOTTYPE     equipSlot;       // Equipment slot
    CItem*       item;            // The item being equipped/unequipped
    Equipping    equipping;       // Yes = equip (NoDrop), No = unequip (Normal)
};

// Tracks which inventory containers have been synced with the client
class InventorySyncState
{
public:
    // Which containers have been sent to the client
    void markSynced(CONTAINER_ID id);
    auto isSynced(CONTAINER_ID id) const -> bool;
    auto getSyncedFlags() const -> uint32_t;

    // Equipment change queue
    void queueEquipChange(CONTAINER_ID container, uint8 containerSlotId, SLOTTYPE equipSlot, CItem* item, Equipping equipping);
    void clearEquipChanges();
    auto hasPendingEquipChanges() const -> bool;
    auto pendingEquipChanges() const -> const std::vector<equip_change_t>&;
    auto dirtyContainers() const -> const std::set<CONTAINER_ID>&;

private:
    xi::bitset<MAX_CONTAINER_ID> syncedContainers_{};
    std::vector<equip_change_t>  pendingEquipChanges_;
    std::set<CONTAINER_ID>       dirtyContainers_;
};
