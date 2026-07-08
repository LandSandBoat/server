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

#include <common/database/libmariadb/libmariadb_connection.h>

#include <common/database/libmariadb/libmariadb_prepared_statement.h>

#include <common/logging.h>
#include <common/settings.h>

#include <mutex>
#include <string>
#include <thread>

#include <chrono>
using namespace std::chrono_literals;

db::LibMariaDBConnection::LibMariaDBConnection(MYSQL* connection)
: connection_(connection)
{
}

db::LibMariaDBConnection::~LibMariaDBConnection()
{
    if (connection_ != nullptr)
    {
        mysql_close(connection_);
    }
}

auto db::LibMariaDBConnection::prepare(const std::string& query) -> std::unique_ptr<PreparedStatement>
{
    MYSQL_STMT* stmt = mysql_stmt_init(connection_);
    if (stmt == nullptr)
    {
        throw detail::libmariadb::Error(mysql_errno(connection_), mysql_error(connection_));
    }

    if (mysql_stmt_prepare(stmt, query.c_str(), static_cast<unsigned long>(query.size())) != 0)
    {
        const auto        errnum  = mysql_stmt_errno(stmt);
        const std::string message = mysql_stmt_error(stmt);
        mysql_stmt_close(stmt);
        throw detail::libmariadb::Error(errnum, message);
    }

    return std::make_unique<LibMariaDBPreparedStatement>(stmt);
}

auto db::LibMariaDBConnection::schema() -> std::string
{
    return settings::get<std::string>("network.SQL_DATABASE");
}

auto db::LibMariaDBConnection::version() -> std::string
{
    return fmt::format("MariaDB {}", mysql_get_server_info(connection_));
}

auto db::LibMariaDBConnection::driverVersion() -> std::string
{
    return fmt::format("MariaDB Connector/C {}", mysql_get_client_info());
}

auto db::LibMariaDBConnection::isConnectionError(const std::exception& e) const -> bool
{
    if (const auto* error = dynamic_cast<const detail::libmariadb::Error*>(&e))
    {
        return detail::libmariadb::isConnectionLost(error->errnum);
    }

    return false;
}

auto db::LibMariaDBConnection::connect() -> std::unique_ptr<Connection>
{
    static std::once_flag libraryInitFlag;
    std::call_once(
        libraryInitFlag,
        []()
        {
            mysql_library_init(0, nullptr, nullptr);
        });

    // Initialize per-thread connector state. Paired thread cleanup is a known TODO; the connection
    // is thread-local for the life of the worker thread.
    mysql_thread_init();

    MYSQL* connection = mysql_init(nullptr);
    if (connection == nullptr)
    {
        ShowCritical("!!! Failed to allocate database handle, terminating server !!!");
        std::this_thread::sleep_for(1s);
        std::terminate();
    }

    const auto login  = settings::get<std::string>("network.SQL_LOGIN");
    const auto passwd = settings::get<std::string>("network.SQL_PASSWORD");
    const auto host   = settings::get<std::string>("network.SQL_HOST");
    const auto port   = settings::get<uint16>("network.SQL_PORT");
    const auto schema = settings::get<std::string>("network.SQL_DATABASE");

    if (mysql_real_connect(connection, host.c_str(), login.c_str(), passwd.c_str(), schema.c_str(), port, nullptr, 0) == nullptr)
    {
        // If we can't establish a connection to the database we can't do anything.
        // Time to die!
        ShowCritical("!!! Failed to connect to database, terminating server !!!");
        ShowCritical(mysql_error(connection));
        mysql_close(connection);
        std::this_thread::sleep_for(1s);
        std::terminate();
    }

    mysql_set_character_set(connection, "utf8mb4");

    return std::make_unique<LibMariaDBConnection>(connection);
}
