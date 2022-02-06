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

#include "application.h"
#include "logging_service.h"

#include "zmq.hpp"
// #include "zmq_addon.hpp"

class ZMQService final : public Singleton<ZMQService>
{
public:
    ZMQService()
    {
        pContext = std::make_unique<zmq::context_t>();
        pSocket  = std::make_unique<zmq::socket_t>(*pContext, zmq::socket_type::router);

        pSocket->bind("tcp://127.0.0.1:6666");
    }

    virtual ~ZMQService()
    {
    };
private:
    std::unique_ptr<zmq::context_t> pContext;
    std::unique_ptr<zmq::socket_t>  pSocket;
};
