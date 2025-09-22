/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/utils.h"

#include <cstring>

#include "message_special.h"

#include "entities/baseentity.h"

// https://github.com/atom0s/XiPackets/blob/main/world/server/0x002A/README.md
struct GP_SERV_TALKNUMWORK
{
    uint16_t id : 9;
    uint16_t size : 7;
    uint16_t sync;
    uint32_t UniqueNo;   // PS2: UniqueNo
    int32_t  num[4];     // PS2: num
    uint16_t ActIndex;   // PS2: ActIndex
    uint16_t MesNum;     // PS2: MesNum
    uint8_t  Type;       // PS2: Type
    uint8_t  Flag;       // PS2: dummy
    uint8_t  String[32]; // PS2: dummy2
};

CMessageSpecialPacket::CMessageSpecialPacket(CBaseEntity* PEntity, uint16 messageID, uint32 param0, uint32 param1, uint32 param2, uint32 param3, bool ShowName)
{
    auto packet = this->as<GP_SERV_TALKNUMWORK>();

    packet->id   = 0x2A;
    packet->size = roundUpToNearestFour(sizeof(GP_SERV_TALKNUMWORK) - sizeof(packet->String)) / 4; // SE dynamically sizes this if it has the name in it or not

    packet->UniqueNo = PEntity->id;

    packet->num[0] = param0;
    packet->num[1] = param1;
    packet->num[2] = param2;
    packet->num[3] = param3;

    packet->ActIndex = PEntity->targid;

    packet->Type = 0; // Old behavior is hardcoded to zero
    packet->Flag = 0; // Old behavior is hardcoded to zero

    if (ShowName)
    {
        std::memset(packet->String, 0, sizeof(packet->String));

        packet->size = roundUpToNearestFour(sizeof(GP_SERV_TALKNUMWORK)) / 4;
        std::memcpy(&packet->String[0], PEntity->getName().c_str(), std::min<size_t>(PEntity->getName().size(), sizeof(packet->String) - 1)); // Subtract 1 for the null terminator
    }
    else if (PEntity->objtype == TYPE_PC) // No clue what this is. Likely a consequence of Type and Flag always being 0 in the past.
    {
        messageID += 0x8000;
    }

    packet->MesNum = messageID;
}
