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

#include <common/cbasetypes.h>

#include <common/database/blob.h>
#include <common/database/bound_value.h>
#include <common/database/traits.h>

#include <memory>
#include <optional>
#include <string>
#include <type_traits>
#include <utility>
#include <vector>

namespace db::detail
{

// Lower a single C++ argument into a type-erased BoundValue, appending it to the parameter list.
template <typename T>
auto lowerBoundValue(std::vector<BoundValue>& params, T&& value) -> void;

// Lower a full argument pack into a parameter list, preserving left-to-right order.
template <typename... Args>
auto lowerBoundValues(Args&&... args) -> std::vector<BoundValue>;

} // namespace db::detail

//
// Out-of-line template definitions
//

namespace db::detail
{

template <typename T>
auto lowerBoundValue(std::vector<BoundValue>& params, T&& value) -> void
{
    using U = enum_decay_t<std::remove_cvref_t<T>>;

    if constexpr (std::is_same_v<U, std::nullopt_t>)
    {
        params.emplace_back(std::in_place_type<std::monostate>);
    }
    else if constexpr (is_optional_v<U>)
    {
        // An engaged optional binds as its contained value; a disengaged one binds as SQL NULL.
        if (value.has_value())
        {
            lowerBoundValue(params, *value);
        }
        else
        {
            params.emplace_back(std::in_place_type<std::monostate>);
        }
    }
    else if constexpr (is_std_vector_v<U>)
    {
        // A vector binds one parameter per element, in order, for IN (...) lists built with
        // db::placeholders(). The query must carry a matching number of '?' holes.
        for (const auto& element : value)
        {
            lowerBoundValue(params, element);
        }
    }
    else if constexpr (std::is_same_v<U, int32>)
    {
        params.emplace_back(std::in_place_type<int32>, static_cast<int32>(value));
    }
    else if constexpr (std::is_same_v<U, uint32>)
    {
        params.emplace_back(std::in_place_type<uint32>, static_cast<uint32>(value));
    }
    else if constexpr (std::is_same_v<U, int16>)
    {
        params.emplace_back(std::in_place_type<int16>, static_cast<int16>(value));
    }
    else if constexpr (std::is_same_v<U, uint16>)
    {
        params.emplace_back(std::in_place_type<uint16>, static_cast<uint16>(value));
    }
    else if constexpr (std::is_same_v<U, int8>)
    {
        params.emplace_back(std::in_place_type<int8>, static_cast<int8>(value));
    }
    else if constexpr (std::is_same_v<U, uint8>)
    {
        params.emplace_back(std::in_place_type<uint8>, static_cast<uint8>(value));
    }
    else if constexpr (std::is_same_v<U, int64>)
    {
        params.emplace_back(std::in_place_type<int64>, static_cast<int64>(value));
    }
    else if constexpr (std::is_same_v<U, uint64>)
    {
        params.emplace_back(std::in_place_type<uint64>, static_cast<uint64>(value));
    }
    else if constexpr (std::is_same_v<U, bool>)
    {
        params.emplace_back(std::in_place_type<bool>, static_cast<bool>(value));
    }
    else if constexpr (std::is_same_v<U, double>)
    {
        params.emplace_back(std::in_place_type<double>, static_cast<double>(value));
    }
    else if constexpr (std::is_same_v<U, float>)
    {
        params.emplace_back(std::in_place_type<float>, static_cast<float>(value));
    }
    else if constexpr (std::is_same_v<U, std::string>)
    {
        params.emplace_back(std::in_place_type<std::string>, value);
    }
    else if constexpr (std::is_same_v<U, const char*> || std::is_same_v<U, char*>)
    {
        params.emplace_back(std::in_place_type<std::string>, value);
    }
    else if constexpr (std::is_same_v<U, size_t>)
    {
        // Only reached on platforms where size_t is a distinct type from uint64.
        params.emplace_back(std::in_place_type<uint64>, static_cast<uint64>(value));
    }
    else if constexpr (is_blob_v<U>)
    {
        params.emplace_back(std::in_place_type<std::shared_ptr<BlobWrapper>>, BlobWrapper::create(value));
    }
    else
    {
        static_assert(always_false_v<T>, "Unsupported type in binder");
    }
}

template <typename... Args>
auto lowerBoundValues(Args&&... args) -> std::vector<BoundValue>
{
    std::vector<BoundValue> params;
    params.reserve(sizeof...(Args));
    (lowerBoundValue(params, std::forward<Args>(args)), ...);
    return params;
}

} // namespace db::detail
