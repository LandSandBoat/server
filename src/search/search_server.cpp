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

#include "search_server.h"
#include "data_loader.h"

SearchServer::SearchServer(int argc, char** argv)
: Application("search", argc, argv)
{
    asio::io_context io_context;

    // clang-format off
    gConsoleService->RegisterCommand(
    "ah_cleanup", fmt::format("AH task to return items older than {} days.", settings::get<uint16>("search.EXPIRE_DAYS")),
    [&](std::vector<std::string>& inputs)
    {
        ahCleanup();
    });

    gConsoleService->RegisterCommand(
    "expire_all", "Force-expire all items on the AH, returning to sender.",
    [](std::vector<std::string>& inputs)
    {
        CDataLoader data;
        data.ExpireAHItems(0);
    });

    gConsoleService->RegisterCommand("exit", "Safely close the search server",
    [&](std::vector<std::string>& inputs)
    {
        fmt::print("> Goodbye!");
        m_RequestExit = true;
        io_context.stop();
        gConsoleService->stop();
    });
    // clang-format on

    // Is this necessary for search?
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
        ShowInfo("creating ports");

        // clang-format off
        const auto search_handler_handler = handler(io_context, settings::get<uint32>("network.SEARCH_PORT"), [&](asio::ip::tcp::socket socket) {
            const auto handler = std::make_shared<search_handler>(std::move(socket), io_context, IPAddressesInUse_, IPAddressWhitelist_);
            handler->start();
        });
        // clang-format on

        // AH cleanup callback. May not be used if settings doesn't enable it.
        asio::steady_timer cleanup_callback(io_context, std::chrono::seconds(settings::get<uint32>("search.EXPIRE_INTERVAL")));

        if (settings::get<bool>("search.EXPIRE_AUCTIONS"))
        {
            ShowInfo("AH task to return items older than %u days is running", settings::get<uint16>("search.EXPIRE_DAYS"));

            ahCleanup();

            cleanup_callback.async_wait(std::bind(&SearchServer::periodicCleanup, this, std::placeholders::_1, &cleanup_callback));
        }

        sol::table accessWhitelist = lua["xi"]["settings"]["search"]["ACCESS_WHITELIST"].get_or_create<sol::table>();
        for (auto const& [_, value] : accessWhitelist)
        {
            // clang-format off
            auto str = value.as<std::string>();
            IPAddressWhitelist_.write([str](auto& ipWhitelist)
            {
                ipWhitelist.insert(str);
            });
            // clang-format on
        }

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

void SearchServer::ahCleanup()
{
    CDataLoader data;
    data.ExpireAHItems(settings::get<uint16>("search.EXPIRE_DAYS"));
}

void SearchServer::periodicCleanup(const asio::error_code& error, asio::steady_timer* timer)
{
    if (!error)
    {
        ahCleanup();

        if (Application::IsRunning())
        {
            // reset timer
            timer->expires_at(timer->expiry() + std::chrono::seconds(settings::get<uint32>("search.EXPIRE_INTERVAL")));
            timer->async_wait(std::bind(&SearchServer::periodicCleanup, this, std::placeholders::_1, timer));
        }
    }
}
