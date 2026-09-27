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

#include <string_view>
#include <unordered_map>

namespace profile
{

class IrcSession;

// tracks online accounts and sends their friends status notices
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
    void sendFriendsTo(uint32 accountId);
    void introduce(uint32 accountId, uint32 otherAccountId); // new friends see each other
    void hide(uint32 accountId, uint32 otherAccountId);      // accountId appears offline to otherAccountId

private:
    struct Online
    {
        IrcSession* session{};
        SessionHash sessionHash{};
        uint64      signOnId{};
        Status      status;
    };

    void announce(uint32 accountId);
    auto playing(uint32 accountId) const -> Maybe<uint32>;
    void notify(uint32 subjectAccountId, uint32 recipientAccountId, uint8 listIndex, bool visible, Maybe<uint32> character);
    void send(uint32 senderAccountId, uint32 recipientAccountId, std::string_view text);
    auto nextTimestamp() -> uint64;

    std::unordered_map<uint32, Online> online_;
    uint64                             lastSignOnId_{};
    uint64                             lastTimestamp_{};
};

} // namespace profile
