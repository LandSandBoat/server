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

#include "0x074_group_solicit_res.h"

#include "alliance.h"
#include "common/ipc_structs.h"
#include "entities/charentity.h"
#include "ipc_client.h"
#include "packets/s2c/0x009_message.h"
#include "party.h"
#include "status_effect_container.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_GROUP_SOLICIT_RES::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_GROUP_SOLICIT_RES_RES>(Res);
}

void GP_CLI_COMMAND_GROUP_SOLICIT_RES::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (CCharEntity* PInviter = zoneutils::GetCharFromWorld(PChar->InvitePending.id, PChar->InvitePending.targid); PInviter != nullptr)
    {
        // This switch statement only occurs when both the invitee and inviter are on the same process
        switch (static_cast<GP_CLI_COMMAND_GROUP_SOLICIT_RES_RES>(Res))
        {
            case GP_CLI_COMMAND_GROUP_SOLICIT_RES_RES::Decline:
            {
                ShowDebug("%s declined party invite from %s", PChar->getName(), PInviter->getName());

                // invitee declined invite
                PInviter->pushPacket<GP_SERV_COMMAND_MESSAGE>(PInviter, 0, 0, MsgStd::InvitationDeclined);
            }
            break;
            case GP_CLI_COMMAND_GROUP_SOLICIT_RES_RES::Accept:
            {
                // check for alliance invite
                if (PChar->PParty != nullptr && PInviter->PParty != nullptr)
                {
                    // both invitee and inviter are party leaders
                    if (PInviter->PParty->GetLeader() == PInviter && PChar->PParty->GetLeader() == PChar)
                    {
                        ShowDebug("%s invited %s to an alliance", PInviter->getName(), PChar->getName());

                        // the inviter already has an alliance and wants to add another party - only add if they have room for another party
                        if (PInviter->PParty->m_PAlliance)
                        {
                            // break if alliance is full or the inviter is not the leader
                            if (PInviter->PParty->m_PAlliance->isFull() || PInviter->PParty->m_PAlliance->getMainParty() != PInviter->PParty)
                            {
                                ShowDebug("Alliance is full, invite to %s cancelled", PChar->getName());
                                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar, 0, 0, MsgStd::CannotBeProcessed);
                                break;
                            }

                            // alliance is not full, add the new party
                            PInviter->PParty->m_PAlliance->addParty(PChar->PParty);
                            ShowDebug("%s party added to %s alliance", PChar->getName(), PInviter->getName());
                        }
                        else if (PChar->PParty->HasTrusts() || PInviter->PParty->HasTrusts())
                        {
                            // Cannot form alliance if you have Trusts
                            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar, 0, 0, MsgStd::TrustCannotJoinAlliance);
                        }
                        else
                        {
                            // party leaders have no alliance - create a new one!
                            ShowDebug("Creating new alliance");
                            PInviter->PParty->m_PAlliance = new CAlliance(PInviter);
                            PInviter->PParty->m_PAlliance->addParty(PChar->PParty);
                            ShowDebug("%s party added to %s alliance", PChar->getName(), PInviter->getName());
                        }
                    }
                }

                // the rest is for a standard party invitation
                if (PChar->PParty == nullptr)
                {
                    if (!(PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC) && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_RESTRICTION)))
                    {
                        ShowDebug("%s is not under lvl sync or restriction", PChar->getName());
                        if (PInviter->PParty == nullptr)
                        {
                            ShowDebug("Creating new party");
                            PInviter->PParty = new CParty(PInviter);
                        }
                        if (PInviter->PParty->GetLeader() == PInviter)
                        {
                            if (PInviter->PParty->IsFull())
                            { // someone else accepted invitation
                                // PInviter->pushPacket<GP_SERV_COMMAND_MESSAGE>(PInviter, 0, 0, 14); Don't think retail sends error packet to inviter on full pt
                                ShowDebug("Someone else accepted party invite, %s cannot be added to party", PChar->getName());
                                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar, 0, 0, MsgStd::CannotBeProcessed);
                            }
                            else
                            {
                                ShowDebug("Added %s to %s's party", PChar->getName(), PInviter->getName());
                                PInviter->PParty->AddMember(PChar);
                            }
                        }
                    }
                    else
                    {
                        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar, 0, 0, MsgStd::CannotJoinLevelSync);
                    }
                }
            }
            break;
        }
    }
    else
    {
        // If invitee and inviter not on same process,
        // defer to world process to route the request
        message::send(ipc::PartyInviteResponse{
            .inviteeId     = PChar->id,
            .inviteeTargId = PChar->targid,
            .inviterId     = PChar->InvitePending.id,
            .inviterTargId = PChar->InvitePending.targid,
            .inviteAnswer  = Res,
        });
    }

    PChar->InvitePending.clean();
}
