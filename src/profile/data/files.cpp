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

#include "data/files.h"

#include "protocol/bytes.h"

#include "common/database.h"
#include "common/macros.h"

#include <algorithm>
#include <cstring>

namespace profile::files
{

namespace
{

constexpr uint32 kOwnFileLimit       = 32;
constexpr uint64 kOwnBytesLimit      = 0x800000;
constexpr uint32 kMailboxLimit       = 100;
constexpr uint32 kMailboxSenderLimit = 10;
constexpr uint32 kSenderUnreadLimit  = 50;
constexpr uint32 kMessageSizeLimit   = 1024;

struct Usage
{
    uint32 files{};
    uint64 bytes{};
};

auto ownUsage(const uint32 accountId, const std::string& exceptPath) -> Usage
{
    const auto rset = db::preparedStmt("SELECT COUNT(*) AS files, COALESCE(SUM(LENGTH(data)), 0) AS bytes FROM accounts_files WHERE accid = ? AND path <> ?",
                                       accountId,
                                       exceptPath);
    if (!rset || !rset->next())
    {
        return { .files = kOwnFileLimit, .bytes = kOwnBytesLimit };
    }

    return { .files = rset->get<uint32>("files"), .bytes = rset->get<uint64>("bytes") };
}

// O/m/<name> lives in accounts_messages
auto messageName(const std::string& path) -> Maybe<std::string>
{
    if (!path.starts_with(mailbox))
    {
        return std::nullopt;
    }

    return path.substr(mailbox.size());
}

} // namespace

auto read(const uint32 accountId, const std::string& path) -> ErrorOr<Maybe<std::string>>
{
    const auto rset = [&]()
    {
        if (const auto name = messageName(path))
        {
            return db::preparedStmt("SELECT data FROM accounts_messages WHERE accid = ? AND name = ?", accountId, *name);
        }

        return db::preparedStmt("SELECT data FROM accounts_files WHERE accid = ? AND path = ?", accountId, path);
    }();

    if (!rset)
    {
        return Error("file query failed");
    }

    if (!rset->next())
    {
        return Maybe<std::string>{};
    }

    return Maybe<std::string>{ rset->getBlobBytes("data") };
}

auto write(const uint32 accountId, const std::string& path, const uint32 offset, const std::span<const uint8> data) -> bool
{
    // names that don't fit a file list entry
    if (messageName(path) || path.size() >= sizeof(ProfFileInfo::name) || static_cast<uint64>(offset) + data.size() > fileSizeLimit)
    {
        return false;
    }

    const auto usage = ownUsage(accountId, path);
    if (usage.files >= kOwnFileLimit || usage.bytes + offset + data.size() > kOwnBytesLimit)
    {
        return false;
    }

    if (offset == 0)
    {
        return db::preparedStmt("REPLACE INTO accounts_files(accid, path, data) VALUES(?, ?, ?)", accountId, path, asString(data)) != nullptr;
    }

    const auto rset = db::preparedStmt("UPDATE accounts_files SET data = CONCAT(data, ?) WHERE accid = ? AND path = ? AND LENGTH(data) = ?",
                                       asString(data),
                                       accountId,
                                       path,
                                       offset);
    return rset && rset->rowsAffected() == 1;
}

auto post(const uint32 senderAccountId, const uint32 recipientAccountId, const std::string& name, const MessageType type, const std::span<const uint8> data) -> bool
{
    if (name.size() >= sizeof(ProfFileInfo::name) || data.size() > kMessageSizeLimit)
    {
        return false;
    }

    const auto mailboxRset = db::preparedStmt("SELECT COUNT(*) AS messages, COALESCE(SUM(sender_accid = ?), 0) AS sent FROM accounts_messages WHERE accid = ?",
                                              senderAccountId,
                                              recipientAccountId);
    if (!mailboxRset || !mailboxRset->next() || mailboxRset->get<uint32>("messages") >= kMailboxLimit || mailboxRset->get<uint32>("sent") >= kMailboxSenderLimit)
    {
        return false;
    }

    // read messages are deleted, so whatever is left is unread
    const auto unreadRset = db::preparedStmt("SELECT COUNT(*) AS unread FROM accounts_messages WHERE sender_accid = ?", senderAccountId);
    if (!unreadRset || !unreadRset->next() || unreadRset->get<uint32>("unread") >= kSenderUnreadLimit)
    {
        return false;
    }

    const auto rset = db::preparedStmt("INSERT IGNORE INTO accounts_messages(accid, name, sender_accid, type, data) VALUES(?, ?, ?, ?, ?)",
                                       recipientAccountId,
                                       name,
                                       senderAccountId,
                                       static_cast<uint8>(type),
                                       asString(data));
    return rset && rset->rowsAffected() == 1;
}

auto erase(const uint32 accountId, const std::string& path) -> bool
{
    if (const auto name = messageName(path))
    {
        return db::preparedStmt("DELETE FROM accounts_messages WHERE accid = ? AND name = ?", accountId, *name) != nullptr;
    }

    return db::preparedStmt("DELETE FROM accounts_files WHERE accid = ? AND path = ?", accountId, path) != nullptr;
}

auto list(const uint32 accountId, const std::string_view directory, const uint16 limit) -> Maybe<std::vector<ProfFileInfo>>
{
    const auto rset = [&]()
    {
        if (directory == mailbox)
        {
            return db::preparedStmt("SELECT name, LENGTH(data) AS size, UNIX_TIMESTAMP(sent) AS updated FROM accounts_messages "
                                    "WHERE accid = ? ORDER BY sent, name LIMIT ?",
                                    accountId,
                                    static_cast<uint32>(limit));
        }

        return db::preparedStmt("SELECT SUBSTRING(path, ?) AS name, LENGTH(data) AS size, UNIX_TIMESTAMP(updated) AS updated FROM accounts_files "
                                "WHERE accid = ? AND LEFT(path, ?) = ? ORDER BY updated, path LIMIT ?",
                                static_cast<uint32>(directory.size() + 1),
                                accountId,
                                static_cast<uint32>(directory.size()),
                                std::string(directory),
                                static_cast<uint32>(limit));
    }();

    if (!rset)
    {
        return std::nullopt;
    }

    auto entries = std::vector<ProfFileInfo>{};
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        auto info = ProfFileInfo{
            .time = rset->get<uint32>("updated"),
            .size = rset->get<uint32>("size"),
        };
        const auto name = rset->get<std::string>("name");
        std::memcpy(info.name, name.data(), std::min(name.size(), sizeof(info.name) - 1));
        entries.push_back(info);
    }

    return entries;
}

} // namespace profile::files
