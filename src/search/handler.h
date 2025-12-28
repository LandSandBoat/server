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

#include "search_handler.h"

class handler
{
public:
    handler(asio::io_context& io_context, unsigned int port, SynchronizedShared<std::unordered_set<std::string>>& ipWhitelist)
    : acceptor_(io_context, asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port))
    {
        acceptor_.set_option(asio::socket_base::reuse_address(true));

        do_accept(
            [&](asio::ip::tcp::socket socket)
            {
                const auto handler = std::make_shared<search_handler>(std::move(socket), io_context, ipInFlight_, ipWhitelist);
                handler->start();
            });
    }

private:
    void do_accept(std::function<void(asio::ip::tcp::socket&&)> acceptFn)
    {
        acceptor_.async_accept(
            [this, acceptFn](const std::error_code ec, asio::ip::tcp::socket socket)
            {
                if (!ec)
                {
                    acceptFn(std::move(socket));
                }
                else
                {
                    // TODO: This can't be the Fmt variant because of constexpr things?
                    ShowError(ec.message());
                }

                do_accept(acceptFn);
            });
    }

    asio::ip::tcp::acceptor acceptor_;

    // A single IP should only have one request in flight at a time, so we are going to
    // be tracking the IP addresses of incoming requests and if we haven't cleared the
    // record for it - we block until it's done
    SynchronizedShared<std::map<std::string, uint16_t>> ipInFlight_;
};
