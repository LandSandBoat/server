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

#include <common/zmq/zmq_service.h>

#include <common/logging.h>
#include <common/tracy.h>
#include <common/zmq/dealer_endpoint.h>
#include <common/zmq/router_endpoint.h>

#include <utility>

namespace
{

constexpr long kPollTimeoutMs = 10;

} // namespace

ZMQService::ZMQService(std::string threadName)
: threadName_(std::move(threadName))
, thread_(
      [this]()
      {
          run();
      })
{
}

ZMQService::~ZMQService()
{
    stop();
}

auto ZMQService::stop() noexcept -> void
{
    stop_.store(true, std::memory_order_relaxed);
    if (thread_.joinable())
    {
        thread_.join();
    }
}

auto ZMQService::registerRouter(const std::string& endpoint) -> ipc::Channel<IPPMessage>
{
    auto owned = std::make_unique<RouterEndpoint>(endpoint);

    RouterEndpoint& ep = *owned;

    // Fire-and-forget: the I/O thread opens it. The channel below is usable immediately (it references
    // queues that exist now); if bind fails the endpoint logs it and nothing flows.
    pendingRegistrations_.enqueue(std::move(owned));

    return ipc::Channel<IPPMessage>{ ep.incomingQueue_, ep.outgoingQueue_ };
}

auto ZMQService::registerDealer(const std::string& endpoint, uint64 routingId) -> ipc::Channel<zmq::message_t>
{
    auto owned = std::make_unique<DealerEndpoint>(endpoint, routingId);

    DealerEndpoint& ep = *owned;

    pendingRegistrations_.enqueue(std::move(owned));

    return ipc::Channel<zmq::message_t>{ ep.incomingQueue_, ep.outgoingQueue_ };
}

auto ZMQService::drainPending(std::vector<std::unique_ptr<ZmqEndpoint>>& endpoints) -> bool
{
    bool added = false;

    std::unique_ptr<ZmqEndpoint> endpoint;
    while (pendingRegistrations_.try_dequeue(endpoint))
    {
        endpoint->open(context_);
        endpoints.push_back(std::move(endpoint));
        added = true;
    }

    return added;
}

auto ZMQService::run() -> void
{
    TracySetThreadName(threadName_.c_str());

    std::vector<std::unique_ptr<ZmqEndpoint>> endpoints;

    // Poll set, rebuilt only when an endpoint is added (registrations are rare). zmq_poll refreshes
    // each item's revents every call, so the cached items/polled can be reused between rebuilds.
    std::vector<zmq_pollitem_t> items;
    std::vector<ZmqEndpoint*>   polled;

    bool rebuild = false;

    try
    {
        while (!stop_.load(std::memory_order_relaxed))
        {
            // Apply pending registrations: open sockets on this thread.
            if (drainPending(endpoints))
            {
                rebuild = true;
            }

            if (stop_.load(std::memory_order_relaxed))
            {
                break;
            }

            if (rebuild)
            {
                items.clear();
                polled.clear();
                for (auto& ep : endpoints) // poll only the endpoints that opened successfully
                {
                    if (ep->opened())
                    {
                        items.push_back(zmq_pollitem_t{ ep->socketHandle(), 0, ZMQ_POLLIN, 0 });
                        polled.push_back(ep.get());
                    }
                }
                rebuild = false;
            }

            zmq_pollitem_t* pollItems = nullptr;
            if (!items.empty())
            {
                pollItems = items.data();
            }

            const int rc = zmq_poll(pollItems, static_cast<int>(items.size()), kPollTimeoutMs);
            if (rc < 0)
            {
                if (zmq_errno() == ETERM)
                {
                    break;
                }
                ShowError(fmt::format("ZMQService zmq_poll error: {}", zmq_strerror(zmq_errno())));
                continue;
            }

            for (std::size_t i = 0; i < polled.size(); ++i)
            {
                try
                {
                    if (items[i].revents & ZMQ_POLLIN)
                    {
                        polled[i]->onReadable();
                    }

                    polled[i]->flushOutbound();
                }
                catch (const zmq::error_t& e)
                {
                    if (e.num() == ETERM)
                    {
                        stop_.store(true, std::memory_order_relaxed);
                        break;
                    }
                    ShowError(fmt::format("ZMQService endpoint error: {}", e.what()));
                }
            }
        }
    }
    catch (const std::exception& e)
    {
        // Never let an exception escape the I/O thread
        ShowError(fmt::format("ZMQService I/O thread error: {}", e.what()));
    }

    // Close every socket on this (the I/O) thread before the context is torn down.
    for (auto& ep : endpoints)
    {
        ep->close();
    }
}
