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

#include "common/cbasetypes.h"
#include "common/types/position.h"

#include <fmt/format.h>

#include <optional>
#include <stdexcept>
#include <string_view>
#include <vector>

namespace xi::data::shared
{

// An `at` block: x, y, z, and an optional facing of 0-255.
inline auto toPosition(const std::optional<std::vector<float>>& values, const std::string_view context, const uint16 moving = 0) -> position_t
{
    if (!values)
    {
        return { 0.0f, 0.0f, 0.0f, moving, 0 };
    }

    if (values->size() < 3 || values->size() > 4)
    {
        throw std::runtime_error(fmt::format("{} position needs three values plus an optional facing", context));
    }

    const auto facing = [&]() -> uint8
    {
        if (values->size() > 3)
        {
            return static_cast<uint8>((*values)[3]);
        }

        return 0;
    }();

    return { (*values)[0], (*values)[1], (*values)[2], moving, facing };
}

// Zone lines state their arrival facing in radians, the form the client's own data ships.
inline auto toPositionFacingRadians(const std::optional<std::vector<float>>& values, const std::string_view context) -> position_t
{
    auto position = toPosition(values, context);
    if (values && values->size() > 3)
    {
        position.rotation = radianToRotation((*values)[3]);
    }

    return position;
}

} // namespace xi::data::shared
