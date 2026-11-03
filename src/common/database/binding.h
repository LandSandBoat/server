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

#include <cstddef>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <vector>

namespace db::detail
{

// The scalar types lowerBoundValue binds as themselves.
template <typename U>
inline constexpr bool isBindableScalar = std::is_same_v<U, int8> || std::is_same_v<U, uint8> || std::is_same_v<U, int16> || std::is_same_v<U, uint16> ||
                                         std::is_same_v<U, int32> || std::is_same_v<U, uint32> || std::is_same_v<U, int64> || std::is_same_v<U, uint64> ||
                                         std::is_same_v<U, size_t> || std::is_same_v<U, bool> || std::is_same_v<U, float> || std::is_same_v<U, double> ||
                                         std::is_same_v<U, std::string> || std::is_same_v<U, const char*> || std::is_same_v<U, char*>;

template <typename T>
inline constexpr bool isOptional = false;

template <typename T>
inline constexpr bool isOptional<std::optional<T>> = true;

// Any other trivially copyable value or array binds as its bytes. A pointer would bind its own address, so it doesn't.
template <typename T>
inline constexpr bool isBindableBlob = is_blob_v<enum_decay_t<std::remove_cvref_t<T>>> && std::is_trivially_copyable_v<std::remove_cvref_t<T>> &&
                                       !std::is_pointer_v<std::remove_cvref_t<T>>;

template <typename T>
concept IsBindable = isBindableScalar<enum_decay_t<std::remove_cvref_t<T>>> || isBindableBlob<T> ||
                     std::is_same_v<std::remove_cvref_t<T>, std::nullptr_t>;

// An empty Maybe binds SQL NULL, and a full one binds its value.
template <typename T>
concept IsBindableOrMaybe = IsBindable<T> || (isOptional<std::remove_cvref_t<T>> && IsBindable<typename std::remove_cvref_t<T>::value_type>);

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

    if constexpr (std::is_same_v<U, int32>)
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
        // A char array decays here too. It binds up to its first zero byte, and never reads past its end.
        if constexpr (std::is_array_v<std::remove_cvref_t<T>>)
        {
            const auto text = std::string_view(value, std::extent_v<std::remove_cvref_t<T>>);
            params.emplace_back(std::in_place_type<std::string>, text.substr(0, text.find('\0')));
        }
        else
        {
            if (value == nullptr)
            {
                params.emplace_back(std::in_place_type<std::monostate>);
                return;
            }

            params.emplace_back(std::in_place_type<std::string>, value);
        }
    }
    else if constexpr (std::is_same_v<U, std::nullptr_t>)
    {
        params.emplace_back(std::in_place_type<std::monostate>);
    }
    else if constexpr (isOptional<U>)
    {
        if (value.has_value())
        {
            lowerBoundValue(params, *value);
        }
        else
        {
            params.emplace_back(std::in_place_type<std::monostate>);
        }
    }
    else if constexpr (std::is_same_v<U, int64>)
    {
        params.emplace_back(std::in_place_type<int64>, static_cast<int64>(value));
    }
    else if constexpr (std::is_same_v<U, uint64> || std::is_same_v<U, size_t>)
    {
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
