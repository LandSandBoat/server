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

#include <common/database/bound_value.h>
#include <common/database/connection.h>
#include <common/database/database.h>
#include <common/database/prepared_statement.h>

#include <common/types/fn.h>
#include <common/types/hash_map.h>

#include <memory>
#include <string>
#include <string_view>

namespace db
{

namespace detail
{

// A prepared statement together with its query classification, computed once when the
// statement is first prepared so cached executions skip re-validating the query text.
struct CachedStatement
{
    std::unique_ptr<PreparedStatement> statement;
    ResultSetType                      type;
};

// Per-(thread, backend) connection state: the live connection plus its prepared-statement cache.
struct ConnectionState
{
    std::unique_ptr<Connection>           connection;
    HashMap<std::string, CachedStatement> statements;

    // open transaction on this connection
    bool inTransaction{ false };

    // Set when the connection is lost while a transaction is open. Every statement up to and
    // including the transaction's COMMIT/ROLLBACK is refused, so no work silently escapes onto a
    // fresh auto-committing connection; it clears when the transaction closes.
    bool transactionBroken{ false };
};

} // namespace detail

class CachingDatabase : public Database
{
public:
    CachingDatabase();

    auto execute(std::string_view query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> override;
    auto executeBulk(std::string_view query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> override;

    void setInTransaction(bool value) override;

    auto getSchema() -> std::string override;
    auto getVersion() -> std::string override;
    auto getDriverVersion() -> std::string override;

protected:
    virtual auto createConnection() -> std::unique_ptr<Connection> = 0;

private:
    // Identifies this backend in the per-thread state map. A serial number rather than `this`, so
    // that a later backend allocated at a dead one's address cannot inherit its connection.
    const uint64 id_;

    // The calling thread's connection state for this backend, connecting lazily on first use.
    auto getState() -> detail::ConnectionState&;

    // Find-or-prepare the cached statement for this query on the given connection.
    //
    // Returns nullptr if the query text is rejected.
    auto prepareCached(detail::ConnectionState& connState, std::string_view query) -> detail::CachedStatement*;

    // Run `operation` on this thread's connection, retrying on connection loss.
    //
    // Terminates if the connection can't be re-established.
    auto runWithRetry(std::string_view query, const Fn<std::unique_ptr<ResultSet>(detail::ConnectionState&) const>& operation) -> std::unique_ptr<ResultSet>;
};

} // namespace db
