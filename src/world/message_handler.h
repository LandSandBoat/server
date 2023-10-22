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
#include "common/socket.h"

struct HandleableMessage
{
    std::vector<uint8> payload;
    in_addr            from_addr;
    uint16             from_port;
};

#ifdef WIN32
#include <winsock2.h>
#else
#include <netinet/in.h>
#endif

class IMessageHandler
{
public:
    virtual ~IMessageHandler()
    {
    }

    /**
     * Handles an incoming message from a map server.
     * Return true if the message was handled, false otherwise.
     */
    virtual bool handleMessage(HandleableMessage&& message) = 0;
};
