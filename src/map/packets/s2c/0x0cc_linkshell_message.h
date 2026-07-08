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
#include "linkshell.h"

#include <string>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00CC
// This packet is sent by the server in response to the clients linkshell command request usage.
class GP_SERV_COMMAND_LINKSHELL_MESSAGE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_LINKSHELL_MESSAGE, GP_SERV_COMMAND_LINKSHELL_MESSAGE>
{
public:
    struct PacketData
    {
        uint8_t  stat : 4;            // PS2: stat
        uint8_t  attr : 4;            // PS2: attr
        uint8_t  readLevel : 2;       // PS2: readLevel
        uint8_t  writeLevel : 2;      // PS2: writeLevel
        uint8_t  pubEditLevel : 2;    // PS2: pubEditLevel
        uint8_t  linkshell_index : 2; // PS2: dummyBits
        uint16_t seqId;               // PS2: seqId
        uint8_t  sMessage[128];       // PS2: sMessage
        uint32_t updateTime;          // PS2: updateTime
        uint8_t  modifier[16];        // PS2: modifier
        uint16_t opType;              // PS2: opType
        uint16_t padding9E;           // PS2: padding
        uint8_t  encodedLsName[16];   // PS2: encodedLsName
    };

    GP_SERV_COMMAND_LINKSHELL_MESSAGE(const std::string& poster, const std::string& message, const std::string& lsname, uint32_t posttime, LinkshellSlot slot);
};
