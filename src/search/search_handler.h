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
#include <common/logging.h>
#include <map>
#include <unordered_set>

#include "common/blowfish.h"
#include "common/synchronized.h"
#include "search.h"

enum TCPREQUESTTYPE
{
    TCP_SEARCH_ALL        = 0x00,
    TCP_GROUP_LIST        = 0x02,
    TCP_SEARCH            = 0x03,
    TCP_AH_HISTORY_SINGLE = 0x05,
    TCP_AH_HISTORY_STACK  = 0x06,
    TCP_SEARCH_COMMENT    = 0x08,
    TCP_AH_REQUEST_MORE   = 0x10,
    TCP_AH_REQUEST        = 0x15,
};

class search_handler
: public std::enable_shared_from_this<search_handler>
{
public:
    search_handler(asio::ip::tcp::socket socket, asio::io_context& io_context, SynchronizedShared<std::map<std::string, uint16_t>>& IPAddressesInUseList, SynchronizedShared<std::unordered_set<std::string>>& IPAddressWhitelist);

    ~search_handler();

    void start();

    void do_read();

    void handle_error(std::error_code ec, std::shared_ptr<search_handler> self);

    void do_write();

    void read_func(uint16_t length);

    std::string           ipAddress; // Store IP address in class -- once the file handle is invalid this can no longer be obtained from socket_
    asio::ip::tcp::socket socket_;

    std::array<uint8, 4096> buffer_;

    // Blowfish key

    uint8 key[24] = {
        0x30,
        0x73,
        0x3D,
        0x6D,
        0x3C,
        0x31,
        0x49,
        0x5A,
        0x32,
        0x7A,
        0x42,
        0x43,
        0x63,
        0x38,
        0x7B,
        0x7E,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
    };

private:
    // A single IP should only have one request in flight at a time, so we are going to
    // be tracking the IP addresses of incoming requests and if we haven't cleared the
    // record for it - we block until it's done
    SynchronizedShared<std::map<std::string, uint16_t>>& IPAddressesInUse_;

    // NOTE: We're only using the read-lock for this
    SynchronizedShared<std::unordered_set<std::string>>& IPAddressWhitelist_;

    // Deadline timer to drop a read
    asio::steady_timer deadline_;

    void checkDeadline(const std::shared_ptr<search_handler>& self);

    uint16_t getNumSessionsInUse(const std::string& ipAddressStr);
    void     addToUsedIPAddresses(const std::string& ipAddressStr);
    void     removeFromUsedIPAddresses(const std::string& ipAddressStr);

    bool validatePacket(uint16_t length);
    void decrypt(uint16_t length);
    void encrypt(uint16_t length);

    void HandleSearchRequest();
    void HandleGroupListRequest();
    void HandleSearchComment();
    void HandleAuctionHouseRequest();
    void HandleAuctionHouseHistory();

    auto _HandleSearchRequest() -> search_req;

    blowfish_t blowfish;

    std::deque<searchPacket> searchPackets;
};
