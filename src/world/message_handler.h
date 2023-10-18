/*
===========================================================================

Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "common/mmo.h"

#include <task_system.hpp>
#ifdef WIN32
#include <winsock2.h>
#else
#include <netinet/in.h>
#endif

/**
 * Class responsible for handling messages recieved from the message server.
 *
 * Implementations of this class are responsible for queueing any work
 * that affects internal state / sql queries via the given task system, using
 * the submit() method.
 *
 * This is done to ensure thread-safety outside of the message_server thread.
 */
class IMessageHandler
{
public:
    IMessageHandler()
    {
        ts = new ts::task_system(1);
    }

    virtual ~IMessageHandler()
    {
        delete ts;
    }

    /**
     * Handles messages recieved from the map servers.
     */
    virtual bool handleMessage(const std::vector<uint8>& payload,
                               in_addr                   from_addr,
                               uint16                    from_port) = 0;

    /**
     * Submits work to be executed asynchronously by the task system.
     * This work will happen serialy, on a single thread.
     */
    void submit(std::function<void()> func)
    {
        // clang-format off
        ts->schedule([func]()
        {
            func();
        });
        // clang-format on
    }

private:
    ts::task_system* ts;
};
