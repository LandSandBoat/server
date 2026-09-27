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
#include "stream.h"

#include "common/cbasetypes.h"
#include "common/macros.h"
#include "common/scheduler.h"

#include <asio/steady_timer.hpp>

#include <deque>
#include <string>
#include <string_view>

namespace profile
{

class PresenceManager;

class IrcSession final
{
public:
    IrcSession(Stream stream, std::string peer, const accounts::Credential& credential, PresenceManager& presence);
    ~IrcSession() = default;

    DISALLOW_COPY_AND_MOVE(IrcSession);

    auto run() -> Task<void>;

    void send(std::string_view message); // drops the client if too much is queued
    void close();
    void signOff();

private:
    auto handle(std::string_view line) -> bool;
    void login(std::string_view argument);
    auto readLoop() -> Task<void>;
    auto writeLoop() -> Task<void>;
    auto readLine() -> Task<Maybe<std::string>>;

    Stream                  stream_;
    std::string             peer_;
    accounts::Credential    credential_;
    PresenceManager&        presence_;
    std::string             input_;
    std::deque<std::string> outbox_;
    asio::steady_timer      wake_; // cancelled by send() to wake writeLoop
    bool                    keyed_{};
    uint64                  signOnId_{};
};

auto runIrcSession(Stream stream, std::string peer, accounts::Credential credential, PresenceManager& presence) -> Task<void>;

} // namespace profile
