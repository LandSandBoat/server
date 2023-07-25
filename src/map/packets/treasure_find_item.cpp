/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/timer.h"
#include "entities/baseentity.h"
#include "treasure_pool.h"

#include "treasure_find_item.h"

CTreasureFindItemPacket::CTreasureFindItemPacket(TreasurePoolItem* PItem, CBaseEntity* PEntity, bool isOldItem)
{
    this->setType(0x0D2);
    this->setSize(60);

    ref<uint32>(0x04) = 1;                 // Item Quantity
    ref<uint16>(0x0C) = 0;                 // TODO: Gil Found
    ref<uint16>(0x10) = PItem->ID;         // Item ID
    ref<uint8>(0x14)  = PItem->SlotID;     // Treasure Pool Slot
    ref<uint8>(0x15)  = isOldItem ? 1 : 0; // Old Item
    ref<uint32>(0x18) = (uint32)std::chrono::duration_cast<std::chrono::milliseconds>(PItem->TimeStamp - get_server_start_time()).count();

    if (PEntity != nullptr)
    {
        ref<uint32>(0x08) = PEntity->id;     // Entity ID
        ref<uint16>(0x12) = PEntity->targid; // Entity Index
        ref<uint8>(0x16)  = PEntity->objtype == TYPE_NPC;
    }
}
