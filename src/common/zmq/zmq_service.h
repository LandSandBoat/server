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

#include <common/cbasetypes.h>
#include <common/ipp_message.h>
#include <common/zmq/channel.h>
#include <common/zmq/endpoint.h>

#include <atomic>
#include <memory>
#include <string>
#include <thread>

#include <concurrentqueue.h>
#include <zmq.hpp>

//
// ZMQService
//
//   Owns a single zmq::context_t and a single I/O thread running ONE zmq_poll loop over every
//   registered socket. Endpoints are created, bound/connected, polled, and closed exclusively on the
//   I/O thread (ZMQ sockets are not thread-safe). Producers/consumers exchange messages with the I/O
//   thread through each endpoint's lock-free queues, through a non-owning ipc::Channel.
//
class ZMQService final
{
public:
    explicit ZMQService(std::string threadName = "ZMQ I/O");
    ~ZMQService();

    ZMQService(const ZMQService&)            = delete;
    ZMQService& operator=(const ZMQService&) = delete;
    ZMQService(ZMQService&&)                 = delete;
    ZMQService& operator=(ZMQService&&)      = delete;

    [[nodiscard]] auto registerRouter(const std::string& endpoint) -> ipc::Channel<IPPMessage>;

    [[nodiscard]] auto registerDealer(const std::string& endpoint, uint64 routingId) -> ipc::Channel<zmq::message_t>;

    auto stop() noexcept -> void;

private:
    // I/O thread body
    auto run() -> void;

    auto drainPending(std::vector<std::unique_ptr<ZmqEndpoint>>& endpoints) -> bool;

    std::string       threadName_;
    zmq::context_t    context_{ 1 };
    std::atomic<bool> stop_{ false };

    moodycamel::ConcurrentQueue<std::unique_ptr<ZmqEndpoint>> pendingRegistrations_;

    std::jthread thread_;
};
