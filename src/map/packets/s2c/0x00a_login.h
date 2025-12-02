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

struct EventInfo;
class CCharEntity;
// PS2: GP_SERV_POS_HEAD
struct GP_SERV_POS_HEAD
{
    uint32_t UniqueNo;      // PS2: UniqueNo
    uint16_t ActIndex;      // PS2: ActIndex
    uint8_t  padding06;     // PS2: (Removed; was SendFlg.)
    int8_t   dir;           // PS2: dir
    float    x;             // PS2: x
    float    z;             // PS2: y
    float    y;             // PS2: z
    uint32_t flags1;        // PS2: (Multiple fields; bits.)
    uint8_t  Speed;         // PS2: Speed
    uint8_t  SpeedBase;     // PS2: SpeedBase
    uint8_t  HpMax;         // PS2: HpMax
    uint8_t  server_status; // PS2: server_status
    uint32_t flags2;        // PS2: (Multiple fields; bits.)
    uint32_t flags3;        // PS2: (Multiple fields; bits.)
    uint32_t flags4;        // PS2: (Multiple fields; bits.)
    uint32_t BtTargetID;    // PS2: BtTargetID
};

// PS2: SAVE_LOGIN_STATE
enum class SAVE_LOGIN_STATE : uint32_t
{
    SAVE_LOGIN_STATE_NONE           = 0,
    SAVE_LOGIN_STATE_MYROOM         = 1,
    SAVE_LOGIN_STATE_GAME           = 2,
    SAVE_LOGIN_STATE_POLEXIT        = 3,
    SAVE_LOGIN_STATE_JOBEXIT        = 4,
    SAVE_LOGIN_STATE_POLEXIT_MYROOM = 5,
    SAVE_LOGIN_STATE_END            = 6
};

// PS2: GP_MYROOM_DANCER
struct GP_MYROOM_DANCER_PKT
{
    uint16_t mon_no;       // PS2: mon_no
    uint16_t face_no;      // PS2: face_no
    uint8_t  mjob_no;      // PS2: mjob_no
    uint8_t  hair_no;      // PS2: hair_no
    uint8_t  size;         // PS2: size
    uint8_t  sjob_no;      // PS2: sjob_no
    uint32_t get_job_flag; // PS2: get_job_flag
    int8_t   job_lev[16];  // PS2: job_lev
    uint16_t bp_base[7];   // PS2: bp_base
    int16_t  bp_adj[7];    // PS2: bp_adj
    int32_t  hpmax;        // PS2: hpmax
    int32_t  mpmax;        // PS2: mpmax
    uint8_t  sjobflg;      // PS2: sjobflg
    uint8_t  unknown41[3]; // PS2: (New; did not exist.)
};

// PS2: SAVE_CONF
struct SAVE_CONF_PKT
{
    uint32_t unknown00[3]; // PS2: (Multiple fields; bits.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x000A
// This packet is sent by the server to respond to a client login request (0x000A).
// The client uses the information from this response to initialize the current GC_ZONE instance, preparing it for usage when the zone is initialized and loaded.
class GP_SERV_COMMAND_LOGIN final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_LOGIN, GP_SERV_COMMAND_LOGIN>
{
public:
    struct PacketData
    {
        GP_SERV_POS_HEAD     PosHead;            // PS2: PosHead
        uint32_t             ZoneNo;             // PS2: ZoneNo
        uint32_t             ntTime;             // PS2: ntTime
        uint32_t             ntTimeSec;          // PS2: ntTimeSec
        uint32_t             GameTime;           // PS2: GameTime
        uint16_t             EventNo;            // PS2: EventNo
        uint16_t             MapNumber;          // PS2: MapNumber
        uint16_t             GrapIDTbl[9];       // PS2: GrapIDTbl
        uint16_t             MusicNum[5];        // PS2: MusicNum
        uint16_t             SubMapNumber;       // PS2: SubMapNumber
        uint16_t             EventNum;           // PS2: EventNum
        uint16_t             EventPara;          // PS2: EventPara
        uint16_t             EventMode;          // PS2: EventMode
        uint16_t             WeatherNumber;      // PS2: WeatherNumber
        uint16_t             WeatherNumber2;     // PS2: WeatherNumber2
        uint32_t             WeatherTime;        // PS2: WeatherTime
        uint32_t             WeatherTime2;       // PS2: WeatherTime2
        uint32_t             WeatherOffsetTime;  // PS2: WeatherOffsetTime
        uint32_t             ShipStart;          // PS2: ShipStart
        uint16_t             ShipEnd;            // PS2: ShipEnd
        uint16_t             IsMonstrosity;      // PS2: (New; did not exist.)
        SAVE_LOGIN_STATE     LoginState;         // PS2: LoginState
        char                 name[16];           // PS2: name
        int32_t              certificate[2];     // PS2: certificate
        uint16_t             unknown9C;          // PS2: (New; did not exist.)
        uint16_t             ZoneSubNo;          // PS2: (New; did not exist.)
        uint32_t             PlayTime;           // PS2: PlayTime
        uint32_t             DeadCounter;        // PS2: DeadCounter
        uint8_t              MyroomSubMapNumber; // PS2: (New; did not exist.)
        uint8_t              unknownA9;          // PS2: (New; did not exist.)
        uint16_t             MyroomMapNumber;    // PS2: MyroomMapNumber
        uint16_t             SendCount;          // PS2: SendCount
        uint8_t              MyRoomExitBit;      // PS2: MyRoomExitBit
        uint8_t              MogZoneFlag;        // PS2: MogZoneFlag
        GP_MYROOM_DANCER_PKT Dancer;             // PS2: Dancer
        SAVE_CONF_PKT        ConfData;           // PS2: ConfData
        uint32_t             Ex;                 // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_LOGIN(CCharEntity* PChar, const EventInfo* currentEvent);
};
