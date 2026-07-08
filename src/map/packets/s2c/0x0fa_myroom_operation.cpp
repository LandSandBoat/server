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

#include "0x0fa_myroom_operation.h"

#include "items/item.h"

GP_SERV_COMMAND_MYROOM_OPERATION::GP_SERV_COMMAND_MYROOM_OPERATION(const CItem* PItem, CONTAINER_ID locationId, uint8 slotId)
{
    auto& packet = this->data();

    packet.MyroomItemNo    = PItem->getID();
    packet.MyroomCategory  = locationId;
    packet.MyroomItemIndex = slotId;
}
