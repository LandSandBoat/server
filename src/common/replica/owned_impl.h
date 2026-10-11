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

#include "owned.h"

#include "common/ipc.h"

#include <algorithm>
#include <iterator>

namespace xi::replica
{

template <Replicable T>
auto Owner::store() -> Owned<T>&
{
    auto& store = stores_[kTypeId<T>];
    if (!store)
    {
        store.reset(new Owned<T>(xi::Badge<Owner>{}, *this));
    }

    return static_cast<Owned<T>&>(*store);
}

template <Replicable T>
Owned<T>::Owned(xi::Badge<Owner>, Owner& owner)
: owner_(owner)
{
}

template <Replicable T>
void Owned<T>::setAudience(Audience audience)
{
    audience_ = std::move(audience);
}

template <Replicable T>
template <Reflectable R>
void Owned<T>::setOnRequest(std::function<void(const IPP& mirror, const R& request)> handler)
{
    onRequest_[kTypeId<R>] = [handler = std::move(handler)](const IPP& mirror, const ipc::ReplicaItem& item)
    {
        const auto request = ipc::fromBytes<R>(item.body);
        if (!request)
        {
            ShowErrorFmt("replica: bad {} from {}", glz::type_name<R>, mirror.toString());
            return;
        }

        DebugReplicaFmt("replica: {} requests {} on {}", mirror.toString(), glz::type_name<R>, glz::type_name<T>);
        handler(mirror, *request);
    };
}

template <Replicable T>
auto Owned<T>::operator[](uint64 id) -> T&
{
    return objects_[id];
}

template <Replicable T>
auto Owned<T>::find(uint64 id) -> T*
{
    const auto it = objects_.find(id);
    if (it == objects_.end())
    {
        return nullptr;
    }

    return &it->second;
}

template <Replicable T>
auto Owned<T>::get(uint64 id) const -> const T*
{
    const auto it = objects_.find(id);
    if (it == objects_.end())
    {
        return nullptr;
    }

    return &it->second;
}

template <Replicable T>
auto Owned<T>::erase(uint64 id) -> bool
{
    return objects_.erase(id) != 0;
}

template <Replicable T>
void Owned<T>::emit(Owner::Batch& out, const std::vector<IPP>& mirrors, ipc::ReplicaOp op, uint64 id, const std::vector<uint8>& body)
{
    for (const auto& mirror : mirrors)
    {
        if (op == ipc::ReplicaOp::Destroy)
        {
            DebugReplicaFmt("replica: destroy {} {} on {}", glz::type_name<T>, id, mirror.toString());
        }
        else
        {
            DebugReplicaFmt("replica: put {} {} to {}", glz::type_name<T>, id, mirror.toString());
        }

        out[mirror].push_back(ipc::ReplicaItem{ .op = op, .typeId = kTypeId<T>, .objectId = id, .body = body });
    }
}

template <Replicable T>
auto Owned<T>::audienceOf(uint64 id, const T& value) const -> std::vector<IPP>
{
    auto mirrors = audience_(id, value);
    std::sort(mirrors.begin(), mirrors.end());
    mirrors.erase(std::unique(mirrors.begin(), mirrors.end()), mirrors.end());
    return mirrors;
}

template <Replicable T>
void Owned<T>::collect(xi::Badge<Owner>, Owner::Batch& out)
{
    for (const auto& [id, value] : objects_)
    {
        const auto [it, isNew] = sent_.try_emplace(id);
        auto& sent             = it->second;

        auto        custom = std::vector<IPP>{};
        const auto* chosen = &owner_.mirrors();
        if (audience_)
        {
            custom = audienceOf(id, value);
            chosen = &custom;
        }

        const auto& next    = *chosen;
        const auto  changed = isNew || sent.value != value;
        if (!changed && next == sent.mirrors)
        {
            continue;
        }

        // a changed object goes to its whole audience, an unchanged one only to mirrors joining it
        auto receivers = std::vector<IPP>{};
        if (changed)
        {
            receivers = next;
        }
        else
        {
            std::set_difference(next.begin(), next.end(), sent.mirrors.begin(), sent.mirrors.end(), std::back_inserter(receivers));
        }

        auto left = std::vector<IPP>{};
        std::set_difference(sent.mirrors.begin(), sent.mirrors.end(), next.begin(), next.end(), std::back_inserter(left));

        if (!receivers.empty())
        {
            emit(out, receivers, ipc::ReplicaOp::Put, id, ipc::toBytes(value));
        }

        emit(out, left, ipc::ReplicaOp::Destroy, id, {});

        if (changed)
        {
            sent.value = value;
        }

        sent.mirrors = next;
    }

    std::erase_if(sent_,
                  [&](const auto& pair)
                  {
                      if (objects_.contains(pair.first))
                      {
                          return false;
                      }

                      emit(out, pair.second.mirrors, ipc::ReplicaOp::Destroy, pair.first, {});
                      return true;
                  });
}

template <Replicable T>
void Owned<T>::snapshot(xi::Badge<Owner>, const IPP& mirror, std::vector<ipc::ReplicaItem>& out)
{
    const auto before = out.size();

    for (const auto& [id, sent] : sent_)
    {
        if (std::binary_search(sent.mirrors.begin(), sent.mirrors.end(), mirror))
        {
            out.push_back(ipc::ReplicaItem{ .op = ipc::ReplicaOp::Put, .typeId = kTypeId<T>, .objectId = id, .body = ipc::toBytes(sent.value) });
        }
    }

    DebugReplicaFmt("replica: {} asked for {}, sending {} objects", mirror.toString(), glz::type_name<T>, out.size() - before);
}

template <Replicable T>
void Owned<T>::request(xi::Badge<Owner>, const IPP& mirror, const ipc::ReplicaItem& item)
{
    const auto it = onRequest_.find(item.objectId);
    if (it == onRequest_.end())
    {
        ShowWarningFmt("replica: {} has no handler for request {} from {}", glz::type_name<T>, item.objectId, mirror.toString());
        return;
    }

    it->second(mirror, item);
}

} // namespace xi::replica
