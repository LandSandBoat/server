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

#pragma once

#include "base.h"
#include "fishingcontest.h"

class CBaseEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x004D
// This packet is sent by the server to respond to a client fragment request.
// The main usage of this packet is for sending the client fragments of the server message as the client requests them.
namespace GP_SERV_COMMAND_FRAGMENTS
{

// Command=2 Event VM messages (payload varies by event)
// Event: Fishing ranking
class FISHRANKING final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_FRAGMENTS, FISHRANKING>
{
public:
    struct PacketData
    {
        uint8_t             Command;      // PS2: Command
        int8_t              Result;       // PS2: Result
        uint8_t             value1;       // PS2: fragmentsNo
        uint8_t             value2;       // PS2: fragmentsTotal
        int32_t             timestamp;    // PS2: signature
        int32_t             size_total;   // PS2: timestamp
        int32_t             offset;       // PS2: offset
        int32_t             data_size;    // PS2: size
        uint32_t            totalEntries; // PS2: (unnamed)
        uint32_t            padding;      // PS2: (unnamed)
        FishingContestEntry data[6];      // PS2: (unnamed)
    };

    FISHRANKING(const std::vector<FishingContestEntry>& entries, int8 language, int32 timestamp, int32 msgOffset, uint32 totalEntries, uint8 msgChunk);
};

} // namespace GP_SERV_COMMAND_FRAGMENTS
