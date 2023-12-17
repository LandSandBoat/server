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

#include "common/database.h"
#include "common/logging.h"
#include "common/settings.h"
#include "common/utils.h"

#include <unordered_set>

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
            json j{};

            // Filter out settings we don't want to expose
            std::unordered_set<std::string> textToOmit{
                "logging.",
                "network.",
                "password", // Just in case
            };

            settings::visit([&](auto const& key, auto const& variant)
            {
                for (auto const& text : textToOmit)
                {
                    // NOTE: Remember that keys are stored as uppercase
                    if (key.find(to_upper(text)) != std::string::npos)
                    {
                        return;
                    }
                }

                std::visit(
                settings::overloaded
                {
                    [&](bool const& arg)
                    {
                        j[key] = arg;
                    },
                    [&](double const& arg)
                    {
                        j[key] = arg;
                    },
                    [&](std::string const& arg)
                    {
                        // JSON can't handle non-ASCII characters, so strip them out
                        j[key] = utils::toASCII(arg, '?');
                    },
                }, variant);
            });

            res.set_content(j.dump(), "application/json");
        });

        m_httpServer.set_error_handler([](httplib::Request const& /*req*/, httplib::Response& res)
        {
            auto str = fmt::format("<p>Error Status: <span style='color:red;'>{} ({})</span></p>",
                res.status, httplib::detail::status_message(res.status));

            for (auto const& [key, val] : res.headers)
            {
                str += fmt::format("<p>{}: {}</p>", key, val);
            }

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

        auto data = APIDataCache{};

        // Total active sessions
        {
            auto rset = db::query("SELECT COUNT(*) FROM accounts_sessions;");
            if (rset && rset->next())
            {
                data.activeSessionCount = rset->getUInt(0);
            }
        }

        // Chars per zone
        {
            auto rset = db::query("SELECT chars.pos_zone, COUNT(*) AS `count` "
                                   "FROM chars "
                                   "LEFT JOIN accounts_sessions "
                                   "ON chars.charid = accounts_sessions.charid "
                                   "GROUP BY pos_zone;");
            if (rset && rset->rowsCount())
            {
                while (rset->next())
                {
                    auto zoneId = rset->getUInt(0);
                    auto count  = rset->getUInt(1);

                    data.zonePlayerCounts[zoneId] = count;
                }
            }
        }

        m_apiDataCache = data;
        m_lastUpdate.store(now);
    }
}
