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

#include "0x048_link_concierge_header.h"

#include <fmt/format.h>

GP_SERV_COMMAND_LINK_CONCIERGE::HEADER::HEADER(const std::optional<uint8> yourSlot, uint16 daysSincePost)
{
    auto& packet = this->data();

    packet.Sentinel[0] = 0xFE;
    packet.Sentinel[1] = 0xFE;
    packet.Sentinel[2] = 0xFE;
    packet.Sentinel[3] = 0xFE;

    if (yourSlot)
    {
        packet.SlotIndex   = *yourSlot;
        packet.ListingFlag = 0xFFFF;
        packet.Registered  = 1;
    }

    if (daysSincePost > 0)
    {
        const auto str = fmt::format("{}d", daysSincePost);
        std::memcpy(packet.PostedDays, str.data(), std::min<std::size_t>(str.size(), sizeof(packet.PostedDays)));
    }
}
