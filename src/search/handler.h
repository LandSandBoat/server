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
    handler(asio::io_context& io_context, unsigned int port, std::function<void(asio::ip::tcp::socket&&)> acceptFn)
    : acceptor_(io_context, asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port))
    {
        acceptor_.set_option(asio::socket_base::reuse_address(true));
        do_accept(acceptFn);
    }

private:
    void do_accept(std::function<void(asio::ip::tcp::socket&&)> acceptFn)
    {
        // clang-format off
        acceptor_.async_accept(
        [this, acceptFn](std::error_code ec, asio::ip::tcp::socket socket)
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
        // clang-format on
    }

    asio::ip::tcp::acceptor acceptor_;
};
