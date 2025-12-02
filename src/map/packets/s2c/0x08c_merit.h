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
#include "merit.h"

#define MAX_MERITS_IN_PACKET 61

class CCharEntity;
struct merit_t
{
    uint16_t index;
    uint8_t  next;
    uint8_t  count;
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x008C
// This packet is sent by the server to populate the clients merit information.
// This packet is also used to update merit information when the client spends merit points.
class GP_SERV_COMMAND_MERIT final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MERIT, GP_SERV_COMMAND_MERIT>
{
public:
    struct PacketData
    {
        uint16_t merit_count;
        uint16_t padding00;
        merit_t  merits[MAX_MERITS_IN_PACKET]; // Variable length array, up to 61 merits per packet
        uint32_t padding01;                    // Must be added after the VLA
    };

    // Constructor for full merit categories (multiple packets)
    GP_SERV_COMMAND_MERIT(CCharEntity* PChar);

    // Constructor for single merit update
    GP_SERV_COMMAND_MERIT(const CCharEntity* PChar, MERIT_TYPE merit);
};
