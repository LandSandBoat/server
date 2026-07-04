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

#include <functional>
#include <string>
#include <string_view>
#include <unordered_map>

//
// HashMap
//
//   A thin alias over std::unordered_map. Unlike FlatHashMap, the nodes live in
//   separately-allocated buckets, so pointers/references to elements stay stable
//   across rehash (only iterators are invalidated). Use this when you need stable
//   element addresses; prefer FlatHashMap on hot paths that don't.
//
// Heterogeneous lookup:
//   When the key is std::string, the default Hash/KeyEqual below are transparent
//   (they define is_transparent), so find()/contains()/count()/equal_range() accept
//   a std::string_view (or const char*) without constructing a temporary std::string.
//   This requires C++20.
//
//   Note: operator[], at(), insert(), and emplace() are NOT heterogeneous in the
//   standard and still require an actual Key.
//

namespace detail
{

// Transparent hasher for string-like keys. All overloads must agree on the hash
// of equal inputs, so they all funnel through std::hash<std::string_view>.
struct StringHash
{
    using is_transparent = void;

    [[nodiscard]] std::size_t operator()(std::string_view sv) const noexcept
    {
        return std::hash<std::string_view>{}(sv);
    }

    [[nodiscard]] std::size_t operator()(const std::string& s) const noexcept
    {
        return std::hash<std::string_view>{}(s);
    }

    [[nodiscard]] std::size_t operator()(const char* s) const
    {
        return std::hash<std::string_view>{}(std::string_view{ s });
    }
};

// Selects a transparent hash/equal pair for std::string keys, and the plain
// defaults for everything else.
template <typename Key>
struct HashMapTraits
{
    using Hash     = std::hash<Key>;
    using KeyEqual = std::equal_to<Key>;
};

template <>
struct HashMapTraits<std::string>
{
    using Hash     = StringHash;
    using KeyEqual = std::equal_to<>; // transparent
};

} // namespace detail

// namespace xi
// {

template <typename Key,
          typename Value,
          typename Hash     = typename detail::HashMapTraits<Key>::Hash,
          typename KeyEqual = typename detail::HashMapTraits<Key>::KeyEqual>
using HashMap = std::unordered_map<Key, Value, Hash, KeyEqual>;

// } // namespace xi
