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

#include "mirror.h"
#include "replicable.h"

#include "common/types/hash_map.h"

#include <functional>
#include <optional>

namespace xi::replica
{

// Read-only copies of the objects of one type that the owner streams to this process.
// Get it from Mirror::store<T>().
// The change hook gets the object before and after, so a consumer can see what changed.
// To change an object, send the owner a request.
template <Replicable T>
class Mirrored final : public Mirror::Store
{
public:
    // before is null when the object is new, after is null when it is gone
    using ChangeHook = std::function<void(uint64 id, const T* before, const T* after)>;

    Mirrored(xi::Badge<Mirror>, Mirror& mirror);

    // hook runs for every object created, changed or destroyed
    void setOnChange(ChangeHook hook);

    // asks the owner to act. the owner's setOnRequest<R> handler decides what happens. does nothing while not synced.
    template <Reflectable R>
    void request(const R& request) const;

    // the object for id, or null
    auto get(uint64 id) const -> const T*;

    auto apply(xi::Badge<Mirror>, const ipc::ReplicaItem& item, Mirror::Hooks& hooks) -> bool override;
    auto replace(xi::Badge<Mirror>, const std::vector<const ipc::ReplicaItem*>& puts, Mirror::Hooks& hooks) -> bool override;

private:
    // queues the hook for id, whose previous value was before
    void notify(Mirror::Hooks& hooks, uint64 id, std::optional<T> before);

    Mirror&            mirror_;
    HashMap<uint64, T> objects_;
    ChangeHook         onChange_;
};

} // namespace xi::replica

#include "mirrored_impl.h"
