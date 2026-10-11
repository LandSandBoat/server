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

#include "owner.h"
#include "replicable.h"

#include "common/types/hash_map.h"

#include <functional>
#include <vector>

namespace xi::replica
{

// The objects of one type, held by the owner.
// Get it from Owner::store<T>().
// A plain container: read and write the objects directly.
// Owner::flush() sends every object that differs from the copy it last sent to the mirrors in that object's audience.
// See mirrored.h for the receiving side.
template <Replicable T>
class Owned final : public Owner::Store
{
public:
    using Audience = std::function<std::vector<IPP>(uint64 id, const T& value)>;

    Owned(xi::Badge<Owner>, Owner& owner);

    // chooses the mirrors that receive an object. every mirror when unset.
    void setAudience(Audience audience);

    // handler runs when a mirror sends request(R), one handler per request type. change the store from it.
    template <Reflectable R>
    void setOnRequest(std::function<void(const IPP& mirror, const R& request)> handler);

    // the object for id, created if missing
    auto operator[](uint64 id) -> T&;

    // the object for id, or null
    auto find(uint64 id) -> T*;
    auto get(uint64 id) const -> const T*;

    // true if id existed
    auto erase(uint64 id) -> bool;

    void collect(xi::Badge<Owner>, Owner::Batch& out) override;
    void snapshot(xi::Badge<Owner>, const IPP& mirror, std::vector<ipc::ReplicaItem>& out) override;
    void request(xi::Badge<Owner>, const IPP& mirror, const ipc::ReplicaItem& item) override;

private:
    struct Sent
    {
        T                value{};
        std::vector<IPP> mirrors{}; // sorted
    };

    // queues one item for each of mirrors
    static void emit(Owner::Batch& out, const std::vector<IPP>& mirrors, ipc::ReplicaOp op, uint64 id, const std::vector<uint8>& body);

    // the custom audience of id, sorted and unique
    auto audienceOf(uint64 id, const T& value) const -> std::vector<IPP>;

    Owner&                owner_;
    HashMap<uint64, T>    objects_;
    HashMap<uint64, Sent> sent_; // what each mirror was last told
    Audience              audience_;

    // by request type
    HashMap<uint64, std::function<void(const IPP& mirror, const ipc::ReplicaItem& item)>> onRequest_;
};

} // namespace xi::replica

#include "owned_impl.h"
