/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#include "database.h"

#include "logging.h"
#include "settings.h"
#include "taskmgr.h"

#include <chrono>
using namespace std::chrono_literals;

namespace
{
    // TODO: Manual checkout and pooling of state
    // Each thread gets its own connection, so we don't need to worry about thread safety.
    thread_local mutex_guarded<db::detail::State> state;

    // Replacement map similar to str_replace in PHP
    const std::unordered_map<char, std::string> replacements = {
        { '\\', "\\\\" },
        { '\0', "\\0" },
        { '\n', "\\n" },
        { '\r', "\\r" },
        { '\'', "\\'" },
        { '\"', "\\\"" },
        { '\x1a', "\\Z" }
    };

    const std::vector<std::string> connectionIssues = {
        "Lost connection",
        "Server has gone away",
        "Connection refused",
        "Can't connect to server",
    };

    bool timersEnabled = false;
} // namespace

auto db::getConnection() -> std::unique_ptr<sql::Connection>
{
    try
    {
        auto login  = settings::get<std::string>("network.SQL_LOGIN");
        auto passwd = settings::get<std::string>("network.SQL_PASSWORD");
        auto host   = settings::get<std::string>("network.SQL_HOST");
        auto port   = settings::get<uint16>("network.SQL_PORT");
        auto schema = settings::get<std::string>("network.SQL_DATABASE");
        auto url    = fmt::format("tcp://{}:{}/{}", host, port, schema);

        return std::unique_ptr<sql::Connection>(sql::mariadb::get_driver_instance()->connect(url.c_str(), login.c_str(), passwd.c_str()));
    }
    catch (const std::exception& e)
    {
        // If we can't establish a connection to the database we can't do anything.
        // Time to die!
        ShowCritical("!!! Failed to connect to database, terminating server !!!");
        ShowCritical(e.what());
        std::this_thread::sleep_for(1s);
        std::terminate();
    }
}

auto db::detail::isConnectionIssue(const std::exception& e) -> bool
{
    const auto str = fmt::format("{}", e.what());
    for (const auto& issue : connectionIssues)
    {
        if (str.find(issue) != std::string::npos)
        {
            return true;
        }
    }

    return false;
}

mutex_guarded<db::detail::State>& db::detail::getState()
{
    TracyZoneScoped;

    // NOTE: mariadb-connector-cpp doesn't seem to make any guarantees about whether or not isValid()
    //     : is const. So we're going to have to wrap calls to it as though they aren't.

    // clang-format off
    if (state.read([&](auto& state)
    {
        return state.connection != nullptr;
    }))
    {
        return state;
    }

    // Otherwise, create a new connection. Writing it to the state.connection unique_ptr will release any previous connection
    // that might be there.

    state.write([&](auto& state)
    {
        state.reset();
    });
    // clang-format on

    return state;
}

auto db::detail::timer(std::string const& query) -> xi::final_action<std::function<void()>>
{
    // clang-format off
    const auto start = hires_clock::now();
    return xi::finally<std::function<void()>>([query, start]() -> void
    {
        const auto end      = hires_clock::now();
        const auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
        if (timersEnabled && settings::get<bool>("logging.SQL_SLOW_QUERY_LOG_ENABLE"))
        {
            if (duration > settings::get<uint32>("logging.SQL_SLOW_QUERY_ERROR_TIME"))
            {
                ShowError(fmt::format("SQL query took {}ms: {}", duration, query));
            }
            else if (duration > settings::get<uint32>("logging.SQL_SLOW_QUERY_WARNING_TIME"))
            {
                ShowWarning(fmt::format("SQL query took {}ms: {}", duration, query));
            }
        }
    });
    // clang-format on
}

auto db::queryStr(std::string const& rawQuery) -> std::unique_ptr<db::detail::ResultSetWrapper>
{
    TracyZoneScoped;
    TracyZoneString(rawQuery);

    // clang-format off
    return detail::getState().write([&](detail::State& state) -> std::unique_ptr<db::detail::ResultSetWrapper>
    {
        const auto operation = [&]() -> std::unique_ptr<db::detail::ResultSetWrapper>
        {
            auto stmt = state.connection->createStatement();

            DebugSQL(fmt::format("query: {}", rawQuery));
            auto queryTimer = detail::timer(rawQuery);
            auto rset       = std::unique_ptr<sql::ResultSet>(stmt->executeQuery(rawQuery.data()));
            return std::make_unique<db::detail::ResultSetWrapper>(std::move(rset), rawQuery);
        };

        const auto queryRetryCount = 1 + settings::get<uint32>("network.SQL_QUERY_RETRY_COUNT");
        for (auto i = 0U; i < queryRetryCount; ++i)
        {
            try
            {
                if (i > 0)
                {
                    ShowInfo("Connection lost, re-establishing connection and retrying query (attempt %d)", i);
                    state.reset();
                }
                return operation();
            }
            catch (const std::exception& e)
            {
                if (!detail::isConnectionIssue(e))
                {
                    ShowError("Query Failed: %s", rawQuery.c_str());
                    ShowError(e.what());
                    return nullptr;
                }
            }
        }

        ShowCritical("Query Failed after %d retries: %s", queryRetryCount, rawQuery.c_str());
        std::this_thread::sleep_for(std::chrono::seconds(1));
        std::terminate();
    });
    // clang-format on
}

auto db::escapeString(std::string const& str) -> std::string
{
    std::string escapedStr;

    for (size_t i = 0; i < str.size(); ++i)
    {
        const char c = str[i];

        // Emulate original strlen-based SqlConnection::EscapeString
        if (c == '\0')
        {
            break;
        }

        auto it = replacements.find(c);
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

auto db::getDatabaseSchema() -> std::string
{
    TracyZoneScoped;

    // clang-format off
    return detail::getState().write([&](detail::State& state) -> std::string
    {
        return state.connection->getSchema().c_str();
    });
    // clang-format on
}

auto db::getDatabaseVersion() -> std::string
{
    TracyZoneScoped;

    // clang-format off
    return detail::getState().write([&](detail::State& state) -> std::string
    {
        const auto metadata = state.connection->getMetaData();
        return fmt::format("{} {}", metadata->getDatabaseProductName().c_str(), metadata->getDatabaseProductVersion().c_str());
    });
    // clang-format on
}

auto db::getDriverVersion() -> std::string
{
    TracyZoneScoped;

    // clang-format off
    return detail::getState().write([&](detail::State& state) -> std::string
    {
        const auto metadata = state.connection->getMetaData();
        return fmt::format("{} {}", metadata->getDriverName().c_str(), metadata->getDriverVersion().c_str());
    });
    // clang-format on
}

void db::checkCharset()
{
    TracyZoneScoped;

    // Check that the SQL charset is what we require
    auto rset = query("SELECT @@character_set_database, @@collation_database");
    if (rset && rset->rowsCount())
    {
        bool foundError = false;
        while (rset->next())
        {
            auto charsetSetting   = rset->get<std::string>(0);
            auto collationSetting = rset->get<std::string>(1);
            if (!starts_with(charsetSetting, "utf8") || !starts_with(collationSetting, "utf8"))
            {
                foundError = true;
                // clang-format off
                ShowWarning(fmt::format("Unexpected character_set or collation setting in database: {}: {}. Expected utf8*.",
                    charsetSetting, collationSetting).c_str());
                // clang-format on
            }
        }

        if (foundError)
        {
            ShowWarning("Non utf8 charset can result in data reads and writes being corrupted!");
            ShowWarning("Non utf8 collation can be indicative that the database was not set up per required specifications.");
        }
    }
}

void db::checkTriggers()
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
        auto rset = preparedStmt(triggerQuery, trigger);
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

bool db::setAutoCommit(bool value)
{
    TracyZoneScoped;

    if (!query("SET @@autocommit = %u", (value) ? 1 : 0))
    {
        // TODO: Logging
        return false;
    }

    return true;
}

bool db::getAutoCommit()
{
    TracyZoneScoped;

    auto rset = query("SELECT @@autocommit");
    if (rset && rset->rowsCount() && rset->next())
    {
        return rset->get<uint32>(0) == 1;
    }

    // TODO: Logging
    return false;
}

bool db::transactionStart()
{
    TracyZoneScoped;

    if (!query("START TRANSACTION"))
    {
        // TODO: Logging
        return false;
    }

    return true;
}

bool db::transactionCommit()
{
    TracyZoneScoped;

    if (!query("COMMIT"))
    {
        // TODO: Logging
        return false;
    }

    return true;
}

bool db::transactionRollback()
{
    TracyZoneScoped;

    if (!query("ROLLBACK"))
    {
        // TODO: Logging
        return false;
    }

    return true;
}

void db::enableTimers()
{
    timersEnabled = true;
}
