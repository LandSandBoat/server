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

#pragma once

#include "common/cbasetypes.h"

#include "base.h"

#include <optional>
#include <string_view>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0048
// This packet is sent by the server when the client is interacting with a linkshell concierge NPC.
namespace GP_SERV_COMMAND_LINK_CONCIERGE
{

#pragma pack(push, 1)

class HEADER final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_LINK_CONCIERGE, HEADER>
{
public:
    struct PacketData
    {
        uint8_t  Sentinel[4]; // FEFEFEFE — identifies header packet
        uint16_t SlotIndex;   // Player own LS slot in the 16-slot table
        uint16_t ListingFlag; // 0xFFFF when registered
        uint8_t  padding00[16];
        char     PostedDays[3]; // ASCII days-since-post (e.g. "22d")
        uint8_t  padding01[17];
        uint8_t  Registered; // 1 if you have an active registration
        uint8_t  padding02[79];
    };

    HEADER(std::optional<uint8> yourSlot, uint16 daysSincePost);
};

#pragma pack(pop)

} // namespace GP_SERV_COMMAND_LINK_CONCIERGE
