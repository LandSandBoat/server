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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0079
// This packet is sent by the server to inform the client about a current proposal. (via /nominate or /propose)
// This packet will be sent when a player has casted a vote in a current proposal or when a current proposal is completed, showing the final results.
class GP_SERV_COMMAND_SWITCH_PROC final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_SWITCH_PROC, GP_SERV_COMMAND_SWITCH_PROC>
{
public:
    struct PacketData
    {
        uint32_t AllNum;        // PS2: AllNum
        uint16_t VoteNumTbl[9]; // PS2: VoteNumTbl
        uint8_t  Kind;          // PS2: Kind
        uint8_t  State;         // PS2: State
        uint8_t  QuestionNum;   // PS2: QuestionNum
        uint8_t  sPropName[15]; // PS2: sPropName
        uint8_t  Str[256];      // PS2: Str (variable length)
    };

    // TODO: Unimplemented
    GP_SERV_COMMAND_SWITCH_PROC() = default;
};
