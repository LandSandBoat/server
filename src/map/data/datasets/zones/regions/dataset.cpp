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

#include "data/datasets/zones/regions/dataset.h"

#include "data/datasets/zones/regions/yaml.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <stdexcept>
#include <string_view>
#include <utility>

namespace xi::data::datasets::zones::regions
{

namespace
{

constexpr size_t kMinimumCorners = 3;

auto convertRing(const wire::Ring& source, const std::string_view name, const std::string_view what) -> RegionRing
{
    if (source.size() < kMinimumCorners)
    {
        throw std::runtime_error(fmt::format("region '{}' has a {} of {} corners", name, what, source.size()));
    }

    RegionRing ring;
    ring.reserve(source.size());
    for (const auto& corner : source)
    {
        if (corner.size() != 3)
        {
            throw std::runtime_error(fmt::format("region '{}' has a {} corner with {} values, not x, y, z", name, what, corner.size()));
        }

        ring.push_back({ corner[0], corner[1], corner[2] });
    }

    return ring;
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto document = yaml::read<YamlDocument>(text);

    Records records;
    records.reserve(document.regions.size());

    for (const auto& [name, source] : document.regions)
    {
        RegionData region{ .Name = name, .Outer = convertRing(source.poly, name, "outer ring") };

        if (source.holes)
        {
            region.Holes.reserve(source.holes->size());
            for (const auto& hole : *source.holes)
            {
                region.Holes.push_back(convertRing(hole, name, "hole"));
            }
        }

        records.push_back(std::move(region));
    }

    return records;
}

} // namespace xi::data::datasets::zones::regions
