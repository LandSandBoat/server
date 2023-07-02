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

#pragma once

#include "common/application.h"
#include "common/console_service.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/md52.h"
#include "common/settings.h"
#include "common/sql.h"
#include "common/utils.h"
#include "common/xirand.h"
#include "map/packets/basic.h"

// openssl applink.c prevents issues with debug vs release vs threaded/single threaded .dlls at runtime
// apparently not an issue with linux
#ifdef _WIN32
#include <ms/applink.c>
#endif

#include <asio/ssl.hpp>
#include <asio/ts/buffer.hpp>
#include <asio/ts/internet.hpp>
#include <chrono>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <memory>
#include <thread>
#include <type_traits>
#include <unordered_map>
#include <utility>
#include <vector>
#include <zmq.hpp>

#include <nonstd/jthread.hpp>

#ifndef _WIN32
#include <sys/resource.h>
#endif

// Login specific stuff
#include "auth_session.h"
#include "cert_helpers.h"
#include "data_session.h"
#include "handler.h"
#include "handler_session.h"
#include "login_packets.h"
#include "login_helpers.h"
#include "session.h"
#include "view_session.h"

class ConnectServer final : public Application
{
public:
    ConnectServer(int argc, char** argv)
    : Application("connect", argc, argv)
    {
        asio::io_context io_context;

        // clang-format off
        gConsoleService->RegisterCommand("stats", "Print server runtime statistics",
        [](std::vector<std::string> inputs)
        {
            size_t uniqueIPs      = loginHelpers::authenticatedSessions_.size();
            size_t uniqueAccounts = 0;

            for (auto ipAddrMap: loginHelpers::authenticatedSessions_)
            {
                uniqueAccounts += loginHelpers::authenticatedSessions_[ipAddrMap.first].size();
            }
            ShowInfo("Serving %u IP addresses with %u accounts\n", uniqueIPs, uniqueAccounts);
        });

        gConsoleService->RegisterCommand("exit", "Safely close the login server",
        [&](std::vector<std::string> inputs)
        {
            m_RequestExit = true;
            io_context.stop();
            gConsoleService->stop();
        });
        // clang-format on

#ifndef _WIN32
        struct rlimit limits;

        uint32 newRLimit = 10240;

        // Get old limits
        if (getrlimit(RLIMIT_NOFILE, &limits) == 0)
        {
            // Increase open file limit, which includes sockets, to newRLimit. This only effects the current process and child processes
            limits.rlim_cur = newRLimit;
            if (setrlimit(RLIMIT_NOFILE, &limits) == -1)
            {
                ShowError("Failed to increase rlim_cur to %d", newRLimit);
            }
        }
#endif
        xirand::seed();

        try
        {
            // Generate a self signed cert if one doesn't exist.
            certificateHelpers::generateSelfSignedCert();

            ShowInfo("creating ports");

            // Handler creates session of type T for specific port on connection.
            handler<auth_session> auth(io_context, 54231);
            handler<view_session> view(io_context, 54001);
            handler<data_session> data(io_context, 54230);
            asio::steady_timer    cleanup_callback(io_context, std::chrono::minutes(15));

            cleanup_callback.async_wait(std::bind(&ConnectServer::periodicCleanup, this, std::placeholders::_1, &cleanup_callback));

            // NOTE: io_context.run() takes over and blocks this thread. Anything after this point will only fire
            // if io_context finishes!
            ShowInfo("starting io_context");

            io_context.run();
        }
        catch (std::exception& e)
        {
            ShowError(e.what());
        }
    }

    ~ConnectServer() override
    {
        // Everything should be handled with RAII
    }

    // TODO: Currently never called. Need io_context asio::steady_timer callback with taskmgr to control timing?
    void Tick() override
    {
        Application::Tick();

        // Connect Server specific things
    }

    // This cleanup function is to periodically poll for auth sessions that were successful but xiloader failed to actually launch FFXI
    // When this happens, the data/view socket are never opened and will never be cleaned up normally.
    // Auth is closed before any other sessions are open, so the data/view cleanups aren't sufficient
    void periodicCleanup(const asio::error_code& error, asio::steady_timer* timer)
    {
        if (!error)
        {
            auto ipAddrIterator = loginHelpers::authenticatedSessions_.begin();
            while (ipAddrIterator != loginHelpers::authenticatedSessions_.end())
            {
                auto sessionIterator = ipAddrIterator->second.begin();
                while (sessionIterator != ipAddrIterator->second.end())
                {
                    session_t& session = sessionIterator->second;

                    // If it's been 15 minutes, erase it from the session list
                    if (!session.data_session &&
                        !session.view_session &&
                        (server_clock::now() - session.authorizedTime) > std::chrono::minutes(15))
                    {
                        sessionIterator = ipAddrIterator->second.erase(sessionIterator);
                    }
                    else
                    {
                        sessionIterator++;
                    }
                }

                // If this map entry is empty, clean it up
                if (ipAddrIterator->second.size() == 0)
                {
                    ipAddrIterator = loginHelpers::authenticatedSessions_.erase(ipAddrIterator);
                }
                else
                {
                    ipAddrIterator++;
                }
            }

            if (Application::IsRunning())
            {
                // reset timer
                timer->expires_at(timer->expiry() + std::chrono::minutes(15));
                timer->async_wait(std::bind(&ConnectServer::periodicCleanup, this, std::placeholders::_1, timer));
            }
        }
    }
};
