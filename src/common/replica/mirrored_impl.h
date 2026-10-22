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

#include "mirrored.h"

#include "common/ipc.h"
#include "common/logging.h"

#include <utility>

namespace xi::replica
{

template <Replicable T>
auto Mirror::store() -> Mirrored<T>&
{
    auto& store = stores_[kTypeId<T>];
    if (!store)
    {
        DebugReplicaFmt("replica: following {}", glz::type_name<T>);
        store.reset(new Mirrored<T>(xi::Badge<Mirror>{}, *this));

        // asks for every store again, so related ones arrive together
        synced_ = false;
        requestSnapshots();
    }

    return static_cast<Mirrored<T>&>(*store);
}

template <Replicable T>
Mirrored<T>::Mirrored(xi::Badge<Mirror>, Mirror& mirror)
: mirror_(mirror)
{
}

template <Replicable T>
void Mirrored<T>::setOnChange(ChangeHook hook)
{
    onChange_ = std::move(hook);
}

template <Replicable T>
template <Reflectable R>
void Mirrored<T>::request(const R& request) const
{
    if (!mirror_.synced())
    {
        ShowWarningFmt("replica: {} not sent, {} is not synced with the owner", glz::type_name<R>, glz::type_name<T>);
        return;
    }

    DebugReplicaFmt("replica: request {} on {}", glz::type_name<R>, glz::type_name<T>);
    mirror_.send(ipc::ReplicaItem{ .op = ipc::ReplicaOp::Request, .typeId = kTypeId<T>, .objectId = kTypeId<R>, .body = ipc::toBytes(request) });
}

template <Replicable T>
auto Mirrored<T>::get(const uint64 id) const -> const T*
{
    const auto it = objects_.find(id);
    if (it == objects_.end())
    {
        return nullptr;
    }

    return &it->second;
}

template <Replicable T>
void Mirrored<T>::notify(Mirror::Hooks& hooks, const uint64 id, std::optional<T> before)
{
    hooks.emplace_back([this, id, before = std::move(before)]
                       {
                           if (!onChange_)
                           {
                               return;
                           }

                           const T* previous = nullptr;
                           if (before)
                           {
                               previous = &*before;
                           }

                           onChange_(id, previous, get(id));
                       });
}

template <Replicable T>
auto Mirrored<T>::apply(xi::Badge<Mirror>, const ipc::ReplicaItem& item, Mirror::Hooks& hooks) -> bool
{
    const auto id = item.objectId;
    const auto it = objects_.find(id);

    auto before = std::optional<T>{};
    if (it != objects_.end())
    {
        before = it->second;
    }

    if (item.op == ipc::ReplicaOp::Destroy)
    {
        if (!before)
        {
            return true;
        }

        DebugReplicaFmt("replica: {} {} destroyed", glz::type_name<T>, id);
        objects_.erase(it);
    }
    else
    {
        auto value = ipc::fromBytes<T>(item.body);
        if (!value)
        {
            ShowErrorFmt("replica: bad body for {} {}", glz::type_name<T>, id);
            return false;
        }

        if (before && *before == *value)
        {
            return true;
        }

        if (before)
        {
            DebugReplicaFmt("replica: {} {} changed", glz::type_name<T>, id);
        }
        else
        {
            DebugReplicaFmt("replica: {} {} created", glz::type_name<T>, id);
        }

        objects_.insert_or_assign(id, std::move(*value));
    }

    notify(hooks, id, std::move(before));
    return true;
}

template <Replicable T>
auto Mirrored<T>::replace(xi::Badge<Mirror>, const std::vector<const ipc::ReplicaItem*>& puts, Mirror::Hooks& hooks) -> bool
{
    auto next = HashMap<uint64, T>{};
    for (const auto* item : puts)
    {
        auto value = ipc::fromBytes<T>(item->body);
        if (!value)
        {
            ShowErrorFmt("replica: bad body for {} {}, snapshot ignored", glz::type_name<T>, item->objectId);
            return false;
        }

        next.insert_or_assign(item->objectId, std::move(*value));
    }

    for (auto it = objects_.begin(); it != objects_.end();)
    {
        if (next.contains(it->first))
        {
            ++it;
            continue;
        }

        const auto id     = it->first;
        auto       before = std::optional<T>{ std::move(it->second) };
        it                = objects_.erase(it);

        DebugReplicaFmt("replica: {} {} destroyed", glz::type_name<T>, id);
        notify(hooks, id, std::move(before));
    }

    for (auto& [id, value] : next)
    {
        const auto it = objects_.find(id);
        if (it == objects_.end())
        {
            DebugReplicaFmt("replica: {} {} created", glz::type_name<T>, id);
            objects_.emplace(id, std::move(value));
            notify(hooks, id, std::nullopt);
        }
        else if (it->second != value)
        {
            DebugReplicaFmt("replica: {} {} changed", glz::type_name<T>, id);
            auto before = std::optional<T>{ std::exchange(it->second, std::move(value)) };
            notify(hooks, id, std::move(before));
        }
    }

    return true;
}

} // namespace xi::replica
