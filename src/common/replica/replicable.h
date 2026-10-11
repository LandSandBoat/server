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

#include <concepts>
#include <string_view>

#include <glaze/cbor.hpp>

namespace xi::replica
{

// a struct glaze can serialize
template <typename T>
concept Reflectable = glz::reflectable<T> || glz::glaze_object_t<T>;

// a Reflectable with operator==, which is how the owner sees a change
template <typename T>
concept Replicable = Reflectable<T> && std::equality_comparable<T>;

// identifies T on the wire: hash of its name and field names
template <Reflectable T>
constexpr auto kTypeId = []
{
    const auto fnv1a = [](const std::string_view text, uint32 hash)
    {
        for (const auto c : text)
        {
            hash = (hash ^ static_cast<uint8>(c)) * 16777619u;
        }

        return hash;
    };

    auto hash = fnv1a(glz::type_name<T>, 2166136261u);
    for (const auto key : glz::reflect<T>::keys)
    {
        hash = fnv1a(key, hash);
    }

    return hash;
}();

} // namespace xi::replica
