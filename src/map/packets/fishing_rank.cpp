/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "fishing_rank.h"
#include "common/socket.h"
#include "utils/fishingcontest.h"

#include <cstring>

CFishingRankPacket::CFishingRankPacket(std::vector<fish_ranking_entry*> entries, int8 language, int32 timestamp, int32 message_offset, uint32 totalEntries, uint8 msg_chunk)
{
    this->setType(0x4D);
    this->setSize(0x28);

    ref<uint8>(0x04)  = msg_chunk;
    ref<uint8>(0x05)  = 1;
    ref<uint8>(0x06)  = 2; // 1 = Svr Message, 2 = Fishing Rank.  Packets otherwise identical.
    ref<uint8>(0x07)  = language;
    ref<uint32>(0x08) = (uint32)(timestamp == 0 ? time(nullptr) : timestamp);
    ref<uint32>(0x0C) = 0;            // Message Length (Total)
    ref<uint32>(0x10) = 0;            // Message Offset
    ref<uint32>(0x14) = 0;            // Message Length
    ref<uint32>(0x18) = totalEntries; // Number of entries in the fishing block

    // Ensure we have a message and the requested offset is not outside of the bounds
    if (entries.size() > 0 && entries.size() <= 6)
    {
        uint8  blockSize  = sizeof(fish_ranking_entry);
        uint8  entryCount = (uint8)entries.size();
        uint32 msgLength  = totalEntries * blockSize;
        uint32 sndLength  = (entryCount - 1) * blockSize > 236 ? 236 : (entryCount - 1) * blockSize; // -1 because the player's block doesn't count
        auto   packetSize = 0x1C + (entryCount * blockSize) > 0xFF ? 0xFF : 0x1C + (entryCount * blockSize);

        ref<uint32>(0x0C) = msgLength;      // Message Length (Total)
        ref<uint32>(0x10) = message_offset; // Message Offset
        ref<uint32>(0x14) = sndLength;      // Message Length

        this->setSize(packetSize);

        uint8 offset = 0x1C;

        for (fish_ranking_entry* entry : entries)
        {
            if (offset + blockSize <= 0xFF)
            {
                std::memcpy(data + offset, entry->name, (uint8)sizeof(entry->name));
                ref<uint8>(offset + 0x10)  = entry->mjob;
                ref<uint8>(offset + 0x11)  = entry->sjob;
                ref<uint8>(offset + 0x12)  = entry->mlvl;
                ref<uint8>(offset + 0x13)  = entry->slvl;
                ref<uint8>(offset + 0x14)  = entry->race;
                ref<uint8>(offset + 0x15)  = 0; // Deliberate padding
                ref<uint8>(offset + 0x16)  = entry->allegiance;
                ref<uint8>(offset + 0x17)  = entry->fishrank;
                ref<uint32>(offset + 0x18) = entry->score;
                ref<uint32>(offset + 0x1C) = entry->submittime;
                ref<uint8>(offset + 0x20)  = entry->contestrank;
                ref<uint8>(offset + 0x21)  = entry->resultcount;
                ref<uint8>(offset + 0x22)  = entry->dataset_a;
                ref<uint8>(offset + 0x23)  = entry->dataset_b;

                offset += blockSize;
            }
        }
    }
}
