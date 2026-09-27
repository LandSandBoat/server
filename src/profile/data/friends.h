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

#include "protocol/profile/c2s/0x0206_store_friend_list.h"
#include "protocol/profile/friend_info.h"

#include "common/cbasetypes.h"
#include "common/types/error_or.h"
#include "common/types/maybe.h"

#include <span>
#include <vector>

namespace profile::friends
{

constexpr uint8 friendListSize = sizeof(StoreFriendListHead::friendOrder);
constexpr uint8 blockListSize  = sizeof(StoreFriendListHead::blackOrder);

auto load(uint32 accountId) -> ErrorOr<std::vector<FriendInfo>>;

struct StoreResult
{
    std::vector<uint32> accepted;
    std::vector<uint32> lost;
};

// sets each entry's result, 0 = applied
auto store(uint32 accountId, const StoreFriendListHead& head, std::span<FriendInfo> entries) -> Maybe<StoreResult>;

// both list each other, neither pending, neither blocked
struct Friend
{
    uint32        accountId{};
    uint8         listIndex{};  // where this account lists the friend
    uint8         theirIndex{}; // where the friend lists this account
    Maybe<uint32> playing;
};

auto visibleFriends(uint32 accountId) -> ErrorOr<std::vector<Friend>>;

} // namespace profile::friends
