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

#include <common/database/caching_database.h>

#include <common/database/query_validation.h>

#include <common/logging.h>
#include <common/settings.h>
#include <common/timer.h>
#include <common/tracy.h>
#include <common/xi.h>

#include <common/types/fn.h>
#include <common/types/hash_map.h>

#include <algorithm>
#include <atomic>
#include <chrono>
#include <mutex>
#include <thread>
using namespace std::chrono_literals;

namespace
{

// Per-(thread, backend instance) connection state. thread_local keeps each worker thread on its own
// connection; keying by the backend pointer lets multiple backends coexist in one process.
thread_local HashMap<const db::CachingDatabase*, db::detail::ConnectionState> tlsStates;

bool timersEnabled = false;

// Each cached statement holds one of the server's max_prepared_stmt_count slots until its connection closes.
std::once_flag           statementLimitRead;
std::atomic<std::size_t> maxCachedStatements{ 2048U };

// Emit a slow-query log line on scope exit if the query exceeded the configured thresholds.
auto makeQueryTimer(const std::string& query) -> xi::final_action<Fn<void()>>
{
    const auto start = timer::now();
    return xi::finally<Fn<void()>>(
        [query, start]() -> void
        {
            if (!timersEnabled || !settings::get<bool>("logging.SQL_SLOW_QUERY_LOG_ENABLE"))
            {
                return;
            }

            const auto duration = timer::count_milliseconds(timer::now() - start);
            if (duration > settings::get<uint32>("logging.SQL_SLOW_QUERY_ERROR_TIME"))
            {
                ShowError(fmt::format("SQL query took {}ms: {}", duration, query));
            }
            else if (duration > settings::get<uint32>("logging.SQL_SLOW_QUERY_WARNING_TIME"))
            {
                ShowWarning(fmt::format("SQL query took {}ms: {}", duration, query));
            }
        });
}

} // namespace

auto db::CachingDatabase::getState() -> detail::ConnectionState&
{
    TracyZoneScoped;

    auto& state = tlsStates[this];
    if (state.connection == nullptr)
    {
        state.connection = createConnection();
        state.statements.clear();

        std::call_once(
            statementLimitRead,
            [&]
            {
                // Runs outside runWithRetry, so a dropped connection here must not escape: keep the default cap.
                try
                {
                    const auto query = std::string("SELECT @@max_prepared_stmt_count");
                    const auto rset  = state.connection->prepare(query)->executeQuery(query);
                    if (rset && rset->next())
                    {
                        const auto serverLimit = rset->get<uint32>(0);
                        maxCachedStatements    = std::min<std::size_t>(maxCachedStatements, serverLimit);
                        ShowInfoFmt("Server allows {} prepared statements, caching up to {} per connection", serverLimit, maxCachedStatements.load());
                    }
                }
                catch (const std::exception& e)
                {
                    ShowWarningFmt("Could not read max_prepared_stmt_count, caching up to {} statements per connection: {}", maxCachedStatements.load(), e.what());
                }
            });
    }

    if (const auto generation = purgeGeneration_.load(); state.purgeGeneration != generation)
    {
        state.statements.clear();
        state.purgeGeneration = generation;
    }

    return state;
}

// Find-or-prepare the cached statement for this query on the given connection.
auto db::CachingDatabase::prepareCached(detail::ConnectionState& connState, const std::string& rawQuery) -> PreparedStatement&
{
    auto it = connState.statements.find(rawQuery);
    if (it == connState.statements.end())
    {
        if (connState.statements.size() >= maxCachedStatements)
        {
            ShowWarningFmt("Prepared statement cache full, clearing it. A query is likely being built from runtime values: {}", rawQuery);
            connState.statements.clear();
        }

        it = connState.statements.emplace(rawQuery, connState.connection->prepare(rawQuery)).first;
    }

    return *it->second;
}

auto db::CachingDatabase::runWithRetry(const std::string& rawQuery, const Fn<std::unique_ptr<ResultSet>(detail::ConnectionState&) const>& operation) -> std::unique_ptr<ResultSet>
{
    if (detail::validateQueryLeadingKeyword(rawQuery) == ResultSetType::Invalid)
    {
        ShowErrorFmt("Invalid query: {}", rawQuery);
        return nullptr;
    }

    if (!detail::validateQueryContent(rawQuery))
    {
        ShowErrorFmt("Invalid query content: {}", rawQuery);
        return nullptr;
    }

    auto& state = getState();

    const auto queryRetryCount = 1 + settings::get<uint32>("network.SQL_QUERY_RETRY_COUNT");
    for (auto i = 0U; i < queryRetryCount; ++i)
    {
        try
        {
            if (i > 0)
            {
                ShowInfo("Connection lost, re-establishing connection and retrying query (attempt %d)", i);
                state.statements.clear();
                state.connection = createConnection();
            }

            return operation(state);
        }
        catch (const std::exception& e)
        {
            if (state.connection == nullptr || !state.connection->isConnectionError(e))
            {
                ShowErrorFmt("Query Failed: {}", rawQuery);
                ShowErrorFmt("{}", e.what());
                return nullptr;
            }

            // reconnect starts in autocommit, retrying would commit this statement on its own
            if (state.inTransaction)
            {
                ShowErrorFmt("Connection lost mid-transaction, not retrying: {}", rawQuery);
                ShowErrorFmt("{}", e.what());
                return nullptr;
            }
        }
    }

    ShowCritical("Query Failed after %d retries: %s", queryRetryCount, rawQuery.c_str());
    std::this_thread::sleep_for(1s);
    std::terminate();
}

auto db::CachingDatabase::execute(const std::string& rawQuery, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet>
{
    TracyZoneScopedS(16);
    TracyZoneString(rawQuery);

    const auto queryType = detail::validateQueryLeadingKeyword(rawQuery);

    const auto operation = [&](detail::ConnectionState& connState) -> std::unique_ptr<ResultSet>
    {
        auto& stmt = prepareCached(connState, rawQuery);

        DebugSQLFmt("preparedStmt: {}", rawQuery);

        // NOTE: Everything is 1-indexed.
        int counter = 0;
        for (const auto& param : params)
        {
            stmt.bind(++counter, param);
        }

        const auto queryTimer = makeQueryTimer(rawQuery);

        if (queryType == ResultSetType::Select)
        {
            return stmt.executeQuery(rawQuery);
        }

        return stmt.executeUpdate(rawQuery);
    };

    return runWithRetry(rawQuery, operation);
}

auto db::CachingDatabase::executeBulk(const std::string& rawQuery, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet>
{
    TracyZoneScoped;
    TracyZoneString(rawQuery);

    const auto operation = [&](detail::ConnectionState& connState) -> std::unique_ptr<ResultSet>
    {
        auto& stmt = prepareCached(connState, rawQuery);

        const auto queryTimer = makeQueryTimer(rawQuery);

        return stmt.executeBulkUpdate(rawQuery, params);
    };

    return runWithRetry(rawQuery, operation);
}

void db::CachingDatabase::setInTransaction(bool value)
{
    getState().inTransaction = value;
}

void db::CachingDatabase::clearStatementCache()
{
    if (const auto it = tlsStates.find(this); it != tlsStates.end())
    {
        ShowInfoFmt("Closing {} cached prepared statements", it->second.statements.size());
        it->second.statements.clear();
    }
}

void db::CachingDatabase::purgeStatementCaches()
{
    ++purgeGeneration_;
}

auto db::CachingDatabase::getSchema() -> std::string
{
    TracyZoneScoped;

    return getState().connection->schema();
}

auto db::CachingDatabase::getVersion() -> std::string
{
    TracyZoneScoped;

    return getState().connection->version();
}

auto db::CachingDatabase::getDriverVersion() -> std::string
{
    TracyZoneScoped;

    return getState().connection->driverVersion();
}

auto db::enableTimers() -> void
{
    timersEnabled = true;
}
