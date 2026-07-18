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

#include <common/cbasetypes.h>
#include <common/ipp.h>

#include <map/socket.h>

#include <memory>

class Scheduler;
class MapStatistics;

// MapSocket owns a dedicated networking thread. That thread does nothing but drain the OS
// receive buffer as fast as the kernel will hand us datagrams (pushing them into a lockless
// ingress ring) and drain our egress ring back out to the wire.
class MapSocket final : public Socket
{
public:
    MapSocket(Scheduler& scheduler, MapStatistics& mapStatistics, uint16 port, ReceiveFn onReceiveFn);
    ~MapSocket() override;

    DISALLOW_COPY_AND_MOVE(MapSocket);

    void send(const IPP& ipp, ByteSpan buffer) override;
    void flushDiagnostics() override;

private:
    struct Impl;
    std::unique_ptr<Impl> impl_;
};
