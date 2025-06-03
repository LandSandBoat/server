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

#include "cbasetypes.h"

#include <zmq.hpp>
#include <zmq_addon.hpp>

#ifdef _WIN32
#include <io.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#else
#include <arpa/inet.h>
#include <cerrno>
#include <errno.h>
#include <net/if.h>
#include <netdb.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#endif

#include <array>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <memory>
#include <string>

auto ip2str(uint32 ip) -> std::string;
auto str2ip(const std::string& ip_str) -> uint32;
auto sockaddr2netip(const sockaddr_in& addr) -> uint32;
auto sockaddr2hostport(const sockaddr_in& addr) -> uint16;

//
// An IP-Port Pair
//
class IPP final
{
public:
    IPP();
    explicit IPP(const uint32 ip, const uint16 port);
    explicit IPP(const uint64& ipp);
    explicit IPP(const zmq::message_t& message);

    auto getRawIPP() const -> uint64;
    auto getIP() const -> uint32;
    auto getIPString() const -> std::string;
    auto getPort() const -> uint16;

    auto toString() const -> std::string;
    auto toZMQMessage() const -> zmq::message_t;

    //
    // Operators for use with STL containers
    //

    auto operator<(const IPP& other) const -> bool;

private:
    // IP is always stored and used in network byte order.
    uint32 ip_{};

    // Port is always stored and used in host byte order (human-readable).
    uint16 port_{};
};
