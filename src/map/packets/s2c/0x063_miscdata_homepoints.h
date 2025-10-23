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
    // Type 0x06: Homepoint Masks (data: 68 bytes, total: 72 bytes)
    class HOMEPOINTS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, HOMEPOINTS>
    {
    public:
        struct PacketData
        {
            GP_SERV_COMMAND_MISCDATA_TYPE type;             // PS2: type
            uint16_t                      unknown06;        // PS2: (New; did not exist.)
            uint32_t                      homePoint[4];     // Homepoint teleport access masks (16 bytes)
            uint32_t                      survivalGuide[4]; // Survival guide access masks (16 bytes)
            uint32_t                      waypoint[4];      // Waypoint/Abyssea Maw access masks (16 bytes)
            uint32_t                      telepoint;        // Telepoint access mask (4 bytes)
            uint32_t                      atmos;            // Atmacite teleport mask (4 bytes)
            uint32_t                      eschanPortal;     // Eschan portal mask (4 bytes)
            uint32_t                      unknown00;        // Unknown mask (4 bytes)
        };

        HOMEPOINTS(const CCharEntity* PChar);
    };
} // namespace GP_SERV_COMMAND_MISCDATA
