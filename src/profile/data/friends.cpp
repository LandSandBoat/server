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

#include "data/friends.h"

#include "data/accounts.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/macros.h"

#include <algorithm>
#include <cstring>
#include <iterator>
#include <ranges>
#include <set>
#include <stdexcept>

namespace profile::friends
{

namespace
{

// throws so the transaction rolls back
template <typename... Args>
auto run(const char* query, Args&&... args)
{
    auto rset = db::preparedStmt(query, std::forward<Args>(args)...);
    if (!rset)
    {
        throw std::runtime_error("friend list statement failed");
    }

    return rset;
}

auto pendingEntry(const uint32 accountId, const uint32 otherAccountId) -> Maybe<bool>
{
    const auto rset = run("SELECT pending FROM accounts_friends WHERE accid = ? AND blacklist = 0 AND friend_accid = ?", accountId, otherAccountId);
    if (!rset->next())
    {
        return std::nullopt;
    }

    return rset->get<bool>("pending");
}

auto isPending(const uint32 accountId, const uint32 friendAccountId) -> bool
{
    return pendingEntry(accountId, friendAccountId).value_or(true);
}

auto apply(const uint32 accountId, FriendInfo& entry) -> bool
{
    const auto isBlack = entry.isBlack != 0;

    // one bad index makes the client reject the whole list
    auto listSize = friendListSize;
    if (isBlack)
    {
        listSize = blockListSize;
    }

    if (entry.Num >= listSize)
    {
        return false;
    }

    if (entry.op == friendOpDelete)
    {
        run("DELETE FROM accounts_friends WHERE accid = ? AND blacklist = ? AND list_index = ?", accountId, isBlack, entry.Num);
        return true;
    }

    // POL ids and handle ids are account ids
    const auto friendAccountId = static_cast<uint32>(entry.PolId);
    if (entry.op != friendOpSet || entry.PolId != friendAccountId || friendAccountId == accountId || !accounts::exists(friendAccountId))
    {
        return false;
    }

    const auto pending = !isBlack && isPending(accountId, friendAccountId);

    entry.handleId     = friendAccountId;
    entry.handleNumber = 0;
    entry.bTemporary   = pending;

    // also moves the friend if listed at another index
    run("REPLACE INTO accounts_friends(accid, blacklist, list_index, friend_accid, display_order, name, pending) VALUES(?, ?, ?, ?, ?, ?, ?)",
        accountId,
        isBlack,
        entry.Num,
        friendAccountId,
        entry.Order,
        asStringFromUntrustedSource(entry.handleName, sizeof(entry.handleName)),
        pending);
    return true;
}

void applyOrder(const uint32 accountId, const StoreFriendListHead& head)
{
    const auto rset = run("SELECT blacklist, list_index, display_order FROM accounts_friends WHERE accid = ?", accountId);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto isBlack   = rset->get<bool>("blacklist");
        const auto listIndex = rset->get<uint8>("list_index");
        auto       order     = head.friendOrder[listIndex];
        if (isBlack)
        {
            order = head.blackOrder[listIndex];
        }

        if (rset->get<uint8>("display_order") == order)
        {
            continue;
        }

        run("UPDATE accounts_friends SET display_order = ? WHERE accid = ? AND blacklist = ? AND list_index = ?", order, accountId, isBlack, listIndex);
    }
}

// throws so the transaction rolls back
auto visibleIds(const uint32 accountId) -> std::set<uint32>
{
    const auto visible = visibleFriends(accountId);
    if (!visible)
    {
        throw std::runtime_error("friend visibility query failed");
    }

    return *visible | std::views::transform(&Friend::accountId) | std::ranges::to<std::set>();
}

} // namespace

auto load(const uint32 accountId) -> ErrorOr<std::vector<FriendInfo>>
{
    const auto rset = db::preparedStmt("SELECT blacklist, list_index, friend_accid, display_order, name, pending FROM accounts_friends WHERE accid = ? ORDER BY blacklist, list_index",
                                       accountId);
    if (!rset)
    {
        return Error("friend list query failed");
    }

    auto entries = std::vector<FriendInfo>{};
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto friendAccountId = rset->get<uint32>("friend_accid");

        // same as retail: kind 1, Group 0xE, no characters
        auto& entry = entries.emplace_back(FriendInfo{
            .op         = friendOpSet,
            .isBlack    = rset->get<bool>("blacklist"),
            .kind       = 1,
            .handleId   = friendAccountId,
            .Group      = 0xE,
            .bTemporary = rset->get<bool>("pending"),
            .Num        = rset->get<uint8>("list_index"),
            .Order      = rset->get<uint8>("display_order"),
            .PolId      = friendAccountId,
        });

        const auto name = rset->get<std::string>("name");
        std::memcpy(entry.handleName, name.data(), std::min(name.size(), sizeof(entry.handleName) - 1));
    }

    return entries;
}

auto store(const uint32 accountId, const StoreFriendListHead& head, const std::span<FriendInfo> entries) -> Maybe<StoreResult>
{
    auto       before    = std::set<uint32>{};
    auto       after     = std::set<uint32>{};
    const auto committed = db::transaction(
        [&]()
        {
            before = visibleIds(accountId);
            for (auto& entry : entries)
            {
                entry.result = 1;
                if (apply(accountId, entry))
                {
                    entry.result = 0;
                }
            }

            applyOrder(accountId, head);
            after = visibleIds(accountId);
        });

    if (!committed)
    {
        return std::nullopt;
    }

    auto result = StoreResult{};
    std::ranges::set_difference(after, before, std::back_inserter(result.accepted));
    std::ranges::set_difference(before, after, std::back_inserter(result.lost));
    return result;
}

auto blocks(const uint32 accountId, const uint32 otherAccountId) -> Maybe<bool>
{
    const auto rset = db::preparedStmt("SELECT list_index FROM accounts_friends WHERE accid = ? AND blacklist = 1 AND friend_accid = ?", accountId, otherAccountId);
    if (!rset)
    {
        return std::nullopt;
    }

    return rset->next();
}

auto accept(const uint32 accountId, const uint32 otherAccountId) -> bool
{
    const auto rset = run("UPDATE accounts_friends SET pending = 0 "
                          "WHERE blacklist = 0 AND pending = 1 "
                          "AND ((accid = ? AND friend_accid = ?) OR (accid = ? AND friend_accid = ?))",
                          accountId,
                          otherAccountId,
                          otherAccountId,
                          accountId);
    return rset->rowsAffected() > 0;
}

void dropPending(const uint32 accountId, const uint32 otherAccountId)
{
    run("DELETE FROM accounts_friends WHERE accid = ? AND blacklist = 0 AND friend_accid = ? AND pending = 1", accountId, otherAccountId);
}

auto visibleFriends(const uint32 accountId) -> ErrorOr<std::vector<Friend>>
{
    const auto rset = db::preparedStmt("SELECT mine.friend_accid, mine.list_index AS my_index, theirs.list_index AS their_index, sessions.charid AS playing "
                                       "FROM accounts_friends mine "
                                       "JOIN accounts_friends theirs ON theirs.accid = mine.friend_accid AND theirs.blacklist = 0 AND theirs.friend_accid = mine.accid AND theirs.pending = 0 "
                                       "LEFT JOIN accounts_sessions sessions ON sessions.accid = mine.friend_accid "
                                       "WHERE mine.accid = ? AND mine.blacklist = 0 AND mine.pending = 0 "
                                       "AND NOT EXISTS (SELECT 1 FROM accounts_friends blocked WHERE blocked.accid = mine.accid AND blocked.blacklist = 1 AND blocked.friend_accid = mine.friend_accid) "
                                       "AND NOT EXISTS (SELECT 1 FROM accounts_friends blocked WHERE blocked.accid = mine.friend_accid AND blocked.blacklist = 1 AND blocked.friend_accid = mine.accid)",
                                       accountId);
    if (!rset)
    {
        return Error("friend visibility query failed");
    }

    auto result = std::vector<Friend>{};
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        auto& visible = result.emplace_back(Friend{
            .accountId  = rset->get<uint32>("friend_accid"),
            .listIndex  = rset->get<uint8>("my_index"),
            .theirIndex = rset->get<uint8>("their_index"),
        });

        if (!rset->isNull("playing"))
        {
            visible.playing = rset->get<uint32>("playing");
        }
    }

    return result;
}

} // namespace profile::friends
