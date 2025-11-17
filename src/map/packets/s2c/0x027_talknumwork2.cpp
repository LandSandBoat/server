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

#include "0x027_talknumwork2.h"

#include "entities/baseentity.h"
#include "entities/charentity.h"

#include <cstring>

// TODO: Super wrong but this is how it's used for Fishing messages currently.
GP_SERV_COMMAND_TALKNUMWORK2::GP_SERV_COMMAND_TALKNUMWORK2(const CCharEntity* PChar, const uint16 param0, const uint16 messageID, const uint8 count)
{
    auto& packet = this->data();

    packet.UniqueNo = PChar->id;
    packet.ActIndex = PChar->targid;
    packet.MesNum   = messageID + 0x8000;
    packet.Num1[0]  = param0;
    packet.Num1[1]  = count;

    std::memcpy(packet.String1, PChar->getName().c_str(), std::min<size_t>(PChar->getName().size(), sizeof(packet.String1)));
}

GP_SERV_COMMAND_TALKNUMWORK2::GP_SERV_COMMAND_TALKNUMWORK2(
    CBaseEntity* PActor,
    const uint16 messageID,
    CBaseEntity* PNameActor,
    const int32  param0,
    const int32  param1,
    const int32  param2,
    const int32  param3,
    const int32  chatType,
    const bool   showSender)
{
    auto& packet = this->data();

    packet.UniqueNo = PActor->id;
    packet.ActIndex = PActor->targid;
    packet.MesNum   = showSender ? messageID : (messageID | 0x8000);
    packet.Type     = chatType;
    packet.Num1[0]  = param0;
    packet.Num1[1]  = param1;
    packet.Num1[2]  = param2;
    packet.Num1[3]  = param3;

    CBaseEntity* PNameEntity = PNameActor ? PNameActor : PActor;
    std::memcpy(packet.String1, PNameEntity->getName().c_str(), std::min<size_t>(PNameEntity->getName().size(), sizeof(packet.String1)));
}
