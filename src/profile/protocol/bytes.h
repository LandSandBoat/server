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

#include "common/cbasetypes.h"
#include "common/types/maybe.h"

#include <cstring>
#include <span>
#include <string>
#include <string_view>
#include <type_traits>

namespace profile
{

// a wire object from exactly its own size of bytes
template <typename T>
    requires std::is_trivially_copyable_v<T>
auto fromBytes(const std::span<const uint8> bytes) -> Maybe<T>
{
    if (bytes.size() != sizeof(T))
    {
        return std::nullopt;
    }

    auto value = T{};
    std::memcpy(&value, bytes.data(), sizeof(T));
    return value;
}

template <typename T>
    requires std::is_trivially_copyable_v<T>
auto asBytes(const T& value) -> std::span<const uint8, sizeof(T)>
{
    return std::span<const uint8, sizeof(T)>(reinterpret_cast<const uint8*>(&value), sizeof(T));
}

inline auto asBytes(const std::string_view text) -> std::span<const uint8>
{
    return { reinterpret_cast<const uint8*>(text.data()), text.size() };
}

inline auto asString(const std::span<const uint8> bytes) -> std::string
{
    return { reinterpret_cast<const char*>(bytes.data()), bytes.size() };
}

} // namespace profile
