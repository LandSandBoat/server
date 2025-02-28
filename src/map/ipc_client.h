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
#include "common/socket.h"
#include "common/sql.h"
#include "common/zmq_dealer_wrapper.h"

#include <nonstd/jthread.hpp>
#include <zmq.hpp>
#include <zmq_addon.hpp>

class IPCClient final : public ipc::IIPCMessageHandler
{
public:
    IPCClient();

    void handleIncomingMessages();

    template <typename T>
    void sendMessage(const T& message);

    //
    // ipc::IIPCMessageHandler
    //

    void handleMessage_EmptyStruct(const IPP& ipp, const ipc::EmptyStruct& message) override;
    void handleMessage_CharLogin(const IPP& ipp, const ipc::CharLogin& message) override;
    void handleMessage_CharZone(const IPP& ipp, const ipc::CharZone& message) override;
    void handleMessage_CharVarUpdate(const IPP& ipp, const ipc::CharVarUpdate& message) override;
    void handleMessage_ChatMessageTell(const IPP& ipp, const ipc::ChatMessageTell& message) override;
    void handleMessage_ChatMessageParty(const IPP& ipp, const ipc::ChatMessageParty& message) override;
    void handleMessage_ChatMessageAlliance(const IPP& ipp, const ipc::ChatMessageAlliance& message) override;
    void handleMessage_ChatMessageLinkshell(const IPP& ipp, const ipc::ChatMessageLinkshell& message) override;
    void handleMessage_ChatMessageUnity(const IPP& ipp, const ipc::ChatMessageUnity& message) override;
    void handleMessage_ChatMessageYell(const IPP& ipp, const ipc::ChatMessageYell& message) override;
    void handleMessage_ChatMessageServerMessage(const IPP& ipp, const ipc::ChatMessageServerMessage& message) override;
    void handleMessage_ChatMessageCustom(const IPP& ipp, const ipc::ChatMessageCustom& message) override;
    void handleMessage_PartyInvite(const IPP& ipp, const ipc::PartyInvite& message) override;
    void handleMessage_PartyInviteResponse(const IPP& ipp, const ipc::PartyInviteResponse& message) override;
    void handleMessage_PartyReload(const IPP& ipp, const ipc::PartyReload& message) override;
    void handleMessage_PartyDisband(const IPP& ipp, const ipc::PartyDisband& message) override;
    void handleMessage_AllianceReload(const IPP& ipp, const ipc::AllianceReload& message) override;
    void handleMessage_AllianceDissolve(const IPP& ipp, const ipc::AllianceDissolve& message) override;
    void handleMessage_PlayerKick(const IPP& ipp, const ipc::PlayerKick& message) override;
    void handleMessage_MessageStandard(const IPP& ipp, const ipc::MessageStandard& message) override;
    void handleMessage_MessageSystem(const IPP& ipp, const ipc::MessageSystem& message) override;
    void handleMessage_LinkshellRankChange(const IPP& ipp, const ipc::LinkshellRankChange& message) override;
    void handleMessage_LinkshellRemove(const IPP& ipp, const ipc::LinkshellRemove& message) override;
    void handleMessage_LinkshellSetMessage(const IPP& ipp, const ipc::LinkshellSetMessage& message) override;
    void handleMessage_LuaFunction(const IPP& ipp, const ipc::LuaFunction& message) override;
    void handleMessage_KillSession(const IPP& ipp, const ipc::KillSession& message) override;
    void handleMessage_ConquestEvent(const IPP& ipp, const ipc::ConquestEvent& message) override;
    void handleMessage_BesiegedEvent(const IPP& ipp, const ipc::BesiegedEvent& message) override;
    void handleMessage_CampaignEvent(const IPP& ipp, const ipc::CampaignEvent& message) override;
    void handleMessage_ColonizationEvent(const IPP& ipp, const ipc::ColonizationEvent& message) override;
    void handleMessage_EntityInformationRequest(const IPP& ipp, const ipc::EntityInformationRequest& message) override;
    void handleMessage_EntityInformationResponse(const IPP& ipp, const ipc::EntityInformationResponse& message) override;
    void handleMessage_SendPlayerToLocation(const IPP& ipp, const ipc::SendPlayerToLocation& message) override;

    void handleUnknownMessage(const IPP& ipp, const std::span<uint8_t> message) override;

private:
    ZMQDealerWrapper zmqDealerWrapper_;
};

//
// Inline implementations
//

template <typename T>
void IPCClient::sendMessage(const T& message)
{
    TracyZoneScoped;

    // TODO: IPP for World Server
    DebugIPCFmt("Sending message: {}", ipc::toString(ipc::getEnumType<T>()));

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
    void init();

    template <typename T>
    void send(const T& message)
    {
        ipcClient_->sendMessage(message);
    }

    void handle_incoming();
} // namespace message
