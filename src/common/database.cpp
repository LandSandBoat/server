/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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
#include "taskmgr.h"
#include "utils.h"

#include <chrono>
using namespace std::chrono_literals;

namespace
{
    mutex_guarded<db::detail::State> state;
} // namespace

int32 ping_connection(time_point tick, CTaskMgr::CTask* task)
{
    auto& state = db::detail::getState();

    // clang-format off
    state.write([&](auto& state)
    {
        ShowInfo("(C++) Pinging database to keep connection alive");
        try
        {
            if (!state.connection->isValid())
            {
                ShowError("Database connection is invalid, attempting to reconnect...");
                state.connection->reconnect();
            }
        }
        catch (const std::exception& e)
        {
            ShowError(e.what());
            state.connection = nullptr; // Wipe the connection so that it can't be used if it's broken
        }
    });
    // clang-format on

    return 0;
};

mutex_guarded<db::detail::State>& db::detail::getState()
{
    TracyZoneScoped;

    // TODO: Manual pooling?
    // TODO: Locking of individual connections by passing back a handle with a `*this` reference to free the connection on handle destruction?

    // clang-format off
    if (state.read([&](const auto& state) { return state.connection != nullptr; }))
    {
        return state;
    }

    state.write([&](auto& state)
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

            state.connection = std::unique_ptr<sql::Connection>(driver->connect(url.c_str(), login.c_str(), passwd.c_str()));
            state.connection->setSchema(schema.c_str());
        }
        catch (const std::exception& e)
        {
            ShowError(e.what());
            state.connection = nullptr; // Wipe the connection so that it can't be used if it's broken
        }
    });
    // clang-format on

    // NOTE: This is mostly the same logic from sql.cpp:
    // Add periodic task to ping this db connection to keep it alive or to bring it back
    uint32 timeout = 7200; // 2 hours

    // TODO: Request the timeout value from the mysql server
    // GetTimeout(&timeout);

    timeout = std::max(timeout, 60u);

    // 30-second reserve
    uint8 reserve = 30;
    timeout       = timeout + reserve;

    auto duration = std::chrono::seconds(timeout);

    CTaskMgr::getInstance()->AddTask("ping database connection", server_clock::now() + duration, nullptr, CTaskMgr::TASK_INTERVAL, ping_connection, duration);

    return state;
}

std::unique_ptr<sql::ResultSet> db::query(std::string const& rawQuery)
{
    TracyZoneScoped;
    TracyZoneString(rawQuery);

    // clang-format off
    return detail::getState().write([&](detail::State& state) -> std::unique_ptr<sql::ResultSet>
    {
        auto stmt = state.connection->createStatement();
        try
        {
            DebugSQL(fmt::format("query: {}", rawQuery));
            return std::unique_ptr<sql::ResultSet>(stmt->executeQuery(rawQuery.data()));
        }
        catch (const std::exception& e)
        {
            ShowError("Query Failed: %s", rawQuery.data());
            ShowError(e.what());
            return nullptr;
        }
    });
    // clang-format on
}
