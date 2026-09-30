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

#include "data/accounts.h"

#include "common/database.h"
#include "common/macros.h"

namespace profile::accounts
{

auto freshness(const Credential& credential) -> Maybe<bool>
{
    // blobs bind from a mutable value
    auto hash = credential.sessionHash;

    // banned accounts lose profile access too
    const auto rset = db::preparedStmt("SELECT sessions.refreshed > NOW() - INTERVAL 2 HOUR AS fresh FROM accounts_profile sessions "
                                       "JOIN accounts ON accounts.id = sessions.accid "
                                       "WHERE sessions.accid = ? AND sessions.session_hash = ? AND accounts.status & 1",
                                       credential.accountId,
                                       hash);
    if (!rset || !rset->next())
    {
        return std::nullopt;
    }

    return rset->get<bool>("fresh");
}

void refresh(const uint32 accountId, const SessionHash& sessionHash)
{
    // blobs bind from a mutable value
    auto hash = sessionHash;
    db::preparedStmt("UPDATE accounts_profile SET refreshed = NOW() WHERE accid = ? AND session_hash = ?", accountId, hash);
}

auto udpPortSlot(const Credential& credential) -> uint16
{
    auto hash = credential.sessionHash;

    const auto rset = db::preparedStmt("SELECT udp_port_slot FROM accounts_profile WHERE accid = ? AND session_hash = ?", credential.accountId, hash);
    FOR_DB_SINGLE_RESULT(rset)
    {
        return rset->get<uint16>("udp_port_slot");
    }

    return 0;
}

auto exists(const uint32 accountId) -> bool
{
    const auto rset = db::preparedStmt("SELECT id FROM accounts WHERE id = ?", accountId);
    return rset && rset->next();
}

auto openStatus(const uint32 accountId) -> Maybe<OpenStatus>
{
    const auto rset = db::preparedStmt("SELECT open_status FROM accounts_profile WHERE accid = ?", accountId);
    if (!rset)
    {
        return std::nullopt;
    }

    if (!rset->next())
    {
        return OpenStatus::Online;
    }

    switch (const auto stored = static_cast<OpenStatus>(rset->get<uint8>("open_status")))
    {
        case OpenStatus::Online:
        case OpenStatus::Away:
        case OpenStatus::Invisible:
            return stored;
        default:
            return OpenStatus::Online;
    }
}

auto setOpenStatus(const uint32 accountId, const OpenStatus status) -> bool
{
    return db::preparedStmt("UPDATE accounts_profile SET open_status = ? WHERE accid = ?", static_cast<uint8>(status), accountId) != nullptr;
}

auto characters(const uint32 accountId) -> ErrorOr<std::vector<Character>>
{
    const auto rset = db::preparedStmt("SELECT charid, charname FROM chars WHERE accid = ? ORDER BY charid", accountId);
    if (!rset)
    {
        return Error("character query failed");
    }

    auto result = std::vector<Character>{};
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        result.push_back({
            .id   = rset->get<uint32>("charid"),
            .name = rset->get<std::string>("charname"),
        });
    }

    return result;
}

auto playing(const uint32 accountId) -> Maybe<uint32>
{
    const auto rset = db::preparedStmt("SELECT charid FROM accounts_sessions WHERE accid = ?", accountId);
    if (!rset || !rset->next())
    {
        return std::nullopt;
    }

    return rset->get<uint32>("charid");
}

auto characterOwner(const uint32 characterId) -> Maybe<Owner>
{
    const auto rset = db::preparedStmt("SELECT chars.accid, chars.charname FROM chars "
                                       "JOIN accounts_sessions sessions ON sessions.charid = chars.charid "
                                       "WHERE chars.charid = ?",
                                       characterId);
    if (!rset || !rset->next())
    {
        return std::nullopt;
    }

    return Owner{
        .accountId     = rset->get<uint32>("accid"),
        .characterName = rset->get<std::string>("charname"),
    };
}

} // namespace profile::accounts
