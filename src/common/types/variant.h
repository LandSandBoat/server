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

#include <utility>
#include <variant>

//
// Variant
//
//   A drop-in std::variant that adds a member .visit() so you can write
//   v.visit(visitor) instead of std::visit(visitor, v). Everything else
//   (std::get, std::holds_alternative, index(), etc.) works unchanged.
//
//   A common visitor pattern is an overload set built from lambdas:
//
//       Variant<int, std::string> v = 42;
//       v.visit(overload{
//           [](int i)                { /* ... */ },
//           [](const std::string& s) { /* ... */ },
//       });
//

// Overload-set helper for building inline visitors from multiple lambdas.
// helper type for std::visit / Variant::visit
// https://en.cppreference.com/w/cpp/utility/variant/visit
template <typename... Ts>
struct overload : Ts...
{
    // cppcheck-suppress syntaxError
    using Ts::operator()...;
};

template <typename... Ts>
overload(Ts...) -> overload<Ts...>;

template <typename... Types>
class Variant : public std::variant<Types...>
{
public:
    using std::variant<Types...>::variant;
    using std::variant<Types...>::operator=;

    template <typename Visitor>
    decltype(auto) visit(Visitor&& visitor) &;

    template <typename Visitor>
    decltype(auto) visit(Visitor&& visitor) const&;

    template <typename Visitor>
    decltype(auto) visit(Visitor&& visitor) &&;
};

//
// Implementation
//

template <typename... Types>
template <typename Visitor>
decltype(auto) Variant<Types...>::visit(Visitor&& visitor) &
{
    return std::visit(std::forward<Visitor>(visitor), static_cast<std::variant<Types...>&>(*this));
}

template <typename... Types>
template <typename Visitor>
decltype(auto) Variant<Types...>::visit(Visitor&& visitor) const&
{
    return std::visit(std::forward<Visitor>(visitor), static_cast<const std::variant<Types...>&>(*this));
}

template <typename... Types>
template <typename Visitor>
decltype(auto) Variant<Types...>::visit(Visitor&& visitor) &&
{
    return std::visit(std::forward<Visitor>(visitor), static_cast<std::variant<Types...>&&>(*this));
}
