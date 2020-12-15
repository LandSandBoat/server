/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include <mutex>
#include <queue>

#include "message.h"

#include "alliance.h"
#include "linkshell.h"
#include "party.h"
#include "status_effect_container.h"

#include "entities/charentity.h"

#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/party_invite.h"
#include "packets/server_ip.h"

#include "items/item_linkshell.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"

namespace message
{
    zmq::context_t             zContext;
    zmq::socket_t*             zSocket = nullptr;
    std::mutex                 send_mutex;
    std::queue<chat_message_t> message_queue;

    void send_queue()
    {
        while (!message_queue.empty())
        {
            std::lock_guard<std::mutex> lk(send_mutex);
            chat_message_t              msg = message_queue.front();
            message_queue.pop();
            try
            {
                zSocket->send(*msg.type, ZMQ_SNDMORE);
                zSocket->send(*msg.data, ZMQ_SNDMORE);
                zSocket->send(*msg.packet);
            }
            catch (std::exception& e)
            {
                ShowError("Message: %s", e.what());
            }
        }
    }

    void parse(MSGSERVTYPE type, zmq::message_t* extra, zmq::message_t* packet)
    {
        ShowDebug("Message: Received message %d from message server\n", static_cast<uint8>(type));
        switch (type)
        {
            case MSG_LOGIN:
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra->data(), 0));

                if (!PChar)
                {
                    Sql_Query(SqlHandle, "DELETE FROM accounts_sessions WHERE charid = %d;", ref<uint32>((uint8*)extra->data(), 0));
                }
                else
                {
                    // TODO: disconnect the client, but leave the character in the disconnecting state
                    // PChar->status = STATUS_SHUTDOWN;
                    // won't save their position (since this is the wrong thread) but not a huge deal
                    // PChar->pushPacket(new CServerIPPacket(PChar, 1, 0));
                }
                break;
            }
            case MSG_CHAT_TELL:
            {
                CCharEntity* PChar = zoneutils::GetCharByName((int8*)extra->data() + 4);
                if (PChar && PChar->status != STATUS_DISAPPEAR && !jailutils::InPrison(PChar))
                {
                    std::unique_ptr<CBasicPacket> newPacket = std::make_unique<CBasicPacket>();
                    memcpy(*newPacket, packet->data(), std::min<size_t>(packet->size(), PACKET_SIZE));
                    auto gm_sent = newPacket->ref<uint8>(0x05);
                    if (PChar->nameflags.flags & FLAG_AWAY && !gm_sent)
                    {
                        send(MSG_DIRECT, extra->data(), sizeof(uint32), new CMessageStandardPacket(PChar, 0, 0, MsgStd::TellNotReceivedAway));
                    }
                    else
                    {
                        PChar->pushPacket(std::move(newPacket));
                    }
                }
                else
                {
                    send(MSG_DIRECT, extra->data(), sizeof(uint32), new CMessageStandardPacket(PChar, 0, 0, MsgStd::TellNotReceivedOffline));
                }
                break;
            }
            case MSG_CHAT_PARTY:
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra->data(), 0));
                if (PChar)
                {
                    if (PChar->PParty)
                    {
                        if (PChar->PParty->m_PAlliance != nullptr)
                        {
                            for (uint8 i = 0; i < PChar->PParty->m_PAlliance->partyList.size(); ++i)
                            {
                                CBasicPacket* newPacket = new CBasicPacket();
                                memcpy(*newPacket, packet->data(), std::min<size_t>(packet->size(), PACKET_SIZE));
                                ((CParty*)PChar->PParty->m_PAlliance->partyList.at(i))->PushPacket(ref<uint32>((uint8*)extra->data(), 4), 0, newPacket);
                            }
                        }
                        else
                        {
                            CBasicPacket* newPacket = new CBasicPacket();
                            memcpy(*newPacket, packet->data(), std::min<size_t>(packet->size(), PACKET_SIZE));
                            PChar->PParty->PushPacket(ref<uint32>((uint8*)extra->data(), 4), 0, newPacket);
                        }
                    }
                }
                break;
            }
            case MSG_CHAT_LINKSHELL:
            {
                uint32      linkshellID = ref<uint32>((uint8*)extra->data(), 0);
                CLinkshell* PLinkshell  = linkshell::GetLinkshell(linkshellID);
                if (PLinkshell)
                {
                    CBasicPacket* newPacket = new CBasicPacket();
                    memcpy(*newPacket, packet->data(), std::min<size_t>(packet->size(), PACKET_SIZE));
                    PLinkshell->PushPacket(ref<uint32>((uint8*)extra->data(), 4), newPacket);
                }
                break;
            }
            case MSG_CHAT_YELL:
            {
                zoneutils::ForEachZone([&packet, &extra](CZone* PZone) {
                    if (PZone->CanUseMisc(MISC_YELL))
                    {
                        PZone->ForEachChar([&packet, &extra](CCharEntity* PChar) {
                            // don't push to sender
                            if (PChar->id != ref<uint32>((uint8*)extra->data(), 0))
                            {
                                CBasicPacket* newPacket = new CBasicPacket();
                                memcpy(*newPacket, packet->data(), std::min<size_t>(packet->size(), PACKET_SIZE));

                                PChar->pushPacket(newPacket);
                            }
                        });
                    }
                });
                break;
            }
            case MSG_CHAT_SERVMES:
            {
                zoneutils::ForEachZone([&packet](CZone* PZone) {
                    PZone->ForEachChar([&packet](CCharEntity* PChar) {
                        CBasicPacket* newPacket = new CBasicPacket();
                        memcpy(*newPacket, packet->data(), std::min<size_t>(packet->size(), PACKET_SIZE));
                        PChar->pushPacket(newPacket);
                    });
                });
                break;
            }
            case MSG_PT_INVITE:
            {
                uint32 id = ref<uint32>((uint8*)extra->data(), 0);
                // uint16 targid = ref<uint16>((uint8*)extra->data(), 4);
                uint8        inviteType = ref<uint8>((uint8*)packet->data(), 0x0B);
                CCharEntity* PInvitee   = zoneutils::GetChar(id);

                if (PInvitee)
                {
                    // make sure invitee isn't dead or in jail, they aren't a party member and don't already have an invite pending, and your party is not full
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 ||
                        (PInvitee->PParty && inviteType == INVITE_PARTY) ||
                        (inviteType == INVITE_ALLIANCE && (!PInvitee->PParty || PInvitee->PParty->GetLeader() != PInvitee || PInvitee->PParty->m_PAlliance)))
                    {
                        ref<uint32>((uint8*)extra->data(), 0) = ref<uint32>((uint8*)extra->data(), 6);
                        send(MSG_DIRECT, extra->data(), sizeof(uint32), new CMessageStandardPacket(PInvitee, 0, 0, MsgStd::CannotInvite));
                        return;
                    }
                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ref<uint32>((uint8*)extra->data(), 0) = ref<uint32>((uint8*)extra->data(), 6);
                        // Target is blocking assistance
                        send(MSG_DIRECT, extra->data(), sizeof(uint32), new CMessageSystemPacket(0, 0, 225));
                        // Interaction was blocked
                        PInvitee->pushPacket(new CMessageSystemPacket(0, 0, 226));
                        // You cannot invite that person at this time.
                        send(MSG_DIRECT, extra->data(), sizeof(uint32), new CMessageStandardPacket(PInvitee, 0, 0, MsgStd::CannotInvite));
                        break;
                    }
                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ref<uint32>((uint8*)extra->data(), 0) = ref<uint32>((uint8*)extra->data(), 6);
                        send(MSG_DIRECT, extra->data(), sizeof(uint32), new CMessageStandardPacket(PInvitee, 0, 0, MsgStd::CannotInviteLevelSync));
                        return;
                    }

                    PInvitee->InvitePending.id     = ref<uint32>((uint8*)extra->data(), 6);
                    PInvitee->InvitePending.targid = ref<uint16>((uint8*)extra->data(), 10);
                    CBasicPacket* newPacket        = new CBasicPacket();
                    memcpy(*newPacket, packet->data(), std::min<size_t>(packet->size(), PACKET_SIZE));
                    PInvitee->pushPacket(newPacket);
                }
                break;
            }
            case MSG_PT_INV_RES:
            {
                uint32 inviterId = ref<uint32>((uint8*)extra->data(), 0);
                // uint16 inviterTargid = ref<uint16>((uint8*)extra->data(), 4);
                uint32 inviteeId = ref<uint32>((uint8*)extra->data(), 6);
                // uint16 inviteeTargid = ref<uint16>((uint8*)extra->data(), 10);
                uint8        inviteAnswer = ref<uint8>((uint8*)extra->data(), 12);
                CCharEntity* PInviter     = zoneutils::GetChar(inviterId);

                if (PInviter)
                {
                    if (inviteAnswer == 0)
                    {
                        PInviter->pushPacket(new CMessageStandardPacket(PInviter, 0, 0, MsgStd::InvitationDeclined));
                    }
                    else
                    {
                        // both party leaders?
                        int ret = Sql_Query(SqlHandle, "SELECT * FROM accounts_parties WHERE partyid <> 0 AND \
                                                    ((charid = %u OR charid = %u) AND partyflag & %u);",
                                            inviterId, inviteeId, PARTY_LEADER);
                        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 2)
                        {
                            if (PInviter->PParty->m_PAlliance)
                            {
                                ret = Sql_Query(SqlHandle, "SELECT * FROM accounts_parties WHERE allianceid <> 0 AND \
                                                        allianceid = (SELECT allianceid FROM accounts_parties where \
                                                        charid = %u) GROUP BY partyid;",
                                                inviterId);
                                if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NumRows(SqlHandle) < 3)
                                {
                                    PInviter->PParty->m_PAlliance->addParty(inviteeId);
                                }
                                else
                                {
                                    send(MSG_DIRECT, (uint8*)extra->data() + 6, sizeof(uint32),
                                         new CMessageStandardPacket(PInviter, 0, 0, MsgStd::CannotBeProcessed));
                                }
                            }
                            else
                            {
                                // make new alliance
                                CAlliance* PAlliance = new CAlliance(PInviter);
                                PAlliance->addParty(inviteeId);
                            }
                        }
                        else
                        {
                            if (PInviter->PParty == nullptr)
                            {
                                PInviter->PParty = new CParty(PInviter);
                            }
                            if (PInviter->PParty && PInviter->PParty->GetLeader() == PInviter)
                            {
                                ret = Sql_Query(SqlHandle, "SELECT * FROM accounts_parties WHERE partyid <> 0 AND \
                                                       															charid = %u;",
                                                inviteeId);
                                if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 0)
                                {
                                    PInviter->PParty->AddMember(inviteeId);
                                }
                            }
                        }
                    }
                }
                break;
            }
            case MSG_PT_RELOAD:
            {
                if (extra->size() == 8)
                {
                    CCharEntity* PChar = zoneutils::GetCharToUpdate(ref<uint32>((uint8*)extra->data(), 4), ref<uint32>((uint8*)extra->data(), 0));
                    if (PChar)
                    {
                        PChar->ReloadPartyInc();
                        break;
                    }
                }
                else
                {
                    CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra->data(), 0));
                    if (PChar)
                    {
                        PChar->ForAlliance([](CBattleEntity* PMember) { ((CCharEntity*)PMember)->ReloadPartyInc(); });
                    }
                }

                break;
            }
            case MSG_PT_DISBAND:
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra->data(), 0));
                uint32       id    = ref<uint32>((uint8*)extra->data(), 4);
                if (PChar)
                {
                    if (PChar->PParty)
                    {
                        if (PChar->PParty->m_PAlliance && PChar->PParty->m_PAlliance->m_AllianceID == id)
                        {
                            PChar->PParty->m_PAlliance->dissolveAlliance(false);
                        }
                        else
                        {
                            PChar->PParty->DisbandParty(false);
                        }
                    }
                }
                break;
            }
            case MSG_DIRECT:
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra->data(), 0));
                if (PChar)
                {
                    CBasicPacket* newPacket = new CBasicPacket();
                    memcpy(*newPacket, packet->data(), std::min<size_t>(packet->size(), PACKET_SIZE));
                    PChar->pushPacket(newPacket);
                }
                break;
            }
            case MSG_LINKSHELL_RANK_CHANGE:
            {
                CLinkshell* PLinkshell = linkshell::GetLinkshell(ref<uint32>((uint8*)extra->data(), 24));

                if (PLinkshell)
                {
                    PLinkshell->ChangeMemberRank((int8*)extra->data() + 4, ref<uint8>((uint8*)extra->data(), 28));
                }
                break;
            }
            case MSG_LINKSHELL_REMOVE:
            {
                CCharEntity* PChar = zoneutils::GetCharByName((int8*)extra->data() + 4);

                if (PChar && PChar->PLinkshell1 && PChar->PLinkshell1->getID() == ref<uint32>((uint8*)extra->data(), 24))
                {
                    uint8           kickerRank = ref<uint8>((uint8*)extra->data(), 28);
                    CItemLinkshell* targetLS   = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);
                    if (targetLS && (kickerRank == LSTYPE_LINKSHELL || (kickerRank == LSTYPE_PEARLSACK && targetLS->GetLSType() == LSTYPE_LINKPEARL)))
                    {
                        PChar->PLinkshell1->RemoveMemberByName((int8*)extra->data() + 4,
                                                               (targetLS->GetLSType() == LSTYPE_LINKSHELL ? LSTYPE_PEARLSACK : kickerRank));
                    }
                }
                else if (PChar && PChar->PLinkshell2 && PChar->PLinkshell2->getID() == ref<uint32>((uint8*)extra->data(), 24))
                {
                    uint8           kickerRank = ref<uint8>((uint8*)extra->data(), 28);
                    CItemLinkshell* targetLS   = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
                    if (targetLS && (kickerRank == LSTYPE_LINKSHELL || (kickerRank == LSTYPE_PEARLSACK && targetLS->GetLSType() == LSTYPE_LINKPEARL)))
                    {
                        PChar->PLinkshell2->RemoveMemberByName((int8*)extra->data() + 4, kickerRank);
                    }
                }
                break;
            }
            case MSG_SEND_TO_ZONE:
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra->data(), 0));

                if (PChar && PChar->loc.zone)
                {
                    uint32 requester = ref<uint32>((uint8*)extra->data(), 4);

                    if (requester != 0)
                    {
                        char buf[30];
                        memset(&buf[0], 0, sizeof(buf));

                        ref<uint32>(&buf, 0)  = requester;
                        ref<uint16>(&buf, 8)  = PChar->getZone();
                        ref<float>(&buf, 10)  = PChar->loc.p.x;
                        ref<float>(&buf, 14)  = PChar->loc.p.y;
                        ref<float>(&buf, 18)  = PChar->loc.p.z;
                        ref<uint8>(&buf, 22)  = PChar->loc.p.rotation;
                        ref<uint32>(&buf, 23) = PChar->m_moghouseID;

                        message::send(MSG_SEND_TO_ZONE, &buf, sizeof(buf), nullptr);
                        break;
                    }

                    uint16 zoneId     = ref<uint16>((uint8*)extra->data(), 8);
                    float  x          = ref<float>((uint8*)extra->data(), 10);
                    float  y          = ref<float>((uint8*)extra->data(), 14);
                    float  z          = ref<float>((uint8*)extra->data(), 18);
                    uint8  rot        = ref<uint8>((uint8*)extra->data(), 22);
                    uint32 moghouseID = ref<uint32>((uint8*)extra->data(), 23);

                    PChar->updatemask = 0;

                    PChar->m_moghouseID = 0;

                    PChar->loc.p.x         = x;
                    PChar->loc.p.y         = y;
                    PChar->loc.p.z         = z;
                    PChar->loc.p.rotation  = rot;
                    PChar->loc.destination = zoneId;
                    PChar->m_moghouseID    = moghouseID;
                    PChar->loc.boundary    = 0;
                    PChar->status          = STATUS_DISAPPEAR;
                    PChar->animation       = ANIMATION_NONE;
                    PChar->clearPacketList();

                    charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(zoneId));
                }
                break;
            }
            case MSG_SEND_TO_ENTITY:
            {
                // Need to check which server we're on so we don't get null pointers
                bool toTargetServer = ref<bool>((uint8*)extra->data(), 0);
                bool spawnedOnly    = ref<bool>((uint8*)extra->data(), 1);

                if (toTargetServer) // This is going to the target's game server
                {
                    CBaseEntity* Entity = zoneutils::GetEntity(ref<uint32>((uint8*)extra->data(), 6));

                    if (Entity && Entity->loc.zone)
                    {
                        char buf[22];
                        memset(&buf[0], 0, sizeof(buf));

                        uint16 targetZone = ref<uint16>((uint8*)extra->data(), 2);
                        uint16 playerZone = ref<uint16>((uint8*)extra->data(), 4);
                        uint16 playerID   = ref<uint16>((uint8*)extra->data(), 10);

                        float X = Entity->GetXPos();
                        float Y = Entity->GetYPos();
                        float Z = Entity->GetZPos();
                        uint8 R = Entity->GetRotPos();

                        ref<bool>(&buf, 1) = true; // Found, so initiate warp back on the requesting server

                        if (Entity->status == STATUS_DISAPPEAR)
                        {
                            if (spawnedOnly)
                            {
                                ref<bool>(&buf, 1) = false; // Spawned only, so do not initiate warp
                            }
                            else
                            {
                                // If entity not spawned, go to default location as listed in database
                                const char* query = "SELECT pos_x, pos_y, pos_z FROM mob_spawn_points WHERE mobid = %u;";
                                auto        fetch = Sql_Query(SqlHandle, query, Entity->id);

                                if (fetch != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
                                {
                                    while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                                    {
                                        X = (float)Sql_GetFloatData(SqlHandle, 0);
                                        Y = (float)Sql_GetFloatData(SqlHandle, 1);
                                        Z = (float)Sql_GetFloatData(SqlHandle, 2);
                                    }
                                }
                            }
                        }

                        ref<bool>(&buf, 0)    = false;
                        ref<uint16>(&buf, 2)  = playerZone;
                        ref<uint16>(&buf, 4)  = playerID;
                        ref<float>(&buf, 6)   = X;
                        ref<float>(&buf, 10)  = Y;
                        ref<float>(&buf, 14)  = Z;
                        ref<uint8>(&buf, 18)  = R;
                        ref<uint16>(&buf, 20) = targetZone;

                        message::send(MSG_SEND_TO_ENTITY, &buf, sizeof(buf), nullptr);
                        break;
                    }
                }
                else // This is going to the player's game server
                {
                    CCharEntity* PChar = zoneutils::GetChar(ref<uint16>((uint8*)extra->data(), 4));

                    if (PChar && PChar->loc.zone)
                    {
                        if (ref<bool>((uint8*)extra->data(), 1) == true)
                        {
                            PChar->loc.p.x         = ref<float>((uint8*)extra->data(), 6);
                            PChar->loc.p.y         = ref<float>((uint8*)extra->data(), 10);
                            PChar->loc.p.z         = ref<float>((uint8*)extra->data(), 14);
                            PChar->loc.p.rotation  = ref<uint8>((uint8*)extra->data(), 18);
                            PChar->loc.destination = ref<uint16>((uint8*)extra->data(), 20);

                            PChar->m_moghouseID = 0;
                            PChar->loc.boundary = 0;
                            PChar->updatemask   = 0;

                            PChar->status    = STATUS_DISAPPEAR;
                            PChar->animation = ANIMATION_NONE;

                            PChar->clearPacketList();

                            charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(PChar->loc.destination));
                        }
                    }
                }
                break;
            }
            default:
            {
                ShowWarning("Message: unhandled message type %d\n", type);
            }
        }
    }

    void listen()
    {
        while (true)
        {
            zmq::message_t type;
            zmq::message_t extra;
            zmq::message_t packet;

            try
            {
                if (!zSocket)
                {
                    return;
                }
                if (!zSocket->recv(&type))
                {
                    if (!message_queue.empty())
                    {
                        send_queue();
                    }
                    continue;
                }

                int    more;
                size_t size = sizeof(more);
                zSocket->getsockopt(ZMQ_RCVMORE, &more, &size);
                if (more)
                {
                    zSocket->recv(&extra);
                    zSocket->getsockopt(ZMQ_RCVMORE, &more, &size);
                    if (more)
                    {
                        zSocket->recv(&packet);
                    }
                }
            }
            catch (zmq::error_t& e)
            {
                if (!zSocket)
                {
                    return;
                }
                ShowError("Message: %s\n", e.what());
                continue;
            }

            parse((MSGSERVTYPE)ref<uint8>((uint8*)type.data(), 0), &extra, &packet);
        }
    }

    void init(const char* chatIp, uint16 chatPort)
    {
        SqlHandle = Sql_Malloc();

        if (Sql_Connect(SqlHandle, map_config.mysql_login.c_str(), map_config.mysql_password.c_str(), map_config.mysql_host.c_str(), map_config.mysql_port,
                        map_config.mysql_database.c_str()) == SQL_ERROR)
        {
            exit(EXIT_FAILURE);
        }
        Sql_Keepalive(SqlHandle);

        zContext = zmq::context_t(1);
        zSocket  = new zmq::socket_t(zContext, ZMQ_DEALER);

        uint64 ipp  = map_ip.s_addr;
        uint64 port = map_port;

        // if no ip/port were supplied, set to 1 (0 is not valid for an identity)
        if (map_ip.s_addr == 0 && map_port == 0)
        {
            int ret = Sql_Query(SqlHandle, "SELECT zoneip, zoneport FROM zone_settings GROUP BY zoneip, zoneport ORDER BY COUNT(*) DESC;");
            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                inet_pton(AF_INET, (const char*)Sql_GetData(SqlHandle, 0), &ipp);
                port = Sql_GetUIntData(SqlHandle, 1);
            }
        }
        ipp |= (port << 32);

        zSocket->setsockopt(ZMQ_IDENTITY, &ipp, sizeof ipp);

        uint32 to = 500;
        zSocket->setsockopt(ZMQ_RCVTIMEO, &to, sizeof to);

        string_t server = "tcp://";
        server.append(chatIp);
        server.append(":");
        server.append(std::to_string(chatPort));

        try
        {
            zSocket->connect(server.c_str());
        }
        catch (zmq::error_t& err)
        {
            ShowFatalError("Message: Unable to connect chat socket: %s\n", err.what());
        }

        listen();
    }

    void close()
    {
        if (zSocket)
        {
            zSocket->close();
            delete zSocket;
            zSocket = nullptr;
        }
        zContext.close();
    }

    void send(MSGSERVTYPE type, void* data, size_t datalen, CBasicPacket* packet)
    {
        std::lock_guard<std::mutex> lk(send_mutex);
        chat_message_t              msg;
        msg.type                                = new zmq::message_t(sizeof(MSGSERVTYPE));
        ref<uint8>((uint8*)msg.type->data(), 0) = type;

        msg.data = new zmq::message_t(datalen);
        if (datalen > 0)
        {
            memcpy(msg.data->data(), data, datalen);
        }

        if (packet)
        {
            msg.packet = new zmq::message_t(*packet, packet->length(), [](void* data, void* hint) { delete[](uint8*) data; });
        }
        else
        {
            msg.packet = new zmq::message_t(0);
        }
        message_queue.push(msg);
    }
}; // namespace message
