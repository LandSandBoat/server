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

#include "0x11c_party_request.h"

#include "common/ipc_structs.h"
#include "entities/char_entity.h"
#include "ipc_client.h"
#include "packets/c2s/validation.h"
#include "utils/blacklistutils.h"

auto GP_CLI_COMMAND_PARTY_REQUEST::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .oneOf<GP_CLI_COMMAND_PARTY_REQUEST_KIND>(this->Kind)
        .mustNotEqual(PChar->id, this->UniqueNo, "Cannot request to join yourself")
        .mustEqual(PChar->m_PMonstrosity == nullptr, true, "Cannot request while in Monstrosity");
}

void GP_CLI_COMMAND_PARTY_REQUEST::process(MapSession* PSession, CCharEntity* PChar) const
{
    // dropped silently
    if (blacklistutils::IsBlacklisted(this->UniqueNo, PChar->id))
    {
        return;
    }

    // the request list lives on the recipient's client
    message::send(ipc::PartyRequest{
        .recipientId     = this->UniqueNo,
        .requesterId     = PChar->id,
        .requesterTargId = PChar->targid,
        .requesterZoneId = PChar->getZone(),
        .requesterName   = PChar->getName(),
        .requesterRace   = PChar->look.race,
        .kind            = this->Kind,
    });
}
