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
#include "items/exdata/linkshell.h"

#include <array>
#include <string>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0048
// This packet is sent by the server when the client is interacting with a linkshell concierge NPC.
namespace GP_SERV_COMMAND_LINK_CONCIERGE
{

struct SlotInput
{
    bool        filled{ false };
    uint8_t     slotIndex{ 0xFF };
    uint32_t    groupId{ 0 };
    uint16_t    groupKey{ 0 };
    uint16_t    color{ 0 };
    uint8_t     flag{ 0 };
    std::string name;
    uint8_t     lang{ 0 };            // 1=JP, 2=EN, 3=Other
    uint8_t     membersGoal{ 0 };     // 1..10
    uint8_t     activeTier{ 0 };      // 0=1-6, 1=7-18, 2=19+
    uint16_t    characteristics{ 0 }; // 16-bit characteristics flags
};

#pragma pack(push, 1)

struct SlotAttrs
{
    uint32_t Active : 1;
    uint32_t LangJP : 1;
    uint32_t LangEN : 1;
    uint32_t padding00 : 2;
    uint32_t LangOther : 1;
    uint32_t MembersGoal : 4;
    uint32_t unknown00 : 4;  // varies, decomp ignores
    uint32_t ActiveTier : 2; // 0=1-6, 1=7-18, 2=19+
    uint32_t Characteristics : 16;
};

class RECORD final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_LINK_CONCIERGE, RECORD>
{
public:
    struct PacketData
    {
        uint8_t           Indices[4];   // concierge slot id per entry (0xFF = empty)
        uint16_t          unknown00[4]; // observed 0x0203 × 4
        Exdata::Linkshell Bodies[4];    // Linkshell exdata
        SlotAttrs         Attrs[4];
    };

    RECORD(const std::array<SlotInput, 4>& slots);
};

#pragma pack(pop)

} // namespace GP_SERV_COMMAND_LINK_CONCIERGE
