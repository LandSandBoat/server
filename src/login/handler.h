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

#include "auth_session.h"
#include "data_session.h"
#include "view_session.h"

template <typename T>
class handler
{
public:
    handler(asio::io_context& io_context, unsigned int port)
    : acceptor_(io_context, asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port))
    , sslContext_(asio::ssl::context::tls_server)
    {
        acceptor_.set_option(asio::socket_base::reuse_address(true));

        sslContext_.set_options(asio::ssl::context::default_workarounds | asio::ssl::context::verify_fail_if_no_peer_cert);
        sslContext_.set_default_verify_paths();
        sslContext_.use_rsa_private_key_file("login.key", asio::ssl::context::file_format::pem);
        sslContext_.use_certificate_chain_file("login.cert");

        do_accept();
    }

private:
    void do_accept()
    {
        // clang-format off
        acceptor_.async_accept(
        [this](std::error_code ec, asio::ip::tcp::socket socket)
        {
            if (!ec)
            {
                if constexpr (std::is_same_v<T, auth_session>)
                {
                    auto auth_handler = std::make_shared<T>(asio::ssl::stream<asio::ip::tcp::socket>(std::move(socket), sslContext_));
                    auth_handler->start();
                }
                else if constexpr (std::is_same_v<T, view_session>)
                {
                    auto view_handler = std::make_shared<T>(asio::ssl::stream<asio::ip::tcp::socket>(std::move(socket), sslContext_));
                    view_handler->start();
                }
                else if constexpr (std::is_same_v<T, data_session>)
                {
                    auto data_handler = std::make_shared<T>(asio::ssl::stream<asio::ip::tcp::socket>(std::move(socket), sslContext_));
                    data_handler->start();
                }
            }
            else
            {
                ShowError(ec.message());
            }

            do_accept();
        });
        // clang-format on
    }

    asio::ip::tcp::acceptor acceptor_;
    asio::ssl::context      sslContext_;
};
