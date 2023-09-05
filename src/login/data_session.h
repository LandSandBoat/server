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

#include <asio/ts/buffer.hpp>
#include <asio/ts/internet.hpp>

#include "handler_session.h"
#include "login_errors.h"
#include "login_helpers.h"
#include "login_packets.h"

// port 54230
class data_session : public handler_session
{
public:
    data_session(asio::ssl::stream<asio::ip::tcp::socket> socket)
    : handler_session(std::move(socket))
    {
        DebugSockets("data_session from IP %s", ipAddress);
    }

protected:
    void read_func() override;

    void write_func() override
    {
        do_read();
    }

    void handle_error(std::error_code ec, std::shared_ptr<handler_session> self) override;
};
