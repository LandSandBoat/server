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

enum JOBTYPE : uint8;
class CCharEntity;
struct GP_MYROOM_DANCER
{
    uint16_t mon_no;
    uint16_t face_no;
    JOBTYPE  mjob_no;
    uint8_t  hair_no;
    uint8_t  size;
    JOBTYPE  sjob_no;
    uint32_t get_job_flag;
    int8_t   job_lev[16];
    uint16_t bp_base[7];
    int16_t  bp_adj[7];
    int32_t  hpmax;
    int32_t  mpmax;
    uint8_t  sjobflg;
    uint8_t  unknown41[3];
    uint8_t  job_lev2[0x18];
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x001B
// This packet is sent by the server to inform the client of the characters general job information.
class GP_SERV_COMMAND_JOB_INFO final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_JOB_INFO, GP_SERV_COMMAND_JOB_INFO>
{
public:
    struct PacketData
    {
        GP_MYROOM_DANCER dancer;                   // PS2: (New; did not exist.)
        uint32_t         encumbrance;              // PS2: (New; did not exist.)
        uint8_t          can_thumbs_up_mentor;     // PS2: (New; did not exist.)
        uint8_t          mentor_rank;              // PS2: (New; did not exist.)
        uint8_t          mastery_rank;             // PS2: (New; did not exist.)
        uint8_t          padding67;                // PS2: (New; did not exist.)
        uint32_t         job_mastery_flags;        // PS2: (New; did not exist.)
        uint8_t          job_mastery_levels[0x18]; // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_JOB_INFO(CCharEntity* PChar);
};
