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

#include "profile_engine.h"

#include "irc/irc_session.h"
#include "profile/profile_session.h"

#include "common/logging.h"
#include "common/settings.h"

#include <asio/read.hpp>

#include <array>
#include <chrono>
#include <cstring>
#include <stdexcept>

namespace
{

using namespace std::chrono_literals;

constexpr auto   kHandshakeDeadline  = 10s;
constexpr auto   kRefreshInterval    = 1h;
constexpr uint16 kConnectionsPerPeer = 16;

// hardcoded in polcore
constexpr uint16 kIrcPort = 51240;

} // namespace

ProfileEngine::ProfileEngine(Scheduler& scheduler)
: scheduler_(scheduler)
, tls_(asio::ssl::context::tlsv13_server)
{
    auto ec = asio::error_code{};
    tls_.set_options(asio::ssl::context::default_workarounds);
    tls_.use_certificate_chain_file("profile.cert", ec);
    if (!ec)
    {
        tls_.use_private_key_file("profile.key", asio::ssl::context::file_format::pem, ec);
    }

    if (ec)
    {
        throw std::runtime_error(fmt::format("Cannot load profile.cert and profile.key ({})", ec.message()));
    }

    const auto profilePort = settings::get<uint16>("network.PROFILE_PORT");
    listen(profilePort,
           [this](profile::Stream stream, std::string peer, const profile::accounts::Credential credential)
           {
               return profile::runProfileSession(std::move(stream), std::move(peer), credential.accountId, presence_);
           });

    listen(kIrcPort,
           [this](profile::Stream stream, std::string peer, const profile::accounts::Credential credential)
           {
               return profile::runIrcSession(std::move(stream), std::move(peer), credential, presence_);
           });

    refreshToken_ = scheduler_.intervalOnMainThread(kRefreshInterval,
                                                    [this]()
                                                    {
                                                        presence_.refreshCredentials();
                                                    });

    ShowInfoFmt("listening on {} (profile) and {} (irc)", profilePort, kIrcPort);
}

ProfileEngine::~ProfileEngine() = default;

void ProfileEngine::listen(const uint16 port, Session session)
{
    auto acceptor = asio::ip::tcp::acceptor(scheduler_.mainContext(), asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port));
    scheduler_.postToMainThread(accept(std::move(acceptor), std::move(session)));
}

auto ProfileEngine::accept(asio::ip::tcp::acceptor acceptor, const Session session) -> Task<void>
{
    while (!scheduler_.closeRequested())
    {
        auto [ec, socket] = co_await acceptor.async_accept(asio::as_tuple(asio::use_awaitable));
        if (ec)
        {
            ShowErrorFmt("failed to accept connection: {}", ec.message());
            co_await Scheduler::yieldFor(100ms);
            continue;
        }

        auto peer = Peer{ acceptor.local_endpoint().port(), socket.remote_endpoint(ec).address().to_string() };
        if (ec || connections_[peer] >= kConnectionsPerPeer)
        {
            continue;
        }

        ++connections_[peer];
        scheduler_.postToMainThread(serve(std::move(socket), std::move(peer), session));
    }
}

auto ProfileEngine::serve(asio::ip::tcp::socket socket, Peer peer, const Session session) -> Task<void>
{
    auto stream = profile::Stream(std::move(socket), tls_);

    const auto handshake = co_await Scheduler::withTimeout(stream.async_handshake(asio::ssl::stream_base::server, asio::as_tuple(asio::use_awaitable)), kHandshakeDeadline);
    if (handshake && !std::get<0>(*handshake))
    {
        const auto credential = co_await authenticate(stream);
        if (!credential)
        {
            ShowWarningFmt("{} refused an unverified connection", peer.second);
        }
        else
        {
            try
            {
                co_await session(std::move(stream), peer.second, *credential);
            }
            catch (const std::exception& e)
            {
                ShowWarningFmt("{} session error: {}", peer.second, e.what());
            }
            catch (...)
            {
                ShowWarningFmt("{} session error", peer.second);
            }
        }
    }

    if (--connections_[peer] == 0)
    {
        connections_.erase(peer);
    }
}

// the relay opens every connection with the account id and its session hash; an expired hash is fine while the account is online
auto ProfileEngine::authenticate(profile::Stream& stream) -> Task<Maybe<profile::accounts::Credential>>
{
    auto       hello  = std::array<uint8, sizeof(uint32) + sizeof(profile::SessionHash)>{};
    const auto result = co_await Scheduler::withTimeout(asio::async_read(stream, asio::buffer(hello), asio::as_tuple(asio::use_awaitable)), kHandshakeDeadline);
    if (!result || std::get<0>(*result))
    {
        co_return std::nullopt;
    }

    auto credential = profile::accounts::Credential{};
    std::memcpy(&credential.accountId, hello.data(), sizeof(uint32));
    std::memcpy(credential.sessionHash.data(), hello.data() + sizeof(uint32), credential.sessionHash.size());

    const auto fresh = profile::accounts::freshness(credential);
    if (!fresh || (!*fresh && !presence_.isOnline(credential.accountId)))
    {
        co_return std::nullopt;
    }

    co_return credential;
}
