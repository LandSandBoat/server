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

#include "0x04d_fragments_fishranking.h"

#include "fishingcontest.h"

GP_SERV_COMMAND_FRAGMENTS::FISHRANKING::FISHRANKING(const std::vector<FishingContestEntry>& entries, int8 language, int32 timestamp, int32 msgOffset, uint32 totalEntries, uint8 msgChunk)
{
    auto& packet = this->data();

    packet.Command      = msgChunk;
    packet.Result       = 1;
    packet.value1       = 2;
    packet.value2       = language;
    packet.timestamp    = timestamp == 0 ? earth_time::timestamp() : timestamp;
    packet.totalEntries = totalEntries;

    // Ensure we have a message and the requested offset is not outside the bounds
    if (entries.size() > 0 && entries.size() <= 6)
    {
        constexpr uint8 blockSize  = sizeof(FishingContestEntry);
        const uint8     entryCount = static_cast<uint8>(entries.size());
        const uint32    msgLength  = totalEntries * blockSize;
        const uint32    sndLength  = (entryCount - 1) * blockSize > 236 ? 236 : (entryCount - 1) * blockSize; // -1 because the player's block doesn't count

        packet.size_total     = msgLength;
        packet.offset         = msgOffset;
        packet.data_size      = sndLength;
        const auto packetSize = sizeof(GP_SERV_HEADER) + sizeof(PacketData) - sizeof(packet.data) + packet.data_size;
        this->setSize(packetSize);

        uint8 idx = 0;
        for (auto&& entry : entries)
        {
            std::memcpy(&packet.data[idx++], &entry, sizeof(FishingContestEntry));
        }
    }
}
