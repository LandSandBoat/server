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

#include <common/database/prepared_statement.h>

#include <exception>
#include <memory>
#include <string>

namespace db
{

class Connection
{
public:
    virtual ~Connection() = default;

    // Prepare (or fail) a statement for this connection.
    virtual auto prepare(const std::string& query) -> std::unique_ptr<PreparedStatement> = 0;

    // The connected database/schema name, ie. xidb.
    virtual auto schema() -> std::string = 0;

    // The database server version, ie. MariaDB 10.6.12-MariaDB.
    virtual auto version() -> std::string = 0;

    // The client driver version, ie. MariaDB Connector/C 3.2.8.
    virtual auto driverVersion() -> std::string = 0;

    // Whether the given exception (thrown by prepare/bind/execute) indicates a lost or broken
    // connection that warrants reconnecting and retrying, rather than a genuine query failure.
    virtual auto isConnectionError(const std::exception& e) const -> bool = 0;
};

} // namespace db
