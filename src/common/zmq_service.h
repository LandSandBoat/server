/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include <iostream>
#include <memory>
#include <string>
#include <thread>
#include <concurrentqueue.h>

#include "logging_service.h"
#include "mmo.h"
#include "sql.h"

#include "zmq.hpp"
#include "zmq_addon.hpp"

struct chat_message_t
{
    uint64         dest;
    MSGSERVTYPE    type;
    zmq::message_t data;
    zmq::message_t packet;
};

class ZMQService
{
public:
    ZMQService(zmq::socket_type type);
    ~ZMQService();

    void send(uint64 ipp, MSGSERVTYPE type, zmq::message_t* extra, zmq::message_t* packet);
    auto recv() -> std::vector<chat_message_t>;

private:
    // For use by the internal thread only
    void _init(zmq::socket_type type);
    void _destroy();
    void _send(uint64 ipp, MSGSERVTYPE type, zmq::message_t* extra, zmq::message_t* packet);
    void _parse(MSGSERVTYPE type, zmq::message_t* extra, zmq::message_t* packet, zmq::message_t* from);
    void _listen();

    std::thread zmqThread;
    std::atomic<bool> running;

    std::unique_ptr<zmq::context_t> pContext;
    std::unique_ptr<zmq::socket_t>  pSocket;
    std::string address;

    std::unique_ptr<SqlConnection> zmqSql;

    moodycamel::ConcurrentQueue<chat_message_t> incoming_queue;
    moodycamel::ConcurrentQueue<chat_message_t> outgoing_queue;
};
