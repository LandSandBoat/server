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

#include "enums/open_status.h"
#include "protocol/codec.h"

#include "common/cbasetypes.h"
#include "common/types/maybe.h"

#include <unordered_map>

namespace profile
{

class IrcSession;

// tracks online accounts
class PresenceManager
{
public:
    struct Status
    {
        OpenStatus openStatus{ OpenStatus::Online };
        bool       inGame{};
        uint8      characterSlot{}; // when in game
        bool       receiveMessages{ true };
    };

    auto signOn(uint32 accountId, const SessionHash& sessionHash, IrcSession* session) -> uint64; // kicks the previous session, if any
    void signOff(uint32 accountId, uint64 signOnId);                                              // no-op if a newer session took over
    auto isOnline(uint32 accountId) const -> bool;
    auto status(uint32 accountId) const -> Maybe<Status>;
    void refreshCredentials() const;                                // bumps the credential timestamp of everyone online
    auto setStatus(uint32 accountId, const Status& status) -> bool; // false if saving the open status failed

private:
    struct Online
    {
        IrcSession* session{};
        SessionHash sessionHash{};
        uint64      signOnId{};
        Status      status;
    };

    std::unordered_map<uint32, Online> online_;
    uint64                             lastSignOnId_{};
};

} // namespace profile
