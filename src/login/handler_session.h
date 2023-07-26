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

#include <asio/ssl.hpp>
#include <asio/ts/buffer.hpp>
#include <asio/ts/internet.hpp>
#include <common/logging.h>

class handler_session
: public std::enable_shared_from_this<handler_session>
{
public:
    handler_session(asio::ssl::stream<asio::ip::tcp::socket> socket);

    virtual ~handler_session() = default;

    void start();

    void do_read();

    virtual void handle_error(std::error_code ec, std::shared_ptr<handler_session> self) = 0;

    void do_write(std::size_t length);

    virtual void read_func()  = 0;
    virtual void write_func() = 0;

    std::string ipAddress;   // Store IP address in class -- once the file handle is invalid this can no longer be obtained from socket_
    std::string sessionHash; // Store session hash here additionally to clean up sockets easier

    asio::ssl::stream<asio::ip::tcp::socket> socket_;

    // TODO: Use std::array
    enum
    {
        max_length = 4096
    };
    char data_[max_length] = {};
};
