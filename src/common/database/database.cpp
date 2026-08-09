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

#include <common/logging.h>
#include <common/macros.h>
#include <common/utils.h>
#include <common/xi.h>

#include <common/types/fn.h>

#include <common/types/hash_map.h>

#include <chrono>
#include <thread>
using namespace std::chrono_literals;

auto db::escapeString(std::string_view str) -> std::string
{
    static const HashMap<char, std::string> replacements = {
        // Replacement map similar to str_replace in PHP
        { '\\', "\\\\" },
        { '\0', "\\0" },
        { '\n', "\\n" },
        { '\r', "\\r" },
        { '\'', "\\'" },
        { '\"', "\\\"" },
        { '\x1a', "\\Z" },

        // Extras
        { '\b', "\\b" },
        { '%', "\\%" },
        { '|', "\\|" },
        { ';', "\\;" },
    };

    std::string escapedStr;

    for (size_t i = 0; i < str.size(); ++i)
    {
        const char c = str[i];

        // Emulate original strlen-based SqlConnection::EscapeString
        if (c == '\0')
        {
            break;
        }

        const auto it = replacements.find(c);
        if (it != replacements.end())
        {
            escapedStr += it->second;
        }
        else
        {
            escapedStr += c;
        }
    }

    return escapedStr;
}

auto db::escapeString(const std::string& str) -> std::string
{
    if (str.empty())
    {
        return {};
    }

    return db::escapeString(std::string_view(str));
}

auto db::escapeString(const char* str) -> std::string
{
    if (str == nullptr)
    {
        return {};
    }

    return db::escapeString(std::string_view(str));
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
            if (!starts_with(charsetSetting, "utf8") || !starts_with(collationSetting, "utf8"))
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
    const auto triggerQuery = "SHOW TRIGGERS WHERE `Trigger` LIKE ?";

    const auto triggers = {
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

auto db::transactionStart() -> bool
{
    TracyZoneScoped;

    if (!db::preparedStmt("START TRANSACTION"))
    {
        ShowError("Failed to start transaction");
        return false;
    }

    return true;
}

auto db::transactionCommit() -> bool
{
    TracyZoneScoped;

    if (!db::preparedStmt("COMMIT"))
    {
        ShowError("Failed to commit transaction");
        return false;
    }

    return true;
}

auto db::transactionRollback() -> bool
{
    TracyZoneScoped;

    if (!db::preparedStmt("ROLLBACK"))
    {
        ShowError("Failed to rollback transaction");
        return false;
    }

    return true;
}

auto db::transaction(const Fn<void() const>& transactionFn) -> bool
{
    TracyZoneScoped;

    if (!db::transactionStart())
    {
        return false;
    }

    // covers COMMIT/ROLLBACK too
    db::getDatabase().setInTransaction(true);
    const auto transactionScope = xi::finally<Fn<void()>>(
        []() -> void
        {
            db::getDatabase().setInTransaction(false);
        });

    try
    {
        transactionFn();
    }
    catch (const std::exception& e)
    {
        ShowCritical("Transaction failed: Rolling back!");
        ShowCritical("Transaction failed: %s", e.what());

        db::transactionRollback();
        return false;
    }

    if (!db::transactionCommit())
    {
        ShowCritical("Transaction failed: COMMIT failed, rolling back!");

        db::transactionRollback();
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
