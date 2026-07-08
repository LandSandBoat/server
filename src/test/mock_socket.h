/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include <common/cbasetypes.h>
#include <common/ipp.h>

#include <map/socket.h>

#include <cstring>
#include <utility>
#include <vector>

// In-memory Socket for tests/benchmarks.
class MockSocket final : public Socket
{
public:
    struct Datagram
    {
        IPP                ipp;
        std::vector<uint8> bytes;
    };

    MockSocket() = default;

    explicit MockSocket(ReceiveFn onReceiveFn)
    : onReceiveFn_(std::move(onReceiveFn))
    {
    }

    void send(const IPP& ipp, ByteSpan buffer) override
    {
        auto& datagram = sent.emplace_back();
        datagram.ipp   = ipp;
        datagram.bytes.assign(buffer.begin(), buffer.end());

        ++sendCount;
    }

    // Every datagram passed to send(), in order.
    std::vector<Datagram> sent;
    std::size_t           sendCount = 0;

private:
    ReceiveFn onReceiveFn_;
};
