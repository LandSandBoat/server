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
#include "common/types/hash_map.h"
#include "data/yaml/enum_token.h"

#include <fmt/format.h>
#include <glaze/glaze.hpp>

#include <algorithm>
#include <array>
#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>

namespace xi::data::yaml
{

// A map keyed by enum name, e.g. `mods: { defp: 20 }`.
template <SchemaEnum Enum, class Value>
struct EnumKeyedMap
{
    std::map<std::string, Value> Values;
};

// Resolve the keys and reject names that alias the same value.
template <SchemaEnum Enum, class Value>
auto resolveKeys(const std::optional<EnumKeyedMap<Enum, Value>>& entries) -> HashMap<Enum, Value>
{
    HashMap<Enum, Value> values;
    if (!entries)
    {
        return values;
    }

    for (const auto& [name, value] : entries->Values)
    {
        if (!values.try_emplace(EnumTraits<Enum>::fromName(name), value).second)
        {
            throw std::runtime_error(fmt::format("duplicate {} entry '{}'", EnumTraits<Enum>::kTypeName, name));
        }
    }

    return values;
}

// $defs key, e.g. "ModValues<int16_t>" — one enum can back maps of different value types.
template <SchemaEnum Enum, class Value>
struct EnumKeyedMapName
{
    static constexpr std::string_view kInfix{ "Values<" };
    static constexpr std::string_view kSuffix{ ">" };

    static constexpr auto kStorage = []
    {
        std::array<char, EnumTraits<Enum>::kTypeName.size() + kInfix.size() + glz::name_v<Value>.size() + kSuffix.size()> out{};

        auto next = std::ranges::copy(EnumTraits<Enum>::kTypeName, out.begin()).out;
        next      = std::ranges::copy(kInfix, next).out;
        next      = std::ranges::copy(glz::name_v<Value>, next).out;
        std::ranges::copy(kSuffix, next);

        return out;
    }();

    static constexpr std::string_view kName{ kStorage.data(), kStorage.size() };
};

} // namespace xi::data::yaml

template <xi::data::yaml::SchemaEnum Enum, class Value>
struct glz::meta<xi::data::yaml::EnumKeyedMap<Enum, Value>>
{
    using T                     = xi::data::yaml::EnumKeyedMap<Enum, Value>;
    static constexpr auto name  = xi::data::yaml::EnumKeyedMapName<Enum, Value>::kName;
    static constexpr auto value = &T::Values;
};

namespace glz::detail
{

// One property per enum name, so editors complete them and typos fail validation.
template <xi::data::yaml::SchemaEnum Enum, class Value>
struct to_json_schema<xi::data::yaml::EnumKeyedMap<Enum, Value>>
{
    template <auto Opts>
    static void op(auto& s, auto& defs)
    {
        schema value{};
        to_json_schema<Value>::template op<Opts>(value, defs);

        std::map<std::string_view, schema, std::less<>> properties;
        for (const auto& [name, _] : xi::data::EnumTraits<Enum>::kEntries)
        {
            properties.emplace(name, value);
        }

        s.type                 = std::string_view{ "object" };
        s.properties           = std::move(properties);
        s.additionalProperties = false;
    }
};

} // namespace glz::detail
