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

#include "0x05a_reqconquest.h"

#include "campaign_system.h"
#include "entities/charentity.h"
#include "packets/s2c/0x05e_conquest.h"
#include "packets/s2c/0x071_influence_campaign.h"
#include "packets/s2c/0x071_influence_colonization.h"

auto GP_CLI_COMMAND_REQCONQUEST::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameter to validate for this packet.
    return PacketValidator();
}

void GP_CLI_COMMAND_REQCONQUEST::process(MapSession* PSession, CCharEntity* PChar) const
{
    PChar->pushPacket<GP_SERV_COMMAND_CONQUEST>(PChar);

    // TODO: This does not work reliably with multiple process.
    // World server needs to stream updates to all map servers.
    // CampaignState state = campaign::GetCampaignState();
    // PChar->pushPacket<GP_SERV_COMMAND_INFLUENCE::CAMPAIGN>(PChar, state, 0);
    // PChar->pushPacket<GP_SERV_COMMAND_INFLUENCE::CAMPAIGN>(PChar, state, 1);
    PChar->pushPacket<GP_SERV_COMMAND_INFLUENCE::COLONIZATION>(PChar);
}
