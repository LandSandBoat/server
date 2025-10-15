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

class CBaseEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x002A
// This packet is sent by the server to display a formatted general zone message.
class GP_SERV_COMMAND_TALKNUMWORK final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TALKNUMWORK, GP_SERV_COMMAND_TALKNUMWORK>
{
public:
    struct PacketData
    {
        uint32_t UniqueNo;     // PS2: UniqueNo
        int32_t  num[4];       // PS2: num
        uint16_t ActIndex;     // PS2: ActIndex
        uint16_t MesNum;       // PS2: MesNum
        uint8_t  Type;         // PS2: Type
        uint8_t  Flag;         // PS2: dummy
        uint8_t  String[32];   // PS2: dummy2
        uint8_t  padding3E[2]; // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_TALKNUMWORK(const CBaseEntity* PEntity, uint16 messageID, uint32 param0 = 0, uint32 param1 = 0, uint32 param2 = 0, uint32 param3 = 0,
                                bool ShowName = false);
};
