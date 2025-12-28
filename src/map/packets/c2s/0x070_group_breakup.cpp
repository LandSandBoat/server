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

#include "0x070_group_breakup.h"

#include "alliance.h"
#include "entities/charentity.h"
#include "enums/party_kind.h"
#include "party.h"

auto GP_CLI_COMMAND_GROUP_BREAKUP::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator()
                  .oneOf<PartyKind>(Kind)
                  .isPartyLeader(PChar);

    switch (Kind)
    {
        case PartyKind::Party:
        {
            pv.mustEqual(PChar->PParty && !PChar->PParty->m_PAlliance, true, "Cant break party while in alliance");
        }
        break;
        case PartyKind::Alliance:
        {
            pv.isAllianceLeader(PChar);
        }
        break;
    }

    return pv;
}

void GP_CLI_COMMAND_GROUP_BREAKUP::process(MapSession* PSession, CCharEntity* PChar) const
{
    switch (Kind)
    {
        case PartyKind::Party:
        {
            ShowDebug("%s is disbanding the party (pcmd breakup)", PChar->getName());
            PChar->PParty->DisbandParty();
            ShowDebug("%s party has been disbanded (pcmd breakup)", PChar->getName());
        }
        break;
        case PartyKind::Alliance:
        {
            ShowDebug("%s is disbanding the alliance (acmd breakup)", PChar->getName());
            PChar->PParty->m_PAlliance->dissolveAlliance();
            ShowDebug("%s alliance has been disbanded (acmd breakup)", PChar->getName());
        }
        break;
    }
}
