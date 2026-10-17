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

#include "mirror.h"

#include "common/logging.h"

#include <algorithm>

namespace xi::replica
{

Mirror::Mirror(Send send)
: send_(std::move(send))
{
}

void Mirror::receive(const ipc::ReplicaSync& message)
{
    const auto restarted = message.epoch != epoch_;
    if (restarted)
    {
        ShowInfoFmt("replica: owner epoch {} -> {}, syncing", epoch_, message.epoch);
        epoch_  = message.epoch;
        synced_ = false;
    }

    // the stores this message holds a snapshot of, and their objects
    auto snapshots = HashMap<uint32, std::vector<const ipc::ReplicaItem*>>{};
    for (const auto& item : message.items)
    {
        if (item.op == ipc::ReplicaOp::Snapshot)
        {
            snapshots.try_emplace(item.typeId);
        }
    }

    for (const auto& item : message.items)
    {
        const auto it = snapshots.find(item.typeId);
        if (item.op == ipc::ReplicaOp::Put && it != snapshots.end())
        {
            it->second.push_back(&item);
        }
    }

    // a snapshot of every store is a fresh start whatever came before
    const auto full = std::ranges::all_of(stores_,
                                          [&](const auto& pair)
                                          {
                                              return snapshots.contains(pair.first);
                                          });
    if (!full)
    {
        auto expected = seq_;
        if (!message.items.empty())
        {
            ++expected;
        }

        const auto missed = synced_ && message.seq != expected;
        if (missed)
        {
            DebugReplicaFmt("replica: expected message {}, got {}, syncing", expected, message.seq);
            synced_ = false;
        }

        // asks once on losing sync. poll() asks again until the snapshot arrives.
        if (restarted || missed)
        {
            requestSnapshots();
        }

        if (!synced_)
        {
            return;
        }
    }

    if (!message.items.empty())
    {
        DebugReplicaFmt("replica: {} items from owner", message.items.size());
    }

    auto hooks = Hooks{};
    auto read  = true;
    for (const auto& [typeId, puts] : snapshots)
    {
        if (const auto it = stores_.find(typeId); it != stores_.end())
        {
            read = it->second->replace(xi::Badge<Mirror>{}, puts, hooks) && read;
        }
    }

    for (const auto& item : message.items)
    {
        if (item.op != ipc::ReplicaOp::Put && item.op != ipc::ReplicaOp::Destroy)
        {
            continue;
        }

        if (snapshots.contains(item.typeId))
        {
            continue;
        }

        if (const auto it = stores_.find(item.typeId); it != stores_.end())
        {
            read = it->second->apply(xi::Badge<Mirror>{}, item, hooks) && read;
        }
    }

    // a message it could not read does not count as received: poll() asks for everything again
    synced_ = read;
    if (read)
    {
        seq_ = message.seq;
    }

    for (const auto& hook : hooks)
    {
        hook();
    }
}

void Mirror::poll(const Clock::time_point now)
{
    if (now - lastPoll_ < kPollInterval)
    {
        return;
    }

    lastPoll_ = now;
    if (!synced_)
    {
        requestSnapshots();
        return;
    }

    DebugReplicaFmt("replica: poll, epoch {}, message {}", epoch_, seq_);
    send_(ipc::ReplicaSync{ .epoch = epoch_ });
}

auto Mirror::synced() const -> bool
{
    return synced_;
}

void Mirror::send(ipc::ReplicaItem item) const
{
    send_(ipc::ReplicaSync{ .epoch = epoch_, .items = { std::move(item) } });
}

void Mirror::requestSnapshots() const
{
    auto request = ipc::ReplicaSync{ .epoch = epoch_ };
    for (const auto& [typeId, store] : stores_)
    {
        request.items.push_back(ipc::ReplicaItem{ .op = ipc::ReplicaOp::Snapshot, .typeId = typeId });
    }

    DebugReplicaFmt("replica: asking for {} stores", request.items.size());
    send_(request);
}

} // namespace xi::replica
