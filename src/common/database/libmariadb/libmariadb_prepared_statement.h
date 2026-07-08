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

// Must precede any project header that could transitively include <windows.h>.
#include <common/database/libmariadb/libmariadb_include.h>

#include <common/database/bound_value.h>
#include <common/database/libmariadb/libmariadb_result_set.h>
#include <common/database/prepared_statement.h>
#include <common/database/result_set.h>

#include <deque>
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>

namespace db::detail::libmariadb
{

// Error raised by the libmariadb backend. Carries the connector errno so the connection can
// distinguish a recoverable connection drop from a genuine query failure.
struct Error final : std::runtime_error
{
    Error(unsigned int errnum, const std::string& message);

    unsigned int errnum;
};

auto isConnectionLost(unsigned int errnum) -> bool;

} // namespace db::detail::libmariadb

namespace db
{

class LibMariaDBPreparedStatement final : public PreparedStatement
{
public:
    explicit LibMariaDBPreparedStatement(MYSQL_STMT* stmt);
    ~LibMariaDBPreparedStatement() override;

    LibMariaDBPreparedStatement(const LibMariaDBPreparedStatement&)            = delete;
    LibMariaDBPreparedStatement& operator=(const LibMariaDBPreparedStatement&) = delete;

    auto bind(int index, const BoundValue& value) -> void override;
    auto executeQuery(const std::string& query) -> std::unique_ptr<ResultSet> override;
    auto executeUpdate(const std::string& query) -> std::unique_ptr<ResultSet> override;

private:
    enum class CellKind
    {
        Int64,
        UInt64,
        Double,
        Text,
    };

    auto applyBindings() -> void;
    auto resetBindings() -> void;
    auto ensureSchema() -> void;
    auto fetchRows() -> std::vector<LibMariaDBResultSet::Row>;

    MYSQL_STMT* stmt_;

    std::vector<MYSQL_BIND>       paramBinds_;
    std::deque<std::vector<char>> paramBuffers_;
    std::deque<unsigned long>     paramLengths_;

    std::shared_ptr<const ColumnSchema> schema_;
    std::vector<CellKind>               kinds_;
    bool                                schemaInitialized_ = false;
};

} // namespace db
