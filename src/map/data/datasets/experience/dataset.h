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
#include "data/datasets/stats/dataset.h"

#include <array>
#include <cstddef>
#include <string_view>

namespace xi::data
{

struct Experience
{
    // Exp needed to go from each level to the next. Level 0 needs none.
    std::array<uint32, kGrowthLevels> NextLevel{};

    auto size() const -> std::size_t
    {
        return NextLevel.size() - 1;
    }
};

} // namespace xi::data

namespace xi::data::datasets::experience::wire
{

struct Document;

}

namespace xi::data::datasets::experience
{

struct Dataset
{
    using Records      = xi::data::Experience;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "experience" };
    static constexpr std::string_view kTitle{ "Experience" };
    static constexpr std::string_view kDescription{ "Exp needed to go from each level to the next." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::experience
