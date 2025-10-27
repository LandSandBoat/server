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

#include "0x04d_fragments_servmes.h"

GP_SERV_COMMAND_FRAGMENTS::SERVMES::SERVMES(const std::string& message, int8 language, int32 timestamp, int32 message_offset)
{
    auto& packet = this->data();

    packet.Command   = message_offset == 0 ? 1 : 2;
    packet.Result    = 1;
    packet.value1    = 1;
    packet.value2    = language;
    packet.timestamp = timestamp == 0 ? earth_time::timestamp() : timestamp;

    // Ensure we have a message and the requested offset is not outside the bounds
    if (message.length() > 0 && message.length() > message_offset)
    {
        const auto sndLength = message.length() - message_offset > 236 ? 236 : message.length() - message_offset;

        packet.size_total     = static_cast<int32_t>(message.length()); // Message Length (Total)
        packet.offset         = message_offset;                         // Message Offset
        packet.data_size      = static_cast<int32_t>(sndLength);        // Message Length
        const auto packetSize = sizeof(GP_SERV_HEADER) + sizeof(PacketData) - sizeof(packet.data) + packet.data_size;
        this->setSize(roundUpToNearestFour(packetSize));

        std::memcpy(packet.data, message.c_str() + message_offset, std::min(sndLength, message.length() - message_offset));
    }
}
