/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#include <cstdint>
#include <span>
#include <string>
#include <type_traits>
#include <vector>

#include <common/cbasetypes.h>
#include <common/types/maybe.h>

//
// Forward declarations (before including ipc headers)
//

namespace ipc
{

template <typename T>
auto toBytes(const T& object) -> std::vector<uint8>;

template <typename T>
auto toBytesWithHeader(const T& object) -> std::vector<uint8>;

template <typename T>
auto fromBytes(const std::span<const uint8> message) -> Maybe<T>;

template <typename T>
auto fromBytesWithHeader(const std::span<const uint8> message) -> Maybe<T>;

} // namespace ipc

#include "ipc_structs.h"
#include "ipc_stubs.h"

#include <glaze/cbor.hpp>

namespace ipc
{

//
// Helpers
//

template <typename T>
auto toBytes(const T& object) -> std::vector<uint8>
{
    auto bytes = std::vector<uint8>();
    if (glz::write_cbor(object, bytes))
    {
        ShowErrorFmt("Failed to serialize {}", glz::type_name<T>);
        return {};
    }

    return bytes;
}

template <typename T>
auto toBytesWithHeader(const T& object) -> std::vector<uint8>
{
    auto bytes = toBytes(object);
    bytes.insert(bytes.begin(), static_cast<uint8>(EnumTypeV<T>));
    return bytes;
}

template <typename T>
auto fromBytes(const std::span<const uint8> message) -> Maybe<T>
{
    if (message.empty())
    {
        return std::nullopt;
    }

    auto object = T{};
    if (glz::read_cbor(object, message))
    {
        return std::nullopt;
    }

    return object;
}

template <typename T>
auto fromBytesWithHeader(const std::span<const uint8> message) -> Maybe<T>
{
    if (message.empty())
    {
        return std::nullopt;
    }

    const auto type = static_cast<MessageType>(message[0]);
    if (type != EnumTypeV<T>)
    {
        return std::nullopt;
    }

    return fromBytes<T>(message.subspan(1));
}

} // namespace ipc
