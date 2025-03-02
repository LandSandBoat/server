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
#include "logging.h"
#include "socket.h"

#include <zmq.hpp>
#include <zmq_addon.hpp>

class IPP final
{
public:
    IPP()
    {
    }

    explicit IPP(const uint32 ip, const uint16 port)
    : ip_(ip)
    , port_(port)
    {
    }

    explicit IPP(const uint64& ipp)
    : IPP(static_cast<uint32>(ipp), static_cast<uint16>(ipp >> 32))
    {
    }

    explicit IPP(const zmq::message_t& message)
    : IPP(*reinterpret_cast<const uint64*>(message.data()))
    {
    }

    auto toString() const -> std::string
    {
        in_addr inaddr{};
        inaddr.s_addr = ip_;

        char address[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, &inaddr, address, INET_ADDRSTRLEN);

        // TODO: Add a designator for if this address is connect, map, search, or world, etc.

        // This is internal, so we can trust it.
        return fmt::format("{}:{}", asStringFromUntrustedSource(address), port_);
    }

    auto getIPP() const -> uint64
    {
        return static_cast<uint64>(ip_) | (static_cast<uint64>(port_) << 32);
    }

    auto toZMQMessage() const -> zmq::message_t
    {
        const auto ipp = getIPP();
        return zmq::message_t(&ipp, sizeof(ipp));
    }

    //
    // Operators for use with STL containers
    //

    auto operator<(const IPP& other) const -> bool
    {
        return ip_ < other.ip_ || (ip_ == other.ip_ && port_ < other.port_);
    }

private:
    uint32 ip_{};
    uint16 port_{};
};
