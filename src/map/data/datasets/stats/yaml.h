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
#include <string_view>

namespace xi::data::datasets::stats::wire
{

// One row of a curve table: what that level up grants each column.
struct GradeRow
{
    uint16 a{};
    uint16 b{};
    uint16 c{};
    uint16 d{};
    uint16 e{};
    uint16 f{};
    uint16 g{};
};

struct MpGradeRow
{
    uint16 a{};
    uint16 b{};
    uint16 c{};
    uint16 d{};
    uint16 f{};
};

struct RaceRow
{
    uint16 hume{};
    uint16 elvaan{};
    uint16 tarutaru{};
    uint16 mithra{};
    uint16 galka{};
};

// A row holds until the next level listed, and the last one runs to 99.
template <class Row>
using Curve = std::map<uint8, Row>;

struct HpCurves
{
    Curve<GradeRow> graded;
    Curve<RaceRow>  racial;
};

struct MpCurves
{
    Curve<MpGradeRow> graded;
    Curve<RaceRow>    racial;
};

struct Tables
{
    bool round_once{};

    HpCurves hp;
    MpCurves mp;

    Curve<GradeRow> attributes;
    Curve<uint16>   ungraded;
};

struct Document
{
    Tables stats;

    using YamlRoot = yaml::DatasetRoot<&Document::stats>;
};

} // namespace xi::data::datasets::stats::wire

template <>
struct glz::meta<xi::data::datasets::stats::wire::GradeRow>
{
    static constexpr std::string_view name{ "grade_row" };
};

template <>
struct glz::meta<xi::data::datasets::stats::wire::RaceRow>
{
    static constexpr std::string_view name{ "race_row" };
};

template <>
struct glz::json_schema<xi::data::datasets::stats::wire::HpCurves>
{
    glz::schema graded{ .description = "HP a level up grants, per grade. A row holds until the next level listed." };
    glz::schema racial{ .description = "HP a level up grants a race, since the April 2014 update gave races their own curves." };
};

template <>
struct glz::json_schema<xi::data::datasets::stats::wire::MpCurves>
{
    glz::schema graded{ .description = "MP a level up grants, per grade." };
    glz::schema racial{ .description = "MP a level up grants a race, since the April 2014 update." };
};

template <>
struct glz::json_schema<xi::data::datasets::stats::wire::Tables>
{
    glz::schema round_once{ .description = "Whether the race, job and subjob attribute parts are pooled and rounded down once, or each rounded down on its own." };
    glz::schema hp{ .description = "HP growth, by grade and by race." };
    glz::schema mp{ .description = "MP growth, by grade and by race." };
    glz::schema attributes{ .description = "Twentieths of a point a level up grants an attribute, per grade. A race contributes through the grade it holds, so there is no racial curve. Stops at 75." };
    glz::schema ungraded{ .description = "Whole points every attribute gains on each level up past 75, whatever its grade, granted to the character rather than to each part." };
};

template <>
struct glz::json_schema<xi::data::datasets::stats::wire::Document>
{
    glz::schema stats{ .description = "What a grade is worth per level, for HP, MP and the base attributes." };
};
