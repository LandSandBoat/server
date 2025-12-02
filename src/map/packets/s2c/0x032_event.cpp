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

#include "0x032_event.h"

#include "entities/charentity.h"
#include "event_info.h"

GP_SERV_COMMAND_EVENT::GP_SERV_COMMAND_EVENT(const CCharEntity* PChar, const EventInfo* eventInfo)
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

    packet.EventNum   = PChar->getZone();
    packet.EventPara  = eventInfo->eventId;
    packet.Mode       = eventInfo->eventFlags & 0xFFFF;
    packet.EventNum2  = PChar->getZone();
    packet.EventPara2 = eventInfo->eventFlags >> 16;
}
