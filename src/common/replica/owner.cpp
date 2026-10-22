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

#include "owner.h"

#include "common/logging.h"

#include <algorithm>
#include <random>

namespace xi::replica
{

void Owner::init(std::vector<IPP> mirrors, Send send)
{
    // nonzero, 0 is a mirror that has not synced
    init(std::move(mirrors), std::move(send), std::random_device{}() | 1);
}

void Owner::init(std::vector<IPP> mirrors, Send send, uint32 epoch)
{
    epoch_   = epoch;
    send_    = std::move(send);
    mirrors_ = std::move(mirrors);
    std::sort(mirrors_.begin(), mirrors_.end());
    seq_.clear();

    DebugReplicaFmt("replica: epoch {}, {} mirrors", epoch_, mirrors_.size());

    // mirrors that outlived the previous owner start over
    for (const auto& mirror : mirrors_)
    {
        send_(mirror, ipc::ReplicaSync{ .epoch = epoch_ });
    }
}

auto Owner::mirrors() const -> const std::vector<IPP>&
{
    return mirrors_;
}

void Owner::flush()
{
    auto batch = Batch{};
    for (const auto& [typeId, store] : stores_)
    {
        store->collect(xi::Badge<Owner>{}, batch);
    }

    for (auto& [mirror, items] : batch)
    {
        DebugReplicaFmt("replica: flush, {} items to {}", items.size(), mirror.toString());
        sendItems(mirror, std::move(items));
    }
}

void Owner::receive(const IPP& from, const ipc::ReplicaSync& message)
{
    const auto current = message.epoch == epoch_;
    auto       asked   = false;

    auto out = std::vector<ipc::ReplicaItem>{};
    for (const auto& item : message.items)
    {
        const auto it = stores_.find(item.typeId);

        if (item.op == ipc::ReplicaOp::Snapshot)
        {
            // a type nothing owns yet still gets an answer: it has no objects
            out.push_back(ipc::ReplicaItem{ .op = ipc::ReplicaOp::Snapshot, .typeId = item.typeId });
            asked = true;

            if (it != stores_.end())
            {
                it->second->snapshot(xi::Badge<Owner>{}, from, out);
            }
            else
            {
                ShowWarningFmt("replica: {} follows type {}, which nothing here owns. are both built from the same source?", from.toString(), item.typeId);
            }
        }
        else if (item.op == ipc::ReplicaOp::Request && current && it != stores_.end())
        {
            it->second->request(xi::Badge<Owner>{}, from, item);
        }
        else if (item.op == ipc::ReplicaOp::Request)
        {
            DebugReplicaFmt("replica: dropped a request from {}, it is on epoch {}, now {}", from.toString(), message.epoch, epoch_);
        }
    }

    if (asked)
    {
        sendItems(from, std::move(out));
    }
    else if (message.items.empty() || !current)
    {
        // a poll, or a mirror that missed a restart: tell it where the owner is
        send_(from, ipc::ReplicaSync{ .epoch = epoch_, .seq = seq_[from] });
    }
}

void Owner::sendItems(const IPP& mirror, std::vector<ipc::ReplicaItem> items)
{
    send_(mirror, ipc::ReplicaSync{ .epoch = epoch_, .seq = ++seq_[mirror], .items = std::move(items) });
}

} // namespace xi::replica
