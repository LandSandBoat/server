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

#include <tl/optional.hpp>

#include <type_traits>
#include <utility>

#include "null.h"

namespace xi
{

//
// Maybe<T>
//
// A wrapper around tl::optional to allow usage of:
// - Maybe<T&>
// - object.apply([](auto& obj) { ... })
//

template <typename T>
concept NotRef = !std::is_reference_v<T>;

template <typename T>
class Maybe
{
public:
    constexpr Maybe() = default;
    constexpr Maybe(tl::nullopt_t) noexcept;
    constexpr Maybe(std::nullopt_t) noexcept;
    constexpr Maybe(T value);

    ~Maybe() = default;

    constexpr Maybe(const Maybe& other)                = default;
    constexpr Maybe(Maybe&& other) noexcept            = default;
    constexpr Maybe& operator=(const Maybe& other)     = default;
    constexpr Maybe& operator=(Maybe&& other) noexcept = default;

    constexpr auto operator=(tl::nullopt_t) noexcept -> Maybe&;
    constexpr auto operator=(std::nullopt_t) noexcept -> Maybe&;
    constexpr auto operator=(T value) -> Maybe&;

    template <typename F>
    constexpr auto apply(F&& f) & -> bool;

    template <typename F>
    constexpr auto apply(F&& f) const& -> bool;

    constexpr explicit operator bool() const noexcept;

    constexpr auto operator*() & -> T&;
    constexpr auto operator*() const& -> const T&;

    constexpr auto operator*() && -> T&&
        requires NotRef<T>;

    constexpr auto operator*() const&& -> const T&&
        requires NotRef<T>;

    constexpr auto hasValue() const noexcept -> bool;

    constexpr auto value() & -> T&;
    constexpr auto value() const& -> const T&;

    constexpr auto value() && -> T&&
        requires NotRef<T>;

    constexpr auto value() const&& -> const T&&
        requires NotRef<T>;

    constexpr void reset() noexcept;

    template <typename... Args>
    constexpr auto emplace(Args&&... args) -> T&;

    constexpr auto operator<=>(const Maybe& other) const = default;

private:
    tl::optional<T> value_ = tl::nullopt;
};

//
// Implementation
//

template <typename T>
constexpr Maybe<T>::Maybe(tl::nullopt_t) noexcept
: value_(tl::nullopt)
{
}

template <typename T>
constexpr Maybe<T>::Maybe(std::nullopt_t) noexcept
: value_(tl::nullopt)
{
}

template <typename T>
constexpr Maybe<T>::Maybe(T value)
: value_(value)
{
}

template <typename T>
constexpr auto Maybe<T>::operator=(tl::nullopt_t) noexcept -> Maybe&
{
    value_ = tl::nullopt;
    return *this;
}

template <typename T>
constexpr auto Maybe<T>::operator=(std::nullopt_t) noexcept -> Maybe&
{
    value_ = tl::nullopt;
    return *this;
}

template <typename T>
constexpr auto Maybe<T>::operator=(T value) -> Maybe&
{
    value_ = value;
    return *this;
}

template <typename T>
template <typename F>
constexpr auto Maybe<T>::apply(F&& f) & -> bool
{
    if (value_)
    {
        f(*value_);
    }
    return value_.has_value();
}

template <typename T>
template <typename F>
constexpr auto Maybe<T>::apply(F&& f) const& -> bool
{
    if (value_)
    {
        f(*value_);
    }
    return value_.has_value();
}

template <typename T>
constexpr Maybe<T>::operator bool() const noexcept
{
    return value_.has_value();
}

template <typename T>
constexpr auto Maybe<T>::operator*() & -> T&
{
    return *value_;
}

template <typename T>
constexpr auto Maybe<T>::operator*() const& -> const T&
{
    return *value_;
}

template <typename T>
constexpr auto Maybe<T>::operator*() && -> T&&
    requires NotRef<T>
{
    return std::move(*value_);
}

template <typename T>
constexpr auto Maybe<T>::operator*() const&& -> const T&&
    requires NotRef<T>
{
    return std::move(*value_);
}

template <typename T>
constexpr auto Maybe<T>::hasValue() const noexcept -> bool
{
    return value_.has_value();
}

template <typename T>
constexpr auto Maybe<T>::value() & -> T&
{
    return value_.value();
}

template <typename T>
constexpr auto Maybe<T>::value() const& -> const T&
{
    return value_.value();
}

template <typename T>
constexpr auto Maybe<T>::value() && -> T&&
    requires NotRef<T>
{
    return std::move(value_.value());
}

template <typename T>
constexpr auto Maybe<T>::value() const&& -> const T&&
    requires NotRef<T>
{
    return std::move(value_.value());
}

template <typename T>
constexpr void Maybe<T>::reset() noexcept
{
    value_.reset();
}

template <typename T>
template <typename... Args>
constexpr auto Maybe<T>::emplace(Args&&... args) -> T&
{
    return value_.emplace(std::forward<Args>(args)...);
}

} // namespace xi
