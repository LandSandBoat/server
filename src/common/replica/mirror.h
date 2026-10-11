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
#include "common/macros.h"
#include "common/types/badge.h"
#include "common/types/hash_map.h"

#include <chrono>
#include <functional>
#include <memory>
#include <vector>

namespace xi::replica
{

template <Replicable T>
class Mirrored;

// The receiving end of xi::replica (xi_map): holds a Mirrored<T> per type and fills it with what the owner streams.
class Mirror final
{
public:
    using Send  = std::function<void(const ipc::ReplicaSync&)>;
    using Hooks = std::vector<std::function<void()>>;
    using Clock = std::chrono::steady_clock;

    static constexpr auto kPollInterval = 10s;

    class Store
    {
    public:
        Store()          = default;
        virtual ~Store() = default;

        DISALLOW_COPY_AND_MOVE(Store);

        // stores or removes the object in item, and queues its hook to run after the whole message.
        // false if it cannot read the item.
        virtual auto apply(xi::Badge<Mirror>, const ipc::ReplicaItem& item, Hooks& hooks) -> bool = 0;

        // makes puts the whole content: removes anything else and queues hooks only for what differs.
        // false, changing nothing, if it cannot read one of them.
        virtual auto replace(xi::Badge<Mirror>, const std::vector<const ipc::ReplicaItem*>& puts, Hooks& hooks) -> bool = 0;
    };

    // send reaches the owner
    explicit Mirror(Send send);
    ~Mirror() = default;

    DISALLOW_COPY_AND_MOVE(Mirror);

    // applies a message from the owner. asks for everything again if it missed one or the owner restarted.
    void receive(const ipc::ReplicaSync& message);

    // asks the owner where it is, which reveals a missed message or restart. call every pump.
    void poll(Clock::time_point now = Clock::now());

    // the copies of type T. the first use asks the owner for them, with every other store. include mirrored.h to call it.
    template <Replicable T>
    auto store() -> Mirrored<T>&;

    // false until the owner has sent every store in full, and again from a missed message until its repair
    auto synced() const -> bool;

    // sends one item to the owner
    void send(ipc::ReplicaItem item) const;

private:
    // asks the owner for every object of every store, in one message
    void requestSnapshots() const;

    uint32                                  epoch_{}; // owner boot id, 0 until synced
    uint64                                  seq_{};   // last numbered message applied
    bool                                    synced_{};
    Send                                    send_;
    HashMap<uint32, std::unique_ptr<Store>> stores_;
    Clock::time_point                       lastPoll_{};
};

} // namespace xi::replica
