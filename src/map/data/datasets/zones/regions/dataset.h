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

#include <array>
#include <string>
#include <string_view>
#include <vector>

namespace xi::data
{

// Corners in the XZ plane, each carrying the ground height under it. The ring closes implicitly.
using RegionRing = std::vector<std::array<float, 3>>;

struct RegionData
{
    std::string             Name;
    RegionRing              Outer;
    std::vector<RegionRing> Holes;
};

using Regions = std::vector<RegionData>;

} // namespace xi::data

namespace xi::data::datasets::zones::regions::wire
{

struct Document;

}

namespace xi::data::datasets::zones::regions
{

struct Dataset
{
    using Records      = xi::data::Regions;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "regions" };
    static constexpr std::string_view kTitle{ "Zone roam regions" };
    static constexpr std::string_view kDescription{ "Hand-drawn areas a mob may roam in, for one zone." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::zones::regions
