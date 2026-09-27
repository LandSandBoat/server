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

namespace profile
{

auto PresenceManager::signOn(const uint32 accountId, const SessionHash& sessionHash, IrcSession* session) -> uint64
{
    auto& online = online_[accountId];
    if (online.session != nullptr)
    {
        online.session->close();
    }

    online.session     = session;
    online.sessionHash = sessionHash;
    online.signOnId    = ++lastSignOnId_;
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

void PresenceManager::refreshCredentials() const
{
    for (const auto& [accountId, online] : online_)
    {
        accounts::refresh(accountId, online.sessionHash);
    }
}

} // namespace profile
