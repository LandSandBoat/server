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

#include "common/enum_traits.h"

#include <fmt/format.h>
#include <glaze/glaze.hpp>

#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <type_traits>
#include <unordered_set>
#include <utility>
#include <vector>

namespace xi::data::yaml
{

template <class Enum>
concept SchemaEnum = Nameable<Enum> && requires {
    EnumTraits<Enum>::kEntries;
};

template <SchemaEnum Enum>
struct EnumToken
{
    std::string Value;
};

template <SchemaEnum Enum>
auto enumTokenSchema() -> glz::schema
{
    glz::schema                   result{ .title = EnumTraits<Enum>::kTypeName };
    std::vector<std::string_view> names;
    names.reserve(EnumTraits<Enum>::kEntries.size());
    for (const auto& [name, _] : EnumTraits<Enum>::kEntries)
    {
        names.emplace_back(name);
    }
    result.enumeration = std::move(names);
    return result;
}

template <SchemaEnum Enum>
auto resolveEnum(const EnumToken<Enum>& token) -> Enum
{
    return EnumTraits<Enum>::fromName(token.Value);
}

template <SchemaEnum Enum>
auto resolveEnum(const std::optional<EnumToken<Enum>>& token, const Enum fallback = {}) -> Enum
{
    return token ? resolveEnum(*token) : fallback;
}

// Resolve a flag list and reject duplicates.
template <SchemaEnum Enum>
auto resolveFlags(const std::optional<std::vector<EnumToken<Enum>>>& tokens) -> Enum
{
    using Underlying = std::underlying_type_t<Enum>;
    Underlying result{};
    if (tokens)
    {
        std::unordered_set<std::string_view> seen;
        seen.reserve(tokens->size());
        for (const auto& token : *tokens)
        {
            if (!seen.emplace(token.Value).second)
            {
                throw std::runtime_error(fmt::format("duplicate enum value '{}'", token.Value));
            }

            result |= static_cast<Underlying>(resolveEnum(token));
        }
    }

    return static_cast<Enum>(result);
}

// Check key syntax and IDs for names already known to the enum.
template <SchemaEnum Enum, class Id>
void verifyNamedMapEntry(const std::string_view key, const Id id)
{
    const auto isLower = [](const char value)
    {
        return value >= 'a' && value <= 'z';
    };
    const auto isDigit = [](const char value)
    {
        return value >= '0' && value <= '9';
    };

    if (key.empty() || !isLower(key.front()))
    {
        throw std::runtime_error("invalid named-map key '" + std::string{ key } + "'");
    }

    for (const auto value : key.substr(1))
    {
        if (!isLower(value) && !isDigit(value) && value != '_')
        {
            throw std::runtime_error("invalid named-map key '" + std::string{ key } + "'");
        }
    }

    const auto* value = enum_detail::findByName<Enum>(key, EnumTraits<Enum>::kEntries);
    if (value && std::to_underlying(*value) != id)
    {
        throw std::runtime_error(fmt::format("'{}' maps to id {}, but YAML declares id {}",
                                             key,
                                             std::to_underlying(*value),
                                             id));
    }
}

} // namespace xi::data::yaml

template <xi::data::yaml::SchemaEnum Enum>
struct glz::meta<xi::data::yaml::EnumToken<Enum>>
{
    using T                     = xi::data::yaml::EnumToken<Enum>;
    static constexpr auto name  = xi::data::EnumTraits<Enum>::kTypeName;
    static constexpr auto value = &T::Value;
};

template <xi::data::yaml::SchemaEnum Enum>
struct glz::json_schema<xi::data::yaml::EnumToken<Enum>>
{
    glz::schema Value = xi::data::yaml::enumTokenSchema<Enum>();
};
