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

#include <common/ipp.h>

#include <memory>
#include <tuple>
#include <vector>

#include <zmq.hpp>

// An IP+Port-addressed message: a routing id plus an opaque payload.
struct IPPMessage
{
    IPP                ipp;
    std::vector<uint8> payload;
};

// IPPMessage with a zmq frame as payload.
struct IPPFrame
{
    IPP            ipp;
    zmq::message_t payload;
};

namespace ipc
{

// zmq takes ownership of bytes, no copy
inline auto toFrame(std::vector<uint8>&& bytes) -> zmq::message_t
{
    // message_t can throw, release after
    auto owner = std::make_unique<std::vector<uint8>>(std::move(bytes));
    auto frame = zmq::message_t(
        owner->data(),
        owner->size(),
        [](void*, void* hint)
        {
            delete static_cast<std::vector<uint8>*>(hint);
        },
        owner.get());

    std::ignore = owner.release();
    return frame;
}

} // namespace ipc
