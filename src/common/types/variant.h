/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include <concepts>
#include <stdexcept>
#include <type_traits>
#include <utility>
#include <variant>

#include "maybe.h"

namespace xi
{

//
// Variant<Ts...>
//
// A wrapper around std::variant to provide:
// - variant.has<T>() -> bool
// - variant.get<T>() -> Maybe<T&>
// - variant.visit(overload{ ... }) -> decltype(auto)
//
// https://en.cppreference.com/w/cpp/utility/variant
//

template <typename T, typename... Ts>
concept OneOf = (std::same_as<T, Ts> || ...);

template <typename... Ts>
class Variant
{
public:
    template <typename T>
    constexpr Variant(T&& value)
        requires OneOf<std::decay_t<T>, Ts...>;

    template <typename T>
    constexpr Variant(const T& value)
        requires OneOf<T, Ts...>;

    ~Variant() = default;

    constexpr Variant(const Variant& other)                = default;
    constexpr Variant(Variant&& other) noexcept            = default;
    constexpr Variant& operator=(const Variant& other)     = default;
    constexpr Variant& operator=(Variant&& other) noexcept = default;

    template <typename T>
    constexpr auto operator=(T&& value) -> Variant&
        requires OneOf<std::decay_t<T>, Ts...>;

    template <typename T>
    constexpr auto operator=(const T& value) -> Variant&
        requires OneOf<T, Ts...>;

    template <typename Visitor>
    constexpr auto visit(Visitor&& visitor) & -> decltype(auto);

    template <typename Visitor>
    constexpr auto visit(Visitor&& visitor) const& -> decltype(auto);

    template <typename Visitor>
    constexpr auto visit(Visitor&& visitor) && -> decltype(auto);

    template <typename Visitor>
    constexpr auto visit(Visitor&& visitor) const&& -> decltype(auto);

    template <typename T>
    constexpr auto get() & -> Maybe<T&>
        requires OneOf<T, Ts...>;

    template <typename T>
    constexpr auto get() const& -> Maybe<const T&>
        requires OneOf<T, Ts...>;

    template <typename T>
    constexpr auto has() const noexcept -> bool
        requires OneOf<T, Ts...>;

    template <typename T, typename... Args>
    constexpr auto emplace(Args&&... args) -> T&
        requires OneOf<T, Ts...>;

    constexpr auto operator<=>(const Variant& other) const = default;

private:
    std::variant<Ts...> variant_;
};

//
// Implementation
//

template <typename... Ts>
template <typename T>
constexpr Variant<Ts...>::Variant(T&& value)
    requires OneOf<std::decay_t<T>, Ts...>
: variant_(std::forward<T>(value))
{
}

template <typename... Ts>
template <typename T>
constexpr Variant<Ts...>::Variant(const T& value)
    requires OneOf<T, Ts...>
: variant_(value)
{
}

template <typename... Ts>
template <typename T>
constexpr auto Variant<Ts...>::operator=(T&& value) -> Variant&
    requires OneOf<std::decay_t<T>, Ts...>
{
    variant_ = std::forward<T>(value);
    return *this;
}

template <typename... Ts>
template <typename T>
constexpr auto Variant<Ts...>::operator=(const T& value) -> Variant&
    requires OneOf<T, Ts...>
{
    variant_ = value;
    return *this;
}

template <typename... Ts>
template <typename Visitor>
constexpr auto Variant<Ts...>::visit(Visitor&& visitor) & -> decltype(auto)
{
    return std::visit(std::forward<Visitor>(visitor), variant_);
}

template <typename... Ts>
template <typename Visitor>
constexpr auto Variant<Ts...>::visit(Visitor&& visitor) const& -> decltype(auto)
{
    return std::visit(std::forward<Visitor>(visitor), variant_);
}

template <typename... Ts>
template <typename Visitor>
constexpr auto Variant<Ts...>::visit(Visitor&& visitor) && -> decltype(auto)
{
    return std::visit(std::forward<Visitor>(visitor), std::move(variant_));
}

template <typename... Ts>
template <typename Visitor>
constexpr auto Variant<Ts...>::visit(Visitor&& visitor) const&& -> decltype(auto)
{
    return std::visit(std::forward<Visitor>(visitor), std::move(variant_));
}

template <typename... Ts>
template <typename T>
constexpr auto Variant<Ts...>::get() & -> Maybe<T&>
    requires OneOf<T, Ts...>
{
    if (auto* ptr = std::get_if<T>(&variant_))
    {
        return Maybe<T&>(*ptr);
    }
    return {};
}

template <typename... Ts>
template <typename T>
constexpr auto Variant<Ts...>::get() const& -> Maybe<const T&>
    requires OneOf<T, Ts...>
{
    if (const auto* ptr = std::get_if<T>(&variant_))
    {
        return Maybe<const T&>(*ptr);
    }
    return {};
}

template <typename... Ts>
template <typename T>
constexpr auto Variant<Ts...>::has() const noexcept -> bool
    requires OneOf<T, Ts...>
{
    return std::holds_alternative<T>(variant_);
}

template <typename... Ts>
template <typename T, typename... Args>
constexpr auto Variant<Ts...>::emplace(Args&&... args) -> T&
    requires OneOf<T, Ts...>
{
    return variant_.template emplace<T>(std::forward<Args>(args)...);
}

} // namespace xi
