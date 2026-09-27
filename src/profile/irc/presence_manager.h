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

#include "protocol/codec.h"

#include "common/cbasetypes.h"

#include <unordered_map>

namespace profile
{

class IrcSession;

// tracks online accounts
class PresenceManager
{
public:
    auto signOn(uint32 accountId, const SessionHash& sessionHash, IrcSession* session) -> uint64; // kicks the previous session, if any
    void signOff(uint32 accountId, uint64 signOnId);                                              // no-op if a newer session took over
    auto isOnline(uint32 accountId) const -> bool;
    void refreshCredentials() const; // bumps the credential timestamp of everyone online

private:
    struct Online
    {
        IrcSession* session{};
        SessionHash sessionHash{};
        uint64      signOnId{};
    };

    std::unordered_map<uint32, Online> online_;
    uint64                             lastSignOnId_{};
};

} // namespace profile
