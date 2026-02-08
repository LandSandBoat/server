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

#include "inventory_sync_state.h"
#include "items/item.h"

// Marks a given container as having been entirely streamed to the client
void InventorySyncState::markSynced(const CONTAINER_ID id)
{
    if (id < MAX_CONTAINER_ID)
    {
        syncedContainers_.set(id);
    }
}

auto InventorySyncState::isSynced(const CONTAINER_ID id) const -> bool
{
    return id < MAX_CONTAINER_ID && syncedContainers_.test(id);
}

// Computes a flag for use in ITEM_FLAG representing containers that have been entirely streamed.
auto InventorySyncState::getSyncedFlags() const -> uint32_t
{
    uint32_t flags = 0;
    std::memcpy(&flags, syncedContainers_.data.data(), std::min(sizeof(flags), syncedContainers_.data.size()));
    return flags;
}

void InventorySyncState::queueEquipChange(CONTAINER_ID container, uint8 containerSlotId, SLOTTYPE equipSlot, CItem* item, Equipping equipping)
{
    pendingEquipChanges_.emplace_back(container, containerSlotId, equipSlot, item, equipping);
    dirtyContainers_.insert(equipping ? container : static_cast<CONTAINER_ID>(item->getLocationID()));
}

void InventorySyncState::clearEquipChanges()
{
    pendingEquipChanges_.clear();
    dirtyContainers_.clear();
}

auto InventorySyncState::hasPendingEquipChanges() const -> bool
{
    return !pendingEquipChanges_.empty();
}

auto InventorySyncState::pendingEquipChanges() const -> const std::vector<equip_change_t>&
{
    return pendingEquipChanges_;
}

auto InventorySyncState::dirtyContainers() const -> const std::set<CONTAINER_ID>&
{
    return dirtyContainers_;
}
