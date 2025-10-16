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

#include "0x034_eventnum.h"

#include <cstring>

#include "entities/charentity.h"
#include "event_info.h"

GP_SERV_COMMAND_EVENTNUM::GP_SERV_COMMAND_EVENTNUM(const CCharEntity* PChar, const EventInfo* eventInfo)
{
    auto& packet = this->data();

    if (const CBaseEntity* PNpc = eventInfo->targetEntity)
    {
        packet.UniqueNo = PNpc->id;
        packet.ActIndex = PNpc->targid;
    }
    else
    {
        packet.UniqueNo = PChar->id;
        packet.ActIndex = PChar->targid;
    }

    for (auto& paramPair : eventInfo->params)
    {
        if (paramPair.first <= 7)
        {
            packet.num[paramPair.first] = paramPair.second;
        }
    }

    packet.EventNum  = PChar->getZone();
    packet.EventPara = eventInfo->eventId;

    if (eventInfo->textTable != -1)
    {
        packet.EventNum2 = eventInfo->textTable;
    }
    else
    {
        packet.EventNum2 = PChar->getZone();
    }

    if (eventInfo->eventFlags != 0)
    {
        packet.Mode       = eventInfo->eventFlags & 0xFFFF;
        packet.EventPara2 = eventInfo->eventFlags >> 16;
    }
    else
    {
        packet.Mode = 8;
    }
}
