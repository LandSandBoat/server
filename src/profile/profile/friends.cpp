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

#include "profile/friends.h"

#include "data/friends.h"
#include "irc/presence_manager.h"
#include "protocol/profile/c2s/0x0206_store_friend_list.h"
#include "protocol/profile/friend_info.h"
#include "protocol/profile/prof_trailer.h"
#include "protocol/profile/s2c/prof_count.h"

#include "common/logging.h"

#include <cstring>
#include <string_view>
#include <vector>

namespace profile
{

// statuses follow as notices once the list is sent
auto loadFriendList(Context& context) -> ProfileAnswer
{
    const auto entries = friends::load(context.accountId);
    if (!entries)
    {
        return ProfileAnswer(ProfError::Refused);
    }

    context.afterAnswer = [&presence = context.presence, accountId = context.accountId]
    {
        presence.sendFriendsTo(accountId);
    };

    return ProfileAnswer().add(ProfCount{ .count = static_cast<uint32>(entries->size()) }).addAll(*entries);
}

auto storeFriendList(Context& context, const std::span<const uint8> body) -> Maybe<ProfileAnswer>
{
    constexpr auto fixedSize = sizeof(StoreFriendListHead) + sizeof(ProfTrailer);
    if (body.size() < fixedSize || (body.size() - fixedSize) % sizeof(FriendInfo) != 0)
    {
        return std::nullopt;
    }

    const auto head    = fromBytes<StoreFriendListHead>(body.first(sizeof(StoreFriendListHead)));
    const auto trailer = fromBytes<ProfTrailer>(body.last(sizeof(ProfTrailer)));
    const auto count   = (body.size() - fixedSize) / sizeof(FriendInfo);
    if (!head || !trailer || head->count != count || !hasTrailingChecksum(body))
    {
        return std::nullopt;
    }

    auto entries = std::vector<FriendInfo>(count);
    std::memcpy(entries.data(), body.data() + sizeof(StoreFriendListHead), count * sizeof(FriendInfo));

    const auto accountId = context.accountId;
    const auto result    = friends::store(accountId, *head, entries);
    if (!result)
    {
        return ProfileAnswer(ProfError::Refused);
    }

    for (const auto& entry : entries)
    {
        if (entry.result != 0)
        {
            continue;
        }

        auto list = std::string_view("friend");
        if (entry.isBlack != 0)
        {
            list = "block";
        }

        if (entry.op == friendOpDelete)
        {
            ShowInfoFmt("account {} removed entry {} from its {} list", accountId, entry.Num, list);
            continue;
        }

        auto pending = std::string_view();
        if (entry.bTemporary != 0)
        {
            pending = ", pending";
        }

        ShowInfoFmt("account {} put account {} (\"{}\") at entry {} of its {} list{}", accountId, entry.PolId, asStringFromUntrustedSource(entry.handleName, sizeof(entry.handleName)), entry.Num, list, pending);
    }

    for (const auto other : result->accepted)
    {
        ShowInfoFmt("accounts {} and {} are now friends", accountId, other);
    }

    for (const auto other : result->lost)
    {
        ShowInfoFmt("account {} no longer shares presence with account {}", accountId, other);
    }

    context.afterAnswer = [&presence = context.presence, accountId, result = *result]
    {
        for (const auto other : result.accepted)
        {
            presence.introduce(accountId, other);
        }

        for (const auto other : result.lost)
        {
            presence.hide(accountId, other);
        }
    };

    return ProfileAnswer().add(ProfCount{ .count = static_cast<uint32>(count) }).addAll(entries).add(ProfTrailer{ .unused00 = trailer->unused00 });
}

} // namespace profile
