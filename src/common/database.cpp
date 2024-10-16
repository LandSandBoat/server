﻿/*
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

#include <chrono>
using namespace std::chrono_literals;

namespace
{
    // TODO: Manual checkout and pooling of state
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

    // NOTE: mariadb-connector-cpp doesn't seem to make any guarantees about whether or not isValid() or reconnect()
    //     : are const. So we're going to have to wrap calls to them as though they aren't.

    // clang-format off
    if (state.write([&](auto& state)
    {
        // If we have a valid and connected connection: return it
        // TODO: Does this logic make ping_connection redundant?
        return state.connection != nullptr && (state.connection->isValid() || state.connection->reconnect());
    }))
    {
        return state;
    }

    // Otherwise, create a new connection. Writing it to the state.connection unique_ptr will release any previous connection
    // that might be there.

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

auto db::query(std::string const& rawQuery) -> std::unique_ptr<db::detail::ResultSetWrapper>
{
    TracyZoneScoped;
    TracyZoneString(rawQuery);

    // clang-format off
    return detail::getState().write([&](detail::State& state) -> std::unique_ptr<db::detail::ResultSetWrapper>
    {
        auto stmt = state.connection->createStatement();
        try
        {
            DebugSQL(fmt::format("query: {}", rawQuery));
            auto rset = std::unique_ptr<sql::ResultSet>(stmt->executeQuery(rawQuery.data()));
            return std::make_unique<db::detail::ResultSetWrapper>(std::move(rset));
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

auto db::escapeString(std::string const& str) -> std::string
{
    std::string escapedStr = str;

    // Replacement map similar to str_replace in PHP
    static std::unordered_map<std::string, std::string> replacements = {
        {"\\", "\\\\"},
        {"\0", "\\0"},
        {"\n", "\\n"},
        {"\r", "\\r"},
        {"'", "\\'"},
        {"\"", "\\\""},
        {"\x1a", "\\Z"}
    };

    // Replace each character based on the replacement map
    for (const auto& [from, to] : replacements) {
        std::string::size_type pos = 0;
        while ((pos = escapedStr.find(from, pos)) != std::string::npos) {
            escapedStr.replace(pos, from.length(), to);
            pos += to.length();
        }
    }

    return escapedStr;
}
