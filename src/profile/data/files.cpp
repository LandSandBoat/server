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

constexpr uint32 kOwnFileLimit  = 32;
constexpr uint64 kOwnBytesLimit = 0x800000;

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

} // namespace

auto read(const uint32 accountId, const std::string& path) -> ErrorOr<Maybe<std::string>>
{
    const auto rset = db::preparedStmt("SELECT data FROM accounts_files WHERE accid = ? AND path = ?", accountId, path);
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
    if (path.size() >= sizeof(ProfFileInfo::name) || static_cast<uint64>(offset) + data.size() > fileSizeLimit)
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

auto erase(const uint32 accountId, const std::string& path) -> bool
{
    return db::preparedStmt("DELETE FROM accounts_files WHERE accid = ? AND path = ?", accountId, path) != nullptr;
}

auto list(const uint32 accountId, const std::string_view directory, const uint16 limit) -> Maybe<std::vector<ProfFileInfo>>
{
    const auto rset = db::preparedStmt("SELECT SUBSTRING(path, ?) AS name, LENGTH(data) AS size, UNIX_TIMESTAMP(updated) AS updated FROM accounts_files "
                                       "WHERE accid = ? AND LEFT(path, ?) = ? ORDER BY updated, path LIMIT ?",
                                       static_cast<uint32>(directory.size() + 1),
                                       accountId,
                                       static_cast<uint32>(directory.size()),
                                       std::string(directory),
                                       static_cast<uint32>(limit));

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
