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

#include <common/types/hash_map.h>

#include <concepts>
#include <fmt/format.h>
#include <span>
#include <stdexcept>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>

namespace xi::data
{

// Codegen emits an EnumTraits<E> specialization per enum.
template <class E>
struct EnumTraits;

template <class E>
concept Nameable = requires(E e, std::string_view sv) {
    { EnumTraits<E>::fromName(sv) } -> std::same_as<E>;
    { EnumTraits<E>::toName(e) } -> std::same_as<std::string_view>;
    { EnumTraits<E>::kTypeName } -> std::convertible_to<std::string_view>;
};

// Codegen sets this true for enums declaring `meta.flags: true`.
template <class E>
inline constexpr bool isFlagEnum = false;

namespace enum_detail
{

// Slug -> enum. Throws on miss; typeName goes in the message.
template <class E>
auto fromName(const std::string_view name, const std::span<const std::pair<std::string_view, E>> entries, const std::string_view typeName) -> E
{
    // Lazy-init on first call, reused after.
    static const HashMap<std::string_view, E> table{ entries.begin(), entries.end() };

    const auto it = table.find(name);
    if (it == table.end())
    {
        throw std::runtime_error(fmt::format("'{}' is not a valid {} enum value", name, typeName));
    }

    return it->second;
}

template <class E>
auto toName(const E value, const std::span<const std::pair<std::string_view, E>> entries) -> std::string_view
{
    // Reverse map. Lazy-init on first call, reused after.
    static const auto table = [entries]
    {
        HashMap<E, std::string_view> m;
        m.reserve(entries.size());
        for (const auto& p : entries)
        {
            m.emplace(p.second, p.first);
        }

        return m;
    }();

    const auto it = table.find(value);
    return it != table.end() ? it->second : std::string_view{ "<unknown>" };
}

} // namespace enum_detail

} // namespace xi::data
