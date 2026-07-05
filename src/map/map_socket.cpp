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

#include <common/logging.h>

MapSocket::MapSocket(Scheduler& scheduler, MapStatistics& mapStatistics, const uint16 port, ReceiveFn onReceiveFn)
: scheduler_(scheduler)
, mapStatistics_(mapStatistics)
, port_(port)
, inFlightSends_(0)
, sendsBlockedThisTick_(0)
, sendsDroppedThisTick_(0)
, socket_(scheduler_.mainContext())
, buffer_{}
, onReceiveFn_(std::move(onReceiveFn))
{
    TracyZoneScoped;

    ShowInfoFmt("MapSocket: Starting on port {}", port_);

    asio::ip::udp::endpoint listen_endpoint(asio::ip::udp::v4(), port_);
    socket_.open(listen_endpoint.protocol());
    socket_.bind(listen_endpoint);

    receive(); // begin receiving loop
}

MapSocket::~MapSocket()
{
    TracyZoneScoped;

    if (socket_.is_open())
    {
        socket_.close();
    }
}

void MapSocket::receive()
{
    TracyZoneScoped;

    socket_.async_receive_from(
        asio::buffer(buffer_), remoteEndpoint_, [this](const std::error_code& ec, std::size_t bytesRecvd)
        {
            // NOTE: ASIO returns the address in host byte order, but we store it in network byte order,
            //     : so we convert it back.
            const auto senderIP   = htonl(remoteEndpoint_.address().to_v4().to_uint());
            const auto senderPort = remoteEndpoint_.port();
            const auto ipp        = IPP(senderIP, senderPort);

            const auto sizedBuffer = ByteSpan(buffer_.data(), bytesRecvd);

            DebugPacketsFmt("Received {} bytes from {}", sizedBuffer.size(), ipp.toString());

            if (ec)
            {
                ShowErrorFmt("Receive error from {}: {}", ipp.toString(), ec.message());
            }
            else if (sizedBuffer.empty())
            {
                ShowErrorFmt("Received empty buffer from {}", ipp.toString());
            }
            else // Everything is OK
            {
                onReceiveFn_(sizedBuffer, ipp);
            }

            if (!scheduler_.closeRequested() && socket_.is_open())
            {
                receive(); // Queue up more work
            }
        });
}

void MapSocket::send(const IPP& ipp, ByteSpan buffer)
{
    TracyZoneScoped;

    DebugPacketsFmt("Sending {} bytes to {}", buffer.size(), ipp.toString());

    // Like with the ip from startReceive(), ASIO is expecting us to be handling it
    // in host byte order, but we store it in network byte order. So, we need to convert it.
    const auto ip       = ntohl(ipp.getIP());
    const auto endpoint = asio::ip::udp::endpoint(asio::ip::address_v4(ip), ipp.getPort());

    // Sends normally complete near-instantly. If the OS send path is backing up, completions
    // arrive late (on POSIX, ASIO silently parks would-block sends until the socket is
    // writable again) and the in-flight count climbs. Its per-tick high-water mark is the
    // backpressure signal that send error codes alone can't show.
    ++inFlightSends_;
    mapStatistics_.set(MapStatistics::Key::MaxInFlightSendsPerTick,
                       std::max(mapStatistics_.get(MapStatistics::Key::MaxInFlightSendsPerTick), inFlightSends_));

    socket_.async_send_to(
        asio::buffer(buffer),
        endpoint,
        [this](const std::error_code& ec, std::size_t bytesSent)
        {
            --inFlightSends_;

            if (ec)
            {
                // ENOBUFS/EWOULDBLOCK (WSAENOBUFS/WSAEWOULDBLOCK on Windows): the OS couldn't
                // accept the datagram right now, i.e. the send path is backing up.
                // Aggregated and logged once per tick in flushDiagnostics(), so a burst of
                // failures can't flood the log while the server is already under pressure.
                if (ec == asio::error::no_buffer_space ||
                    ec == asio::error::would_block ||
                    ec == asio::error::try_again)
                {
                    mapStatistics_.increment(MapStatistics::Key::TotalSendsBlockedPerTick);
                    ++sendsBlockedThisTick_;
                    blockedReasons_.insert(ec);
                }
                else
                {
                    mapStatistics_.increment(MapStatistics::Key::TotalSendErrorsPerTick);
                    ++sendsDroppedThisTick_;
                    droppedReasons_.insert(ec);
                }
            }
            else
            {
                mapStatistics_.increment(MapStatistics::Key::TotalBytesSentPerTick, static_cast<int64>(bytesSent));
            }
        });

    // This will only be called in the middle of a doSocketsFor() call, so we don't
    // need to enqueue more work when we're done here.
}

void MapSocket::flushDiagnostics()
{
    TracyZoneScoped;

    const auto reasonsToString = [](const std::set<std::error_code>& reasons)
    {
        std::string out;
        for (const auto& reason : reasons)
        {
            out += (out.empty() ? "" : ", ") + reason.message();
        }
        return out;
    };

    if (sendsBlockedThisTick_ > 0)
    {
        ShowWarningFmt("{} sends pushed back by the OS this tick (send path backing up, datagrams dropped). Reasons: {}",
                       sendsBlockedThisTick_,
                       reasonsToString(blockedReasons_));
    }

    if (sendsDroppedThisTick_ > 0)
    {
        ShowErrorFmt("{} sends failed this tick (datagrams dropped). Reasons: {}",
                     sendsDroppedThisTick_,
                     reasonsToString(droppedReasons_));
    }

    sendsBlockedThisTick_ = 0;
    sendsDroppedThisTick_ = 0;
    blockedReasons_.clear();
    droppedReasons_.clear();
}
