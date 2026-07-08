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

#include <common/zmq/router_endpoint.h>

#include <common/ipp.h>
#include <common/logging.h>

#include <array>
#include <utility>

#include <zmq_addon.hpp>

RouterEndpoint::RouterEndpoint(std::string endpoint)
: endpoint_(std::move(endpoint))
{
}

auto RouterEndpoint::open(zmq::context_t& ctx) -> bool
{
    socket_ = zmq::socket_t(ctx, zmq::socket_type::router);
    try
    {
        socket_.bind(endpoint_);
        opened_.store(true, std::memory_order_release);
    }
    catch (const zmq::error_t& err)
    {
        ShowError(fmt::format(
            "IPC router could not bind '{}': {}. Is another xi_world or xi_test already bound to this "
            "endpoint? IPC will not function in this process.",
            endpoint_,
            err.what()));
        opened_.store(false, std::memory_order_release);
    }
    return opened_.load(std::memory_order_acquire);
}

auto RouterEndpoint::close() -> void
{
    if (socket_)
    {
        socket_.close();
    }
}

auto RouterEndpoint::socketHandle() -> void*
{
    return socket_.handle();
}

auto RouterEndpoint::onReadable() -> void
{
    while (true)
    {
        std::array<zmq::message_t, 2> msgs;
        if (!zmq::recv_multipart_n(socket_, msgs.data(), msgs.size(), zmq::recv_flags::dontwait))
        {
            break;
        }

        auto ipp     = IPP(msgs[0]);
        auto payload = std::vector<uint8>(msgs[1].data<uint8>(), msgs[1].data<uint8>() + msgs[1].size());
        incomingQueue_.enqueue(IPPMessage{ ipp, std::move(payload) });
    }
}

auto RouterEndpoint::flushOutbound() -> void
{
    IPPMessage out;
    while (outgoingQueue_.try_dequeue(out))
    {
        std::array<zmq::message_t, 2> msgs;
        msgs[0] = out.ipp.toZMQMessage();
        msgs[1] = zmq::message_t(out.payload);
        zmq::send_multipart(socket_, msgs, zmq::send_flags::dontwait);
    }
}
