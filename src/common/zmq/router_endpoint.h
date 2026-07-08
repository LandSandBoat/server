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

#include <common/ipp_message.h>
#include <common/zmq/endpoint.h>

#include <string>

#include <concurrentqueue.h>
#include <zmq.hpp>

class RouterEndpoint final : public ZmqEndpoint
{
public:
    explicit RouterEndpoint(std::string endpoint);

    auto open(zmq::context_t& ctx) -> bool override;
    auto close() -> void override;
    auto socketHandle() -> void* override;
    auto onReadable() -> void override;
    auto flushOutbound() -> void override;

    moodycamel::ConcurrentQueue<IPPMessage> incomingQueue_;
    moodycamel::ConcurrentQueue<IPPMessage> outgoingQueue_;

private:
    std::string   endpoint_;
    zmq::socket_t socket_;
};
