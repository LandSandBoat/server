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

#include "handler_session.h"

handler_session::handler_session(asio::ssl::stream<asio::ip::tcp::socket> socket)
: socket_(std::move(socket))
{
    asio::error_code ec = {};
    socket_.lowest_layer().set_option(asio::socket_base::reuse_address(true));
    ipAddress = socket_.lowest_layer().remote_endpoint(ec).address().to_string();

    if (ec)
    {
        ipAddress = "error";
        socket_.lowest_layer().close();
    }
}

void handler_session::start()
{
    if (socket_.lowest_layer().is_open())
    {
        do_read();
    }
}

void handler_session::do_read()
{
    auto self(shared_from_this());

    // clang-format off
    socket_.next_layer().async_read_some(asio::buffer(data_, max_length),
    [this, self](std::error_code ec, std::size_t length)
    {
        if (!ec)
        {
            read_func();
        }
        else
        {
            DebugSockets("async_read_some error in from IP {}:\n{}", ipAddress, ec.message());
            handle_error(ec, self);
        }
    });
    // clang-format on
}

void handler_session::do_write(std::size_t length)
{
    auto self(shared_from_this());
    // clang-format off
    asio::async_write(socket_.next_layer(), asio::buffer(data_, length),
    [this, self](std::error_code ec, std::size_t /*length*/)
    {
        if (!ec)
        {
            write_func();
        }
        else
        {
            ShowError(ec.message());
        }
    });
    // clang-format on
}
