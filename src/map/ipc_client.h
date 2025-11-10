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

#include "common/cbasetypes.h"
#include "common/ipc.h"
#include "common/lua.h"
#include "common/mmo.h"
#include "common/zmq_dealer_wrapper.h"

#include <nonstd/jthread.hpp>
#include <zmq.hpp>
#include <zmq_addon.hpp>

class MapNetworking;

class IPCClient final : public ipc::IPCMessageHandlerBase<IPCClient>
{
public:
    IPCClient(MapNetworking& networking);

    auto getZMQEndpointString() -> std::string;
    auto getZMQRoutingId() -> uint64;

    void handleIncomingMessages();

    template <typename T>
    void sendMessage(const T& message);

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
    void handleMessage_ChatMessageAssist(const IPP& ipp, const ipc::ChatMessageAssist& message) const;
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
    void handleMessage_AssistChannelEvent(const IPP& ipp, const ipc::AssistChannelEvent& message) const;

    void handleUnknownMessage(const IPP& ipp, const std::span<uint8_t> message);

private:
    MapNetworking&   networking_;
    ZMQDealerWrapper zmqDealerWrapper_;
};

//
// Inline implementations
//

template <typename T>
void IPCClient::sendMessage(const T& message)
{
    TracyZoneScoped;
    TracyZoneCString(ipc::toStringV<T>);

    // TODO: IPP for World Server
    DebugIPCFmt("Sending message: {}", ipc::toStringV<T>);

    const auto bytes = ipc::toBytesWithHeader<T>(message);
    zmqDealerWrapper_.outgoingQueue_.enqueue(zmq::message_t(bytes));
}

//
// Convenience namespace
//

// TODO: Don't do this
extern std::unique_ptr<IPCClient> ipcClient_;

namespace message
{

void init(MapNetworking& networking);

template <typename T>
void send(const T& message)
{
    ipcClient_->sendMessage(message);
}

void handle_incoming();

} // namespace message
