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

#include "0x033_eventstr.h"

#include "entities/charentity.h"
#include "event_info.h"

#include <cstring>

GP_SERV_COMMAND_EVENTSTR::GP_SERV_COMMAND_EVENTSTR(const CCharEntity* PChar, EventInfo* eventInfo)
{
    auto& packet = this->data();

    uint32 npcServerID = 0;
    uint32 npcLocalID  = 0;

    if (const CBaseEntity* PNpc = eventInfo->targetEntity)
    {
        npcServerID = PNpc->id;
        npcLocalID  = PNpc->targid;
    }
    else
    {
        npcServerID = PChar->id;
        npcLocalID  = PChar->targid;
    }

    packet.UniqueNo  = npcServerID;
    packet.ActIndex  = npcLocalID;
    packet.EventNum  = PChar->getZone();
    packet.EventPara = eventInfo->eventId;
    packet.Mode      = (eventInfo->eventFlags != 0) ? (eventInfo->eventFlags & 0xFFFF) : 8;

    for (const auto& [index, str] : eventInfo->strings)
    {
        if (index < std::size(packet.String))
        {
            std::memcpy(packet.String[index], str.c_str(), std::min<size_t>(str.size(), sizeof(packet.String[index]) - 1));
        }
    }

    for (const auto& [index, value] : eventInfo->params)
    {
        if (index < std::size(packet.Data))
        {
            packet.Data[index] = value;
        }
    }
}
