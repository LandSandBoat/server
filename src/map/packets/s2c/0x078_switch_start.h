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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0078
// This packet is sent by the server to inform the client when a player has made a proposal. (via /nominate or /propose)
class GP_SERV_COMMAND_SWITCH_START final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_SWITCH_START, GP_SERV_COMMAND_SWITCH_START>
{
public:
    struct PacketData
    {
        uint32_t UniqueNo;  // PS2: UniqueNo
        uint32_t AllNum;    // PS2: AllNum
        uint16_t ActIndex;  // PS2: ActIndex
        uint8_t  sName[15]; // PS2: sName
        uint8_t  Kind;      // PS2: Kind
        uint8_t  Str[224];  // PS2: Str (variable length)
    };

    // TODO: Unimplemented
    GP_SERV_COMMAND_SWITCH_START() = default;
};
