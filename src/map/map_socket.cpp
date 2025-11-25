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

#include "map_socket.h"

#include "common/logging.h"

MapSocket::MapSocket(asio::io_context& io_context, const uint16 port, ReceiveFn onReceiveFn)
: port_(port)
, io_context_(io_context)
, socket_(io_context)
, buffer_{}
, isRunning(true)
, onReceiveFn_(std::move(onReceiveFn))
{
    TracyZoneScoped;

    ShowInfoFmt("MapSocket: Starting on port {}", port_);

    asio::ip::udp::endpoint listen_endpoint(asio::ip::udp::v4(), port_);
    socket_.open(listen_endpoint.protocol());
    socket_.bind(listen_endpoint);

    startReceive();
}

MapSocket::~MapSocket()
{
    TracyZoneScoped;

    if (socket_.is_open())
    {
        socket_.close();
    }
}

void MapSocket::startReceive()
{
    TracyZoneScoped;

    socket_.async_receive_from(
        asio::buffer(buffer_), remote_endpoint_, [this](const std::error_code& ec, std::size_t bytes_recvd)
        {
            // NOTE: ASIO returns the address in host byte order, but we store it in network byte order,
            //     : so we convert it back.
            const auto sender_ip   = htonl(remote_endpoint_.address().to_v4().to_uint());
            const auto sender_port = remote_endpoint_.port();
            const auto ipp         = IPP(sender_ip, sender_port);

            const auto buffer = std::span(buffer_.data(), bytes_recvd);

            DebugPacketsFmt("Received {} bytes from {}", buffer.size(), ipp.toString());

            onReceiveFn_(ec, buffer, ipp);

            if (!io_context_.stopped() && socket_.is_open())
            {
                startReceive(); // Queue up more work
            }
        });
}

void MapSocket::recvFor(timer::duration duration)
{
    TracyZoneScoped;

    // Blocks until the duration is up
    io_context_.run_for(duration);

    // Once run_for() or run() return the io_context enters a stopped state,
    // even if there are still pending asynchronous operations. You need to
    // call restart() to clear that state before you can run it again.
    if (isRunning)
    {
        io_context_.restart();
    }
}

void MapSocket::send(const IPP& ipp, std::span<uint8> buffer)
{
    TracyZoneScoped;

    DebugPacketsFmt("Sending {} bytes to {}", buffer.size(), ipp.toString());

    // Like with the ip from startReceive(), ASIO is expecting us to be handling it
    // in host byte order, but we store it in network byte order. So, we need to convert it.
    const auto ip       = ntohl(ipp.getIP());
    const auto endpoint = asio::ip::udp::endpoint(asio::ip::address_v4(ip), ipp.getPort());

    socket_.async_send_to(
        asio::buffer(buffer),
        endpoint,
        [](const std::error_code& ec, std::size_t /*bytes_sent*/)
        {
            if (ec)
            {
                ShowErrorFmt("Error sending data: {}", ec.message());
            }
        });

    // This will only be called in the middle of a doSocketsFor() call, so we don't
    // need to enqueue more work when we're done here.
}

void MapSocket::requestExit()
{
    isRunning = false;
    io_context_.stop();
}
