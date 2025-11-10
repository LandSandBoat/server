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

// Type 0x05: Job Points (data: 152 bytes, total: 156 bytes)
class JOB_POINTS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, JOB_POINTS>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;      // PS2: type
        uint16_t                      unknown06; // PS2: (New; did not exist.)
        uint8_t                       access;    // Access flag (0=no access, 1=access)
        uint8_t                       padding[3];
        struct JobPointData
        {
            uint16_t capacityPoints; // Capacity points for this job
            uint16_t currentJp;      // Current unspent job points
            uint16_t totalJpSpent;   // Total job points spent
        } jobs[24];                  // One entry per job (starting from index 1, job 0 unused)
    };

    JOB_POINTS(const CCharEntity* PChar);
};

} // namespace GP_SERV_COMMAND_MISCDATA
