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
#include "data/enums/content.h"
#include "data/enums/job.h"
#include "data/enums/merit.h"
#include "data/enums/mod.h"
#include "data/enums/trait.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <optional>
#include <string>
#include <variant>

namespace xi::data::datasets::traits::wire
{

using Mods = yaml::EnumKeyedMap<xi::Mod, int16>;

struct JobRank
{
    uint8                                       level{};
    std::optional<yaml::EnumToken<xi::Content>> content;
};

// a level, or a level and the content that gates it
using JobRankEntry = std::variant<uint8, JobRank>;

struct JobTrait
{
    uint8                                                                     id{};
    std::optional<yaml::EnumToken<xi::Merit>>                                 merit;
    std::optional<std::map<uint8, Mods>>                                      ranks;
    std::optional<yaml::EnumKeyedMap<xi::Job, std::map<uint8, JobRankEntry>>> jobs;
};

struct Document
{
    std::map<std::string, JobTrait> traits;

    using YamlRoot = yaml::DatasetRoot<&Document::traits>;
};

} // namespace xi::data::datasets::traits::wire

template <>
struct glz::json_schema<xi::data::datasets::traits::wire::JobRank>
{
    glz::schema level{ .description = "Level that grants the rank.", .minimum = 1L, .maximum = 99L };
    glz::schema content{ .description = "Content the rank needs enabled." };
};

template <>
struct glz::json_schema<xi::data::datasets::traits::wire::JobTrait>
{
    glz::schema id{ .description = "Client-facing trait ID. Must fit the 144-bit trait mask.", .minimum = 0L, .maximum = 143L };
    glz::schema merit{ .description = "Merit the trait needs upgrades in." };
    glz::schema ranks{ .description = "Modifiers each rank grants, by rank. Left out when code or scripts give the effect." };
    glz::schema jobs{ .description = "Level each job gets each rank at, by rank." };
};

template <>
struct glz::json_schema<xi::data::datasets::traits::wire::Document>
{
    glz::schema traits{ .description = "Job traits by name, in ID order." };
};
