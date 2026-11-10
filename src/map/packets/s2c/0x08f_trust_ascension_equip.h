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

#include "base.h"

class CCharEntity;

struct trust_ascension_equip_category_t
{
    uint8_t Kind[10];     // Per slot, 0 = slot unavailable. Other values index a client label table (meaning unknown).
    uint8_t Equipped[10]; // Item id - 29424 per slot, 0 = empty
};

// This packet is sent by the server with the player's Trust equipment, in reply to 0x0C5 and 0x0C6.
class GP_SERV_COMMAND_TRUST_ASCENSION_EQUIP final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TRUST_ASCENSION_EQUIP, GP_SERV_COMMAND_TRUST_ASCENSION_EQUIP>
{
public:
    struct PacketData
    {
        uint32_t                         Owned[8];      // Bit i set: the player owns item 29424 + i
        trust_ascension_equip_category_t Categories[7]; // Indexed by category (1-6); the client never reads 0
    };

    GP_SERV_COMMAND_TRUST_ASCENSION_EQUIP(const CCharEntity* PChar);
};
