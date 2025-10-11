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
#include "job_points.h"

class CCharEntity;
struct jobpoint_t
{
    uint16_t index : 5;
    uint16_t job_no : 11;
    uint16_t next : 10;
    uint16_t level : 6;
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x008D
// This packet is sent by the server to populate the clients job point information.
// This packet is also used to update job point information when the client spends job points.
class GP_SERV_COMMAND_JOB_POINTS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_JOB_POINTS, GP_SERV_COMMAND_JOB_POINTS>
{
public:
    struct PacketData
    {
        jobpoint_t points[64]; // NOT a variable length array
    };

    // Constructor for full job point details
    GP_SERV_COMMAND_JOB_POINTS(CCharEntity* PChar);

    // Constructor for single job point update
    GP_SERV_COMMAND_JOB_POINTS(const CCharEntity* PChar, JOBPOINT_TYPE jpType);
};
