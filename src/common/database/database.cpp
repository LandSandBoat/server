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

#include <common/database/database.h>

#include <common/database/query_validation.h>

#include <common/logging.h>
#include <common/macros.h>
#include <common/xi.h>

#include <common/types/fn.h>

#include <algorithm>
#include <array>
#include <cctype>
#include <chrono>
#include <thread>
#include <utility>
using namespace std::chrono_literals;

auto db::detail::validateQueryLeadingKeyword(std::string_view query) -> ResultSetType
{
    constexpr auto whitespace = std::string_view(" \t\r\n");
    constexpr auto keywords   = std::array{
        std::pair{ std::string_view("SELECT"), ResultSetType::Select },
        std::pair{ std::string_view("SHOW"), ResultSetType::Select },
        std::pair{ std::string_view("INSERT"), ResultSetType::Update },
        std::pair{ std::string_view("UPDATE"), ResultSetType::Update },
        std::pair{ std::string_view("DELETE"), ResultSetType::Update },
        std::pair{ std::string_view("REPLACE"), ResultSetType::Update },
        std::pair{ std::string_view("CREATE"), ResultSetType::Update },
        std::pair{ std::string_view("ALTER"), ResultSetType::Update },
        std::pair{ std::string_view("DROP"), ResultSetType::Update },
        std::pair{ std::string_view("TRUNCATE"), ResultSetType::Update },
        std::pair{ std::string_view("SET"), ResultSetType::Update },
        std::pair{ std::string_view("START"), ResultSetType::Update },
        std::pair{ std::string_view("COMMIT"), ResultSetType::Update },
        std::pair{ std::string_view("ROLLBACK"), ResultSetType::Update },
    };

    const auto start = query.find_first_not_of(whitespace);
    if (start == std::string_view::npos)
    {
        return ResultSetType::Invalid;
    }

    query.remove_prefix(start);

    const auto keywordEnd = std::ranges::find_if_not(
        query,
        [](const char c)
        {
            return std::isalnum(static_cast<unsigned char>(c)) != 0 || c == '_';
        });
    const auto keyword = std::string_view(query.begin(), keywordEnd);

    for (const auto& [name, type] : keywords)
    {
        const auto matches = std::ranges::equal(
            name,
            keyword,
            [](const char upper, const char c)
            {
                return upper == std::toupper(static_cast<unsigned char>(c));
            });

        if (matches)
        {
            return type;
        }
    }

    return ResultSetType::Invalid;
}

auto db::detail::validateQueryContent(std::string_view query) -> bool
{
    // NOTE: We shouldn't be checking for the presence of '%', as this
    //     : is the SQL wildcard character.

    if (query.contains("{}"))
    {
        return false;
    }

    if (query.contains(';'))
    {
        return false;
    }

    return true;
}

auto db::getDatabaseSchema() -> std::string
{
    TracyZoneScoped;

    return db::getDatabase().getSchema();
}

auto db::getDatabaseVersion() -> std::string
{
    TracyZoneScoped;

    return db::getDatabase().getVersion();
}

auto db::getDriverVersion() -> std::string
{
    TracyZoneScoped;

    return db::getDatabase().getDriverVersion();
}

auto db::checkCharset() -> void
{
    TracyZoneScoped;

    // Check that the SQL charset is what we require
    const auto rset = preparedStmt("SELECT @@character_set_database, @@collation_database");
    if (rset && rset->rowsCount())
    {
        bool foundError = false;
        while (rset->next())
        {
            const auto charsetSetting   = rset->get<std::string>(0);
            const auto collationSetting = rset->get<std::string>(1);
            if (!charsetSetting.starts_with("utf8") || !collationSetting.starts_with("utf8"))
            {
                foundError = true;

                ShowWarning(
                    fmt::format("Unexpected character_set or collation setting in database: {}: {}. Expected utf8*.",
                                charsetSetting,
                                collationSetting)
                        .c_str());
            }
        }

        if (foundError)
        {
            ShowWarning("Non utf8 charset can result in data reads and writes being corrupted!");
            ShowWarning("Non utf8 collation can be indicative that the database was not set up per required specifications.");
        }
    }
}

auto db::checkTriggers() -> void
{
    constexpr auto triggerQuery = Query("SHOW TRIGGERS WHERE `Trigger` LIKE ?");

    constexpr auto triggers = std::array{
        "account_delete",
        "session_delete",
        "auction_house_list",
        "auction_house_buy",
        "char_insert",
        "char_delete",
        "delivery_box_insert",
        "ensure_synth_ingredients_are_ordered",
        "ensure_synergy_ingredients_are_ordered",
    };

    bool foundError = false;
    for (const auto& trigger : triggers)
    {
        const auto rset = preparedStmt(triggerQuery, trigger);
        if (!rset || rset->rowsCount() == 0)
        {
            ShowWarning(fmt::format("Missing trigger: {}", trigger));
            foundError = true;
        }
    }

    if (foundError)
    {
        ShowCriticalFmt("Missing triggers can result in data corruption or loss of data!!!");
        ShowCriticalFmt("Please ensure all triggers are present in the database (re-run dbtool.py).");
        std::this_thread::sleep_for(1s);
        std::terminate();
    }
}

namespace
{

auto transactionStart() -> bool
{
    TracyZoneScoped;

    if (!db::preparedStmt("START TRANSACTION"))
    {
        ShowError("Failed to start transaction");
        return false;
    }

    return true;
}

auto transactionCommit() -> bool
{
    TracyZoneScoped;

    if (!db::preparedStmt("COMMIT"))
    {
        ShowError("Failed to commit transaction");
        return false;
    }

    return true;
}

auto transactionRollback() -> bool
{
    TracyZoneScoped;

    if (!db::preparedStmt("ROLLBACK"))
    {
        ShowError("Failed to rollback transaction");
        return false;
    }

    return true;
}

} // namespace

auto db::transaction(const Fn<void() const>& transactionFn) -> bool
{
    TracyZoneScoped;

    if (!transactionStart())
    {
        return false;
    }

    // covers COMMIT/ROLLBACK too
    db::getDatabase().setInTransaction(true);
    const auto transactionScope = xi::finally(
        []
        {
            db::getDatabase().setInTransaction(false);
        });

    try
    {
        transactionFn();
    }
    catch (const std::exception& e)
    {
        ShowCriticalFmt("Transaction failed, rolling back: {}", e.what());

        transactionRollback();
        return false;
    }

    if (!transactionCommit())
    {
        ShowCritical("Transaction failed: COMMIT failed, rolling back!");

        transactionRollback();
        return false;
    }

    return true;
}

auto db::getTableColumnNames(const std::string& tableName) -> std::vector<std::string>
{
    TracyZoneScoped;

    const auto rset = db::preparedStmt("SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_NAME = ? AND TABLE_SCHEMA = ?", tableName, db::getDatabaseSchema());
    if (rset && rset->rowsCount())
    {
        std::vector<std::string> columnNames;
        while (rset->next())
        {
            columnNames.emplace_back(rset->get<std::string>(0));
        }

        return columnNames;
    }

    return {};
}

auto db::clearStatementCache() -> void
{
    getDatabase().clearStatementCache();
}

auto db::checkStatementUsage() -> void
{
    const auto rset = db::preparedStmt("SELECT CAST(VARIABLE_VALUE AS UNSIGNED) AS used, @@max_prepared_stmt_count AS max_count "
                                       "FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME = 'PREPARED_STMT_COUNT'");
    if (!rset || !rset->next())
    {
        ShowWarning("Could not read the server's prepared statement usage");
        return;
    }

    const auto used     = rset->get<uint64>("used");
    const auto maxCount = rset->get<uint64>("max_count");

    ShowInfoFmt("Prepared statements in use on the database server: {} of {}", used, maxCount);

    if (used * 4 >= maxCount * 3)
    {
        ShowWarningFmt("Prepared statements are at {} of {}, purging this process's statement caches", used, maxCount);
        getDatabase().purgeStatementCaches();
    }
}
