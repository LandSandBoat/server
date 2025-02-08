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
        requestExit_ = true;
        ioContext_.stop();
        consoleService_->stop();
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

        if (Application::isRunning())
        {
            // reset timer
            timer->expires_at(timer->expiry() + std::chrono::seconds(settings::get<uint32>("search.EXPIRE_INTERVAL")));
            timer->async_wait(std::bind(&SearchServer::periodicCleanup, this, std::placeholders::_1, timer));
        }
    }
}
