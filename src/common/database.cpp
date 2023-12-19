/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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
#include "tracy.h"
#include "utils.h"

namespace
{
    std::recursive_mutex bottleneck;

    // TODO: Have multiple pooled unique_ptr's to connections, which can be "checked out" by multiple callers.
    std::shared_ptr<sql::Connection> conn;

    std::unordered_map<PreparedStatement, std::pair<std::string, std::unique_ptr<sql::PreparedStatement>>> preparedStatements;
    std::unordered_map<std::string, std::unique_ptr<sql::PreparedStatement>>                               lazyPreparedStatements;
} // namespace

std::recursive_mutex& db::detail::getMutex()
{
    return bottleneck;
}

std::unordered_map<PreparedStatement, std::pair<std::string, std::unique_ptr<sql::PreparedStatement>>>& db::detail::getPreparedStatements()
{
    return preparedStatements;
}

std::unordered_map<std::string, std::unique_ptr<sql::PreparedStatement>>& db::detail::getLazyPreparedStatements()
{
    return lazyPreparedStatements;
}

void db::detail::populatePreparedStatements(std::shared_ptr<sql::Connection> conn)
{
    TracyZoneScoped;

    // clang-format off
    auto prep = [&](PreparedStatement stmt, const char* query)
    {
        preparedStatements[stmt] = { query, std::unique_ptr<sql::PreparedStatement>(conn->prepareStatement(query)) };
    };
    // clang-format on

    prep(PreparedStatement::Search_GetSearchComment, "SELECT seacom_message FROM accounts_sessions WHERE charid = (?)");
}

std::shared_ptr<sql::Connection> db::detail::getConnection()
{
    TracyZoneScoped;

    // TODO: Manual pooling?
    // TODO: Locking of individual connections?
    if (conn)
    {
        return conn;
    }

    std::scoped_lock lock(db::detail::getMutex());

    // NOTE: Driver is static, so it will only be initialized once.
    sql::Driver* driver = sql::mariadb::get_driver_instance();

    try
    {
        auto login  = settings::get<std::string>("network.SQL_LOGIN");
        auto passwd = settings::get<std::string>("network.SQL_PASSWORD");
        auto host   = settings::get<std::string>("network.SQL_HOST");
        auto port   = settings::get<uint16>("network.SQL_PORT");
        auto schema = settings::get<std::string>("network.SQL_DATABASE");
        auto url    = fmt::format("tcp://{}:{}", host, port);

        conn = std::shared_ptr<sql::Connection>(driver->connect(url.c_str(), login.c_str(), passwd.c_str()));
        conn->setSchema(schema.c_str());

        db::detail::populatePreparedStatements(conn);

        return conn;
    }
    catch (const std::exception& e)
    {
        ShowError(e.what());
        return nullptr;
    }
}

std::unique_ptr<sql::ResultSet> db::query(std::string_view query)
{
    TracyZoneScoped;

    std::scoped_lock lock(db::detail::getMutex());

    // TODO: Check this is pooled. If not; make it pooled.
    static thread_local auto conn = db::detail::getConnection();

    auto stmt = conn->createStatement();
    try
    {
        return std::unique_ptr<sql::ResultSet>(stmt->executeQuery(query.data()));
    }
    catch (const std::exception& e)
    {
        ShowError("Query Failed: %s", query.data());
        ShowError(e.what());
        return nullptr;
    }
}
