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

#include "0x01f_item_list.h"

#include "utils/itemutils.h"

GP_SERV_COMMAND_ITEM_LIST::GP_SERV_COMMAND_ITEM_LIST(const CItem* PItem, const ItemLockFlg flag)
{
    auto& packet = this->data();

    packet.ItemNum   = PItem->getQuantity();
    packet.ItemNo    = PItem->getID();
    packet.Category  = PItem->getLocationID();
    packet.ItemIndex = PItem->getSlotID();
    packet.LockFlg   = flag;
}
