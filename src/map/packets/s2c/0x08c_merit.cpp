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

#include "0x08c_merit.h"

#include "entities/charentity.h"

// Constructor for full merit categories (multiple packets)
GP_SERV_COMMAND_MERIT::GP_SERV_COMMAND_MERIT(CCharEntity* PChar)
{
    auto& packet       = this->data();
    packet.merit_count = MAX_MERITS_IN_PACKET;

    // TODO: This code assumes 5 packets of 61 merits each (305 total) which is absolutely wrong.
    // Retail sends 219 when in a Mog House, 109 when not.
    for (uint8 packetNum = 0; packetNum < 5; ++packetNum)
    {
        const uint8 offset = packetNum * MAX_MERITS_IN_PACKET;

        for (uint8 i = 0; i < MAX_MERITS_IN_PACKET; ++i)
        {
            const Merit_t* PMerit  = PChar->PMeritPoints->GetMeritByIndex(offset + i);
            packet.merits[i].index = PMerit->id;
            packet.merits[i].count = PMerit->count;
            packet.merits[i].next  = PMerit->next;
        }

        if (!PChar->m_moghouseID)
        {
            for (uint8 i = 0; i < MAX_MERITS_IN_PACKET; ++i)
            {
                packet.merits[i].next = 0; // Reset the next value for all merits
            }
        }

        if (packetNum < 4)
        {
            PChar->pushPacket(this->copy());
        }
    }

    // TODO: When this is fixed to send the correct number of merits, the size will need to be adjusted accordingly.
    // merit_count will also need to be adjusted to the actual number of merits sent in the final packet.
}

// Constructor for single merit update
GP_SERV_COMMAND_MERIT::GP_SERV_COMMAND_MERIT(const CCharEntity* PChar, const MERIT_TYPE merit)
{
    auto& packet = this->data();

    // XiPackets claim this is set to 1 when updating a single merit
    // but values of 4 have been observed on retail
    // This may have a different meaning when updating a single merit
    packet.merit_count = 1;

    const Merit_t* PMerit = PChar->PMeritPoints->GetMerit(merit);
    packet.merits[0]      = {
             .index = PMerit->id,
             .next  = PMerit->next,
             .count = PMerit->count
    };

    // Set size for single merit update: header + count/padding + 2 merits (retail sends padding)
    this->setSize(0x08 + (2 * sizeof(merit_t)));
}
