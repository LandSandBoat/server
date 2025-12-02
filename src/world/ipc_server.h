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

#pragma once

#include "common/ipc.h"
#include "common/ipp.h"
#include "common/mmo.h"
#include "common/zmq_dealer_wrapper.h"

#include "character_cache.h"
#include "world_engine.h"
#include "zone_settings.h"

#include <atomic>
#include <thread>

#include <zmq.hpp>
#include <zmq_addon.hpp>

class IPCServer final : public ipc::IPCMessageHandlerBase<IPCServer>
{
public:
    IPCServer(WorldEngine& worldServer);

    void handleIncomingMessages();

    template <typename T>
    void sendMessage(const IPP& ipp, const T& message);

    template <typename T>
    void broadcastMessage(const T& message);

    //
    // IPP Lookup
    //

    auto getIPPForCharId(uint32 charId) -> std::optional<IPP>;
    auto getIPPForCharName(const std::string& charName) -> std::optional<IPP>;
    auto getIPPForZoneId(uint16 zoneId) -> std::optional<IPP>;
    auto getIPPsForParty(uint32 partyId) -> std::vector<IPP>;
    auto getIPPsForAlliance(uint32 allianceId) -> std::vector<IPP>;
    auto getIPPsForLinkshell(uint32 linkshellId) -> std::vector<IPP>;
    auto getIPPsForUnity(uint32 unityId) -> std::vector<IPP>;
    auto getIPPsForYellZones() -> std::vector<IPP>;
    auto getIPPsForAssistZones() -> std::vector<IPP>;
    auto getIPPsForAllZones() -> std::vector<IPP>;

    //
    // Message routing
    //

    void rerouteMessageToCharId(uint32 charId, const auto& message);
    void rerouteMessageToCharName(const std::string& charName, const auto& message);
    void rerouteMessageToZoneId(uint16 zoneId, const auto& message);
    void rerouteMessageToPartyMembers(uint32 partyId, const auto& message);
    void rerouteMessageToAllianceMembers(uint32 allianceId, const auto& message);
    void rerouteMessageToLinkshellMembers(uint32 linkshellId, const auto& message);
    void rerouteMessageToUnityMembers(uint32 unityId, const auto& message);
    void rerouteMessageToYellZones(const auto& message);
    void rerouteMessageToAssistZones(const auto& message);
    void rerouteMessageToAllZones(const auto& message);

    //
    // ipc::IPCMessageHandlerBase
    //

    void handleMessage_EmptyStruct(const IPP& ipp, const ipc::EmptyStruct& message);
    void handleMessage_AccountLogin(const IPP& ipp, const ipc::AccountLogin& message);
    void handleMessage_CharZone(const IPP& ipp, const ipc::CharZone& message);
    void handleMessage_CharVarUpdate(const IPP& ipp, const ipc::CharVarUpdate& message);
    void handleMessage_ChatMessageTell(const IPP& ipp, const ipc::ChatMessageTell& message);
    void handleMessage_ChatMessageParty(const IPP& ipp, const ipc::ChatMessageParty& message);
    void handleMessage_ChatMessageAlliance(const IPP& ipp, const ipc::ChatMessageAlliance& message);
    void handleMessage_ChatMessageLinkshell(const IPP& ipp, const ipc::ChatMessageLinkshell& message);
    void handleMessage_ChatMessageUnity(const IPP& ipp, const ipc::ChatMessageUnity& message);
    void handleMessage_ChatMessageYell(const IPP& ipp, const ipc::ChatMessageYell& message);
    void handleMessage_ChatMessageAssist(const IPP& ipp, const ipc::ChatMessageAssist& message);
    void handleMessage_ChatMessageServerMessage(const IPP& ipp, const ipc::ChatMessageServerMessage& message);
    void handleMessage_ChatMessageCustom(const IPP& ipp, const ipc::ChatMessageCustom& message);
    void handleMessage_PartyInvite(const IPP& ipp, const ipc::PartyInvite& message);
    void handleMessage_PartyInviteResponse(const IPP& ipp, const ipc::PartyInviteResponse& message);
    void handleMessage_PartyReload(const IPP& ipp, const ipc::PartyReload& message);
    void handleMessage_PartyDisband(const IPP& ipp, const ipc::PartyDisband& message);
    void handleMessage_AllianceReload(const IPP& ipp, const ipc::AllianceReload& message);
    void handleMessage_AllianceDissolve(const IPP& ipp, const ipc::AllianceDissolve& message);
    void handleMessage_PlayerKick(const IPP& ipp, const ipc::PlayerKick& message);
    void handleMessage_MessageStandard(const IPP& ipp, const ipc::MessageStandard& message);
    void handleMessage_MessageSystem(const IPP& ipp, const ipc::MessageSystem& message);
    void handleMessage_LinkshellRankChange(const IPP& ipp, const ipc::LinkshellRankChange& message);
    void handleMessage_LinkshellRemove(const IPP& ipp, const ipc::LinkshellRemove& message);
    void handleMessage_LinkshellSetMessage(const IPP& ipp, const ipc::LinkshellSetMessage& message);
    void handleMessage_LuaFunction(const IPP& ipp, const ipc::LuaFunction& message);
    void handleMessage_KillSession(const IPP& ipp, const ipc::KillSession& message);
    void handleMessage_ConquestEvent(const IPP& ipp, const ipc::ConquestEvent& message);
    void handleMessage_BesiegedEvent(const IPP& ipp, const ipc::BesiegedEvent& message);
    void handleMessage_CampaignEvent(const IPP& ipp, const ipc::CampaignEvent& message);
    void handleMessage_ColonizationEvent(const IPP& ipp, const ipc::ColonizationEvent& message);
    void handleMessage_EntityInformationRequest(const IPP& ipp, const ipc::EntityInformationRequest& message);
    void handleMessage_EntityInformationResponse(const IPP& ipp, const ipc::EntityInformationResponse& message);
    void handleMessage_SendPlayerToLocation(const IPP& ipp, const ipc::SendPlayerToLocation& message);
    void handleMessage_AssistChannelEvent(const IPP& ipp, const ipc::AssistChannelEvent& message);

    void handleUnknownMessage(const IPP& ipp, const std::span<uint8_t> message);

private:
    WorldEngine& worldServer_;

    CharacterCache   characterCache_;
    ZoneSettings     zoneSettings_;
    ZMQRouterWrapper zmqRouterWrapper_;
};

//
// Inline implementations
//

template <typename T>
void IPCServer::sendMessage(const IPP& ipp, const T& message)
{
    TracyZoneScoped;

    DebugIPCFmt("Sending {} message to {}", ipc::toStringV<T>, ipp.toString());

    const auto bytes = ipc::toBytesWithHeader<T>(message);
    const auto out   = IPPMessage{ ipp, std::vector<uint8>{ bytes.begin(), bytes.end() } };

    zmqRouterWrapper_.outgoingQueue_.enqueue(std::move(out));
}

template <typename T>
void IPCServer::broadcastMessage(const T& message)
{
    TracyZoneScoped;

    DebugIPCFmt("Broadcasting {} message to all zone endpoints", ipc::toStringV<T>);

    for (const auto& ipp : zoneSettings_.mapEndpoints_)
    {
        const auto bytes = ipc::toBytesWithHeader<T>(message);
        const auto out   = IPPMessage{ ipp, std::vector<uint8>{ bytes.begin(), bytes.end() } };
        zmqRouterWrapper_.outgoingQueue_.enqueue(std::move(out));
    }
}
