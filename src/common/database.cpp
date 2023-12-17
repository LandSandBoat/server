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
#include "utils.h"

std::unique_ptr<sql::Connection> db::getConnection()
{
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

        std::unique_ptr<sql::Connection> conn(driver->connect(url.c_str(), login.c_str(), passwd.c_str()));

        conn->setSchema(schema.c_str());

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
    // TODO: Check this is pooled. If not; make it pooled.
    static thread_local auto conn = getConnection();

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
