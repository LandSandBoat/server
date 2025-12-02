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

#include "0x071_group_strike.h"

#include "alliance.h"
#include "common/database.h"
#include "common/ipc_structs.h"
#include "entities/charentity.h"
#include "ipc_client.h"
#include "items/item_linkshell.h"
#include "linkshell.h"
#include "party.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_GROUP_STRIKE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator()
                  .oneOf<GP_CLI_COMMAND_GROUP_STRIKE_KIND>(Kind)
                  .mustEqual(ActIndex, 0, "ActIndex not 0")
                  .mustEqual(UniqueNo, 0, "UniqueNo not 0");

    switch (static_cast<GP_CLI_COMMAND_GROUP_STRIKE_KIND>(Kind))
    {
        case GP_CLI_COMMAND_GROUP_STRIKE_KIND::Party:
        {
            pv.isPartyLeader(PChar);
        }
        break;
        case GP_CLI_COMMAND_GROUP_STRIKE_KIND::Linkshell1:
        case GP_CLI_COMMAND_GROUP_STRIKE_KIND::Linkshell2:
        {
            pv.hasLinkshellRank(PChar, Kind, LSTYPE_PEARLSACK);
        }
        break;
        case GP_CLI_COMMAND_GROUP_STRIKE_KIND::Alliance:
        {
            pv.isAllianceLeader(PChar);
        }
        break;
    }

    return pv;
}

void GP_CLI_COMMAND_GROUP_STRIKE::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto victimName = db::escapeString(asStringFromUntrustedSource(sName, sizeof(sName)));

    switch (static_cast<GP_CLI_COMMAND_GROUP_STRIKE_KIND>(Kind))
    {
        case GP_CLI_COMMAND_GROUP_STRIKE_KIND::Party:
        {
            if (auto* PVictim = dynamic_cast<CCharEntity*>(PChar->PParty->GetMemberByName(victimName)))
            {
                // This block executes if PChar and PVictim are on the same process.
                ShowDebug("%s is trying to kick %s from party", PChar->getName(), PVictim->getName());
                if (PVictim == PChar) // using kick on yourself, let's borrow the logic from /pcmd leave to prevent alliance crash
                {
                    if (PChar->PParty->m_PAlliance &&
                        PChar->PParty->HasOnlyOneMember()) // single member alliance parties must be removed from alliance before disband
                    {
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

                PChar->PParty->RemoveMember(PVictim);
                ShowDebug("%s has removed %s from party", PChar->getName(), PVictim->getName());
            }
            else
            {
                // This block executes if PChar and PVictim are on different processes.
                if (const auto victimId = charutils::getCharIdFromName(victimName))
                {
                    const auto rset = db::preparedStmt("DELETE FROM accounts_parties WHERE partyid = ? AND charid = ?", PChar->id, victimId);
                    if (rset && rset->rowsAffected())
                    {
                        ShowDebug("%s has removed %s from party", PChar->getName(), victimName);

                        if (PChar->PParty && PChar->PParty->m_PAlliance)
                        {
                            message::send(ipc::AllianceReload{
                                .allianceId = PChar->PParty->m_PAlliance->m_AllianceID,
                            });
                        }
                        else // No alliance, notify party.
                        {
                            message::send(ipc::PartyReload{
                                .partyId = PChar->PParty->GetPartyID(),
                            });
                        }

                        // Notify the player they were just kicked -- they are no longer in the DB and party/alliance reloads won't notify them.
                        message::send(ipc::PlayerKick{
                            .victimId = victimId,
                        });
                    }
                }
            }
        }
        break;
        case GP_CLI_COMMAND_GROUP_STRIKE_KIND::Linkshell1:
        {
            if (!PChar->PLinkshell1)
            {
                return;
            }

            // Ensure the player has a linkshell equipped
            if (auto* PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK1)))
            {
                message::send(ipc::LinkshellRemove{
                    .requesterId   = PChar->id,
                    .requesterRank = PItemLinkshell->GetLSType(),
                    .victimName    = victimName,
                    .linkshellId   = PChar->PLinkshell1->getID(),
                });
            }
        }
        break;
        case GP_CLI_COMMAND_GROUP_STRIKE_KIND::Linkshell2:
        {
            if (!PChar->PLinkshell2)
            {
                return;
            }

            // Ensure the player has a linkshell equipped
            if (auto* PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK2)))
            {
                message::send(ipc::LinkshellRemove{
                    .requesterId   = PChar->id,
                    .requesterRank = PItemLinkshell->GetLSType(),
                    .victimName    = victimName,
                    .linkshellId   = PChar->PLinkshell2->getID(),
                });
            }
        }
        break;
        case GP_CLI_COMMAND_GROUP_STRIKE_KIND::Alliance:
        {
            CCharEntity* PVictim = nullptr;
            for (std::size_t i = 0; i < PChar->PParty->m_PAlliance->partyList.size(); ++i)
            {
                PVictim = dynamic_cast<CCharEntity*>(PChar->PParty->m_PAlliance->partyList[i]->GetMemberByName(victimName));
                if (PVictim && PVictim->PParty && PVictim->PParty->m_PAlliance) // victim is in this party
                {
                    ShowDebug("%s is trying to kick %s party from alliance", PChar->getName(), PVictim->getName());
                    // if using kick on yourself, or alliance leader using kick on another party leader - remove the party
                    if (PVictim == PChar || (PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty && PVictim->PParty->GetLeader() == PVictim))
                    {
                        if (PVictim->PParty->m_PAlliance->hasOnlyOneParty()) // if there is only 1 party then dissolve alliance
                        {
                            ShowDebug("One party in alliance, %s wants to dissolve the alliance", PChar->getName());
                            PVictim->PParty->m_PAlliance->dissolveAlliance();
                            ShowDebug("%s has dissolved the alliance", PChar->getName());
                        }
                        else
                        {
                            PVictim->PParty->m_PAlliance->removeParty(PVictim->PParty);
                            ShowDebug("%s has removed %s party from alliance", PChar->getName(), PVictim->getName());
                        }
                    }
                    break; // we're done, break the for
                }
            }
            if (!PVictim && PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty)
            {
                uint32 allianceID = PChar->PParty->m_PAlliance->m_AllianceID;

                if (const auto victimId = charutils::getCharIdFromName(victimName))
                {
                    const auto rset = db::preparedStmt(
                        "SELECT partyid FROM accounts_parties WHERE charid = ? AND allianceid = ? AND partyflag & ? LIMIT 1",
                        victimId,
                        PChar->PParty->m_PAlliance->m_AllianceID,
                        PARTY_LEADER | PARTY_SECOND | PARTY_THIRD);

                    FOR_DB_SINGLE_RESULT(rset)
                    {
                        uint32 partyid = rset->get<uint32>("partyid");

                        const auto rset2 = db::preparedStmt("UPDATE accounts_parties SET allianceid = 0, partyflag = partyflag & ~? WHERE partyid = ?",
                                                            PARTY_SECOND | PARTY_THIRD,
                                                            partyid);
                        if (rset2 && rset2->rowsAffected())
                        {
                            ShowDebug("%s has removed %s party from alliance", PChar->getName(), victimName);

                            // notify party they were removed
                            message::send(ipc::PartyReload{
                                .partyId = partyid,
                            });

                            // notify alliance a party was removed
                            message::send(ipc::AllianceReload{
                                .allianceId = allianceID,
                            });
                        }
                    }
                }
            }
        }
        break;
    }
}
