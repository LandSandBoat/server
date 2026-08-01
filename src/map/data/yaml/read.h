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

#include <glaze/yaml.hpp>

#include <stdexcept>
#include <string_view>

namespace xi::data::yaml
{

inline constexpr glz::opts kStrictYaml{
    .error_on_unknown_keys = true,
    .error_on_missing_keys = true,
};

// Decode one YAML document with strict field checks.
template <class T>
auto read(const std::string_view yaml) -> T
{
    T          value{};
    const auto error = glz::read_yaml<kStrictYaml>(value, yaml);
    if (error)
    {
        throw std::runtime_error(glz::format_error(error, yaml));
    }

    return value;
}

} // namespace xi::data::yaml
