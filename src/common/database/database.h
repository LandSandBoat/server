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

#include <common/tracy.h>

#include <common/types/fn.h>

#include <common/database/binding.h>
#include <common/database/bound_value.h>
#include <common/database/query.h>
#include <common/database/result_set.h>

#include <fmt/format.h>

#include <concepts>
#include <functional>
#include <memory>
#include <stdexcept>
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
    virtual auto execute(Query query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> = 0;

    // As execute, but sends every row of `params` in one round trip.
    //
    // Row width comes from the statement's own placeholder count, so `params` must be a whole number of rows.
    virtual auto executeBulk(Query query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> = 0;

    // The database name, ie. xidb.
    virtual auto getSchema() -> std::string = 0;

    // The version of the database software, ie. MariaDB 10.6.12-MariaDB.
    virtual auto getVersion() -> std::string = 0;

    // The version of the database driver, ie. MariaDB Connector/C++ 1.0.3.
    virtual auto getDriverVersion() -> std::string = 0;

    // suppresses the reconnect-and-retry path while a transaction is open
    virtual void setInTransaction(bool)
    {
    }

    virtual auto isInTransaction() -> bool
    {
        return false;
    }

    // Close the calling thread's cached statements, freeing their slots on the server.
    virtual void clearStatementCache()
    {
    }

    // Have every thread close its cached statements the next time it uses the database.
    virtual void purgeStatementCaches()
    {
    }
};

namespace detail
{

template <typename ProjectFn, typename T>
concept IsRowProjection = std::invocable<ProjectFn&, const T&> &&
                          requires { std::tuple_size<std::remove_cvref_t<std::invoke_result_t<ProjectFn&, const T&>>>::value; };

} // namespace detail

// Get the active database backend.
auto getDatabase() -> Database&;

namespace detail
{

// A literal or constexpr query whose placeholder count must match the argument count, checked at compile time.
template <std::size_t ArgCount>
class CheckedQuery final
{
public:
    template <std::size_t N>
    consteval CheckedQuery(const char (&text)[N])
    : CheckedQuery(Query(text))
    {
    }

    consteval CheckedQuery(const Query query)
    : query_(query)
    {
        if (query_.placeholders() != ArgCount)
        {
            throw "The query's placeholder count doesn't match its argument count";
        }
    }

    [[nodiscard]] constexpr auto query() const noexcept -> Query
    {
        return query_;
    }

private:
    Query query_;
};

template <typename... Args>
auto runPrepared(Query query, Args&&... args) -> std::unique_ptr<ResultSet>;

// The number of values each row's projection yields, or 0 when it isn't a projection at all.
template <typename ProjectFn, typename T>
consteval auto rowWidth() -> std::size_t
{
    if constexpr (IsRowProjection<ProjectFn, T>)
    {
        return std::tuple_size_v<std::remove_cvref_t<std::invoke_result_t<ProjectFn&, const T&>>>;
    }
    else
    {
        return 0;
    }
}

} // namespace detail

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
auto preparedStmt(detail::CheckedQuery<sizeof...(Args)> query, Args&&... args) -> std::unique_ptr<ResultSet>;

// As above, for a query picked at runtime with db::selected(). The placeholder count is checked when it runs.
template <typename... Args>
auto preparedStmt(detail::SelectedQuery selection, Args&&... args) -> std::unique_ptr<ResultSet>;

// Send every row of `rows` through `query` in one round trip.
//
// `project` turns one row into a tuple of values, one per placeholder, and every row must yield the same types.
// Numeric columns only.
//
// Throws if the statement fails.
// Call it inside db::transaction, which turns the throw into a rollback.
template <typename T, typename ProjectFn>
    requires detail::IsRowProjection<ProjectFn, T>
void executeBulk(detail::CheckedQuery<detail::rowWidth<ProjectFn, T>()> query, const std::vector<T>& rows, ProjectFn project);

auto getDatabaseSchema() -> std::string;

auto getDatabaseVersion() -> std::string;

auto getDriverVersion() -> std::string;

auto checkCharset() -> void;
auto checkTriggers() -> void;

auto enableTimers() -> void;

// Close the calling thread's cached statements, freeing their slots on the server.
auto clearStatementCache() -> void;

// Log the server's prepared statement usage, and purge every thread's cache once it reaches 75% of the limit.
auto checkStatementUsage() -> void;

// Execute a transaction with the given transaction function.
//
// Rolls back if the transaction function throws, otherwise commits.
//
// Returns true only if the COMMIT itself succeeded.
//
// Inside another transaction it joins that one, so a throw rolls back the outer transaction too.
auto transaction(const Fn<void() const>& transactionFn) -> bool;

auto getTableColumnNames(const std::string& tableName) -> std::vector<std::string>;

//
// Out-of-line template definitions
//

template <typename... Args>
auto detail::runPrepared(const Query query, Args&&... args) -> std::unique_ptr<ResultSet>
{
    TracyZoneScopedS(16);
    TracyZoneString(query.view());

    const auto params = lowerBoundValues(std::forward<Args>(args)...);
    return getDatabase().execute(query, params);
}

template <typename... Args>
auto preparedStmt(const detail::CheckedQuery<sizeof...(Args)> query, Args&&... args) -> std::unique_ptr<ResultSet>
{
    return detail::runPrepared(query.query(), std::forward<Args>(args)...);
}

template <typename... Args>
auto preparedStmt(const detail::SelectedQuery selection, Args&&... args) -> std::unique_ptr<ResultSet>
{
    const auto query = selection.query;
    if (query.placeholders() != sizeof...(Args))
    {
        ShowErrorFmt("Query has {} placeholders but was given {} arguments: {}", query.placeholders(), sizeof...(Args), query);
        return nullptr;
    }

    return detail::runPrepared(query, std::forward<Args>(args)...);
}

template <typename T, typename ProjectFn>
    requires detail::IsRowProjection<ProjectFn, T>
void executeBulk(const detail::CheckedQuery<detail::rowWidth<ProjectFn, T>()> query, const std::vector<T>& rows, ProjectFn project)
{
    TracyZoneScopedS(16);

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

    if (!getDatabase().executeBulk(query.query(), params))
    {
        throw std::runtime_error(fmt::format("bulk statement failed after {} rows: {}", rows.size(), query.query()));
    }
}

} // namespace db
