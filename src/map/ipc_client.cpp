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

#include "ipc_client.h"

#include "common/ipp.h"

#include <concurrentqueue.h>
#include <queue>

#include "alliance.h"
#include "conquest_system.h"
#include "linkshell.h"
#include "map_networking.h"
#include "map_server.h"
#include "status_effect_container.h"
#include "unitychat.h"

#include "entities/charentity.h"
#include "entities/trustentity.h"

#include "lua/luautils.h"

#include "packets/chat_message.h"
#include "packets/linkshell_message.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/party_invite.h"
#include "packets/server_ip.h"

#include "items/item_linkshell.h"
#include "packets/char_status.h"
#include "packets/party_define.h"
#include "packets/party_member_update.h"

#include "party/char_party.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"
#include "utils/serverutils.h"
#include "utils/zoneutils.h"

// TODO: Don't do this
std::unique_ptr<IPCClient> ipcClient_;

void message::init(MapNetworking& networking)
{
    TracyZoneScoped;

    ipcClient_ = std::make_unique<IPCClient>(networking);
}

void message::handle_incoming()
{
    TracyZoneScoped;

    ipcClient_->handleIncomingMessages();
}

IPCClient::IPCClient(MapNetworking& networking)
: networking_(networking)
, zmqDealerWrapper_(getZMQEndpointString(), getZMQRoutingId())
{
    TracyZoneScoped;
}

auto IPCClient::getZMQEndpointString() -> std::string
{
    return fmt::format("tcp://{}:{}", settings::get<std::string>("network.ZMQ_IP"), settings::get<uint16>("network.ZMQ_PORT"));
}

auto IPCClient::getZMQRoutingId() -> uint64
{
    auto ip   = networking_.ipp().getIP();
    auto port = networking_.ipp().getPort();

    // if no ip/port were supplied, set to 1 (0 is not valid for an identity)
    if (ip == 0 && port == 0)
    {
        const auto rset = db::preparedStmt("SELECT zoneip, zoneport FROM zone_settings GROUP BY zoneip, zoneport ORDER BY COUNT(*) DESC");
        if (rset && rset->rowsCount() && rset->next())
        {
            ip   = str2ip(rset->get<std::string>("zoneip"));
            port = rset->get<uint16>("zoneport");
        }
    }

    auto ipp = IPP(ip, port).getRawIPP();
    if (ipp == 0)
    {
        ShowWarning("ZMQ Routing ID IPP calculated as 0 - setting to 1. Check your zone_settings!");
        ipp = 1;
    }

    return ipp;
}

void IPCClient::handleIncomingMessages()
{
    TracyZoneScoped;

    // TODO: Can we stop more messages appearing on the queue while we're processing?
    zmq::message_t out;
    while (zmqDealerWrapper_.incomingQueue_.try_dequeue(out))
    {
        const auto firstByte = out.data<uint8>()[0];
        const auto msgType   = ipc::toString(static_cast<ipc::MessageType>(firstByte));

        // TODO: Make an IPP for the world server, so we can use it here
        DebugIPCFmt("Incoming {} message", msgType);

        handleMessage(IPP(), { static_cast<uint8*>(out.data()), out.size() });
    }
}

void IPCClient::handleMessage_EmptyStruct(const IPP& ipp, const ipc::EmptyStruct& message)
{
    TracyZoneScoped;

    ShowWarningFmt("Received EmptyStruct message from {} - this is probably a bug", ipp.toString());
}

void IPCClient::handleMessage_CharLogin(const IPP& ipp, const ipc::CharLogin& message)
{
    TracyZoneScoped;

    CCharEntity* PChar = zoneutils::GetChar(message.charId);
    if (!PChar)
    {
        db::preparedStmt("DELETE FROM accounts_sessions WHERE charid = ?", message.charId);
    }
    else
    {
        // TODO: disconnect the client, but leave the character in the disconnecting state
        // PChar->status = STATUS_SHUTDOWN;
        // won't save their position but not a huge deal
        // PChar->pushPacket<CServerIPPacket>(PChar, 1, 0);
    }
}

void IPCClient::handleMessage_CharZoneOut(const IPP& ipp, const ipc::CharZoneOut& message)
{
    TracyZoneScoped;

    // TODO: This is mainly for telling the world server that a character has zoned,
    //     : but maybe it would be useful here too?

    std::ignore = message.charId;
    std::ignore = message.destinationZoneId;
}

void IPCClient::handleMessage_CharZoneIn(const IPP& ipp, const ipc::CharZoneIn& message)
{
    TracyZoneScoped;

    networking_.server().parties().reattachMember(message);
}

void IPCClient::handleMessage_CharVarUpdate(const IPP& ipp, const ipc::CharVarUpdate& message)
{
    TracyZoneScoped;

    if (auto* PChar = zoneutils::GetChar(message.charId))
    {
        PChar->updateCharVarCache(message.varName, message.value, message.expiry);
    }
}

void IPCClient::handleMessage_ChatMessageTell(const IPP& ipp, const ipc::ChatMessageTell& message)
{
    TracyZoneScoped;

    CCharEntity* PChar = zoneutils::GetCharByName(message.recipientName);
    if (PChar && PChar->status != STATUS_TYPE::DISAPPEAR && !jailutils::InPrison(PChar))
    {
        const auto gmSent = message.gmLevel > 0;

        if (settings::get<bool>("map.BLOCK_TELL_TO_HIDDEN_GM") && PChar->m_isGMHidden && !gmSent)
        {
            message::send(ipc::MessageStandard{
                .recipientId = message.senderId,
                .message     = MsgStd::TellNotReceivedOffline,
            });
        }
        else if (PChar->isAway() && !gmSent)
        {
            message::send(ipc::MessageStandard{
                .recipientId = message.senderId,
                .message     = MsgStd::TellNotReceivedAway,
            });
        }
        else
        {
            PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, MESSAGE_TELL, message.message, message.senderName));
        }
    }
    else
    {
        message::send(ipc::MessageStandard{
            .recipientId = message.senderId,
            .message     = MsgStd::TellNotReceivedOffline,
        });
    }
}

void IPCClient::handleMessage_ChatMessageParty(const IPP& ipp, const ipc::ChatMessageParty& message)
{
    TracyZoneScoped;

    networking_.server().parties().chatMessage(message);
}

void IPCClient::handleMessage_ChatMessageAlliance(const IPP& ipp, const ipc::ChatMessageAlliance& message)
{
    TracyZoneScoped;

    networking_.server().parties().chatMessage(message);
}

void IPCClient::handleMessage_ChatMessageLinkshell(const IPP& ipp, const ipc::ChatMessageLinkshell& message)
{
    TracyZoneScoped;

    if (CLinkshell* PLinkshell = linkshell::GetLinkshell(message.linkshellId))
    {
        // TODO: Linkshell 1 vs 2?
        PLinkshell->PushPacket(message.senderId, std::make_unique<CChatMessagePacket>(message.senderName, message.zoneId, MESSAGE_LINKSHELL, message.message, message.gmLevel));
    }
}

void IPCClient::handleMessage_ChatMessageUnity(const IPP& ipp, const ipc::ChatMessageUnity& message)
{
    TracyZoneScoped;

    if (CUnityChat* PUnityChat = unitychat::GetUnityChat(message.unityLeaderId))
    {
        PUnityChat->PushPacket(message.senderId, std::make_unique<CChatMessagePacket>(message.senderName, message.zoneId, message.messageType, message.message, message.gmLevel));
    }
}

void IPCClient::handleMessage_ChatMessageYell(const IPP& ipp, const ipc::ChatMessageYell& message)
{
    TracyZoneScoped;

    // clang-format off
    zoneutils::ForEachZone([&](CZone* PZone)
    {
        if (PZone->CanUseMisc(MISC_YELL))
        {
            PZone->ForEachChar([&](CCharEntity* PChar)
            {
                // Don't push to sender
                if (PChar->id != message.senderId)
                {
                    PChar->pushPacket(std::make_unique<CChatMessagePacket>(message.senderName, message.zoneId, message.messageType, message.message, message.gmLevel));
                }
            });
        }
    });
    // clang-format on
}

void IPCClient::handleMessage_ChatMessageServerMessage(const IPP& ipp, const ipc::ChatMessageServerMessage& message)
{
    TracyZoneScoped;

    // clang-format off
    zoneutils::ForEachZone([&](CZone* PZone)
    {
        PZone->ForEachChar([&](CCharEntity* PChar)
        {
            if (PChar->id == message.senderId && message.skipSender)
            {
                return;
            }

            PChar->pushPacket(std::make_unique<CChatMessagePacket>(message.senderName, message.zoneId, message.messageType, message.message, message.gmLevel));
        });
    });
    // clang-format on
}

void IPCClient::handleMessage_ChatMessageCustom(const IPP& ipp, const ipc::ChatMessageCustom& message)
{
    TracyZoneScoped;

    CCharEntity* PChar = zoneutils::GetChar(message.recipientId);
    if (PChar && PChar->status != STATUS_TYPE::DISAPPEAR && !jailutils::InPrison(PChar))
    {
        PChar->pushPacket(std::make_unique<CChatMessagePacket>(PChar, message.messageType, message.message, message.senderName));
    }
}

void IPCClient::handleMessage_MessageStandard(const IPP& ipp, const ipc::MessageStandard& message)
{
    TracyZoneScoped;

    if (CCharEntity* PChar = zoneutils::GetChar(message.recipientId))
    {
        PChar->pushPacket(std::make_unique<CMessageStandardPacket>(PChar, message.param0, message.param1, message.message));
    }
}

void IPCClient::handleMessage_MessageBasic(const IPP& ipp, const ipc::MessageBasic& message)
{
    TracyZoneScoped;

    if (CCharEntity* PChar = zoneutils::GetChar(message.recipientId))
    {
        PChar->pushPacket(std::make_unique<CMessageBasicPacket>(PChar, PChar, message.param0, message.param1, message.message));
    }
}

void IPCClient::handleMessage_MessageSystem(const IPP& ipp, const ipc::MessageSystem& message)
{
    TracyZoneScoped;

    if (CCharEntity* PChar = zoneutils::GetChar(message.recipientId))
    {
        PChar->pushPacket(std::make_unique<CMessageStandardPacket>(PChar, message.param0, message.param1, message.message));
    }
}

void IPCClient::handleMessage_LinkshellRankChange(const IPP& ipp, const ipc::LinkshellRankChange& message)
{
    TracyZoneScoped;

    if (CLinkshell* PLinkshell = linkshell::GetLinkshell(message.linkshellId))
    {
        PLinkshell->ChangeMemberRank(message.memberName, message.permission);
    }
}

void IPCClient::handleMessage_LinkshellRemove(const IPP& ipp, const ipc::LinkshellRemove& message)
{
    TracyZoneScoped;

    CCharEntity* PChar = zoneutils::GetCharByName(message.victimName);

    if (PChar && PChar->PLinkshell1 && PChar->PLinkshell1->getID() == message.linkshellId)
    {
        CItemLinkshell* targetLS = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);
        if (targetLS && (message.linkshellType == LSTYPE_LINKSHELL || (message.linkshellType == LSTYPE_PEARLSACK && targetLS->GetLSType() == LSTYPE_LINKPEARL)))
        {
            PChar->PLinkshell1->RemoveMemberByName(message.victimName, (targetLS->GetLSType() == (uint8)LSTYPE_LINKSHELL ? (uint8)LSTYPE_PEARLSACK : message.linkshellType));
        }
    }
    else if (PChar && PChar->PLinkshell2 && PChar->PLinkshell2->getID() == message.linkshellId)
    {
        CItemLinkshell* targetLS = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
        if (targetLS && (message.linkshellType == LSTYPE_LINKSHELL || (message.linkshellType == LSTYPE_PEARLSACK && targetLS->GetLSType() == LSTYPE_LINKPEARL)))
        {
            PChar->PLinkshell2->RemoveMemberByName(message.victimName, message.linkshellType);
        }
    }
}

void IPCClient::handleMessage_LinkshellSetMessage(const IPP& ipp, const ipc::LinkshellSetMessage& message)
{
    TracyZoneScoped;

    if (CLinkshell* PLinkshell = linkshell::GetLinkshell(message.linkshellId))
    {
        PLinkshell->PushPacket(0, std::make_unique<CLinkshellMessagePacket>(message.poster, message.message, message.linkshellName, message.postTime, LinkshellSlot::LS1));
    }
}

void IPCClient::handleMessage_LuaFunction(const IPP& ipp, const ipc::LuaFunction& message)
{
    TracyZoneScoped;

    auto result = lua.safe_script(message.funcString);
    if (!result.valid())
    {
        sol::error err = result;
        ShowError("IPCClient::handleMessage_LuaFunction: error: %s: %s", err.what(), message.funcString.c_str());
    }

    // TODO: Handle a return value from result, and send back to message.requesterZoneId
}

void IPCClient::handleMessage_KillSession(const IPP& ipp, const ipc::KillSession& message)
{
    TracyZoneScoped;

    if (auto sessionToDelete = networking_.sessions().getSessionByCharId(message.victimId))
    {
        if (sessionToDelete->blowfish.status == BLOWFISH_PENDING_ZONE)
        {
            ShowDebugFmt("Closing session of charid {} on request of other process", message.victimId);
            networking_.sessions().destroySession(sessionToDelete);
        }
        else
        {
            ShowDebugFmt("KillSession for charid {} not needed", message.victimId);
        }

        networking_.server().parties().onKillSession(message.victimId);
    }
}

void IPCClient::handleMessage_ConquestEvent(const IPP& ipp, const ipc::ConquestEvent& message)
{
    TracyZoneScoped;

    conquest::HandleMessage(message.type, { message.payload.data(), message.payload.size() });
}

void IPCClient::handleMessage_BesiegedEvent(const IPP& ipp, const ipc::BesiegedEvent& message)
{
    TracyZoneScoped;
}

void IPCClient::handleMessage_CampaignEvent(const IPP& ipp, const ipc::CampaignEvent& message)
{
    TracyZoneScoped;
}

void IPCClient::handleMessage_ColonizationEvent(const IPP& ipp, const ipc::ColonizationEvent& message)
{
    TracyZoneScoped;
}

void IPCClient::handleMessage_EntityInformationRequest(const IPP& ipp, const ipc::EntityInformationRequest& message)
{
    TracyZoneScoped;

    auto PEntity = [&]() -> CBaseEntity*
    {
        if (message.entityType & TYPE_PC)
        {
            return zoneutils::GetChar(message.targetId);
        }
        else
        {
            return zoneutils::GetEntity(message.targetId);
        }
    }();

    if (PEntity && PEntity->loc.zone)
    {
        const bool isSpawned = PEntity->status != STATUS_TYPE::DISAPPEAR;

        float x = 0.0f;
        float y = 0.0f;
        float z = 0.0f;

        if ((message.entityType & TYPE_MOB) && !isSpawned)
        {
            // If entity not spawned, go to default location as listed in database
            const auto rset = db::preparedStmt("SELECT pos_x, pos_y, pos_z FROM mob_spawn_points WHERE mobid = ?", PEntity->id);
            if (rset && rset->rowsCount())
            {
                while (rset->next())
                {
                    x = rset->get<float>("pos_x");
                    y = rset->get<float>("pos_y");
                    z = rset->get<float>("pos_z");
                }
            }
        }
        else
        {
            // Otherwise, their information is available
            x = PEntity->loc.p.x;
            y = PEntity->loc.p.y;
            z = PEntity->loc.p.z;
        }

        const bool shouldWarp = message.warp && isSpawned;

        const auto moghouseId = PEntity->objtype == TYPE_PC ? static_cast<CCharEntity*>(PEntity)->m_moghouseID : 0;

        message::send(ipc::EntityInformationResponse{
            .requesterId = message.requesterId,
            .targetId    = message.targetId,
            .entityType  = message.entityType,
            .warp        = shouldWarp,
            .zoneId      = PEntity->loc.zone->GetID(),
            .x           = x,
            .y           = y,
            .z           = z,
            .rot         = PEntity->loc.p.rotation,
            .moghouseId  = moghouseId,
        });
    }
    else
    {
        ShowWarningFmt("EntityInformationRequest for entity {} failed", message.targetId);
    }
}

void IPCClient::handleMessage_EntityInformationResponse(const IPP& ipp, const ipc::EntityInformationResponse& message)
{
    TracyZoneScoped;

    CCharEntity* PChar = zoneutils::GetChar(message.requesterId);
    if (PChar && PChar->loc.zone)
    {
        if (message.warp)
        {
            PChar->loc.p.x         = message.x;
            PChar->loc.p.y         = message.y;
            PChar->loc.p.z         = message.z;
            PChar->loc.p.rotation  = message.rot;
            PChar->loc.destination = message.zoneId;

            PChar->m_moghouseID = message.moghouseId;
            PChar->loc.boundary = 0;
            PChar->updatemask   = 0;

            PChar->status    = STATUS_TYPE::DISAPPEAR;
            PChar->animation = ANIMATION_NONE;

            PChar->clearPacketList();

            charutils::SendToZone(PChar, PChar->loc.destination);
        }
    }
}

void IPCClient::handleMessage_SendPlayerToLocation(const IPP& ipp, const ipc::SendPlayerToLocation& message)
{
    TracyZoneScoped;

    CCharEntity* PChar = zoneutils::GetChar(message.targetId);
    if (PChar && PChar->loc.zone)
    {
        PChar->loc.p.x         = message.x;
        PChar->loc.p.y         = message.y;
        PChar->loc.p.z         = message.z;
        PChar->loc.p.rotation  = message.rot;
        PChar->loc.destination = message.zoneId;

        PChar->m_moghouseID = message.moghouseId;
        PChar->loc.boundary = 0;
        PChar->updatemask   = 0;

        PChar->status    = STATUS_TYPE::DISAPPEAR;
        PChar->animation = ANIMATION_NONE;

        PChar->clearPacketList();

        charutils::SendToZone(PChar, PChar->loc.destination);
    }
}

void IPCClient::handleMessage_PartyInvite(const IPP& ipp, const ipc::PartyInvite& message)
{
    TracyZoneScoped;

    if (CCharEntity* PInvitee = zoneutils::GetChar(message.inviteeId))
    {
        // make sure invitee isn't dead or in jail, they aren't a party member and don't already have an invite pending, and your party is not full
        if (PInvitee->isDead() ||
            jailutils::InPrison(PInvitee) ||
            PInvitee->InvitePending.id != 0 ||
            (PInvitee->hasParty() && message.inviteType == INVITE_PARTY)) // ||
        // (message.inviteType == INVITE_ALLIANCE && (!PInvitee->PParty || PInvitee->PParty->GetLeader() != PInvitee || (PInvitee->PParty && PInvitee->PParty->m_PAlliance))))
        {
            message::send(ipc::MessageStandard{
                .recipientId = message.inviterId,
                .message     = MsgStd::CannotInvite,
            });

            return;
        }

        if (PInvitee->getBlockingAid())
        {
            // Target is blocking assistance
            message::send(ipc::MessageSystem{
                .recipientId = message.inviterId,
                .message     = MsgStd::TargetIsCurrentlyBlocking,
            });

            // Interaction was blocked
            PInvitee->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);

            // You cannot invite that person at this time.
            message::send(ipc::MessageStandard{
                .recipientId = message.inviterId,
                .message     = MsgStd::CannotInvite,
            });

            return;
        }

        if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
        {
            message::send(ipc::MessageStandard{
                .recipientId = message.inviterId,
                .message     = MsgStd::CannotInviteLevelSync,
            });

            return;
        }

        PInvitee->InvitePending.id     = message.inviterId;
        PInvitee->InvitePending.targid = message.inviterTargId;

        PInvitee->pushPacket(std::make_unique<CPartyInvitePacket>(message.inviterId, message.inviterTargId, message.inviterName, message.inviteType));
    }
}

void IPCClient::handleMessage_PartyInviteResponse(const IPP& ipp, const ipc::PartyInviteResponse& message)
{
    TracyZoneScoped;

    if (CCharEntity* PInviter = zoneutils::GetChar(message.inviterId))
    {
        if (message.inviteAnswer == 0)
        {
            PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::InvitationDeclined);
        }
        else
        {
            // TODO: alliance
            // Can't use IPC helper as we may not yet have a party
            if (!PInviter->hasParty())
            {
                message::send(ipc::PartyEvent{
                    .partyId = PInviter->id,
                    .payload = MemberAddMessage{
                        .charId = message.inviteeId,
                        .type   = PartyMemberType::Player,
                    } });
            }
            else
            {
                PInviter->getParty().addMember(message.inviteeId, PartyMemberType::Player);
            }
        }
    }
}

void IPCClient::handleMessage_AllianceDissolve(const IPP& ipp, const ipc::AllianceDissolve& message)
{
    TracyZoneScoped;

    // CAlliance* PAlliance = nullptr;
    //
    // const auto allianceid = message.allianceId;
    //
    // // TODO: When Party/Alliance gets a rewrite, make a zoneutils::ForEachAlliance or some other accessor to reduce the amount of iterations significantly.
    //
    // // clang-format off
    // zoneutils::ForEachZone([allianceid, &PAlliance](CZone* PZone)
    // {
    //     PZone->ForEachChar([allianceid, &PAlliance](CCharEntity* PChar)
    //     {
    //         if (PChar->PParty && PChar->PParty->m_PAlliance && PChar->PParty->m_PAlliance->m_AllianceID == allianceid)
    //         {
    //             PAlliance = PChar->PParty->m_PAlliance;
    //             return;
    //         }
    //     });
    //     if (PAlliance)
    //     {
    //         return;
    //     }
    // });
    // if (PAlliance)
    // {
    //     PAlliance->dissolveAlliance(false);
    // }
    // clang-format on
}

void IPCClient::handleMessage_PartyChangeId(const IPP& ipp, const ipc::PartyChangeId& message)
{
    networking_.server().parties().updateId(message.formerId, message.newId);
}

void IPCClient::handleMessage_PartySystemSync(const IPP& ipp, const ipc::PartySystemSync& message)
{
    TracyZoneScoped;

    // World server is requesting copies of the party system
    // Very much experimental, to see if we can forego the DB entirely.
    for (const auto& updateMessage : networking_.server().parties().partiesSync())
    {
        message::send(updateMessage);
    }
}

void IPCClient::handleMessage_PartyEvent(const IPP& ipp, const ipc::PartyEvent& message)
{
    // Only a handful of events matter in this direction:
    // - Full party updates
    // - Party disband
    std::visit([&]<typename MessageType>(const MessageType& msg)
               {
                   using T = std::decay_t<MessageType>;

                   if constexpr (std::is_same_v<T, DisbandMessage>)
                   {
                       networking_.server().parties().disbandParty(message.partyId);
                   }
                   else if constexpr (std::is_same_v<T, PartyFullUpdateMessage>)
                   {
                       networking_.server().parties().updateParty(msg);
                   }
               },
               message.payload);
}

void IPCClient::handleUnknownMessage(const IPP& ipp, const std::span<uint8_t> message)
{
    TracyZoneScoped;

    ShowWarningFmt("Received unknown message from {} with code {} and size {}", ipp.toString(), message[0], message.size());
}
