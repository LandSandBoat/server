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

#include "data/enums/job.h"
#include "data/enums/stat_rank.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <string_view>

namespace xi::data::datasets::grades::wire
{

using Rank = yaml::EnumToken<xi::StatRank>;

struct Attributes
{
    Rank hp;
    Rank mp;
    Rank str;
    Rank dex;
    Rank vit;
    Rank agi;
    Rank intelligence;
    Rank mnd;
    Rank chr;
};

struct RaceGrades
{
    Attributes hume;
    Attributes elvaan;
    Attributes tarutaru;
    Attributes mithra;
    Attributes galka;
};

struct Tables
{
    yaml::EnumKeyedMap<xi::Job, Attributes> jobs;
    RaceGrades                              races;
};

struct Document
{
    Tables grades;

    using YamlRoot = yaml::DatasetRoot<&Document::grades>;
};

} // namespace xi::data::datasets::grades::wire

template <>
struct glz::meta<xi::data::datasets::grades::wire::Attributes>
{
    using T                                  = xi::data::datasets::grades::wire::Attributes;
    static constexpr std::string_view name   = "attribute_grades";
    static constexpr auto             modify = glz::object("int", &T::intelligence);
};

template <>
struct glz::json_schema<xi::data::datasets::grades::wire::Tables>
{
    glz::schema jobs{ .description = "Grade each job holds in every attribute." };
    glz::schema races{ .description = "Grade each race holds in every attribute." };
};

template <>
struct glz::json_schema<xi::data::datasets::grades::wire::Document>
{
    glz::schema grades{ .description = "The grade every job and race holds in each attribute." };
};
