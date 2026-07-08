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

#include <asio/ts/buffer.hpp>
#include <asio/ts/internet.hpp>

#include "handler_session.h"
#include "login_errors.h"
#include "login_helpers.h"
#include "login_packets.h"

#include "common/ipp.h"
#include "common/zmq/channel.h"

#include <zmq.hpp>

// port 54230
class data_session : public handler_session
{
public:
    data_session(asio::ssl::stream<asio::ip::tcp::socket> socket, ipc::Channel<zmq::message_t> dealerChannel)
    : handler_session(std::move(socket))
    , dealerChannel_(dealerChannel)
    {
        DebugSockets("data_session from IP %s", ipAddress);
    }

    void deleteCharFromCharInfo(uint32_t charid);
    void addCharIntoCharInfo(const lpkt_chr_info_sub2& charInfo);
    void renameCharInCharInfo(uint32_t charId, const std::string& newName);

protected:
    void read_func() override;

    void write_func() override
    {
        do_read();
    }

    void handle_error(std::error_code ec, std::shared_ptr<handler_session> self) override;

private:
    ipc::Channel<zmq::message_t> dealerChannel_;

    lpkt_chr_info2 characterInfoResponse = {}; // Store this for char deletion/creation client behavior. We need to skip slots instead of "flatten" them.
    bool           generatedCharInfo     = false;
};
