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

#include "0x11c_lockstyle_error.h"

#include <algorithm>
#include <iterator>

GP_SERV_COMMAND_LOCKSTYLE_ERROR::GP_SERV_COMMAND_LOCKSTYLE_ERROR(const std::vector<uint16_t>& failedItemIds)
{
    auto& packet = this->data();

    packet.Count = static_cast<uint8_t>(std::min(failedItemIds.size(), std::size(packet.ItemNo)));
    for (size_t i = 0; i < packet.Count; ++i)
    {
        packet.ItemNo[i] = failedItemIds[i];
    }
}
