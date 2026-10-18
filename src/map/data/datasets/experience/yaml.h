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

namespace xi::data::datasets::experience::wire
{

struct Tables
{
    std::map<uint8, uint32> next_level;
};

struct Document
{
    Tables experience;

    using YamlRoot = yaml::DatasetRoot<&Document::experience>;
};

} // namespace xi::data::datasets::experience::wire

template <>
struct glz::json_schema<xi::data::datasets::experience::wire::Tables>
{
    glz::schema next_level{ .description = "Exp needed to go from each level from 1 to 99 to the next." };
};

template <>
struct glz::json_schema<xi::data::datasets::experience::wire::Document>
{
    glz::schema experience{ .description = "Exp needed to go from each level to the next." };
};
