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

#include "0x05c_pendingnum.h"

GP_SERV_COMMAND_PENDINGNUM::GP_SERV_COMMAND_PENDINGNUM(const std::vector<std::pair<uint8_t, uint32_t>>& params)
{
    auto& packet = this->data();

    for (const auto& [index, value] : params)
    {
        if (index < std::size(packet.num))
        {
            packet.num[index] = static_cast<int32_t>(value);
        }
    }
}
