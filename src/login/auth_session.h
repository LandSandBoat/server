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

#include "handler_session.h"
#include "login_helpers.h"

// TODO: Move to enum
#define LOGIN_ATTEMPT         0x10
#define LOGIN_CREATE          0x20
#define LOGIN_CHANGE_PASSWORD 0x30

/*return result*/
#define LOGIN_FAIL                    0x00
#define LOGIN_SUCCESS                 0x01
#define LOGIN_SUCCESS_CREATE          0x03
#define LOGIN_SUCCESS_CHANGE_PASSWORD 0x06

#define LOGIN_REQUEST_NEW_PASSWORD 0x05

#define LOGIN_ERROR                     0x02
#define LOGIN_ERROR_CREATE              0x09
#define LOGIN_ERROR_CREATE_TAKEN        0x04
#define LOGIN_ERROR_CREATE_DISABLED     0x08
#define LOGIN_ERROR_CHANGE_PASSWORD     0x07
#define LOGIN_ERROR_ALREADY_LOGGED_IN   0x0A
#define LOGIN_ERROR_VERSION_UNSUPPORTED 0x0B

#define SUPPORTED_XILOADER_VERSION "1.0.0"

// NOTE: This collection of flags is 64-bits wide!
enum AUTH_COMPONENTS
{
    // Information to be sent during login sequence.
    // Each item is added to the data sequentially,
    // after username and password, which are mandatory:
    // [username][password][email]
    // If you opted not to use email:
    // [username][password]
    SEND_EMAIL       = 1 << 0,
    SEND_HOSTNAME    = 1 << 1,
    SEND_MAC_ADDRESS = 1 << 2,

    // These flags enable additional workflows between connect and xiloader
    ENABLE_ACCOUNT_CREATE  = 1 << 3, // Ability for a user to create an account
    ENABLE_ACCOUNT_DELETE  = 1 << 4, // Ability for a user to delete their account
    ENABLE_PASSWORD_CHANGE = 1 << 5, // Ability for a user to change their password through xiloader
    ENABLE_PASSWORD_RESET  = 1 << 6, // Ability for a user to flag their account for a password reset through connect server
};

enum ACCOUNT_STATUS_CODE : uint8
{
    NORMAL = 0x01,
    BANNED = 0x02,
};

enum ACCOUNT_PRIVILEGE_CODE : uint8
{
    USER  = 0x01,
    ADMIN = 0x02,
    ROOT  = 0x04,
};

// Interaction with xiloader, port 54231
class auth_session : public handler_session
{
public:
    auth_session(asio::ssl::stream<asio::ip::tcp::socket> socket)
    : handler_session(std::move(socket))
    {
        DebugSockets(fmt::format("auth_session from {}", ipAddress));
    }

public:
    void start();

protected:
    void do_read();

    void read_func() override;

    void write_func() override
    {
        do_read();
    }

    void handle_error(std::error_code ec, std::shared_ptr<handler_session> self) override
    {
        // Intentionally do not log any errors
        // Most errors are extremely noisy, any connection that's been dropped (Such as port scanners) will log an error
    }

    void do_write(std::size_t length);
};
