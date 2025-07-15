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

#include "0x05b_eventend.h"

#include "entities/baseentity.h"
#include "entities/charentity.h"
#include "lua/luautils.h"
#include "packets/release.h"

auto GP_CLI_COMMAND_EVENTEND::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_EVENTEND_MODE>(Mode)
        .isInEvent(PChar, EventPara);
}

void GP_CLI_COMMAND_EVENTEND::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto       result  = EndPara;
    const auto eventId = EventPara;

    if (PChar->currentEvent->option != 0)
    {
        result = PChar->currentEvent->option;
    }

    switch (static_cast<GP_CLI_COMMAND_EVENTEND_MODE>(Mode))
    {
        case GP_CLI_COMMAND_EVENTEND_MODE::UpdatePending:
        {
            // If optional cutscene is started, we check to see if the selected option should lock the player
            if (result != -1 && PChar->currentEvent->hasCutsceneOption(result))
            {
                PChar->setLocked(true);
            }

            luautils::OnEventUpdate(PChar, eventId, result);
        }
        break;
        case GP_CLI_COMMAND_EVENTEND_MODE::End:
        {
            luautils::OnEventFinish(PChar, eventId, result);
            // reset if this event did not initiate another event
            if (PChar->currentEvent->eventId == eventId)
            {
                PChar->endCurrentEvent();
            }
        }
        break;
    }

    PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::EVENT);
    PChar->updatemask |= UPDATE_HP;
}
