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

#include <common/types/hash_map.h>

#include <memory>
#include <string>

namespace db
{

namespace detail
{

// Per-(thread, backend) connection state: the live connection plus its prepared-statement cache.
struct ConnectionState
{
    std::unique_ptr<Connection>                              connection;
    HashMap<std::string, std::unique_ptr<PreparedStatement>> statements;
};

} // namespace detail

class CachingDatabase : public Database
{
public:
    auto execute(const std::string& query, const std::vector<BoundValue>& params) -> std::unique_ptr<ResultSet> override;

    auto getSchema() -> std::string override;
    auto getVersion() -> std::string override;
    auto getDriverVersion() -> std::string override;

protected:
    virtual auto createConnection() -> std::unique_ptr<Connection> = 0;

private:
    // The calling thread's connection state for this backend, connecting lazily on first use.
    auto getState() -> detail::ConnectionState&;
};

} // namespace db
