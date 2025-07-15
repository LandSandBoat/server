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

enum class GP_CLI_COMMAND_FAQ_GMCALL_TYPE : uint8_t
{
    AddHistory = 1,
    GMCall     = 2,
    GMNotice   = 3,
};

struct FFGpGMReportBlockHdr
{
    uint8_t  bkType;   // PS2: bkType
    uint8_t  bkLength; // PS2: bkLength
    uint16_t bkOpt;    // PS2: bkOpt
};

struct sub_block_00_t
{
    FFGpGMReportBlockHdr header;
    uint16_t             zone;      // PS2: zone
    uint16_t             world;     // PS2: world
    float                cliPos[3]; // PS2: cliPos
    float                srvPos[3]; // PS2: srvPos
};

struct sub_block_01_t
{
    FFGpGMReportBlockHdr header;
    uint32_t             unknown00;
    uint32_t             unknown01[4];
};

struct sub_block_02_t
{
    FFGpGMReportBlockHdr header;
    int16_t              code;     // PS2: code
    uint16_t             count;    // PS2: count
    uint32_t             timeCode; // PS2: timeCode
};

struct sub_block_03_t
{
    FFGpGMReportBlockHdr header;
    uint8_t              Str[256]; // Unknown max size.
};

struct FFGpGMReportLobbyStruct
{
    FFGpGMReportBlockHdr header;
    uint16_t             cmd;      // PS2: cmd
    uint16_t             opt;      // PS2: opt
    uint32_t             timeCode; // PS2: timeCode
    uint32_t             ident;    // PS2: ident
    uint8_t              name[16]; // PS2: name
};

struct sub_block_04_t
{
    FFGpGMReportBlockHdr    header;
    FFGpGMReportLobbyStruct characters[8];
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00D3
// This packet is sent by the client when interacting with the Help Desk system. More specifically, when selecting an option that will send a request to the server.
GP_CLI_PACKET(GP_CLI_COMMAND_FAQ_GMCALL,
              uint16_t type : 4;   // PS2: type
              uint16_t vers : 4;   // PS2: vers
              uint16_t pktId : 8;  // PS2: pktId
              uint16_t seq : 7;    // PS2: seq
              uint16_t eos : 1;    // PS2: eos
              uint16_t blkNum : 8; // PS2: blkNum -- 9 max observed
              uint8_t  Data[256];  // PS2: (Non-specific structured data.) - Unknown max size
);
