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
    // Type 0x09: Status Effect Icons (data: 196 bytes, total: 200 bytes)
    class STATUS_ICONS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, STATUS_ICONS>
    {
    public:
        struct PacketData
        {
            GP_SERV_COMMAND_MISCDATA_TYPE type;           // PS2: type
            uint16_t                      unknown06;      // PS2: (New; did not exist.)
            uint16_t                      icons[32];      // Status effect icon IDs (64 bytes)
            uint32_t                      timestamps[32]; // Status effect expiration timestamps (Vanadiel time) (128 bytes)
        };

        STATUS_ICONS(const CCharEntity* PChar);
    };
} // namespace GP_SERV_COMMAND_MISCDATA
