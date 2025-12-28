/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "0x0d2_trophy_list.h"

#include "common/timer.h"
#include "entities/baseentity.h"
#include "treasure_pool.h"

GP_SERV_COMMAND_TROPHY_LIST::GP_SERV_COMMAND_TROPHY_LIST(const TreasurePoolItem* PItem, const CBaseEntity* PEntity, const bool isOldItem)
{
    auto& packet = this->data();

    packet.TrophyItemNum   = 1;                 // Item Quantity
    packet.Gold            = 0;                 // TODO: Gil Found
    packet.TrophyItemNo    = PItem->ID;         // Item ID
    packet.TrophyItemIndex = PItem->SlotID;     // Treasure Pool Slot
    packet.Entry           = isOldItem ? 1 : 0; // Old Item
    packet.StartTime       = static_cast<uint32_t>(timer::count_milliseconds(PItem->TimeStamp - timer::start_time));

    if (PEntity != nullptr)
    {
        packet.TargetUniqueNo = PEntity->id;     // Entity ID
        packet.TargetActIndex = PEntity->targid; // Entity Index
        packet.IsContainer    = PEntity->objtype == TYPE_NPC;
    }
}
