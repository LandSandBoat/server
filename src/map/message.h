/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "../common/socket.h"
#include "../common/sql.h"
#include "../common/mmo.h"
#include "../common/zmq.hpp"
#include "../common/cbasetypes.h"

class CBasicPacket;

struct chat_message_t
{
    zmq::message_t* type;
    zmq::message_t* data;
    zmq::message_t* packet;
};

namespace message
{
    void init(const char* chatIp, uint16 chatPort);
    void send(MSGSERVTYPE type, void* data, size_t datalen, CBasicPacket* packet);
    void close();
};
