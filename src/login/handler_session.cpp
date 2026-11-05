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
        // Enable keepalives for long sessions (view_session in particular)
        socket_.lowest_layer().set_option(asio::socket_base::keep_alive(true));

        socket_.lowest_layer().set_option(asio::detail::socket_option::integer<IPPROTO_TCP, TCP_KEEPINTVL>(5 * 60)); // interval between keepalive
        socket_.lowest_layer().set_option(asio::detail::socket_option::integer<IPPROTO_TCP, TCP_KEEPCNT>(10));       // failed keepalives before declaring dead

#ifdef __APPLE__
        socket_.lowest_layer().set_option(asio::detail::socket_option::integer<IPPROTO_TCP, TCP_KEEPALIVE>(5 * 60)); // secs before keepalive probes
#else
        socket_.lowest_layer().set_option(asio::detail::socket_option::integer<IPPROTO_TCP, TCP_KEEPIDLE>(5 * 60)); // secs before keepalive probes
#endif

        socket_.async_handshake(
            asio::ssl::stream_base::server,
            [this, self = shared_from_this()](std::error_code ec)
            {
                if (!ec)
                {
                    do_read();
                    return;
                }

                const auto errStr = fmt::format("Error from {}: (EC: {}), {}", ipAddress, ec.value(), ec.message());
                ShowWarning(errStr);
                ShowWarning("Failed to handshake!");
                if (errStr.contains("wrong version number (SSL routines)"))
                {
                    ShowWarning("This is likely due to the client using an outdated/incompatible version of xiloader.");
                    ShowWarning("Please make sure you're using the latest release: https://github.com/LandSandBoat/xiloader/releases");
                }

                socket_.lowest_layer().close();
            });
    }
}

void handler_session::do_read()
{
    std::memset(buffer_.data(), 0, buffer_.size());

    socket_.async_read_some(
        asio::buffer(buffer_.data(), buffer_.size()),
        [this, self = shared_from_this()](std::error_code ec, std::size_t length)
        {
            if (!ec)
            {
                read_func();
            }
            else
            {
                DebugSockets(fmt::format("async_read_some error in handler_session from IP {} ({}: {})", ipAddress, ec.value(), ec.message()));
                handle_error(ec, self);
            }
        });
}

void handler_session::do_write(std::size_t length)
{
    asio::async_write(
        socket_,
        asio::buffer(buffer_.data(), length),
        [this, self = shared_from_this()](std::error_code ec, std::size_t /*length*/)
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
}
