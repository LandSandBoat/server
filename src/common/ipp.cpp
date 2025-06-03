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

#include "ipp.h"

#include "logging.h"

// Converts a network-order IP to a host-order string.
auto ip2str(uint32 ip) -> std::string
{
    char address[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &ip, address, INET_ADDRSTRLEN);
    return asStringFromUntrustedSource(address);
}

// Converts a host-order string to a network-order IP.
auto str2ip(const std::string& ip_str) -> uint32
{
    uint32 ip = 0;
    inet_pton(AF_INET, ip_str.c_str(), &ip);
    return ip;
}

// Extracts the network-order IP from sockaddr_in.
auto sockaddr2netip(const sockaddr_in& addr) -> uint32
{
#ifdef _WIN32
    return addr.sin_addr.S_un.S_addr;
#else
    return addr.sin_addr.s_addr;
#endif
}

// Extracts the host-order port from sockaddr_in.
auto sockaddr2hostport(const sockaddr_in& addr) -> uint16
{
    return ntohs(addr.sin_port);
}

IPP::IPP()
{
}

IPP::IPP(const uint32 ip, const uint16 port)
: ip_(ip)
, port_(port)
{
}

IPP::IPP(const uint64& ipp)
: IPP(static_cast<uint32>(ipp), static_cast<uint16>(ipp >> 32))
{
}

IPP::IPP(const zmq::message_t& message)
: IPP(*reinterpret_cast<const uint64*>(message.data()))
{
}

auto IPP::getRawIPP() const -> uint64
{
    return static_cast<uint64>(ip_) | (static_cast<uint64>(port_) << 32);
}

auto IPP::getIP() const -> uint32
{
    return ip_;
}

auto IPP::getIPString() const -> std::string
{
    return ip2str(ip_);
}

auto IPP::getPort() const -> uint16
{
    return port_;
}

auto IPP::toString() const -> std::string
{
    return fmt::format("{}:{}", getIPString(), port_);
}

auto IPP::toZMQMessage() const -> zmq::message_t
{
    const auto ipp = getRawIPP();
    return zmq::message_t(&ipp, sizeof(ipp));
}

auto IPP::operator<(const IPP& other) const -> bool
{
    return ip_ < other.ip_ || (ip_ == other.ip_ && port_ < other.port_);
}
