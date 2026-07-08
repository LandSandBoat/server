/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include <atomic>

#include <zmq.hpp>

class ZmqEndpoint
{
public:
    ZmqEndpoint() = default;
    virtual ~ZmqEndpoint();

    ZmqEndpoint(const ZmqEndpoint&)            = delete;
    ZmqEndpoint& operator=(const ZmqEndpoint&) = delete;
    ZmqEndpoint(ZmqEndpoint&&)                 = delete;
    ZmqEndpoint& operator=(ZmqEndpoint&&)      = delete;

    [[nodiscard]] auto opened() const -> bool;

    // Create the socket from ctx, set options, and bind/connect.
    virtual auto open(zmq::context_t& ctx) -> bool = 0;

    // Close the socket.
    virtual auto close() -> void = 0;

    // Raw 0MQ socket handle for zmq_pollitem_t.
    virtual auto socketHandle() -> void* = 0;

    // Drain all currently-available inbound messages into the incoming queue.
    virtual auto onReadable() -> void = 0;

    // Send everything queued for outbound.
    virtual auto flushOutbound() -> void = 0;

protected:
    std::atomic<bool> opened_{ false };
};
