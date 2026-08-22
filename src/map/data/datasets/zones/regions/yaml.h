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
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <optional>
#include <string>
#include <vector>

namespace xi::data::datasets::zones::regions::wire
{

// A ring is a closed loop of x, y, z corners; it closes implicitly.
using Ring = std::vector<std::vector<float>>;

struct Region
{
    Ring                             poly;
    std::optional<std::vector<Ring>> holes;
};

struct Document
{
    std::map<std::string, Region> regions;

    using YamlRoot = yaml::DatasetRoot<&Document::regions>;
};

} // namespace xi::data::datasets::zones::regions::wire

template <>
struct glz::json_schema<xi::data::datasets::zones::regions::wire::Region>
{
    glz::schema poly{ .description = "Outer ring, as x, y, z corners in order. Closes implicitly. Y is the ground under that corner." };
    glz::schema holes{ .description = "Rings cut out of the outer one, each in the same form. Omitted means a solid region." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::regions::wire::Document>
{
    glz::schema regions{ .description = "Areas a mob may roam in, keyed by name. A spawn joins one by naming it." };
};
