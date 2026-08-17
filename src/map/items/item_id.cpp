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

#include "item_id.h"

#include "entities/char_entity.h"
#include "item_container.h"
#include "items/item.h"

ItemId::ItemId(const CCharEntity* owner, const CItem* PItem)
{
    if (!owner || !PItem)
    {
        return;
    }

    this->owner    = EntityId(owner);
    this->uid      = PItem->uid();
    this->itemId   = PItem->getID();
    this->location = PItem->getLocationID();
    this->slot     = PItem->getSlotID();
}

void ItemId::clean()
{
    *this = ItemId{};
}

auto ItemId::isSet() const -> bool
{
    return this->uid != 0;
}

auto ItemId::operator==(const ItemId& other) const -> bool
{
    return this->isSet() && this->uid == other.uid;
}

auto ItemId::operator==(const CItem* PItem) const -> bool
{
    return PItem != nullptr && PItem->uid() == this->uid;
}

auto ItemId::resolve() const -> CItem*
{
    if (!this->isSet())
    {
        return nullptr;
    }

    auto* POwner = this->owner.resolve<CCharEntity>();
    if (!POwner)
    {
        return nullptr;
    }

    const auto* PContainer = POwner->getStorage(this->location);
    if (!PContainer)
    {
        return nullptr;
    }

    // the slot is where it was, so the uid decides whether this is still the same stack
    CItem* PItem = PContainer->GetItem(this->slot);

    return (*this == PItem) ? PItem : nullptr;
}
