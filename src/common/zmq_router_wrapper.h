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

struct IPPMessage
{
    IPP                ipp;
    std::vector<uint8> payload;
};

class ZMQRouterWrapper final
{
    class ZMQWorker final
    {
    public:
        ZMQWorker(std::atomic<bool>&                       requestExit,
                  moodycamel::ConcurrentQueue<IPPMessage>& incomingQueue,
                  moodycamel::ConcurrentQueue<IPPMessage>& outgoingQueue,
                  const std::string&                       endpoint)
        : requestExit_(requestExit)
        , incomingQueue_(incomingQueue)
        , outgoingQueue_(outgoingQueue)
        , zmqContext_(1)
        , zmqSocket_(zmqContext_, zmq::socket_type::router)
        {
            zmqSocket_.set(zmq::sockopt::rcvtimeo, 200);

            try
            {
                zmqSocket_.bind(endpoint);
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

                // Since we are a zmq::socket_type::router, we expect a multipart message:
                // [routing id (IPP), message]
                std::array<zmq::message_t, 2> msgs;
                try
                {
                    if (!zmq::recv_multipart_n(zmqSocket_, msgs.data(), msgs.size(), zmq::recv_flags::none))
                    {
                        IPPMessage msg;
                        while (outgoingQueue_.try_dequeue(msg))
                        {
                            // We send the same way as we receive: [routing id (IPP), message]
                            msgs[0] = msg.ipp.toZMQMessage();
                            msgs[1] = zmq::message_t(msg.payload);
                            zmq::send_multipart(zmqSocket_, msgs, zmq::send_flags::none);
                        }
                        continue;
                    }
                }
                catch (zmq::error_t& e)
                {
                    // Context was terminated
                    // Exit loop
                    if (e.num() == 156384765) // ETERM
                    {
                        return;
                    }

                    ShowError(fmt::format("Message: {}", e.what()));
                    continue;
                }

                // Handle incoming message
                auto& from = msgs[0];
                auto& data = msgs[1];

                // TODO: Reduce copies here

                auto ipp     = IPP(from);
                auto payload = std::vector<uint8>(data.data<uint8>(), data.data<uint8>() + data.size());

                incomingQueue_.enqueue(IPPMessage{ ipp, payload });
            }
        }

    private:
        std::atomic<bool>& requestExit_;

        moodycamel::ConcurrentQueue<IPPMessage>& incomingQueue_;
        moodycamel::ConcurrentQueue<IPPMessage>& outgoingQueue_;

        zmq::context_t zmqContext_;
        zmq::socket_t  zmqSocket_;
    };

public:
    ZMQRouterWrapper(const std::string& endpoint)
    : requestExit_(false)
    , thread_(
          [this, endpoint]()
          {
              TracySetThreadName("Message Server (ZMQ)");
              ZMQWorker worker(requestExit_, incomingQueue_, outgoingQueue_, endpoint);
          })
    {
    }

    ~ZMQRouterWrapper()
    {
        requestExit_ = true;
        thread_.join();
    }

    moodycamel::ConcurrentQueue<IPPMessage> incomingQueue_;
    moodycamel::ConcurrentQueue<IPPMessage> outgoingQueue_;

private:
    std::atomic<bool> requestExit_;
    std::jthread      thread_;
};
