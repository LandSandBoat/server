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

enum class MsgStd : uint16_t;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0053
// This packet is sent by the server to display a formatted message loaded from the DAT files. (via PutSystemMessage)
class GP_SERV_COMMAND_SYSTEMMES final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_SYSTEMMES, GP_SERV_COMMAND_SYSTEMMES>
{
public:
    struct PacketData
    {
        uint32_t para;      // PS2: para
        uint32_t para2;     // PS2: para2
        MsgStd   Number;    // PS2: Number
        uint16_t padding0E; // PS2: dummy
    };

    GP_SERV_COMMAND_SYSTEMMES(uint32 param0, uint32 param1, MsgStd messageId);
};
