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

#ifndef _MESSAGE_H_
#define _MESSAGE_H_

#include "common/cbasetypes.h"
#include "common/lua.h"
#include "common/mmo.h"
#include "common/socket.h"
#include "common/sql.h"

#include <zmq.hpp>

class CBasicPacket;

struct chat_message_t
{
    zmq::message_t type;
    zmq::message_t data;
    zmq::message_t packet;

    chat_message_t() noexcept
    {
    }

    chat_message_t& operator=(chat_message_t&& other) noexcept
    {
        this->type.move(other.type);
        this->packet.move(other.packet);
        this->data.move(other.data);
        return *this;
    }

    chat_message_t(chat_message_t const& other) noexcept
    {
        // NOTE: Normally we wouldn't want to use const_cast, but ZMQ has
        //       deprecated their copy function that uses const&.
        this->type.copy(*const_cast<zmq::message_t*>(&other.type));
        this->packet.copy(*const_cast<zmq::message_t*>(&other.packet));
        this->data.copy(*const_cast<zmq::message_t*>(&other.data));
    }

    chat_message_t(chat_message_t&& other) noexcept
    : type(std::move(other.type))
    , data(std::move(other.data))
    , packet(std::move(other.packet))
    {
    }
};

namespace message
{
    // For use on the main thread
    // NOTE: All SQL operations happen on the main thread
    void init();
    void init(const char* chatIp, uint16 chatPort);
    void handle_incoming();
    void send(MSGSERVTYPE type, void* data, size_t datalen, const std::unique_ptr<CBasicPacket>& packet = nullptr);
    void send(uint16 zone, std::string const& luaFunc);
    void send(uint32 playerId, const std::unique_ptr<CBasicPacket>& packet);
    void send(std::string const& playerName, const std::unique_ptr<CBasicPacket>& packet);
    void send_charvar_update(uint32 charId, std::string const& varName, uint32 value, uint32 expiry);
    void rpc_send(uint16 sendZone, uint16 recvZone, std::string const& sendStr, sol::function recvFunc);

    void close();

    // For use on the zmq thread
    // NOTE: No SQL operations happen in here
    void listen();
    void send_queue();
}; // namespace message

#endif
