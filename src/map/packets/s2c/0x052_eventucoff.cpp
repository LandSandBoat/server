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

#include "0x052_eventucoff.h"

#include <string_view>

#include "entities/charentity.h"

namespace
{
    bool shouldLogEventPacketsS2C(const CCharEntity* PChar)
    {
        return PChar != nullptr && std::string_view(PChar->getName()) == "Tsuketaru";
    }
} // namespace

GP_SERV_COMMAND_EVENTUCOFF::GP_SERV_COMMAND_EVENTUCOFF(CCharEntity* PChar, const GP_SERV_COMMAND_EVENTUCOFF_MODE mode)
{
    auto& packet = this->data();

    packet.Mode = mode;
    // For Mode 2, pack the event ID.
    if (mode == GP_SERV_COMMAND_EVENTUCOFF_MODE::CancelEvent && PChar->currentEvent)
    {
        packet.Mode = static_cast<GP_SERV_COMMAND_EVENTUCOFF_MODE>(static_cast<uint32_t>(packet.Mode) | PChar->currentEvent->eventId << 8);
    }

    if (shouldLogEventPacketsS2C(PChar))
    {
        ShowInfoFmt("[EventPkt][S2C][0x052] name={} zone={} modeRaw=0x{:08X} currentEventId={}",
                    PChar->getName(),
                    PChar->getZone(),
                    static_cast<uint32_t>(packet.Mode),
                    PChar->currentEvent ? PChar->currentEvent->eventId : 0);
    }

    PChar->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
}
