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

#pragma once

#include "data/accounts.h"
#include "irc/presence_manager.h"
#include "stream.h"

#include "common/engine.h"
#include "common/scheduler.h"

#include <asio/ssl/context.hpp>

#include <functional>
#include <map>
#include <string>
#include <utility>

// the profile server (friend lists, status, files) and the IRC server (presence, message notices)
class ProfileEngine final : public Engine
{
public:
    explicit ProfileEngine(Scheduler& scheduler);
    ~ProfileEngine() override;

private:
    using Session = std::function<Task<void>(profile::Stream, std::string, profile::accounts::Credential)>;
    using Peer    = std::pair<uint16, std::string>; // port, address

    void listen(uint16 port, Session session);
    auto accept(asio::ip::tcp::acceptor acceptor, Session session) -> Task<void>;
    auto serve(asio::ip::tcp::socket socket, Peer peer, Session session) -> Task<void>;
    auto authenticate(profile::Stream& stream) -> Task<Maybe<profile::accounts::Credential>>;

    Scheduler&               scheduler_;
    asio::ssl::context       tls_;
    profile::PresenceManager presence_;
    std::map<Peer, uint16>   connections_;
    Maybe<Scheduler::Token>  refreshToken_;
};
