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

#include "enums/message_type.h"

#include "common/cbasetypes.h"
#include "common/types/maybe.h"

#include <string>
#include <string_view>

namespace profile
{

// the client drops notices older than the last one
struct FriendStatusNotice
{
    uint32        friendAccountId{};
    uint8         listIndex{}; // where the recipient lists the friend
    uint8         status{};    // 0 offline, 1 online, 2 away
    uint64        timestamp{};
    Maybe<uint32> activeCharacterId; // lets the client look up world, zone and job
};

auto friendStatusNotice(const FriendStatusNotice& notice) -> std::string;

// polcore waits for this before finishing login.
// the slot keeps clients behind the same nat on different game ports.
auto profileAvailableNotice(uint16 udpPortSlot) -> std::string;

// only types a client may send
struct MessageName
{
    uint32      sender{};
    uint32      recipient{};
    MessageType type{};
    std::string senderName;
    uint32      length{};
};

auto parseMessageName(std::string_view name) -> Maybe<MessageName>;

// the message name with the online-notice bit set
auto messageNotice(std::string_view name) -> std::string;

} // namespace profile
