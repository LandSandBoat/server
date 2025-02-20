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

#include "connect_server.h"

ConnectServer::ConnectServer(int argc, char** argv)
: Application("connect", argc, argv)
{
    asio::io_context io_context;

    // clang-format off
    gConsoleService->RegisterCommand("stats", "Print server runtime statistics",
    [](std::vector<std::string>& inputs)
    {
        size_t uniqueIPs      = loginHelpers::getAuthenticatedSessions().size();
        size_t uniqueAccounts = 0;

        for (auto& ipAddrMap: loginHelpers::getAuthenticatedSessions())
        {
            uniqueAccounts += loginHelpers::getAuthenticatedSessions()[ipAddrMap.first].size();
        }
        ShowInfo("Serving %u IP addresses with %u accounts\n", uniqueIPs, uniqueAccounts);
    });

    gConsoleService->RegisterCommand("exit", "Safely close the login server",
    [&](std::vector<std::string>& inputs)
    {
        m_RequestExit = true;
        io_context.stop();
        gConsoleService->stop();
    });
    // clang-format on

#ifndef _WIN32
    rlimit limits{};

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
        handler<auth_session> auth(io_context, settings::get<uint32>("network.LOGIN_AUTH_PORT"));
        handler<view_session> view(io_context, settings::get<uint32>("network.LOGIN_VIEW_PORT"));
        handler<data_session> data(io_context, settings::get<uint32>("network.LOGIN_DATA_PORT"));
        asio::steady_timer    cleanup_callback(io_context, std::chrono::minutes(15));

        cleanup_callback.async_wait(std::bind(&ConnectServer::periodicCleanup, this, std::placeholders::_1, &cleanup_callback));

        // NOTE: io_context.run() takes over and blocks this thread. Anything after this point will only fire
        // if io_context finishes!
        ShowInfo("starting io_context");

        // This busy loop looks nasty, however --
        // https://think-async.com/Asio/asio-1.24.0/doc/asio/reference/io_service.html
        /* If an exception is thrown from a handler, the exception is allowed to propagate through the throwing thread's invocation of
            run(), run_one(), run_for(), run_until(), poll() or poll_one(). No other threads that are calling any of these functions are affected.
            It is then the responsibility of the application to catch the exception.
        */

        while (Application::IsRunning())
        {
            try
            {
                io_context.run();
                break;
            }
            catch (std::exception& e)
            {
                // TODO: make a list of "allowed exceptions", the rest can/should cause shutdown.
                ShowError(fmt::format("Inner fatal: {}", e.what()));
            }
        }
    }
    catch (std::exception& e)
    {
        ShowError(fmt::format("Outer fatal: {}", e.what()));
    }
}

void ConnectServer::periodicCleanup(const asio::error_code& error, asio::steady_timer* timer)
{
    if (!error)
    {
        auto& sessions       = loginHelpers::getAuthenticatedSessions();
        auto  ipAddrIterator = sessions.begin();
        while (ipAddrIterator != sessions.end())
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
                ipAddrIterator = sessions.erase(ipAddrIterator);
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
