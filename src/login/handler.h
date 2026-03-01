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

#include "common/scheduler.h"
#include "common/zmq_dealer_wrapper.h"

template <typename T>
class handler
{
public:
    handler(Scheduler& scheduler, unsigned int port, ZMQDealerWrapper& zmqDealerWrapper)
    : scheduler_(scheduler)
    , acceptor_(scheduler_.ioContext(), asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port))
    , sslContext_(asio::ssl::context::tls_server)
    , zmqDealerWrapper_(zmqDealerWrapper)
    {
        acceptor_.set_option(asio::socket_base::reuse_address(true));

        sslContext_.set_options(asio::ssl::context::default_workarounds | asio::ssl::context::verify_fail_if_no_peer_cert);
        sslContext_.set_default_verify_paths();
        sslContext_.use_rsa_private_key_file("login.key", asio::ssl::context::file_format::pem);
        sslContext_.use_certificate_chain_file("login.cert");

        scheduler_.postToMainThread(accept_loop());
    }

private:
    auto accept_loop() -> Task<void>
    {
        while (!scheduler_.closeRequested())
        {
            auto [ec, socket] = co_await acceptor_.async_accept(asio::as_tuple(asio::use_awaitable));

            if (!ec)
            {
                const auto sessionHandler = std::make_shared<T>(asio::ssl::stream<asio::ip::tcp::socket>(std::move(socket), sslContext_), zmqDealerWrapper_);
                scheduler_.postToWorkerThread(
                    [sessionHandler]
                    {
                        sessionHandler->start();
                    });
            }
            else
            {
                ShowError(ec.message());
            }
        }
    }

    Scheduler&              scheduler_;
    asio::ip::tcp::acceptor acceptor_;
    asio::ssl::context      sslContext_;

    ZMQDealerWrapper& zmqDealerWrapper_;
};
