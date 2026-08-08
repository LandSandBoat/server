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

#pragma once

#include <common/scheduler.h>
#include <common/tracy.h>

#include <common/types/fn.h>

#include <common/database/binding.h>
#include <common/database/bound_value.h>
#include <common/database/result_set.h>

#include <fmt/format.h>

#include <memory>
#include <string>
#include <string_view>
#include <tuple>
#include <type_traits>
#include <utility>

// @note Everything in sql:: database-land is 1-indexed, not 0-indexed.
namespace db
{

class Database
{
public:
    virtual ~Database() = default;

    // Execute a query with the given pre-lowered parameters.
    // Returns a queryable result set for SELECT-like queries, a rows-affected result set for
    // UPDATE-like queries, or nullptr if the query is invalid.
    virtual auto execute(const std::string& query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> = 0;

    // As execute, but sends every row of `params` in one round trip.
    //
    // Row width comes from the statement's own placeholder count, so `params` must be a whole number of rows.
    virtual auto executeBulk(const std::string& query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> = 0;

    // The database name, ie. xidb.
    virtual auto getSchema() -> std::string = 0;

    // The version of the database software, ie. MariaDB 10.6.12-MariaDB.
    virtual auto getVersion() -> std::string = 0;

    // The version of the database driver, ie. MariaDB Connector/C++ 1.0.3.
    virtual auto getDriverVersion() -> std::string = 0;
};

// Get the active database backend.
auto getDatabase() -> Database&;

// Override the active database backend (intended for tests/benchmarks). Pass nullptr to restore the
// default backend.
auto setDatabase(Database* database) -> void;

// @brief Execute a prepared statement with the given query string and arguments.
// @param query The query string to execute.
// @param args The arguments to bind to the prepared statement.
// @return A unique pointer to the result set of the query.
// @note If the query hasn't been seen before it will generate a prepared statement for it to be used immediately and in the future.
// @note Everything in database-land is 1-indexed, not 0-indexed.
template <typename... Args>
auto preparedStmt(const std::string& rawQuery, Args&&... args) -> std::unique_ptr<ResultSet>;

template <typename... Args>
auto preparedStmt(Scheduler& scheduler, const std::string& rawQuery, Args&&... args) -> Task<std::unique_ptr<ResultSet>>;

// Send every row of `rows` through `query` in one round trip.
//
// `project` turns one row into a tuple of values, one per placeholder, and every row must yield the same types.
// Numeric columns only.
template <typename T, typename ProjectFn>
void executeBulk(const std::string& query, const std::vector<T>& rows, ProjectFn project);

auto escapeString(std::string_view str) -> std::string;
auto escapeString(const std::string& str) -> std::string;
auto escapeString(const char* str) -> std::string;

auto getDatabaseSchema() -> std::string;

auto getDatabaseVersion() -> std::string;

auto getDriverVersion() -> std::string;

auto checkCharset() -> void;
auto checkTriggers() -> void;

auto setAutoCommit(bool value) -> bool;
auto getAutoCommit() -> bool;

auto transactionStart() -> bool;
auto transactionCommit() -> bool;
auto transactionRollback() -> bool;

auto enableTimers() -> void;

// Execute a transaction with the given transaction function.
//
// Will handle maintenance of the autocommit state and rollback the transaction if the transaction
// function throws. Otherwise will commit the transaction on successful completion of the function.
//
// Returns true if the transaction was successful and committed or false if it was rolled back.
auto transaction(const Fn<void() const>& transactionFn) -> bool;

auto getTableColumnNames(const std::string& tableName) -> std::vector<std::string>;

//
// Out-of-line template definitions
//

template <typename... Args>
auto preparedStmt(const std::string& rawQuery, Args&&... args) -> std::unique_ptr<ResultSet>
{
    TracyZoneScoped;
    TracyZoneString(rawQuery);

    const auto params = detail::lowerBoundValues(std::forward<Args>(args)...);
    return getDatabase().execute(rawQuery, params);
}

template <typename T, typename ProjectFn>
void executeBulk(const std::string& query, const std::vector<T>& rows, ProjectFn project)
{
    TracyZoneScoped;

    if (rows.empty())
    {
        return;
    }

    using Row = std::remove_cvref_t<decltype(project(rows.front()))>;

    std::vector<BoundValue> params;
    params.reserve(rows.size() * std::tuple_size_v<Row>);

    for (const auto& row : rows)
    {
        std::apply(
            [&](const auto&... values)
            {
                (detail::lowerBoundValue(params, values), ...);
            },
            project(row));
    }

    getDatabase().executeBulk(query, params);
}

template <typename... Args>
auto preparedStmt(Scheduler& scheduler, const std::string& rawQuery, Args&&... args) -> Task<std::unique_ptr<ResultSet>>
{
    co_return scheduler.spawnOnWorkerThread(
        [rawQuery, ... capturedArgs = std::forward<Args>(args)]() mutable
        {
            return db::preparedStmt(rawQuery, std::forward<Args>(capturedArgs)...);
        });
}

} // namespace db
