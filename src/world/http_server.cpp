/*
===========================================================================

Copyright (c) 2022 LandSandBoat Dev Teams

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
#include "http_server.h"

#include "common/logging.h"
#include "common/settings.h"
#include "common/sql.h"
#include "common/utils.h"

#include <nlohmann/json.hpp>
using json = nlohmann::json;

HTTPServer::HTTPServer()
{
    if (!settings::get<bool>("network.ENABLE_HTTP"))
    {
        return;
    }

    ts = std::make_unique<ts::task_system>(1);

    // NOTE: Everything registered in here happens off the main thread, so lock any global resources
    //     : you might be using.

    LockingUpdate();

    auto host = settings::get<std::string>("network.HTTP_HOST");
    auto port = settings::get<uint16>("network.HTTP_PORT");

    // clang-format off
    ts->schedule([this, host, port]()
    {
        m_httpServer.Get("/api", [&](httplib::Request const& req, httplib::Response& res)
        {
            res.set_content("Hello LSB API", "text/plain");
        });

        m_httpServer.Get("/api/sessions", [&](httplib::Request const& req, httplib::Response& res)
        {
            LockingUpdate();

            std::unique_lock<std::mutex> lock(m_updateBottleneck);
            json j;
            j = m_apiDataCache.activeSessionCount;
            res.set_content(j.dump(), "application/json");
        });

        m_httpServer.Get("/api/zones", [&](httplib::Request const& req, httplib::Response& res)
        {
            LockingUpdate();

            std::unique_lock<std::mutex> lock(m_updateBottleneck);
            json j = m_apiDataCache.zonePlayerCounts;
            res.set_content(j.dump(), "application/json");
        });

        m_httpServer.Get(R"(/api/zones/(\d+))", [&](httplib::Request const& req, httplib::Response& res)
        {
            auto maybeZoneId = req.matches[1].str();
            uint16 zoneId = std::strtol(maybeZoneId.c_str(), nullptr, 10);
            if (zoneId && zoneId < ZONEID::MAX_ZONEID)
            {
                LockingUpdate();

                std::unique_lock<std::mutex> lock(m_updateBottleneck);
                json j = m_apiDataCache.zonePlayerCounts[zoneId];
                res.set_content(j.dump(), "application/json");
            }
            else
            {
                res.status = 404;
            }
        });

        m_httpServer.Get("/api/settings", [&](httplib::Request const& req, httplib::Response& res)
        {
            // TODO: Cache these
            json j;
            j["SERVER_NAME"]          = settings::get<std::string>("main.SERVER_NAME");
            j["EXP_RATE"]             = settings::get<float>("main.EXP_RATE");
            j["ENABLE_TRUST_CASTING"] = settings::get<bool>("main.ENABLE_TRUST_CASTING");
            j["MAX_LEVEL"]            = settings::get<uint8>("main.MAX_LEVEL");
            res.set_content(j.dump(), "application/json");
        });

        m_httpServer.set_error_handler([](httplib::Request const& /*req*/, httplib::Response& res)
        {
            auto str = fmt::format("<p>Error Status: <span style='color:red;'>{} ({})</span></p>", res.status, httplib::detail::status_message(res.status));
            res.set_content(str, "text/html");
        });

        m_httpServer.set_logger([](httplib::Request const& req, httplib::Response const& res)
        {
            // https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
            if (res.status >= 500)
            {
                ShowError(fmt::format("Server Error: {} ({})", res.status, httplib::detail::status_message(res.status)));
                return;
            }
            else if (res.status >= 400)
            {
                ShowError(fmt::format("Client Error: {} ({})", res.status, httplib::detail::status_message(res.status)));
                return;
            }
        });

        ShowInfo(fmt::format("Starting HTTP Server on http://{}:{}/api", host, port));
        m_httpServer.listen(host, port);
    });
    // clang-format on
}

HTTPServer::~HTTPServer()
{
    m_httpServer.stop();
}

void HTTPServer::LockingUpdate()
{
    std::unique_lock<std::mutex> lock(m_updateBottleneck);

    auto now = server_clock::now();
    if (now > (m_lastUpdate.load() + 60s))
    {
        ShowInfo("API data is stale. Updating...");

        auto sql  = std::make_unique<SqlConnection>();
        auto data = APIDataCache{};

        // Total active sessions
        {
            auto ret = sql->Query("SELECT COUNT(*) FROM accounts_sessions;");
            if (ret != SQL_ERROR && sql->NumRows() && sql->NextRow() == SQL_SUCCESS)
            {
                data.activeSessionCount = sql->GetUIntData(0);
            }
        }

        // Chars per zone
        {
            auto ret = sql->Query("SELECT chars.pos_zone, COUNT(*) AS `count` "
                                  "FROM chars "
                                  "LEFT JOIN accounts_sessions "
                                  "ON chars.charid = accounts_sessions.charid "
                                  "GROUP BY pos_zone;");
            if (ret != SQL_ERROR && sql->NumRows())
            {
                while (sql->NextRow() == SQL_SUCCESS)
                {
                    auto zoneId = sql->GetUIntData(0);
                    auto count  = sql->GetUIntData(1);

                    data.zonePlayerCounts[zoneId] = count;
                }
            }
        }

        m_apiDataCache = data;
        m_lastUpdate.store(now);
    }
}
