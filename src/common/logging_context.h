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

#include "macros.h"

#include <magic_enum/magic_enum.hpp>

#include <cstdint>
#include <initializer_list>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <variant>

namespace logging
{

struct Field;

using Subfields = std::vector<Field>;

struct Field
{
    using Value = std::variant<
        std::int64_t,
        std::uint64_t,
        double,
        bool,
        std::string_view,
        std::string,
        Subfields>;

    std::string_view key;
    Value            value;

    template <typename T>
    Field(std::string_view k, T&& v)
    : key(k)
    , value(toValue(std::forward<T>(v)))
    {
    }

    Field(std::string_view k, std::initializer_list<Field> nested)
    : key(k)
    , value(Subfields(nested))
    {
    }

private:
    template <typename T>
    static auto toValue(T&& v) -> Value
    {
        using U = std::remove_cvref_t<T>;

        if constexpr (std::is_same_v<U, bool>)
        {
            return v;
        }
        else if constexpr (std::is_enum_v<U>)
        {
            if (auto name = magic_enum::enum_name(v); !name.empty())
            {
                return name;
            }

            return toValue(std::to_underlying(v));
        }
        else if constexpr (std::is_integral_v<U> && std::is_signed_v<U>)
        {
            return static_cast<std::int64_t>(v);
        }
        else if constexpr (std::is_integral_v<U> && std::is_unsigned_v<U>)
        {
            return static_cast<std::uint64_t>(v);
        }
        else if constexpr (std::is_floating_point_v<U>)
        {
            return static_cast<double>(v);
        }
        else if constexpr (std::is_same_v<U, std::string>)
        {
            if constexpr (std::is_lvalue_reference_v<T>)
            {
                return std::string_view(v);
            }
            else
            {
                return std::move(v);
            }
        }
        else if constexpr (std::is_convertible_v<T, std::string_view>)
        {
            return std::string_view(v);
        }
        else
        {
            static_assert(sizeof(T*) == 0, "logging::Field: unsupported value type");
            return Value{};
        }
    }
};

class LogScope
{
public:
    LogScope(std::initializer_list<Field> fields);
    ~LogScope();

    DISALLOW_COPY_AND_MOVE(LogScope)

private:
    std::size_t pushedCount_{ 0 };
};

auto currentContext() -> const std::vector<Field>&;

} // namespace logging

// clang-format off

#define LOG_WITH_CAT_INNER(a, b) a##b
#define LOG_WITH_CAT(a, b)       LOG_WITH_CAT_INNER(a, b)

/// Add key/values to logging context. Popped when LogWith goes out of scope.
#define LogWith(...) \
    ::logging::LogScope LOG_WITH_CAT(_ls_, __LINE__){ __VA_ARGS__ }

// clang-format on
