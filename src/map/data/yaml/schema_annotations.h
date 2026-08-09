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

#include <glaze/glaze.hpp>

#include <string_view>

namespace xi::data::yaml
{

// Ignore generator metadata while keeping the dataset payload required.
template <auto Payload>
struct DatasetRoot
{
    static constexpr auto value = glz::object(
        "meta",
        glz::skip{},
        glz::get_name<Payload>(),
        Payload);

    static constexpr bool requires_key(const std::string_view key, const bool isNullable)
    {
        return key != "meta" && !isNullable;
    }
};

template <class T>
concept DatasetDocument = requires {
    typename T::YamlRoot;
};

} // namespace xi::data::yaml

template <class T>
    requires xi::data::yaml::DatasetDocument<T>
struct glz::meta<T> : T::YamlRoot
{
};
