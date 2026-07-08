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

#include <array>
#include <type_traits>

namespace db::detail
{

template <typename T>
struct always_false : std::false_type
{
};

template <typename T>
inline constexpr bool always_false_v = always_false<T>::value;

template <typename T>
struct is_std_array : std::false_type
{
};

template <typename T, std::size_t N>
struct is_std_array<std::array<T, N>> : std::true_type
{
};

template <typename T>
inline constexpr bool is_std_array_v = is_std_array<T>::value;

template <typename T>
struct is_standard_trivial : std::bool_constant<std::is_standard_layout_v<T> && std::is_trivial_v<T>>
{
};

template <typename T>
inline constexpr bool is_standard_trivial_v = is_standard_trivial<T>::value;

template <typename T>
inline constexpr bool is_blob = (is_std_array_v<T> || std::is_array_v<T> || is_standard_trivial_v<T>) && !std::is_fundamental_v<T>;

template <typename T>
inline constexpr bool is_blob_v = is_blob<T>;

template <typename T, bool = std::is_enum_v<T>>
struct enum_decay_impl
{
    using type = std::decay_t<T>;
};

template <typename T>
struct enum_decay_impl<T, true>
{
    using type = std::underlying_type_t<T>;
};

template <typename T>
using enum_decay_t = typename enum_decay_impl<T>::type;

} // namespace db::detail
