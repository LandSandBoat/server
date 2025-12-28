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

struct unityinfo_t
{
    uint32_t Faction : 5;
    uint32_t Unknown : 5;
    uint32_t Points : 17;
    uint32_t unused : 5;
};

struct masteryinfo_t
{
    uint8_t job_no;
    uint8_t job_lv;
    uint8_t flags;
    uint8_t padding00;
};

struct CLISTATUS
{
    int32_t       hpmax;                 // PS2: hpmax
    int32_t       mpmax;                 // PS2: mpmax
    JOBTYPE       mjob_no;               // PS2: mjob_no
    uint8_t       mjob_lv;               // PS2: mjob_lv
    JOBTYPE       sjob_no;               // PS2: sjob_no
    uint8_t       sjob_lv;               // PS2: sjob_lv
    int16_t       exp_now;               // PS2: exp_now
    int16_t       exp_next;              // PS2: exp_next
    uint16_t      bp_base[7];            // PS2: bp_base
    int16_t       bp_adj[7];             // PS2: bp_adj
    int16_t       atk;                   // PS2: atk
    int16_t       def;                   // PS2: def
    int16_t       def_elem[8];           // PS2: def_elem
    uint16_t      designation;           // PS2: designation
    uint16_t      rank;                  // PS2: rank
    uint16_t      rankbar;               // PS2: rankbar
    uint16_t      BindZoneNo;            // PS2: BindZoneNo
    uint32_t      MonsterBuster;         // PS2: MonsterBuster
    uint8_t       nation;                // PS2: nation
    uint8_t       myroom;                // PS2: myroom
    uint8_t       su_lv;                 // PS2: (New; did not exist.)
    uint8_t       padding4F;             // PS2: (New; did not exist.)
    uint8_t       highest_ilvl;          // PS2: (New; did not exist.)
    uint8_t       ilvl;                  // PS2: (New; did not exist.)
    uint8_t       ilvl_mhand;            // PS2: (New; did not exist.)
    uint8_t       ilvl_ranged;           // PS2: (New; did not exist.)
    unityinfo_t   unity_info;            // PS2: (New; did not exist.)
    uint16_t      unity_points1;         // PS2: (New; did not exist.)
    uint16_t      unity_points2;         // PS2: (New; did not exist.)
    uint32_t      unity_chat_color_flag; // PS2: (New; did not exist.)
    masteryinfo_t mastery_info;          // PS2: (New; did not exist.)
    uint32_t      mastery_exp_now;       // PS2: (New; did not exist.)
    uint32_t      mastery_exp_next;      // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0061
// This packet is sent by the server to update the client with the characters stats information.
class GP_SERV_COMMAND_CLISTATUS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CLISTATUS, GP_SERV_COMMAND_CLISTATUS>
{
public:
    struct PacketData
    {
        CLISTATUS statusdata; // PS2: statusdata
    };

    GP_SERV_COMMAND_CLISTATUS(CCharEntity* PChar);
};
