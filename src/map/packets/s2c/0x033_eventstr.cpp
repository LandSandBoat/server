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
#include <string_view>

namespace
{
    bool shouldLogEventPacketsS2C(const CCharEntity* PChar)
    {
        return PChar != nullptr && std::string_view(PChar->getName()) == "Tsuketaru";
    }
} // namespace

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

    if (shouldLogEventPacketsS2C(PChar))
    {
        // Don't dump the full string table; log a couple and the first few params.
        const auto safeStr = [&](uint32 idx) -> std::string_view
        {
            static constexpr std::string_view kEmpty = "";
            if (idx < std::size(packet.String))
            {
                return std::string_view(packet.String[idx]);
            }
            return kEmpty;
        };

        ShowInfoFmt("[EventPkt][S2C][0x033] name={} zone={} eventId={} mode={} s0='{}' s1='{}' d0={} d1={} d2={} d3={}",
                    PChar->getName(),
                    PChar->getZone(),
                    eventInfo->eventId,
                    packet.Mode,
                    safeStr(0),
                    safeStr(1),
                    packet.Data[0],
                    packet.Data[1],
                    packet.Data[2],
                    packet.Data[3]);
    }
}
