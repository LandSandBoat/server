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

#include <concurrentqueue.h>
#include <queue>

#include "message.h"

#include "alliance.h"
#include "conquest_system.h"
#include "linkshell.h"
#include "party.h"
#include "status_effect_container.h"
#include "unitychat.h"

#include "entities/charentity.h"

#include "lua/luautils.h"

#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/party_invite.h"
#include "packets/server_ip.h"

#include "items/item_linkshell.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"
#include "utils/serverutils.h"
#include "utils/zoneutils.h"

namespace message
{
    zmq::context_t                 zContext;
    std::unique_ptr<zmq::socket_t> zSocket;

    moodycamel::ConcurrentQueue<chat_message_t> outgoing_queue;
    moodycamel::ConcurrentQueue<chat_message_t> incoming_queue;

    std::unordered_map<uint64_t, sol::function> replyMap;

    void send_queue()
    {
        TracyZoneScoped;

        chat_message_t msg;
        while (outgoing_queue.try_dequeue(msg))
        {
            try
            {
                zSocket->send(msg.type, zmq::send_flags::sndmore);
                zSocket->send(msg.data, zmq::send_flags::sndmore);
                zSocket->send(msg.packet, zmq::send_flags::none);
            }
            catch (std::exception& e)
            {
                ShowError("Message: %s", e.what());
            }
        }
    }

    void parse(chat_message_t& message)
    {
        TracyZoneScoped;

        auto  type   = (MSGSERVTYPE)ref<uint8>((uint8*)message.type.data(), 0);
        auto& extra  = message.data;
        auto& packet = message.packet;

        TracyZoneCString(msgTypeToStr(type));

        ShowDebug("Message: Received message %s (%d) from message server",
                  msgTypeToStr(type), static_cast<uint8>(type));

        switch (type)
        {
            case MSG_LOGIN:
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra.data(), 0));

                if (!PChar)
                {
                    _sql->Query("DELETE FROM accounts_sessions WHERE charid = %d", ref<uint32>((uint8*)extra.data(), 0));
                }
                else
                {
                    // TODO: disconnect the client, but leave the character in the disconnecting state
                    // PChar->status = STATUS_SHUTDOWN;
                    // won't save their position (since this is the wrong thread) but not a huge deal
                    // PChar->pushPacket<CServerIPPacket>(PChar, 1, 0);
                }
                break;
            }
            case MSG_CHAT_TELL:
            {
                char characterName[PacketNameLength] = {};
                std::memcpy(&characterName, reinterpret_cast<char*>(extra.data()) + 4, PacketNameLength - 1);

                CCharEntity* PChar = zoneutils::GetCharByName(characterName);
                if (PChar && PChar->status != STATUS_TYPE::DISAPPEAR && !jailutils::InPrison(PChar))
                {
                    std::unique_ptr<CBasicPacket> newPacket = std::make_unique<CBasicPacket>();
                    std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                    auto gm_sent = newPacket->ref<uint8>(0x05);
                    if (settings::get<bool>("map.BLOCK_TELL_TO_HIDDEN_GM") && PChar->m_isGMHidden && !gm_sent)
                    {
                        send(MSG_DIRECT, extra.data(), sizeof(uint32), std::make_unique<CMessageStandardPacket>(PChar, 0, 0, MsgStd::TellNotReceivedOffline));
                    }
                    else if (PChar->isAway() && !gm_sent)
                    {
                        send(MSG_DIRECT, extra.data(), sizeof(uint32), std::make_unique<CMessageStandardPacket>(PChar, 0, 0, MsgStd::TellNotReceivedAway));
                    }
                    else
                    {
                        PChar->pushPacket(std::move(newPacket));
                    }
                }
                else
                {
                    send(MSG_DIRECT, extra.data(), sizeof(uint32), std::make_unique<CMessageStandardPacket>(PChar, 0, 0, MsgStd::TellNotReceivedOffline));
                }
                break;
            }
            case MSG_CHAT_PARTY:
            {
                uint32  partyid  = ref<uint32>((uint8*)extra.data(), 0);
                uint32  senderid = ref<uint32>((uint8*)extra.data(), 4);
                CParty* PParty   = nullptr;

                // TODO: when Party/Alliance gets a rewrite, make a zoneutils::ForEachParty or some other accessor to reduce the amount of iterations significantly.
                // clang-format off
                zoneutils::ForEachZone([partyid, &PParty](CZone* PZone)
                {
                    PZone->ForEachChar([partyid, &PParty](CCharEntity* PChar)
                    {
                        if (PChar->PParty && PChar->PParty->GetPartyID() == partyid)
                        {
                            PParty = PChar->PParty;
                            return;
                        }
                    });

                    if (PParty)
                    {
                        return;
                    }
                });
                // clang-format on

                if (PParty)
                {
                    auto newPacket = std::make_unique<CBasicPacket>();
                    std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                    PParty->PushPacket(senderid, 0, newPacket);
                }
                break;
            }
            case MSG_CHAT_ALLIANCE:
            {
                uint32     allianceid = ref<uint32>((uint8*)extra.data(), 0);
                uint32     senderid   = ref<uint32>((uint8*)extra.data(), 4);
                CAlliance* PAlliance  = nullptr;

                // TODO: when Party/Alliance gets a rewrite, make a zoneutils::ForEachParty or some other accessor to reduce the amount of iterations significantly.
                // clang-format off
                zoneutils::ForEachZone([allianceid, &PAlliance](CZone* PZone)
                {
                    PZone->ForEachChar([allianceid, &PAlliance](CCharEntity* PChar)
                    {
                        if (PChar->PParty && PChar->PParty && PChar->PParty->m_PAlliance && PChar->PParty->m_PAlliance->m_AllianceID == allianceid)
                        {
                            PAlliance = PChar->PParty->m_PAlliance;
                            return;
                        }
                    });

                    if (PAlliance)
                    {
                        return;
                    }
                });
                // clang-format on

                if (PAlliance)
                {
                    for (auto& currentParty : PAlliance->partyList)
                    {
                        auto newPacket = std::make_unique<CBasicPacket>();
                        std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                        currentParty->PushPacket(senderid, 0, newPacket);
                    }
                }
                break;
            }
            case MSG_CHAT_LINKSHELL:
            {
                uint32      linkshellID = ref<uint32>((uint8*)extra.data(), 0);
                CLinkshell* PLinkshell  = linkshell::GetLinkshell(linkshellID);
                if (PLinkshell)
                {
                    auto newPacket = std::make_unique<CBasicPacket>();
                    std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                    PLinkshell->PushPacket(ref<uint32>((uint8*)extra.data(), 4), newPacket);
                }
                break;
            }
            case MSG_CHAT_UNITY:
            {
                uint32      leader     = ref<uint32>((uint8*)extra.data(), 0);
                CUnityChat* PUnityChat = unitychat::GetUnityChat(leader);
                if (PUnityChat)
                {
                    auto newPacket = std::make_unique<CBasicPacket>();
                    std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                    PUnityChat->PushPacket(ref<uint32>((uint8*)extra.data(), 4), newPacket);
                }
                break;
            }
            case MSG_CHAT_YELL:
            {
                // clang-format off
                zoneutils::ForEachZone([&packet, &extra](CZone* PZone)
                {
                    if (PZone->CanUseMisc(MISC_YELL))
                    {
                        PZone->ForEachChar([&packet, &extra](CCharEntity* PChar)
                        {
                            // don't push to sender
                            if (PChar->id != ref<uint32>((uint8*)extra.data(), 0))
                            {
                                auto newPacket = std::make_unique<CBasicPacket>();
                                std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                                PChar->pushPacket(std::move(newPacket));
                            }
                        });
                    }
                });
                // clang-format on
                break;
            }
            case MSG_CHAT_SERVMES:
            {
                // clang-format off
                zoneutils::ForEachZone([&packet](CZone* PZone)
                {
                    PZone->ForEachChar([&packet](CCharEntity* PChar)
                    {
                        auto newPacket = std::make_unique<CBasicPacket>();
                        std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                        PChar->pushPacket(std::move(newPacket));
                    });
                });
                // clang-format on
                break;
            }
            case MSG_PT_INVITE:
            {
                uint32 id = ref<uint32>((uint8*)extra.data(), 0);
                // uint16 targid = ref<uint16>((uint8*)extra.data(), 4);
                uint8        inviteType = ref<uint8>((uint8*)packet.data(), 0x0B);
                CCharEntity* PInvitee   = zoneutils::GetChar(id);

                if (PInvitee)
                {
                    // make sure invitee isn't dead or in jail, they aren't a party member and don't already have an invite pending, and your party is not full
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 ||
                        (PInvitee->PParty && inviteType == INVITE_PARTY) ||
                        (inviteType == INVITE_ALLIANCE && (!PInvitee->PParty || PInvitee->PParty->GetLeader() != PInvitee || (PInvitee->PParty && PInvitee->PParty->m_PAlliance))))
                    {
                        ref<uint32>((uint8*)extra.data(), 0) = ref<uint32>((uint8*)extra.data(), 6);
                        send(MSG_DIRECT, extra.data(), sizeof(uint32), std::make_unique<CMessageStandardPacket>(PInvitee, 0, 0, MsgStd::CannotInvite));
                        return;
                    }
                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ref<uint32>((uint8*)extra.data(), 0) = ref<uint32>((uint8*)extra.data(), 6);
                        // Target is blocking assistance
                        send(MSG_DIRECT, extra.data(), sizeof(uint32), std::make_unique<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking));
                        // Interaction was blocked
                        PInvitee->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
                        // You cannot invite that person at this time.
                        send(MSG_DIRECT, extra.data(), sizeof(uint32), std::make_unique<CMessageStandardPacket>(PInvitee, 0, 0, MsgStd::CannotInvite));
                        break;
                    }
                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ref<uint32>((uint8*)extra.data(), 0) = ref<uint32>((uint8*)extra.data(), 6);
                        send(MSG_DIRECT, extra.data(), sizeof(uint32), std::make_unique<CMessageStandardPacket>(PInvitee, 0, 0, MsgStd::CannotInviteLevelSync));
                        return;
                    }

                    PInvitee->InvitePending.id     = ref<uint32>((uint8*)extra.data(), 6);
                    PInvitee->InvitePending.targid = ref<uint16>((uint8*)extra.data(), 10);

                    auto newPacket = std::make_unique<CBasicPacket>();
                    std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                    PInvitee->pushPacket(std::move(newPacket));
                }
                break;
            }
            case MSG_PT_INV_RES:
            {
                uint32 inviterId = ref<uint32>((uint8*)extra.data(), 0);
                // uint16 inviterTargid = ref<uint16>((uint8*)extra.data(), 4);
                uint32 inviteeId = ref<uint32>((uint8*)extra.data(), 6);
                // uint16 inviteeTargid = ref<uint16>((uint8*)extra.data(), 10);
                uint8        inviteAnswer = ref<uint8>((uint8*)extra.data(), 12);
                CCharEntity* PInviter     = zoneutils::GetChar(inviterId);

                if (PInviter)
                {
                    if (inviteAnswer == 0)
                    {
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::InvitationDeclined);
                    }
                    else
                    {
                        // both party leaders?
                        int ret = _sql->Query("SELECT * FROM accounts_parties WHERE partyid <> 0 AND \
                                                    ((charid = %u OR charid = %u) AND partyflag & %u)",
                                              inviterId, inviteeId, PARTY_LEADER);
                        if (ret != SQL_ERROR && _sql->NumRows() == 2)
                        {
                            if (PInviter->PParty)
                            {
                                if (PInviter->PParty->m_PAlliance)
                                {
                                    ret = _sql->Query("SELECT * FROM accounts_parties WHERE allianceid <> 0 AND \
                                                    allianceid = (SELECT allianceid FROM accounts_parties where \
                                                    charid = %u) GROUP BY partyid",
                                                      inviterId);
                                    if (ret != SQL_ERROR && _sql->NumRows() > 0 && _sql->NumRows() < 3)
                                    {
                                        PInviter->PParty->m_PAlliance->addParty(inviteeId);
                                    }
                                    else
                                    {
                                        send(MSG_DIRECT, (uint8*)extra.data() + 6, sizeof(uint32),
                                             std::make_unique<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotBeProcessed));
                                    }
                                }
                                else if (PInviter->PParty)
                                {
                                    // make new alliance
                                    CAlliance* PAlliance = new CAlliance(PInviter);
                                    PAlliance->addParty(inviteeId);
                                }
                            }
                            else // Somehow, the inviter didn't have a party despite the database thinking they did.
                            {
                                send(MSG_DIRECT, (uint8*)extra.data() + 6, sizeof(uint32),
                                     std::make_unique<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotBeProcessed));
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
                                ret = _sql->Query("SELECT * FROM accounts_parties WHERE partyid <> 0 AND charid = %u", inviteeId);
                                if (ret != SQL_ERROR && _sql->NumRows() == 0)
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
                uint32 partyid = ref<uint32>((uint8*)extra.data(), 0);

                int ret = _sql->Query("SELECT charid FROM accounts_parties WHERE partyid = %u", partyid);
                if (ret != SQL_ERROR && _sql->NumRows() != 0)
                {
                    while (_sql->NextRow() == SQL_SUCCESS)
                    {
                        CCharEntity* PChar = zoneutils::GetChar(_sql->GetUIntData(0));
                        if (PChar)
                        {
                            PChar->ReloadPartyInc();
                        }
                    }
                }

                break;
            }
            case MSG_PT_DISBAND:
            {
                uint32  partyid = ref<uint32>((uint8*)extra.data(), 0);
                CParty* PParty  = nullptr;

                // TODO: when Party/Alliance gets a rewrite, make a zoneutils::ForEachParty or some other accessor to reduce the amount of iterations significantly.
                // clang-format off
                zoneutils::ForEachZone([partyid, &PParty](CZone* PZone)
                {
                    PZone->ForEachChar([partyid, &PParty](CCharEntity* PChar)
                    {
                        if (PChar->PParty && PChar->PParty->GetPartyID() == partyid)
                        {
                            PParty = PChar->PParty;
                            return;
                        }
                    });

                    if (PParty)
                    {
                        return;
                    }
                });
                // clang-format on

                if (PParty)
                {
                    PParty->DisbandParty(false);
                }

                break;
            }
            case MSG_ALLIANCE_RELOAD:
            {
                uint32 allianceid = ref<uint32>((uint8*)extra.data(), 0);

                int ret = _sql->Query("SELECT charid FROM accounts_parties WHERE allianceid = %u", allianceid);
                if (ret != SQL_ERROR && _sql->NumRows() != 0)
                {
                    while (_sql->NextRow() == SQL_SUCCESS)
                    {
                        CCharEntity* PChar = zoneutils::GetChar(_sql->GetUIntData(0));
                        if (PChar)
                        {
                            PChar->ReloadPartyInc();
                        }
                    }
                }

                break;
            }
            case MSG_ALLIANCE_DISSOLVE:
            {
                uint32     allianceid = ref<uint32>((uint8*)extra.data(), 0);
                CAlliance* PAlliance  = nullptr;

                // TODO: when Party/Alliance gets a rewrite, make a zoneutils::ForEachAlliance or some other accessor to reduce the amount of iterations significantly.
                // clang-format off
                zoneutils::ForEachZone([allianceid, &PAlliance](CZone* PZone)
                {
                    PZone->ForEachChar([allianceid, &PAlliance](CCharEntity* PChar)
                    {
                        if (PChar->PParty && PChar->PParty->m_PAlliance && PChar->PParty->m_PAlliance->m_AllianceID == allianceid)
                        {
                            PAlliance = PChar->PParty->m_PAlliance;
                            return;
                        }
                    });

                    if (PAlliance)
                    {
                        return;
                    }
                });
                // clang-format on

                if (PAlliance)
                {
                    PAlliance->dissolveAlliance(false);
                }

                break;
            }
            case MSG_PLAYER_KICK:
            {
                uint32 charid = ref<uint32>((uint8*)extra.data(), 0);

                // player was kicked and is no longer in alliance/party db -- they need a direct update.
                CCharEntity* PChar = zoneutils::GetChar(charid);
                if (PChar)
                {
                    PChar->ReloadPartyInc();
                }
                break;
            }
            case MSG_DIRECT:
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra.data(), 0));
                if (PChar)
                {
                    auto newPacket = std::make_unique<CBasicPacket>();
                    std::memcpy(*newPacket, packet.data(), std::min<size_t>(packet.size(), PACKET_SIZE));
                    PChar->pushPacket(std::move(newPacket));
                }
                break;
            }
            case MSG_LINKSHELL_RANK_CHANGE:
            {
                CLinkshell* PLinkshell = linkshell::GetLinkshell(ref<uint32>((uint8*)extra.data(), 24));

                if (PLinkshell)
                {
                    char memberName[PacketNameLength] = {};
                    std::memcpy(&memberName, reinterpret_cast<char*>(extra.data()) + 4, PacketNameLength - 1);
                    PLinkshell->ChangeMemberRank(memberName, ref<uint8>((uint8*)extra.data(), 28));
                }
                break;
            }
            case MSG_LINKSHELL_REMOVE:
            {
                char memberName[PacketNameLength] = {};
                std::memcpy(&memberName, reinterpret_cast<char*>(extra.data()) + 4, PacketNameLength - 1);
                CCharEntity* PChar = zoneutils::GetCharByName(memberName);

                if (PChar && PChar->PLinkshell1 && PChar->PLinkshell1->getID() == ref<uint32>((uint8*)extra.data(), 24))
                {
                    uint8           kickerRank = ref<uint8>((uint8*)extra.data(), 28);
                    CItemLinkshell* targetLS   = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);
                    if (targetLS && (kickerRank == LSTYPE_LINKSHELL || (kickerRank == LSTYPE_PEARLSACK && targetLS->GetLSType() == LSTYPE_LINKPEARL)))
                    {
                        PChar->PLinkshell1->RemoveMemberByName(memberName,
                                                               (targetLS->GetLSType() == (uint8)LSTYPE_LINKSHELL ? (uint8)LSTYPE_PEARLSACK : kickerRank));
                    }
                }
                else if (PChar && PChar->PLinkshell2 && PChar->PLinkshell2->getID() == ref<uint32>((uint8*)extra.data(), 24))
                {
                    uint8           kickerRank = ref<uint8>((uint8*)extra.data(), 28);
                    CItemLinkshell* targetLS   = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
                    if (targetLS && (kickerRank == LSTYPE_LINKSHELL || (kickerRank == LSTYPE_PEARLSACK && targetLS->GetLSType() == LSTYPE_LINKPEARL)))
                    {
                        PChar->PLinkshell2->RemoveMemberByName(memberName, kickerRank);
                    }
                }
                break;
            }
            case MSG_SEND_TO_ZONE:
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra.data(), 0));

                if (PChar && PChar->loc.zone)
                {
                    uint32 requester = ref<uint32>((uint8*)extra.data(), 4);

                    if (requester != 0)
                    {
                        char buf[30];
                        std::memset(&buf[0], 0, sizeof(buf));

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

                    uint16 zoneId     = ref<uint16>((uint8*)extra.data(), 8);
                    float  x          = ref<float>((uint8*)extra.data(), 10);
                    float  y          = ref<float>((uint8*)extra.data(), 14);
                    float  z          = ref<float>((uint8*)extra.data(), 18);
                    uint8  rot        = ref<uint8>((uint8*)extra.data(), 22);
                    uint32 moghouseID = ref<uint32>((uint8*)extra.data(), 23);

                    PChar->updatemask = 0;

                    PChar->m_moghouseID = 0;

                    PChar->loc.p.x         = x;
                    PChar->loc.p.y         = y;
                    PChar->loc.p.z         = z;
                    PChar->loc.p.rotation  = rot;
                    PChar->loc.destination = zoneId;
                    PChar->m_moghouseID    = moghouseID;
                    PChar->loc.boundary    = 0;
                    PChar->status          = STATUS_TYPE::DISAPPEAR;
                    PChar->animation       = ANIMATION_NONE;
                    PChar->clearPacketList();

                    charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(zoneId));
                }
                break;
            }
            case MSG_SEND_TO_ENTITY:
            {
                // Need to check which server we're on so we don't get null pointers
                bool toTargetServer = ref<bool>((uint8*)extra.data(), 0);
                bool spawnedOnly    = ref<bool>((uint8*)extra.data(), 1);

                if (toTargetServer) // This is going to the target's game server
                {
                    CBaseEntity* Entity = zoneutils::GetEntity(ref<uint32>((uint8*)extra.data(), 6));

                    if (Entity && Entity->loc.zone)
                    {
                        char buf[22];
                        std::memset(&buf[0], 0, sizeof(buf));

                        uint16 targetZone = ref<uint16>((uint8*)extra.data(), 2);
                        uint16 playerZone = ref<uint16>((uint8*)extra.data(), 4);
                        uint16 playerID   = ref<uint16>((uint8*)extra.data(), 10);

                        float X = Entity->GetXPos();
                        float Y = Entity->GetYPos();
                        float Z = Entity->GetZPos();
                        uint8 R = Entity->GetRotPos();

                        ref<bool>(&buf, 1) = true; // Found, so initiate warp back on the requesting server

                        if (Entity->status == STATUS_TYPE::DISAPPEAR)
                        {
                            if (spawnedOnly)
                            {
                                ref<bool>(&buf, 1) = false; // Spawned only, so do not initiate warp
                            }
                            else
                            {
                                // If entity not spawned, go to default location as listed in database
                                const char* query = "SELECT pos_x, pos_y, pos_z FROM mob_spawn_points WHERE mobid = %u";
                                auto        fetch = _sql->Query(query, Entity->id);

                                if (fetch != SQL_ERROR && _sql->NumRows() != 0)
                                {
                                    while (_sql->NextRow() == SQL_SUCCESS)
                                    {
                                        X = _sql->GetFloatData(0);
                                        Y = _sql->GetFloatData(1);
                                        Z = _sql->GetFloatData(2);
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
                    CCharEntity* PChar = zoneutils::GetChar(ref<uint16>((uint8*)extra.data(), 4));

                    if (PChar && PChar->loc.zone)
                    {
                        if (ref<bool>((uint8*)extra.data(), 1))
                        {
                            PChar->loc.p.x         = ref<float>((uint8*)extra.data(), 6);
                            PChar->loc.p.y         = ref<float>((uint8*)extra.data(), 10);
                            PChar->loc.p.z         = ref<float>((uint8*)extra.data(), 14);
                            PChar->loc.p.rotation  = ref<uint8>((uint8*)extra.data(), 18);
                            PChar->loc.destination = ref<uint16>((uint8*)extra.data(), 20);

                            PChar->m_moghouseID = 0;
                            PChar->loc.boundary = 0;
                            PChar->updatemask   = 0;

                            PChar->status    = STATUS_TYPE::DISAPPEAR;
                            PChar->animation = ANIMATION_NONE;

                            PChar->clearPacketList();

                            charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(PChar->loc.destination));
                        }
                    }
                }
                break;
            }
            case MSG_LUA_FUNCTION:
            {
                auto str    = std::string((const char*)extra.data() + 4);
                auto result = lua.safe_script(str);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("MSG_LUA_FUNCTION: error: %s: %s", err.what(), str.c_str());
                }
                break;
            }
            case MSG_CHARVAR_UPDATE:
            {
                uint8* data   = (uint8*)extra.data();
                uint32 charId = ref<uint32>(data, 0);
                int32  value  = ref<int32>(data, 4);
                uint32 expiry = ref<uint32>(data, 8);

                ShowDebug(fmt::format("Received message to update var for {}", charId));

                uint8 varNameSize = ref<uint8>(data, 12);
                auto  varName     = std::string(data + 13, data + 13 + varNameSize);

                if (auto player = zoneutils::GetChar(charId))
                {
                    ShowDebug(fmt::format("Updating charvar for {} ({}): {} = {}", player->getName(), charId, varName, value));
                    player->updateCharVarCache(varName, value, expiry);
                }
                break;
            }
            case MSG_RPC_SEND:
            {
                // Extract data
                uint8*   data     = (uint8*)extra.data();
                uint16   sendZone = ref<uint16>(data, 2); // here
                uint16   recvZone = ref<uint16>(data, 4); // origin
                uint64_t slotKey  = ref<uint64_t>(data, 6);
                uint16   strSize  = ref<uint16>(data, 14);
                auto     sendStr  = std::string(data + 16, data + 16 + strSize);

                // Execute Lua & collect payload
                std::string payload = "";
                auto        result  = lua.safe_script(sendStr);
                if (result.valid() && result.return_count())
                {
                    payload = result.get<std::string>(0);
                }

                // Reply w/ payload
                std::vector<uint8> packetData(16 + payload.size() + 1);

                ref<uint16>(packetData.data(), 2)   = recvZone; // origin
                ref<uint16>(packetData.data(), 4)   = sendZone; // here
                ref<uint64_t>(packetData.data(), 6) = slotKey;

                ref<uint16>(packetData.data(), 14) = (uint16)payload.size();
                std::memcpy(packetData.data() + 16, payload.data(), payload.size());

                packetData[packetData.size() - 1] = '\0';

                message::send(MSG_RPC_RECV, packetData.data(), packetData.size());

                break;
            }
            case MSG_RPC_RECV:
            {
                uint8* data = (uint8*)extra.data();
                // No need for any of the zone id data now
                uint64_t slotKey = ref<uint64_t>(data, 6);
                uint16   strSize = ref<uint16>(data, 14);
                auto     payload = std::string(data + 16, data + 16 + strSize);

                auto maybeEntry = replyMap.find(slotKey);
                if (maybeEntry != replyMap.end())
                {
                    auto& recvFunc = maybeEntry->second;
                    auto  result   = recvFunc(payload);
                    if (!result.valid())
                    {
                        sol::error err = result;
                        ShowError("message::parse::MSG_RPC_RECV: %s", err.what());
                    }
                    replyMap.erase(slotKey);
                }

                break;
            }
            case MSG_WORLD2MAP_REGIONAL_EVENT:
            {
                // Extract data
                uint8* data      = (uint8*)extra.data();
                uint8  eventType = ref<uint8>(data, 0);
                // uint8  subtype   = ref<uint8>(data, 1);

                // Handle each event type and subtype.
                switch (eventType)
                {
                    case REGIONAL_EVT_MSG_CONQUEST:
                    {
                        conquest::HandleZMQMessage(data);
                        break;
                    }
                    /*
                    case REGIONAL_EVT_MSG_BESIEGED:
                    {
                        // TODO: Handle besieged message
                        break;
                    }
                    case REGIONAL_EVT_MSG_CAMPAIGN:
                    {
                        // TODO: Handle besieged message
                        break;
                    }
                    case REGIONAL_EVT_MSG_COLONIZATION:
                    {
                        // TODO: Handle besieged message
                        break;
                    }
                    */
                    default:
                    {
                        ShowWarning("Message: unhandled regional event type %d", eventType);
                    }
                }

                break;
            }
            case MSG_KILL_SESSION:
            {
                uint32 charID = ref<uint32>((uint8*)extra.data(), 0);

                map_session_data_t* sessionToDelete = nullptr;
                for (auto mapSession : map_session_list)
                {
                    auto session = mapSession.second;
                    if (session->charID == charID)
                    {
                        sessionToDelete = session;
                        break;
                    }
                }

                if (sessionToDelete && sessionToDelete->blowfish.status == BLOWFISH_PENDING_ZONE)
                {
                    DebugSockets(fmt::format("Closing session of charid {} on request of other process", charID));
                    map_close_session(server_clock::now(), sessionToDelete);
                }
                break;
            }
            default:
            {
                ShowWarning("Message: unhandled message type %d", type);
            }
        }
    }

    void send_charvar_update(uint32 charId, std::string const& varName, uint32 value, uint32 expiry)
    {
        const uint32 size      = sizeof(uint32) + sizeof(uint32) + sizeof(uint32) + sizeof(uint8) + 256;
        char         buf[size] = {};
        std::memset(&buf[0], 0, size);

        ref<uint32>(buf, 0) = charId;
        ref<int32>(buf, 4)  = value;
        ref<uint32>(buf, 8) = expiry;
        ref<uint8>(buf, 12) = static_cast<uint8>(std::min<size_t>(varName.size(), 255));
        std::memcpy(buf + 13, varName.c_str(), varName.size());

        message::send(MSG_CHARVAR_UPDATE, buf, size, nullptr);
    }

    void handle_incoming()
    {
        TracyZoneScoped;

        chat_message_t message;
        while (incoming_queue.try_dequeue(message))
        {
            parse(message);
        }
    }

    void listen()
    {
        TracySetThreadName("ZMQ Thread");
        while (gRunFlag)
        {
            if (!zSocket)
            {
                return;
            }

            try
            {
                chat_message_t message;
                if (!zSocket->recv(message.type, zmq::recv_flags::none))
                {
                    TracyZoneScoped;
                    send_queue();
                    continue;
                }

                TracyZoneScoped;
                int more = zSocket->get(zmq::sockopt::rcvmore);
                if (more)
                {
                    std::ignore = zSocket->recv(message.data);
                    more        = zSocket->get(zmq::sockopt::rcvmore);
                    if (more)
                    {
                        std::ignore = zSocket->recv(message.packet);
                    }
                }

                incoming_queue.enqueue(std::move(message));
            }
            catch (zmq::error_t& e)
            {
                // Context was terminated (ETERM = 156384765)
                // Exit loop
                if (!zSocket || e.num() == 156384765)
                {
                    return;
                }
                ShowError("Message: %s\n", e.what());
                continue;
            }
        }
    }

    void init()
    {
        init(settings::get<std::string>("network.ZMQ_IP").c_str(), settings::get<uint16>("network.ZMQ_PORT"));
    }

    void init(const char* chatIp, uint16 chatPort)
    {
        TracyZoneScoped;

        zContext = zmq::context_t(1);
        zSocket  = std::make_unique<zmq::socket_t>(zContext, zmq::socket_type::dealer);

        uint64 ipp  = map_ip.s_addr;
        uint64 port = map_port;

        // if no ip/port were supplied, set to 1 (0 is not valid for an identity)
        if (map_ip.s_addr == 0 && map_port == 0)
        {
            int ret = _sql->Query("SELECT zoneip, zoneport FROM zone_settings GROUP BY zoneip, zoneport ORDER BY COUNT(*) DESC");
            if (ret != SQL_ERROR && _sql->NumRows() > 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                inet_pton(AF_INET, (const char*)_sql->GetData(0), &ipp);
                port = _sql->GetUIntData(1);
            }
        }

        ipp |= (port << 32);

        zSocket->set(zmq::sockopt::routing_id, zmq::const_buffer(&ipp, sizeof(ipp)));
        zSocket->set(zmq::sockopt::rcvtimeo, 500);

        std::string server = "tcp://";
        server.append(chatIp);
        server.append(":");
        server.append(std::to_string(chatPort));

        try
        {
            zSocket->connect(server.c_str());
        }
        catch (zmq::error_t& err)
        {
            ShowCritical("Message: Unable to connect chat socket: %s", err.what());
        }
    }

    void close()
    {
        TracyZoneScoped;

        if (zSocket)
        {
            zSocket->close();
            zSocket = nullptr;
        }
        zContext.close();
    }

    void send(MSGSERVTYPE type, void* data, size_t datalen, const std::unique_ptr<CBasicPacket>& packet)
    {
        TracyZoneScoped;

        chat_message_t msg;
        msg.type = zmq::message_t(sizeof(MSGSERVTYPE));

        ref<uint8>((uint8*)msg.type.data(), 0) = type;

        msg.data = zmq::message_t(datalen);
        if (datalen > 0)
        {
            std::memcpy(msg.data.data(), data, datalen);
        }

        if (packet)
        {
            // clang-format off
            msg.packet = zmq::message_t(*packet, packet->getSize());
        }
        else
        {
            msg.packet = zmq::message_t(0);
        }

        outgoing_queue.enqueue(msg);
    }

    void send(uint16 zone, std::string const& luaFunc)
    {
        TracyZoneScoped;

        std::vector<uint8> packetData(4 + luaFunc.size() + 1);
        ref<uint16>(packetData.data(), 2) = zone;

        std::memcpy(packetData.data() + 4, luaFunc.data(), luaFunc.size());

        packetData[packetData.size() - 1] = '\0';

        message::send(MSG_LUA_FUNCTION, packetData.data(), packetData.size());
    }

    void send(uint32 playerId, const std::unique_ptr<CBasicPacket>& packet)
    {
        TracyZoneScoped;

        std::array<uint8, 4> packetData{};
        ref<uint32>(packetData.data(), 0) = playerId;
        message::send(MSG_DIRECT, packetData.data(), packetData.size(), packet);
    }

    void send(std::string const& playerName, const std::unique_ptr<CBasicPacket>& packet)
    {
        TracyZoneScoped;

        send(charutils::getCharIdFromName(playerName), packet);
    }

    void rpc_send(uint16 sendZone, uint16 recvZone, std::string const& sendStr, sol::function recvFunc)
    {
        uint64_t slotKey  = std::chrono::duration_cast<std::chrono::microseconds>(hires_clock::now().time_since_epoch()).count();
        replyMap[slotKey] = std::move(recvFunc);

        std::vector<uint8> packetData(16 + sendStr.size() + 1);

        ref<uint16>(packetData.data(), 2)   = recvZone; // destination
        ref<uint16>(packetData.data(), 4)   = sendZone; // origin
        ref<uint64_t>(packetData.data(), 6) = slotKey;

        ref<uint16>(packetData.data(), 14) = (uint16)sendStr.size();
        std::memcpy(packetData.data() + 16, sendStr.data(), sendStr.size());

        packetData[packetData.size() - 1] = '\0';

        message::send(MSG_RPC_SEND, packetData.data(), packetData.size());
    }
}; // namespace message
