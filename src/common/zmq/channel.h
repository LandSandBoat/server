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

#include <common/logging.h>

#include <atomic>
#include <cstddef>
#include <utility>

#include <concurrentqueue.h>

namespace ipc
{

//
// ipc::Channel
//
//   A non-owning handle to one IPC endpoint's message queues.
//
template <typename MessageT>
class Channel
{
public:
    Channel(moodycamel::ConcurrentQueue<MessageT>& incoming, moodycamel::ConcurrentQueue<MessageT>& outgoing)
    : incoming_(incoming)
    , outgoing_(outgoing)
    {
    }

    // Dequeue one inbound message. Returns false when none are available.
    [[nodiscard]] auto tryReceive(MessageT& out) -> bool
    {
        return incoming_.try_dequeue(out);
    }

    // Queue a message for the I/O thread to send.
    auto send(MessageT message) -> void
    {
        outgoing_.enqueue(std::move(message));
    }

private:
    moodycamel::ConcurrentQueue<MessageT>& incoming_;
    moodycamel::ConcurrentQueue<MessageT>& outgoing_;
};

} // namespace ipc
