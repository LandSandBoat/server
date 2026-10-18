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
#include "data/enums/job.h"
#include "data/enums/skill_rank.h"
#include "data/enums/skill_type.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <string_view>

namespace xi::data::datasets::skills::wire
{

using Rank = yaml::EnumToken<xi::SkillRank>;

using JobRanks = yaml::EnumKeyedMap<xi::Job, Rank>;

// The cap each rank reaches at one level.
struct CapRow
{
    uint16 a_plus{};
    uint16 a{};
    uint16 b_plus{};
    uint16 b{};
    uint16 b_minus{};
    uint16 c_plus{};
    uint16 c{};
    uint16 c_minus{};
    uint16 d{};
    uint16 e{};
    uint16 f{};
    uint16 g{};
};

struct Tables
{
    yaml::EnumKeyedMap<xi::SkillType, JobRanks> ranks;
    std::map<uint8, CapRow>                     caps;
};

struct Document
{
    Tables skills;

    using YamlRoot = yaml::DatasetRoot<&Document::skills>;
};

} // namespace xi::data::datasets::skills::wire

template <>
struct glz::meta<xi::data::datasets::skills::wire::CapRow>
{
    static constexpr std::string_view name{ "skill_cap_row" };
};

template <>
struct glz::json_schema<xi::data::datasets::skills::wire::Tables>
{
    glz::schema ranks{ .description = "Rank each job holds in a skill. A job left out has no rank in it." };
    glz::schema caps{ .description = "Cap each rank reaches at every level from 1 to 99." };
};

template <>
struct glz::json_schema<xi::data::datasets::skills::wire::Document>
{
    glz::schema skills{ .description = "The rank every job holds in each skill, and the cap each rank reaches per level." };
};
