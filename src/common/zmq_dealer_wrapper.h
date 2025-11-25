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

#include "common/ipp.h"
#include "common/logging.h"

#include <atomic>
#include <memory>
#include <thread>

#include <concurrentqueue.h>
#include <zmq.hpp>
#include <zmq_addon.hpp>

class ZMQDealerWrapper final
{
    class ZMQWorker final
    {
    public:
        ZMQWorker(std::atomic<bool>&                           requestExit,
                  moodycamel::ConcurrentQueue<zmq::message_t>& incomingQueue,
                  moodycamel::ConcurrentQueue<zmq::message_t>& outgoingQueue,
                  const std::string&                           endpoint,
                  uint64_t                                     routingId)
        : requestExit_(requestExit)
        , incomingQueue_(incomingQueue)
        , outgoingQueue_(outgoingQueue)
        , zmqContext_(1)
        , zmqSocket_(zmqContext_, zmq::socket_type::dealer)
        {
            zmqSocket_.set(zmq::sockopt::routing_id, zmq::const_buffer(&routingId, sizeof(uint64)));
            zmqSocket_.set(zmq::sockopt::rcvtimeo, 200);

            try
            {
                zmqSocket_.connect(endpoint);
            }
            catch (zmq::error_t& err)
            {
                throw std::runtime_error(fmt::format("Unable to bind chat socket: {}", err.what()));
            }

            listen();
        }

        ~ZMQWorker()
        {
            zmqSocket_.close();
            zmqContext_.close();
        }

    private:
        void listen()
        {
            while (!requestExit_)
            {
                TracyZoneScoped;

                zmq::message_t msg;
                try
                {
                    if (!zmqSocket_.recv(msg, zmq::recv_flags::none))
                    {
                        while (outgoingQueue_.try_dequeue(msg))
                        {
                            zmqSocket_.send(msg, zmq::send_flags::none);
                        }
                        continue;
                    }

                    incomingQueue_.enqueue(std::move(msg));
                }
                catch (zmq::error_t& e)
                {
                    // Context was terminated (ETERM = 156384765)
                    // Exit loop
                    if (e.num() == 156384765)
                    {
                        return;
                    }

                    ShowError(fmt::format("Message: {}", e.what()));
                    continue;
                }
            }
        }

    private:
        std::atomic<bool>& requestExit_;

        moodycamel::ConcurrentQueue<zmq::message_t>& incomingQueue_;
        moodycamel::ConcurrentQueue<zmq::message_t>& outgoingQueue_;

        zmq::context_t zmqContext_;
        zmq::socket_t  zmqSocket_;
    };

public:
    ZMQDealerWrapper(const std::string& endpoint, uint64 routingId)
    : requestExit_(false)
    , thread_(
          [this, endpoint, routingId]()
          {
              ZMQWorker worker(requestExit_, incomingQueue_, outgoingQueue_, endpoint, routingId);
          })
    {
    }

    ~ZMQDealerWrapper()
    {
        requestExit_ = true;
        thread_.join();
    }

    moodycamel::ConcurrentQueue<zmq::message_t> incomingQueue_;
    moodycamel::ConcurrentQueue<zmq::message_t> outgoingQueue_;

private:
    std::atomic<bool> requestExit_;
    std::jthread      thread_;
};
