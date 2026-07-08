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

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00A0
// This packet is sent by the server to inform the client of its party members locations when viewing the map.
class GP_SERV_COMMAND_MAP_GROUP final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MAP_GROUP, GP_SERV_COMMAND_MAP_GROUP>
{
public:
    struct PacketData
    {
        uint32_t UniqueID;  // PS2: UniqueID
        int16_t  zone;      // PS2: zone
        uint16_t padding0A; // PS2: (New; did not exist.)
        float    x;         // PS2: x
        float    y;         // PS2: y
        float    z;         // PS2: z
    };

    GP_SERV_COMMAND_MAP_GROUP(const CCharEntity* PChar);
};
