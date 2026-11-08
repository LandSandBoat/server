/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "lua/helpers/lua_client_entity_pair_network.h"

#include "lua/lua_client_entity_pair.h"
#include "lua/sol_bindings.h"
#include "test_char.h"
#include "test_common.h"
#include "test_network_client.h"

#include "common/database.h"
#include "map/entities/char_entity.h"
#include "map/map_engine.h"
#include "map/map_networking.h"
#include "map/map_session.h"

namespace
{

// A real client resends 0x00A every 2 s for about two minutes
constexpr auto kMaxLoginAttempts = 60U;

// The zone-in burst takes a few dozen datagrams to deliver
constexpr auto kMaxDrainExchanges = 200U;

} // namespace

CLuaClientEntityPairNetwork::CLuaClientEntityPairNetwork(CLuaClientEntityPair* parent)
: parent_(parent)
{
}

/************************************************************************
 *  Function: login()
 *  Purpose : Sends a plaintext C2S 0x00A and reads the reply
 *  Example : player.network:login()
 *            player.network:login({ dropReply = true })
 *  Notes   : Returns true once the client accepts S2C 0x00A.
 *            dropReply loses the server's reply on the wire.
 *            ignoreLogin keeps the reply but drops its 0x00A.
 ************************************************************************/

auto CLuaClientEntityPairNetwork::login(sol::optional<sol::table> params) const -> bool
{
    const auto faults = TestNetworkClient::LoginFaults{
        .dropReply   = params.has_value() && params.value().get_or("dropReply", false),
        .ignoreLogin = params.has_value() && params.value().get_or("ignoreLogin", false),
    };

    const auto accepted = parent_->networkClient().login(faults);
    parent_->refreshEntity();

    return accepted;
}

/************************************************************************
 *  Function: sendStaleLogin()
 *  Purpose : Sends a plaintext C2S 0x00A with a chosen header seq
 *  Example : player.network:sendStaleLogin(1)
 *            player.network:sendStaleLogin(1, 12345)
 *  Notes   : Models a late or reordered retry reaching the server.
 *            port sends it from that port instead of the current one.
 ************************************************************************/

void CLuaClientEntityPairNetwork::sendStaleLogin(const uint16 seq, sol::optional<uint16> port) const
{
    auto&      client = parent_->networkClient();
    const auto from   = [&]
    {
        if (port.has_value())
        {
            return IPP(client.ipp().getIP(), port.value());
        }

        return client.ipp();
    }();

    client.sendStaleLogin(seq, from);
    parent_->refreshEntity();
}

/************************************************************************
 *  Function: rebind()
 *  Purpose : Moves the client to a new source port, as a NAT rebind would
 *  Example : player.network:rebind(23456)
 ************************************************************************/

void CLuaClientEntityPairNetwork::rebind(const uint16 port) const
{
    auto& client = parent_->networkClient();
    client.rebind(IPP(client.ipp().getIP(), port));
}

/************************************************************************
 *  Function: finishLoading()
 *  Purpose : Finishes the zone load and sends C2S 0x00C
 *  Example : player.network:finishLoading()
 *            player.network:finishLoading({ refuseGameOk = true })
 *  Notes   : Sends the C2S 0x011 queued at zone-in first. Its reply is
 *            read while the zone loads, before the zone handlers exist
 *            and before the client reaches mode 9.
 *            refuseGameOk sends a C2S 0x00C the handler rejects.
 ************************************************************************/

void CLuaClientEntityPairNetwork::finishLoading(sol::optional<sol::table> params) const
{
    const auto gameOk = [&]
    {
        if (params.has_value() && params.value().get_or("refuseGameOk", false))
        {
            return TestNetworkClient::GameOk::Refused;
        }

        return TestNetworkClient::GameOk::Accepted;
    }();

    parent_->networkClient().finishLoading(gameOk);
    parent_->refreshEntity();
}

/************************************************************************
 *  Function: zoneIn()
 *  Purpose : Retries C2S 0x00A until accepted, loads, and drains the burst
 *  Example : player.network:zoneIn()
 ************************************************************************/

void CLuaClientEntityPairNetwork::zoneIn() const
{
    auto& client = parent_->networkClient();

    const auto accepted = [&]
    {
        for (auto attempt = 0U; attempt < kMaxLoginAttempts; ++attempt)
        {
            if (client.login({}))
            {
                return true;
            }
        }

        return false;
    }();

    parent_->refreshEntity();

    if (!accepted)
    {
        TestError("Client did not get S2C 0x00A after {} attempts", kMaxLoginAttempts);
        return;
    }

    client.finishLoading(TestNetworkClient::GameOk::Accepted);
    parent_->refreshEntity();
    drain();
}

/************************************************************************
 *  Function: exchange()
 *  Purpose : One client send tick, then reads every reply
 *  Example : player.network:exchange()
 *            player.network:exchange({ dropReply = true })
 *  Notes   : Zones out on its own when it accepts S2C 0x00B in game.
 *            dropReply loses the server's reply on the wire.
 ************************************************************************/

void CLuaClientEntityPairNetwork::exchange(sol::optional<sol::table> params) const
{
    const auto faults = TestNetworkClient::LoginFaults{
        .dropReply = params.has_value() && params.value().get_or("dropReply", false),
    };

    parent_->networkClient().exchange(faults);
    parent_->refreshEntity();
}

/************************************************************************
 *  Function: drain()
 *  Purpose : Exchanges until the server has nothing queued for the client
 *  Example : player.network:drain()
 ************************************************************************/

void CLuaClientEntityPairNetwork::drain() const
{
    auto& client = parent_->networkClient();

    for (auto i = 0U; i < kMaxDrainExchanges; ++i)
    {
        const auto* PChar = parent_->testChar()->entity();
        if (PChar == nullptr || PChar->getPacketList().empty() || client.mode() != TestNetworkClient::Mode::InGame)
        {
            return;
        }

        client.exchange({});
        parent_->refreshEntity();
    }

    TestError("Server still had packets queued after {} exchanges", kMaxDrainExchanges);
}

/************************************************************************
 *  Function: mode()
 *  Purpose : The client's state: login, loading, ingame, loggedout or hung
 *  Example : assert(player.network:mode() == 'ingame')
 ************************************************************************/

auto CLuaClientEntityPairNetwork::mode() const -> std::string
{
    switch (parent_->networkClient().mode())
    {
        case TestNetworkClient::Mode::Login:
            return "login";
        case TestNetworkClient::Mode::Loading:
            return "loading";
        case TestNetworkClient::Mode::InGame:
            return "ingame";
        case TestNetworkClient::Mode::LoggedOut:
            return "loggedout";
        case TestNetworkClient::Mode::Hung:
            return "hung";
    }

    return "unknown";
}

/************************************************************************
 *  Function: isHung()
 *  Purpose : True when the client got S2C 0x00B outside mode 9
 *  Example : assert(not player.network:isHung(), player.network:hangReason())
 ************************************************************************/

auto CLuaClientEntityPairNetwork::isHung() const -> bool
{
    return parent_->networkClient().mode() == TestNetworkClient::Mode::Hung;
}

auto CLuaClientEntityPairNetwork::hangReason() const -> std::string
{
    return parent_->networkClient().hangReason();
}

/************************************************************************
 *  Function: received()
 *  Purpose : Every S2C sub-packet the client read, accepted or dropped
 *  Example : for _, pkt in ipairs(player.network:received()) do ... end
 *  Notes   : Each entry has type, sync, datagramSeq, entityId, updateMask,
 *            datagram, accepted and reason. A dropped datagram has type 0.
 ************************************************************************/

auto CLuaClientEntityPairNetwork::received() const -> sol::table
{
    auto table = lua.create_table();
    auto index = 1;

    for (const auto& entry : parent_->networkClient().received())
    {
        auto row           = lua.create_table();
        row["type"]        = entry.type;
        row["sync"]        = entry.sync;
        row["datagramSeq"] = entry.datagramSeq;
        row["entityId"]    = entry.entityId;
        row["updateMask"]  = entry.updateMask;
        row["datagram"]    = entry.datagram;
        row["accepted"]    = entry.accepted;
        row["reason"]      = entry.reason;

        table[index++] = row;
    }

    return table;
}

void CLuaClientEntityPairNetwork::clearReceived() const
{
    parent_->networkClient().clearReceived();
}

/************************************************************************
 *  Function: setStoredZone()
 *  Purpose : Overwrites the zone saved for the char, as a stale row would
 *  Example : player.network:setStoredZone(1000)
 *  Notes   : Use between zone-out and zone-in, when the server reloads
 *            the char from the database.
 ************************************************************************/

void CLuaClientEntityPairNetwork::setStoredZone(const uint16 zoneId) const
{
    if (!db::preparedStmt("UPDATE chars SET pos_zone = ? WHERE charid = ?", zoneId, parent_->testChar()->charId()))
    {
        TestError("Failed to store zone {}", zoneId);
    }
}

/************************************************************************
 *  Function: isLinkDeadAfter()
 *  Purpose : Runs the session cleanup as if nothing arrived for that long
 *  Example : assert(not player.network:isLinkDeadAfter(10))
 *  Notes   : Moves the session's last update back rather than the
 *            earth clock, which every later test would inherit.
 ************************************************************************/

auto CLuaClientEntityPairNetwork::isLinkDeadAfter(const uint32 seconds) const -> bool
{
    auto* session = parent_->testChar()->session();
    session->last_update -= std::chrono::seconds(seconds);

    auto& networking = parent_->engine()->networking();
    networking.sessions().cleanupSessions(networking.ipp());

    const auto* PChar = parent_->testChar()->entity();
    return PChar != nullptr && PChar->isLinkDead;
}

/************************************************************************
 *  Function: hasSentZoneOut()
 *  Purpose : True once the server has sent S2C 0x00B and released the char
 *  Example : assert(player.network:hasSentZoneOut())
 *  Notes   : The player's entity is gone from then until the zone-in.
 ************************************************************************/

auto CLuaClientEntityPairNetwork::hasSentZoneOut() const -> bool
{
    const auto* session = parent_->testChar()->session();
    return session != nullptr && session->PChar == nullptr && session->blowfish.status == BLOWFISH_PENDING_ZONE;
}

void CLuaClientEntityPairNetwork::Register()
{
    SOL_USERTYPE("CClientEntityPairNetwork", CLuaClientEntityPairNetwork);
    SOL_REGISTER("login", CLuaClientEntityPairNetwork::login);
    SOL_REGISTER("sendStaleLogin", CLuaClientEntityPairNetwork::sendStaleLogin);
    SOL_REGISTER("finishLoading", CLuaClientEntityPairNetwork::finishLoading);
    SOL_REGISTER("rebind", CLuaClientEntityPairNetwork::rebind);
    SOL_REGISTER("zoneIn", CLuaClientEntityPairNetwork::zoneIn);
    SOL_REGISTER("exchange", CLuaClientEntityPairNetwork::exchange);
    SOL_REGISTER("drain", CLuaClientEntityPairNetwork::drain);
    SOL_REGISTER("mode", CLuaClientEntityPairNetwork::mode);
    SOL_REGISTER("isHung", CLuaClientEntityPairNetwork::isHung);
    SOL_REGISTER("hangReason", CLuaClientEntityPairNetwork::hangReason);
    SOL_REGISTER("received", CLuaClientEntityPairNetwork::received);
    SOL_REGISTER("clearReceived", CLuaClientEntityPairNetwork::clearReceived);
    SOL_REGISTER("setStoredZone", CLuaClientEntityPairNetwork::setStoredZone);
    SOL_REGISTER("isLinkDeadAfter", CLuaClientEntityPairNetwork::isLinkDeadAfter);
    SOL_REGISTER("hasSentZoneOut", CLuaClientEntityPairNetwork::hasSentZoneOut);
}
