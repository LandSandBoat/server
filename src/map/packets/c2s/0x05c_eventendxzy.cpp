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

#include "0x05c_eventendxzy.h"

#include "entities/charentity.h"
#include "lua/luautils.h"
#include "packets/s2c/0x052_eventucoff.h"
#include "packets/s2c/0x05b_wpos.h"
#include "packets/s2c/0x065_wpos2.h"

auto GP_CLI_COMMAND_EVENTENDXZY::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(Mode, 1, "Mode not 1")
        .isInEvent(PChar, EventPara);
}

void GP_CLI_COMMAND_EVENTENDXZY::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto result  = EndPara;
    const auto eventId = EventPara;

    bool updatePosition = false;

    // TODO: Currently the return value for onEventUpdate in Interaction Framework is not received.  Remove
    // the localVar check when this is resolved.

    const int32  updateResult     = luautils::OnEventUpdate(PChar, eventId, result);
    const uint32 noPositionUpdate = PChar->GetLocalVar("noPosUpdate");
    updatePosition                = noPositionUpdate == 0 ? updateResult == 1 : false;

    PChar->SetLocalVar("noPosUpdate", 0);

    if (updatePosition)
    {
        position_t newPos = {
            x,
            y,
            z,
            0,
            static_cast<uint8_t>(dir),
        };

        PChar->pushPacket<GP_SERV_COMMAND_WPOS2>(PChar, newPos, POSMODE::EVENT);
        PChar->pushPacket<GP_SERV_COMMAND_WPOS>(PChar, newPos, POSMODE::NORMAL);
    }
    else
    {
        PChar->pushPacket<GP_SERV_COMMAND_WPOS2>(PChar, PChar->loc.p, POSMODE::CLEAR);
    }

    PChar->pushPacket<GP_SERV_COMMAND_EVENTUCOFF>(PChar, GP_SERV_COMMAND_EVENTUCOFF_MODE::EventRecvPending);
}
