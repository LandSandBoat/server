/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "asio.hpp"
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <iostream>
#include <memory>
#include <string>
#include <thread>
#include <unordered_map>
#include <vector>

struct Session
{
    uint64_t ipp;
};

static constexpr std::size_t MAX_BUFFER_SIZE = 1024;

using asio::ip::udp;

class MapNetworkHandler : public std::enable_shared_from_this<MapNetworkHandler>
{
public:
    NetworkHandler(asio::io_context& ioContext, unsigned short port)
    : socket(ioContext, udp::endpoint(udp::v4(), port))
    {
    }

    void queue_async_recv()
    {
        socket.async_receive_from(
            asio::buffer(buffer), // Reused for each receive.
            remoteEndpoint,       // Reused for each receive.
            [self = shared_from_this()](const asio::error_code& ec, std::size_t bytesRecvd)
            {
                self->handleReceive(ec, bytesRecvd);
            });
    }

    // Process network events for the given duration.
    void run_for(duration d)
    {
        socket.get_executor().context().run_for(d);
    }

private:
    // TODO: This should exist outside?
    std::shared_ptr<Session> lookupSession(uint64_t ipp)
    {
        auto it = sessions.find(ipp);
        if (it != sessions.end())
        {
            return it->second;
        }
        auto session  = std::make_shared<Session>();
        session->ipp  = ipp;
        sessions[ipp] = session;
        return session;
    }

    void handleReceive(const asio::error_code& ec, std::size_t bytesRecvd)
    {
        if (!ec && bytesRecvd > 0)
        {
            std::cout << "Received " << bytesRecvd << " bytes from "
                      << remoteEndpoint.address().to_string() << ":"
                      << remoteEndpoint.port() << std::endl;

            auto     ip   = remoteEndpoint.address().to_v4().to_ulong();
            uint16_t port = remoteEndpoint.port();
            uint64_t ipp  = ip;
            ipp |= (static_cast<uint64_t>(port) << 32);

            auto session = lookupSession(ipp);
            if (session)
            {
                std::cout << "Session found/created for ipp: " << ipp << std::endl;
                std::string data(buffer.data(), bytesRecvd);
                std::cout << "Data: " << data << std::endl;
            }
        }
        else if (ec)
        {
            std::cerr << "Receive error: " << ec.message() << std::endl;
        }

        // Queue the next asynchronous receive.
        queue_async_recv();
    }

    using SessionMap = std::unordered_map<uint64_t, std::shared_ptr<Session>>;
    using Buffer     = std::array<char, MAX_BUFFER_SIZE>;

    udp::socket   socket;
    udp::endpoint remoteEndpoint; // Reused for each receive.
    Buffer        buffer;         // Reused for each receive.

    SessionMap sessions;
};
