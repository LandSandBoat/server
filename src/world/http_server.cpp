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

#include "common/async.h"
#include "common/database.h"
#include "common/logging.h"
#include "common/settings.h"
#include "common/utils.h"
#include "common/xi.h"

#include <unordered_set>

#include <nlohmann/json.hpp>
using json = nlohmann::json;

HTTPServer::HTTPServer()
: m_apiDataCache(APIDataCache{})
{
    if (!settings::get<bool>("network.ENABLE_HTTP"))
    {
        return;
    }

    // NOTE: Everything registered in here happens off the main thread, so lock any global resources
    //     : you might be using.

    LockingUpdate();

    auto host = settings::get<std::string>("network.HTTP_HOST");
    auto port = settings::get<uint16>("network.HTTP_PORT");

    ShowInfoFmt("Starting HTTP Server on http://{}:{}/api", host, port);

    Async::getInstance()->submit(
        [this, host, port]()
        {
            m_httpServer.Get(
                "/api",
                [&](const httplib::Request& req, httplib::Response& res)
                {
                    res.set_content("Hello LSB API", "text/plain");
                });

            m_httpServer.Get(
                "/api/sessions",
                [&](const httplib::Request& req, httplib::Response& res)
                {
                    LockingUpdate();
                    m_apiDataCache.read([&](const auto& apiDataCache)
                                        {
                                            json j = apiDataCache.activeSessionCount;
                                            res.set_content(j.dump(), "application/json");
                                        });
                });

            m_httpServer.Get(
                "/api/ips",
                [&](const httplib::Request& req, httplib::Response& res)
                {
                    LockingUpdate();
                    m_apiDataCache.read(
                        [&](const auto& apiDataCache)
                        {
                            json j = apiDataCache.activeUniqueIPCount;
                            res.set_content(j.dump(), "application/json");
                        });
                });

            m_httpServer.Get(
                "/api/zones",
                [&](const httplib::Request& req, httplib::Response& res)
                {
                    LockingUpdate();
                    m_apiDataCache.read(
                        [&](const auto& apiDataCache)
                        {
                            json j = apiDataCache.zonePlayerCounts;
                            res.set_content(j.dump(), "application/json");
                        });
                });

            m_httpServer.Get(
                R"(/api/zones/(\d+))",
                [&](const httplib::Request& req, httplib::Response& res)
                {
                    auto   maybeZoneId = req.matches[1].str();
                    uint16 zoneId      = std::strtol(maybeZoneId.c_str(), nullptr, 10);
                    if (zoneId && zoneId < ZONEID::MAX_ZONEID)
                    {
                        LockingUpdate();
                        m_apiDataCache.read(
                            [&](const auto& apiDataCache)
                            {
                                json j = apiDataCache.zonePlayerCounts[zoneId];
                                res.set_content(j.dump(), "application/json");
                            });
                    }
                    else
                    {
                        res.status = 404;
                    }
                });

            m_httpServer.Get(
                "/api/settings",
                [&](const httplib::Request& req, httplib::Response& res)
                {
                    // TODO: Cache these
                    json j{};

                    // Filter out settings we don't want to expose
                    std::unordered_set<std::string> textToOmit{
                        "logging.",
                        "network.",
                        "password", // Just in case
                    };

                    settings::visit(
                        [&](const auto& key, const auto& variant)
                        {
                            for (const auto& text : textToOmit)
                            {
                                // NOTE: Remember that keys are stored as uppercase
                                if (key.find(to_upper(text)) != std::string::npos)
                                {
                                    return;
                                }
                            }

                            std::visit(
                                xi::overload{
                                    [&](const bool& arg)
                                    {
                                        j[key] = arg;
                                    },
                                    [&](const double& arg)
                                    {
                                        j[key] = arg;
                                    },
                                    [&](const std::string& arg)
                                    {
                                        // JSON can't handle non-ASCII characters, so strip them out
                                        j[key] = utils::toASCII(arg, '?');
                                    },
                                },
                                variant);
                        });

                    res.set_content(j.dump(), "application/json");
                });

            m_httpServer.set_error_handler(
                [](const httplib::Request& /*req*/, httplib::Response& res)
                {
                    auto str = fmt::format("<p>Error Status: <span style='color:red;'>{} ({})</span></p>",
                                           res.status,
                                           httplib::status_message(res.status));

                    for (const auto& [key, val] : res.headers)
                    {
                        str += fmt::format("<p>{}: {}</p>", key, val);
                    }

                    res.set_content(str, "text/html");
                });

            m_httpServer.set_logger(
                [](const httplib::Request& req, const httplib::Response& res)
                {
                    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
                    if (res.status >= 500)
                    {
                        ShowErrorFmt("Server Error: {} ({})", res.status, httplib::status_message(res.status));
                        return;
                    }
                    else if (res.status >= 400)
                    {
                        ShowErrorFmt("Client Error: {} ({})", res.status, httplib::status_message(res.status));
                        return;
                    }
                });

            m_httpServer.listen(host, port);
        });
}

HTTPServer::~HTTPServer()
{
    m_httpServer.stop();
}

void HTTPServer::LockingUpdate()
{
    auto now = timer::now();
    if (now < (m_lastUpdate.load() + 60s))
    {
        return;
    }

    m_apiDataCache.write(
        [&](auto& apiDataCache)
        {
            ShowInfoFmt("API data is stale. Updating...");

            // Total active sessions
            {
                auto rset = db::preparedStmt("SELECT COUNT(*) AS `count` FROM accounts_sessions");
                if (rset && rset->next())
                {
                    apiDataCache.activeSessionCount = rset->get<uint32>("count");
                }
            }

            // Total active unique IPs
            {
                auto rset = db::preparedStmt("SELECT COUNT(DISTINCT client_addr) AS `count` FROM accounts_sessions");
                if (rset && rset->next())
                {
                    apiDataCache.activeUniqueIPCount = rset->get<uint32>("count");
                }
            }

            // Chars per zone
            {
                auto rset = db::preparedStmt("SELECT chars.pos_zone, COUNT(*) AS `count` "
                                             "FROM chars "
                                             "INNER JOIN accounts_sessions "
                                             "ON chars.charid = accounts_sessions.charid "
                                             "GROUP BY pos_zone");
                if (rset && rset->rowsCount())
                {
                    while (rset->next())
                    {
                        auto zoneId = rset->get<uint16>("pos_zone");
                        auto count  = rset->get<uint32>("count");

                        apiDataCache.zonePlayerCounts[zoneId] = count;
                    }
                }
            }

            m_lastUpdate.store(now);
        });
}
