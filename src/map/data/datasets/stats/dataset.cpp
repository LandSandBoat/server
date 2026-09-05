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

#include "data/datasets/stats/dataset.h"

#include "data/datasets/stats/yaml.h"
#include "data/enums/stat_rank.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <array>
#include <cstddef>
#include <iterator>
#include <stdexcept>
#include <string_view>

namespace xi::data::datasets::stats
{

namespace
{

// Attribute growth stops here, past which the ungraded gain takes over.
constexpr uint8 kAttributeLastLevel = 75;

constexpr uint8 kMaxLevel = kGrowthLevels - 1;

// A row's columns, in the order the growth arrays are indexed.
auto columnsOf(const wire::GradeRow& row) -> std::array<uint16, 7>
{
    return { row.a, row.b, row.c, row.d, row.e, row.f, row.g };
}

auto columnsOf(const wire::MpGradeRow& row) -> std::array<uint16, 5>
{
    return { row.a, row.b, row.c, row.d, row.f };
}

auto columnsOf(const wire::RaceRow& row) -> std::array<uint16, kGrowthRaces>
{
    return { row.hume, row.elvaan, row.tarutaru, row.mithra, row.galka };
}

// A table with a single unnamed column, like the ungraded gain.
auto columnsOf(const uint16 row) -> std::array<uint16, 1>
{
    return { row };
}

// Read a level-major table down its columns, accumulating what each has granted by every level.
// A row holds until the next level listed, and the last runs to lastLevel.
template <class Row>
auto buildCurves(const wire::Curve<Row>& table, const uint8 firstLevel, const uint8 lastLevel, const std::string_view name)
{
    constexpr auto kCount = std::tuple_size_v<decltype(columnsOf(std::declval<Row>()))>;

    if (table.empty() || table.begin()->first != firstLevel)
    {
        throw std::runtime_error(fmt::format("{} has to open at level {}", name, firstLevel));
    }

    if (table.rbegin()->first > lastLevel)
    {
        throw std::runtime_error(fmt::format("{} keys level {}, past the {} it covers", name, table.rbegin()->first, lastLevel));
    }

    std::array<GrowthCurve, kCount> curves{};
    std::array<uint32, kCount>      running{};

    for (auto row = table.begin(); row != table.end(); ++row)
    {
        const auto next    = std::next(row);
        const auto until   = next == table.end() ? lastLevel : static_cast<uint8>(next->first - 1);
        const auto granted = columnsOf(row->second);

        for (auto level = row->first; level <= until; ++level)
        {
            for (std::size_t column = 0; column < kCount; ++column)
            {
                running[column] += granted[column];

                curves[column].Total[level] = static_cast<uint16>(running[column]);
            }
        }
    }

    // Past the levels a table covers a curve holds what it reached, so a capped attribute reads straight off
    for (std::size_t level = lastLevel + 1u; level < kGrowthLevels; ++level)
    {
        for (std::size_t column = 0; column < kCount; ++column)
        {
            curves[column].Total[level] = curves[column].Total[lastLevel];
        }
    }

    return curves;
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto source = yaml::read<YamlDocument>(text).stats;

    Stats stats{};

    stats.RoundOnce = source.round_once;

    // Rank none holds no curve, so the grade columns land from index 1 on
    const auto hpByGrade = buildCurves(source.hp.graded, 1, kMaxLevel, "hp graded");
    for (std::size_t column = 0; column < hpByGrade.size(); ++column)
    {
        stats.JobHp[column + 1] = hpByGrade[column];
    }

    // No job holds an E or G MP grade, so the MP table has no column for them
    constexpr std::array kMpRanks{ xi::StatRank::A, xi::StatRank::B, xi::StatRank::C, xi::StatRank::D, xi::StatRank::F };

    const auto mpByGrade = buildCurves(source.mp.graded, 1, kMaxLevel, "mp graded");
    for (std::size_t column = 0; column < mpByGrade.size(); ++column)
    {
        stats.JobMp[static_cast<std::size_t>(kMpRanks[column])] = mpByGrade[column];
    }

    stats.RaceHp = buildCurves(source.hp.racial, 1, kMaxLevel, "hp racial");
    stats.RaceMp = buildCurves(source.mp.racial, 1, kMaxLevel, "mp racial");

    // Attributes are counted in twentieths and floored to half points, so the parts pool before rounding
    const auto byGrade = buildCurves(source.attributes, 1, kAttributeLastLevel, "attributes");
    for (std::size_t column = 0; column < byGrade.size(); ++column)
    {
        for (std::size_t level = 0; level < kGrowthLevels; ++level)
        {
            stats.HalfPoints[column + 1][level] = byGrade[column].Total[level] / 10;
        }
    }

    const auto ungraded = buildCurves(source.ungraded, kAttributeLastLevel + 1, kMaxLevel, "ungraded")[0];
    for (std::size_t level = 0; level < kGrowthLevels; ++level)
    {
        stats.PointsOver75[level] = static_cast<uint8>(ungraded.Total[level]);
    }

    return stats;
}

} // namespace xi::data::datasets::stats
