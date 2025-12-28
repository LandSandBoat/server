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

#include "0x01d_item_same.h"

#include "item_container.h"

GP_SERV_COMMAND_ITEM_SAME::GP_SERV_COMMAND_ITEM_SAME()
{
    auto& packet = this->data();

    packet.State        = GP_SERV_COMMAND_ITEM_SAME_STATE::AllLoaded;
    packet.padding00[0] = CONTAINER_ID::MAX_CONTAINER_ID; // This data appears to be used as the container index at times, but the client does not use any part of it at all.
    packet.Flags        = 0x0003FFFF;
}

GP_SERV_COMMAND_ITEM_SAME::GP_SERV_COMMAND_ITEM_SAME(const CONTAINER_ID id)
{
    auto& packet = this->data();

    packet.State        = GP_SERV_COMMAND_ITEM_SAME_STATE::StillLoading;
    packet.padding00[0] = id; // This data appears to be used as the container index at times, but the client does not use any part of it at all.
    // TODO: Missing Flags
}
