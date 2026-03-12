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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x008E
// This packet is sent by the server to populate the clients alter ego points information. This packet is also used to update alter ego points when the client spends alter ego points.
class GP_SERV_PACKET_ALTER_EGO_POINTS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_PACKET_ALTER_EGO_POINTS, GP_SERV_PACKET_ALTER_EGO_POINTS>
{
public:
    struct PacketData
    {
        uint16_t Points;
        uint16_t padding00;
        uint8_t  Upgrades[32];
        uint16_t Costs[32];
    };

    GP_SERV_PACKET_ALTER_EGO_POINTS(CCharEntity* PChar);
};
