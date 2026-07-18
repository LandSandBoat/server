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
#include <common/types/fn.h>

class Socket
{
public:
    // Called when bytes are received from a client, with the sender's address.
    using ReceiveFn = Fn<void(ByteSpan, const IPP&)>;

    virtual ~Socket() = default;

    virtual void send(const IPP& ipp, ByteSpan buffer) = 0;

    // Called once per tick to emit aggregated diagnostics (e.g. send failures).
    virtual void flushDiagnostics()
    {
    }

    // TODO: Mockable receive()
};
