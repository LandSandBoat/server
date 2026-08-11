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
#include <common/database/query_string.h>
#include <common/database/result_set.h>

#include <fmt/format.h>

#include <memory>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <type_traits>
#include <utility>

// @note Bind parameters in database-land are 1-indexed; result-set columns are 0-indexed.
namespace db
{

class Database
{
public:
    virtual ~Database() = default;

    // Execute a query with the given pre-lowered parameters.
    // Returns a queryable result set for SELECT-like queries, a rows-affected result set for
    // UPDATE-like queries, or nullptr if the query is invalid.
    virtual auto execute(std::string_view query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> = 0;

    // As execute, but sends every row of `params` in one round trip.
    //
    // Row width comes from the statement's own placeholder count, so `params` must be a whole number of rows.
    virtual auto executeBulk(std::string_view query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> = 0;

    // The database name, ie. xidb.
    virtual auto getSchema() -> std::string = 0;

    // The version of the database software, ie. MariaDB 10.6.12-MariaDB.
    virtual auto getVersion() -> std::string = 0;

    // The version of the database driver, ie. MariaDB Connector/C++ 1.0.3.
    virtual auto getDriverVersion() -> std::string = 0;

    // Suppress the reconnect-and-retry path while a transaction is open.
    virtual void setInTransaction(bool)
    {
    }

    // Whether this thread's connection already has a transaction open.
    [[nodiscard]] virtual auto isInTransaction() -> bool
    {
        return false;
    }
};

// Get the active database backend.
auto getDatabase() -> Database&;

// Override the active database backend (intended for tests/benchmarks). Pass nullptr to restore the
// default backend.
auto setDatabase(Database* database) -> void;

// Execute a prepared statement with the given query string and arguments.
//
// A string-literal query is validated at compile time: leading keyword, forbidden characters, and
// '?' count against argument count. Wrap runtime-built text in db::runtime(...).
//
// A query seen for the first time is prepared, then cached on the connection and reused.
//
// @note Bind parameters are 1-indexed; result-set columns are 0-indexed.
template <typename... Args>
auto preparedStmt(QueryString<std::type_identity_t<Args>...> query, Args&&... args) -> std::unique_ptr<ResultSet>;

template <typename... Args>
auto preparedStmt(Scheduler& scheduler, QueryString<std::type_identity_t<Args>...> query, Args&&... args) -> Task<std::unique_ptr<ResultSet>>;

// Send every row of `rows` through `query` in one round trip.
//
// `project` turns one row into a tuple of values, one per placeholder, and every row must yield the same types.
// Numeric columns only.
//
// A string-literal query is validated against that tuple at compile time, exactly as for
// preparedStmt.
//
// Throws if the statement fails.
// Call it inside db::transaction, which turns the throw into a rollback.
template <typename T, typename ProjectFn>
void executeBulk(detail::BulkQueryString<T, ProjectFn> query, const std::vector<T>& rows, ProjectFn project);

// Build a "?, ?, ?" list with count placeholders, for IN (...) clauses whose values are bound
// from a std::vector parameter: preparedStmt binds one parameter per vector element.
[[nodiscard]] auto placeholders(std::size_t count) -> std::string;

namespace detail
{

// True while a db::transaction body is running on this thread.
//
// A statement that fails in that window throws, so db::transaction rolls the whole thing back.
// Outside a transaction a failed statement still just returns nullptr, as it always has.
[[nodiscard]] auto failuresThrow() noexcept -> bool;

} // namespace detail

auto getDatabaseSchema() -> std::string;

auto getDatabaseVersion() -> std::string;

auto getDriverVersion() -> std::string;

auto checkCharset() -> void;
auto checkTriggers() -> void;

auto transactionStart() -> bool;
auto transactionCommit() -> bool;
auto transactionRollback() -> bool;

auto enableTimers() -> void;

// Execute a transaction with the given transaction function.
//
// Rolls back if the transaction function throws, otherwise commits.
//
// Returns true only if the COMMIT itself succeeded.
auto transaction(const Fn<void() const>& transactionFn) -> bool;

auto getTableColumnNames(const std::string& tableName) -> std::vector<std::string>;

//
// Out-of-line template definitions
//

template <typename... Args>
auto preparedStmt(QueryString<std::type_identity_t<Args>...> query, Args&&... args) -> std::unique_ptr<ResultSet>
{
    TracyZoneScoped;
    TracyZoneStringView(query.text());

    const auto params = detail::lowerBoundValues(std::forward<Args>(args)...);

    auto rset = getDatabase().execute(query.text(), params);

    // Inside a transaction, carrying on past a failed statement means committing the statements
    // around it. Throw instead, so db::transaction rolls back.
    if (rset == nullptr && detail::failuresThrow())
    {
        throw std::runtime_error(fmt::format("statement failed inside a transaction: {}", query.text()));
    }

    return rset;
}

template <typename T, typename ProjectFn>
void executeBulk(detail::BulkQueryString<T, ProjectFn> query, const std::vector<T>& rows, ProjectFn project)
{
    TracyZoneScoped;

    if (rows.empty())
    {
        return;
    }

    using Row = detail::BulkRow<T, ProjectFn>;

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

    if (!getDatabase().executeBulk(query.text(), params))
    {
        throw std::runtime_error(fmt::format("bulk statement failed after {} rows: {}", rows.size(), query.text()));
    }
}

template <typename... Args>
auto preparedStmt(Scheduler& scheduler, QueryString<std::type_identity_t<Args>...> query, Args&&... args) -> Task<std::unique_ptr<ResultSet>>
{
    co_return scheduler.spawnOnWorkerThread(
        [rawQuery = std::string(query.text()), ... capturedArgs = std::forward<Args>(args)]() mutable
        {
            return db::preparedStmt(db::runtime(rawQuery), std::forward<Args>(capturedArgs)...);
        });
}

} // namespace db
