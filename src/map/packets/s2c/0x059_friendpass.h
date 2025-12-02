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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0059
// This packet is sent by the server when interacting with an NPC that handles world passes.
class GP_SERV_COMMAND_FRIENDPASS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_FRIENDPASS, GP_SERV_COMMAND_FRIENDPASS>
{
public:
    struct PacketData
    {
        int32_t  leftNum;    // PS2: leftNum
        int32_t  leftDays;   // PS2: leftDays
        int32_t  passPop;    // PS2: passPop
        char     String[16]; // PS2: String
        char     Type;       // PS2: Type
        char     unknown21;  // PS2: (New; did not exist.)
        uint16_t padding00;  // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_FRIENDPASS(uint32_t worldPass);
};
