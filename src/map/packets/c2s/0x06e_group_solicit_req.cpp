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

#include "0x06e_group_solicit_req.h"

#include "common/ipc_structs.h"
#include "entities/charentity.h"
#include "ipc_client.h"
#include "packets/message_basic.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/s2c/0x0dc_group_solicit_req.h"
#include "status_effect_container.h"
#include "utils/blacklistutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_GROUP_SOLICIT_REQ::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator()
                  .oneOf<PartyKind>(Kind)
                  .mustNotEqual(PChar->id, UniqueNo, "Cannot invite yourself")
                  .mustEqual(blacklistutils::IsBlacklisted(UniqueNo, PChar->id), false, "Character has inviter blacklisted");

    return pv;
}

void GP_CLI_COMMAND_GROUP_SOLICIT_REQ::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PInviter = PChar;

    const uint32 inviteeCharId = UniqueNo;
    const uint16 inviteeTargId = ActIndex;

    if (jailutils::InPrison(PInviter))
    {
        // Initiator is in prison.  Send error message.
        PInviter->pushPacket<CMessageBasicPacket>(PInviter, PInviter, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    switch (Kind)
    {
        case PartyKind::Party:
        {
            if (PInviter->PParty == nullptr || PInviter->PParty->GetLeader() == PInviter)
            {
                if (PInviter->PParty && PInviter->PParty->IsFull())
                {
                    PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInvite);
                    break;
                }

                CCharEntity* PInvitee = nullptr;

                if (inviteeTargId != 0)
                {
                    CBaseEntity* PEntity = PInviter->GetEntity(inviteeTargId, TYPE_PC);
                    if (PEntity && PEntity->id == inviteeCharId)
                    {
                        PInvitee = static_cast<CCharEntity*>(PEntity);
                    }
                }
                else
                {
                    PInvitee = zoneutils::GetChar(inviteeCharId);
                }

                if (PInvitee)
                {
                    ShowDebug("%s sent party invite to %s", PInviter->getName(), PInvitee->getName());

                    // make sure invitee isn't dead or in jail, they aren't a party member and don't already have an invite pending, and your party is not full
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || PInvitee->PParty != nullptr)
                    {
                        ShowDebug("%s is dead, in jail, has a pending invite, or is already in a party", PInvitee->getName());
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInvite);
                        break;
                    }

                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug("%s is blocking party invites", PInvitee->getName());
                        // Target is blocking assistance
                        PInviter->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
                        // Interaction was blocked
                        PInvitee->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
                        // You cannot invite that person at this time.
                        PInviter->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotInvite);
                        break;
                    }

                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug("%s has level sync, unable to send invite", PInvitee->getName());
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInviteLevelSync);
                        break;
                    }

                    PInvitee->InvitePending.id     = PInviter->id;
                    PInvitee->InvitePending.targid = PInviter->targid;

                    PInvitee->pushPacket<GP_SERV_COMMAND_GROUP_SOLICIT_REQ>(inviteeCharId, inviteeTargId, PInviter->getName(), PartyKind::Party);

                    ShowDebug("Sent party invite packet to %s", PInvitee->getName());

                    if (PInviter->PParty && PInviter->PParty->GetSyncTarget())
                    {
                        PInvitee->pushPacket<CMessageStandardPacket>(PInvitee, 0, 0, MsgStd::LevelSyncWarning);
                    }
                }
                else
                {
                    // on another server (hopefully)
                    message::send(ipc::PartyInvite{
                        .inviteeId     = inviteeCharId,
                        .inviteeTargId = inviteeTargId,
                        .inviterId     = PInviter->id,
                        .inviterTargId = PInviter->targid,
                        .inviterName   = PInviter->getName(),
                        .inviteType    = PartyKind::Party,
                    });
                }
            }
            else // in party but not leader, cannot invite
            {
                ShowDebug("%s is not party leader, cannot send invite", PInviter->getName());
                PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::NotPartyLeader);
            }
        }
        break;
        case PartyKind::Alliance:
        {
            if (PInviter->PParty && PInviter->PParty->GetLeader() == PInviter &&
                (PInviter->PParty->m_PAlliance == nullptr ||
                 (PInviter->PParty->m_PAlliance->getMainParty() == PInviter->PParty && !PInviter->PParty->m_PAlliance->isFull())))
            {
                CCharEntity* PInvitee = nullptr;

                if (inviteeTargId != 0)
                {
                    CBaseEntity* PEntity = PInviter->GetEntity(inviteeTargId, TYPE_PC);
                    if (PEntity && PEntity->id == inviteeCharId)
                    {
                        PInvitee = static_cast<CCharEntity*>(PEntity);
                    }
                }
                else
                {
                    PInvitee = zoneutils::GetChar(inviteeCharId);
                }

                if (PInvitee)
                {
                    ShowDebug("%s sent alliance invite to %s", PInviter->getName(), PInvitee->getName());

                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug("%s is blocking alliance invites", PInvitee->getName());
                        // Target is blocking assistance
                        PInviter->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
                        // Interaction was blocked
                        PInvitee->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
                        // You cannot invite that person at this time.
                        PInviter->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotInvite);
                        break;
                    }

                    // make sure intvitee isn't dead or in jail, they are an unallied party leader and don't already have an invite pending
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || PInvitee->PParty == nullptr ||
                        PInvitee->PParty->GetLeader() != PInvitee || PInvitee->PParty->m_PAlliance)
                    {
                        ShowDebug("%s is dead, in jail, has a pending invite, or is already in a party/alliance", PInvitee->getName());
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInvite);
                        break;
                    }

                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug("%s has level sync, unable to send invite", PInvitee->getName());
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInviteLevelSync);
                        break;
                    }

                    PInvitee->InvitePending.id     = PInviter->id;
                    PInvitee->InvitePending.targid = PInviter->targid;

                    PInvitee->pushPacket<GP_SERV_COMMAND_GROUP_SOLICIT_REQ>(inviteeCharId, inviteeTargId, PInviter->getName(), PartyKind::Alliance);

                    ShowDebug("Sent party invite packet to %s", PInvitee->getName());
                }
                else
                {
                    // on another server (hopefully)
                    message::send(ipc::PartyInvite{
                        .inviteeId     = inviteeCharId,
                        .inviteeTargId = inviteeTargId,
                        .inviterId     = PInviter->id,
                        .inviterTargId = PInviter->targid,
                        .inviterName   = PInviter->getName(),
                        .inviteType    = PartyKind::Alliance,
                    });
                }
            }
        }
        break;
    }
}
