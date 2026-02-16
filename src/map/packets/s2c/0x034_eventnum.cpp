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
#include <string_view>

#include "entities/charentity.h"
#include "event_info.h"

namespace
{
    bool shouldLogEventPacketsS2C(const CCharEntity* PChar)
    {
        return PChar != nullptr && std::string_view(PChar->getName()) == "Tsuketaru";
    }
} // namespace

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

    if (shouldLogEventPacketsS2C(PChar))
    {
        ShowInfoFmt("[EventPkt][S2C][0x034] name={} zone={} eventId={} mode={} p0={} p1={} p2={} p3={} p4={} p5={} p6={} p7={}",
                    PChar->getName(),
                    PChar->getZone(),
                    eventInfo->eventId,
                    packet.Mode,
                    packet.num[0],
                    packet.num[1],
                    packet.num[2],
                    packet.num[3],
                    packet.num[4],
                    packet.num[5],
                    packet.num[6],
                    packet.num[7]);
    }
}
