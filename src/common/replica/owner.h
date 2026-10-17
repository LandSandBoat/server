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

#include "replicable.h"

#include "common/ipc_structs.h"
#include "common/ipp.h"
#include "common/macros.h"
#include "common/types/badge.h"
#include "common/types/hash_map.h"

#include <functional>
#include <map>
#include <memory>
#include <vector>

namespace xi::replica
{

template <Replicable T>
class Owned;

// The owning end of xi::replica (xi_world): holds an Owned<T> per type and streams their changes to the mirrors.
class Owner final
{
public:
    using Send  = std::function<void(const IPP&, const ipc::ReplicaSync&)>;
    using Batch = std::map<IPP, std::vector<ipc::ReplicaItem>>;

    class Store
    {
    public:
        Store()          = default;
        virtual ~Store() = default;

        DISALLOW_COPY_AND_MOVE(Store);

        // adds what changed since the last call to out, per mirror
        virtual void collect(xi::Badge<Owner>, Batch& out) = 0;

        // adds every object mirror should hold to out
        virtual void snapshot(xi::Badge<Owner>, const IPP& mirror, std::vector<ipc::ReplicaItem>& out) = 0;

        // handles a request from mirror
        virtual void request(xi::Badge<Owner>, const IPP& mirror, const ipc::ReplicaItem& item) = 0;
    };

    Owner()  = default;
    ~Owner() = default;

    DISALLOW_COPY_AND_MOVE(Owner);

    // starts a new epoch and announces it to mirrors
    void init(std::vector<IPP> mirrors, Send send);

    // the same with a chosen epoch, for tests
    void init(std::vector<IPP> mirrors, Send send, uint32 epoch);

    // every map process, sorted
    auto mirrors() const -> const std::vector<IPP>&;

    // sends each mirror what changed since the last flush. call once per pump.
    void flush();

    // handles a mirror's snapshot request, poll or store request
    void receive(const IPP& from, const ipc::ReplicaSync& message);

    // the objects of type T, created on first use. include owned.h to call it.
    template <Replicable T>
    auto store() -> Owned<T>&;

private:
    // sends items as the next numbered message to mirror
    void sendItems(const IPP& mirror, std::vector<ipc::ReplicaItem> items);

    uint32                                  epoch_{};
    Send                                    send_;
    std::vector<IPP>                        mirrors_;
    std::map<IPP, uint64>                   seq_; // last numbered message sent to each mirror
    HashMap<uint32, std::unique_ptr<Store>> stores_;
};

} // namespace xi::replica
