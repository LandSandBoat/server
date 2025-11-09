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

#include "0x063_miscdata.h"
#include "base.h"

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0063
// This packet is sent by the server to inform the client of multiple different kinds of information.
namespace GP_SERV_COMMAND_MISCDATA
{

// Type 0x02: Merit/Limit Points (data: 12 bytes, total: 16 bytes)
class MERITS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, MERITS>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;                    // PS2: type
        uint16_t                      unknown06;               // PS2: (New; did not exist.)
        uint16_t                      limitPoints;             // Limit points available
        uint16_t                      meritPoints : 7;         // Merit points value (0-127)
        uint16_t                      bluBonus : 6;            // BLU spell point bonus (0-63)
        uint16_t                      canUseMeritMode : 1;     // Level >= 75 and has Limit Breaker KI
        uint16_t                      xpCappedOrMeritMode : 1; // XP is capped or player is in merit mode
        uint16_t                      meritModeEnabled : 1;    // Merit mode enabled and current job is eligible
        uint8_t                       maxMeritPoints;          // Maximum merit points
        uint8_t                       padding[3];
    };

    MERITS(CCharEntity* PChar);
};

} // namespace GP_SERV_COMMAND_MISCDATA
