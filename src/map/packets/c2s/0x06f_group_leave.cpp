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

#include "0x06f_group_leave.h"

#include "entities/charentity.h"
#include "enums/party_kind.h"

auto GP_CLI_COMMAND_GROUP_LEAVE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<PartyKind>(Kind)
        .mustNotEqual(PChar->PParty, nullptr, "Character is not in a party");
}

void GP_CLI_COMMAND_GROUP_LEAVE::process(MapSession* PSession, CCharEntity* PChar) const
{
    switch (Kind)
    {
        case PartyKind::Party:
        {
            if (PChar->PParty->m_PAlliance &&
                PChar->PParty->HasOnlyOneMember()) // single member alliance parties must be removed from alliance before disband
            {
                ShowDebug("%s party size is one", PChar->getName());

                if (PChar->PParty->m_PAlliance->hasOnlyOneParty()) // if there is only 1 party then dissolve alliance
                {
                    ShowDebug("%s alliance size is one party", PChar->getName());

                    PChar->PParty->m_PAlliance->dissolveAlliance();
                    ShowDebug("%s alliance is dissolved", PChar->getName());
                }
                else
                {
                    ShowDebug("Removing %s party from alliance", PChar->getName());

                    PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                    ShowDebug("%s party is removed from alliance", PChar->getName());
                }
            }

            ShowDebug("Removing %s from party", PChar->getName());

            PChar->PParty->RemoveMember(PChar);
            ShowDebug("%s is removed from party", PChar->getName());
        }
        break;
        case PartyKind::Alliance:
        {
            if (PChar->PParty->m_PAlliance && PChar->PParty->GetLeader() == PChar)
            {
                ShowDebug("%s is leader of a party in an alliance", PChar->getName());
                if (PChar->PParty->m_PAlliance->hasOnlyOneParty()) // if there is only 1 party then dissolve alliance
                {
                    ShowDebug("One party in alliance, %s wants to dissolve the alliance", PChar->getName());

                    PChar->PParty->m_PAlliance->dissolveAlliance();
                    ShowDebug("%s has dissolved the alliance", PChar->getName());
                }
                else
                {
                    ShowDebug("%s wants to remove their party from the alliance", PChar->getName());

                    PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                    ShowDebug("%s party is removed from the alliance", PChar->getName());
                }
            }
        }
        break;
    }
}
