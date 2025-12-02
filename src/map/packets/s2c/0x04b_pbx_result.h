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

enum class GP_CLI_COMMAND_PBX_BOXNO : int8_t;
enum class GP_CLI_COMMAND_PBX_COMMAND : uint8_t;
class CItem;
// PS2: GC_PBOX_SEND
struct GC_PBOX_SEND
{
    uint8_t  To[16];      // PS2: To
    uint32_t RequestID;   // PS2: RequestID
    uint32_t RequestTime; // PS2: RequestTime
    int32_t  ItemWorkNo;  // PS2: ItemWorkNo
};

// PS2: GC_PBOX_RECV
struct GC_PBOX_RECV
{
    uint8_t  From[16];       // PS2: From
    uint32_t RequestID;      // PS2: RequestID
    uint32_t RequestTime;    // PS2: RequestTime
    int32_t  OpponentPBoxNo; // PS2: OpponentPBoxNo
};

// PS2: (unknown)
struct GC_PBOX
{
    union
    {
        GC_PBOX_SEND Send; // PS2: Send
        GC_PBOX_RECV Recv; // PS2: Recv
    } pbox;
};

// PS2: GP_POST_BOX_STATE
struct GP_POST_BOX_STATE
{
    uint32_t Stat;      // PS2: Stat
    GC_PBOX  box_state; // PS2: box_state
    uint16_t ItemNo;    // PS2: ItemNo
    uint16_t padding22; // PS2: (New; did not exist.)
    int32_t  Kind;      // PS2: Kind
    uint32_t Stack;     // PS2: Stack
    uint8_t  Data[28];  // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x004B
// This packet is sent by the server when the client is interacting with the delivery box system.
class GP_SERV_COMMAND_PBX_RESULT final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_PBX_RESULT, GP_SERV_COMMAND_PBX_RESULT>
{
public:
    struct PacketData
    {
        uint8_t Command;    // PS2: Command
        int8_t  BoxNo;      // PS2: BoxNo
        int8_t  PostWorkNo; // PS2: PostWorkNo
        int8_t  ItemWorkNo; // PS2: ItemWorkNo
        int32_t ItemStacks; // PS2: ItemStacks
        int8_t  Result;     // PS2: Result
        int8_t  ResParam1;  // PS2: ResParam1
        int8_t  ResParam2;  // PS2: ResParam2
        int8_t  ResParam3;  // PS2: ResParam3
        union
        {
            uint32_t          Represent; // PS2: Represent
            GP_POST_BOX_STATE State;     // PS2: Represent
        };
    };

    GP_SERV_COMMAND_PBX_RESULT(GP_CLI_COMMAND_PBX_COMMAND action, GP_CLI_COMMAND_PBX_BOXNO boxid, uint8 count, uint8 param);
    GP_SERV_COMMAND_PBX_RESULT(GP_CLI_COMMAND_PBX_COMMAND action, GP_CLI_COMMAND_PBX_BOXNO boxid, CItem* PItem, uint8 slotid, uint8 count, uint8 message);
};
