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

#include "irc/presence_manager.h"

#include "data/accounts.h"
#include "data/friends.h"
#include "irc/irc_session.h"
#include "protocol/irc/notices.h"

#include "common/logging.h"

#include <fmt/format.h>
#include <magic_enum/magic_enum.hpp>

#include <algorithm>
#include <chrono>
#include <ranges>

namespace profile
{

namespace
{

// invisible shows as offline
auto listStatus(const PresenceManager::Status& status) -> uint8
{
    switch (status.openStatus)
    {
        case OpenStatus::Online:
            return 1;
        case OpenStatus::Away:
            return 2;
        default:
            return 0;
    }
}

} // namespace

auto PresenceManager::signOn(const uint32 accountId, const SessionHash& sessionHash, IrcSession* session) -> uint64
{
    const auto [entry, signedOn] = online_.try_emplace(accountId);
    auto& online                 = entry->second;

    // restore the saved status so invisible stays invisible
    if (signedOn)
    {
        online.status.openStatus = accounts::openStatus(accountId).value_or(OpenStatus::Invisible);
    }

    if (online.session != nullptr)
    {
        online.session->close();
    }

    online.session     = session;
    online.sessionHash = sessionHash;
    online.signOnId    = ++lastSignOnId_;

    // the new client reports its character again
    online.status = Status{ .openStatus = online.status.openStatus, .receiveMessages = online.status.receiveMessages };
    announce(accountId);
    return online.signOnId;
}

void PresenceManager::signOff(const uint32 accountId, const uint64 signOnId)
{
    if (const auto online = online_.find(accountId); online != online_.end() && online->second.signOnId == signOnId)
    {
        online_.erase(online);
        announce(accountId);
    }
}

auto PresenceManager::isOnline(const uint32 accountId) const -> bool
{
    return online_.contains(accountId);
}

auto PresenceManager::status(const uint32 accountId) const -> Maybe<Status>
{
    if (const auto online = online_.find(accountId); online != online_.end())
    {
        return online->second.status;
    }

    return std::nullopt;
}

void PresenceManager::refreshCredentials() const
{
    for (const auto& [accountId, online] : online_)
    {
        accounts::refresh(accountId, online.sessionHash);
    }
}

auto PresenceManager::setStatus(const uint32 accountId, const Status& status) -> bool
{
    const auto online = online_.find(accountId);
    if (online == online_.end())
    {
        return false;
    }

    if (status.openStatus != online->second.status.openStatus)
    {
        if (!accounts::setOpenStatus(accountId, status.openStatus))
        {
            return false;
        }

        ShowInfoFmt("account {} changed status to {}", accountId, magic_enum::enum_name(status.openStatus));
    }

    // friends only see open status and in-game
    const auto changed    = status.openStatus != online->second.status.openStatus || status.inGame != online->second.status.inGame;
    online->second.status = status;
    if (changed)
    {
        announce(accountId);
    }

    return true;
}

void PresenceManager::sendFriendsTo(const uint32 accountId)
{
    const auto friendList = friends::visibleFriends(accountId);
    if (!friendList)
    {
        return;
    }

    for (const auto& visible : *friendList)
    {
        notify(visible.accountId, accountId, visible.listIndex, true, visible.playing);
    }
}

void PresenceManager::introduce(const uint32 accountId, const uint32 otherAccountId)
{
    const auto visible = friends::visibleFriends(accountId);
    if (!visible)
    {
        return;
    }

    if (const auto other = std::ranges::find(*visible, otherAccountId, &friends::Friend::accountId); other != visible->end())
    {
        notify(otherAccountId, accountId, other->listIndex, true, other->playing);
        notify(accountId, otherAccountId, other->theirIndex, true, playing(accountId));
    }
}

void PresenceManager::hide(const uint32 accountId, const uint32 otherAccountId)
{
    const auto visible = friends::visibleFriends(accountId);
    if (!visible || std::ranges::find(*visible, otherAccountId, &friends::Friend::accountId) != visible->end())
    {
        return;
    }

    const auto listings = friends::load(otherAccountId);
    if (!listings)
    {
        return;
    }

    for (const auto& listing : *listings)
    {
        if (listing.isBlack == 0 && listing.PolId == accountId)
        {
            notify(accountId, otherAccountId, listing.Num, false, std::nullopt);
        }
    }
}

void PresenceManager::deliverMessage(const uint32 senderAccountId, const uint32 recipientAccountId, const std::string_view name)
{
    if (!online_.contains(recipientAccountId))
    {
        DebugIRCFmt("account {} left a message for offline account {}", senderAccountId, recipientAccountId);
        return;
    }

    DebugIRCFmt("account {} notified of a message from account {}", recipientAccountId, senderAccountId);
    send(senderAccountId, recipientAccountId, messageNotice(name));
}

void PresenceManager::announce(const uint32 accountId)
{
    const auto friendList = friends::visibleFriends(accountId);
    if (!friendList)
    {
        return;
    }

    const auto character = playing(accountId);
    for (const auto& visible : *friendList)
    {
        notify(accountId, visible.accountId, visible.theirIndex, true, character);
    }
}

auto PresenceManager::playing(const uint32 accountId) const -> Maybe<uint32>
{
    if (const auto online = status(accountId); online && online->inGame)
    {
        return accounts::playing(accountId);
    }

    return std::nullopt;
}

void PresenceManager::notify(const uint32 subjectAccountId, const uint32 recipientAccountId, const uint8 listIndex, const bool visible, const Maybe<uint32> character)
{
    if (!online_.contains(recipientAccountId))
    {
        return;
    }

    auto notice = FriendStatusNotice{
        .friendAccountId = subjectAccountId,
        .listIndex       = listIndex,
        .timestamp       = nextTimestamp(),
    };

    if (const auto subject = status(subjectAccountId); subject && visible)
    {
        notice.status = listStatus(*subject);
        if (notice.status != 0 && subject->inGame)
        {
            notice.activeCharacterId = character;
        }
    }

    send(subjectAccountId, recipientAccountId, friendStatusNotice(notice));
}

void PresenceManager::send(const uint32 senderAccountId, const uint32 recipientAccountId, const std::string_view text)
{
    const auto recipient = online_.find(recipientAccountId);
    if (recipient == online_.end())
    {
        return;
    }

    if (recipient->second.session != nullptr)
    {
        recipient->second.session->send(fmt::format(":{}!p@pol NOTICE {} :{}", scrambleNick(senderAccountId), scrambleNick(recipientAccountId), text));
    }
}

// strictly increasing, the client drops stale notices
auto PresenceManager::nextTimestamp() -> uint64
{
    const auto now = static_cast<uint64>(std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count());
    lastTimestamp_ = std::max(now, lastTimestamp_ + 1);
    return lastTimestamp_;
}

} // namespace profile
