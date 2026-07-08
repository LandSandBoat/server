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

#pragma once

#include <asio/ts/buffer.hpp>
#include <asio/ts/internet.hpp>
#include <common/logging.h>

#include "common/scheduler.h"
#include "search_handler.h"

class SearchListener
{
public:
    SearchListener(Scheduler& scheduler, unsigned int port, SynchronizedShared<std::unordered_set<std::string>>& ipWhitelist)
    : scheduler_(scheduler)
    , acceptor_(scheduler_.mainContext(), asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port))
    , ipWhitelist_(ipWhitelist)
    {
        acceptor_.set_option(asio::socket_base::reuse_address(true));

        scheduler_.postToMainThread(accept_loop());
    }

private:
    auto accept_loop() -> Task<void>
    {
        // Run "forever"
        while (!scheduler_.closeRequested())
        {
            auto [ec, socket] = co_await acceptor_.async_accept(asio::as_tuple(asio::use_awaitable));

            if (!ec)
            {
                auto handler = std::make_shared<SearchHandler>(scheduler_, std::move(socket), ipInFlight_, ipWhitelist_);
                scheduler_.postToMainThread(handler->run());
            }
            else
            {
                ShowErrorFmt("Failed to accept connection: {}", ec.message());
            }
        }
    }

    Scheduler&              scheduler_;
    asio::ip::tcp::acceptor acceptor_;

    SynchronizedShared<std::unordered_set<std::string>>& ipWhitelist_;
    SynchronizedShared<std::map<std::string, uint16_t>>  ipInFlight_;
};
