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
#include "irc/irc_session.h"

#include "common/logging.h"

#include <magic_enum/magic_enum.hpp>

namespace profile
{

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
    return online.signOnId;
}

void PresenceManager::signOff(const uint32 accountId, const uint64 signOnId)
{
    if (const auto online = online_.find(accountId); online != online_.end() && online->second.signOnId == signOnId)
    {
        online_.erase(online);
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

    online->second.status = status;
    return true;
}

} // namespace profile
