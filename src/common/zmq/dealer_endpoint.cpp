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

#include <common/zmq/dealer_endpoint.h>

#include <common/logging.h>

#include <utility>

DealerEndpoint::DealerEndpoint(std::string endpoint, uint64 routingId)
: endpoint_(std::move(endpoint))
, routingId_(routingId)
{
}

auto DealerEndpoint::open(zmq::context_t& ctx) -> bool
{
    socket_ = zmq::socket_t(ctx, zmq::socket_type::dealer);
    socket_.set(zmq::sockopt::routing_id, zmq::const_buffer(&routingId_, sizeof(uint64)));
    try
    {
        socket_.connect(endpoint_);
        opened_.store(true, std::memory_order_release);
    }
    catch (const zmq::error_t& err)
    {
        ShowError(fmt::format("ZMQService: unable to connect dealer socket '{}': {}", endpoint_, err.what()));
        opened_.store(false, std::memory_order_release);
    }
    return opened_.load(std::memory_order_acquire);
}

auto DealerEndpoint::close() -> void
{
    if (socket_)
    {
        socket_.close();
    }
}

auto DealerEndpoint::socketHandle() -> void*
{
    return socket_.handle();
}

auto DealerEndpoint::onReadable() -> void
{
    while (true)
    {
        zmq::message_t msg;
        if (!socket_.recv(msg, zmq::recv_flags::dontwait))
        {
            break;
        }
        incomingQueue_.enqueue(std::move(msg));
    }
}

auto DealerEndpoint::flushOutbound() -> void
{
    zmq::message_t out;
    while (outgoingQueue_.try_dequeue(out))
    {
        socket_.send(out, zmq::send_flags::dontwait);
    }
}
