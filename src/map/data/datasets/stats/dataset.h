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
#include "data/datasets/grades/dataset.h"

#include <algorithm>
#include <array>
#include <cstddef>
#include <string_view>

namespace xi::data
{

// Levels a character can hold, plus level 0 for "no subjob".
inline constexpr std::size_t kGrowthLevels = 100;

// Ranks none through G.
inline constexpr std::size_t kGrowthRanks = 8;

// A curve flattened to the value it has reached at each level. Level 0 is worth nothing, which is what a missing subjob adds.
struct GrowthCurve
{
    std::array<uint16, kGrowthLevels> Total{};

    auto at(const uint8 level) const -> uint16
    {
        return Total[std::min<std::size_t>(level, kGrowthLevels - 1)];
    }
};

using GrowthCurvesByRank = std::array<GrowthCurve, kGrowthRanks>;
using GrowthCurvesByRace = std::array<GrowthCurve, kGrowthRaces>;

struct Stats
{
    GrowthCurvesByRank JobHp{};
    GrowthCurvesByRank JobMp{};
    GrowthCurvesByRace RaceHp{};
    GrowthCurvesByRace RaceMp{};

    // Retail pools the race, job and subjob parts and rounds once; before April 2014 each was rounded on its own
    bool RoundOnce{};

    // Attributes are tracked in half points so the race, job and subjob parts can be pooled before rounding
    std::array<std::array<uint16, kGrowthLevels>, kGrowthRanks> HalfPoints{};

    // Whole points every attribute has gained past level 75
    std::array<uint8, kGrowthLevels> PointsOver75{};

    auto size() const -> std::size_t
    {
        return JobHp.size() + JobMp.size();
    }
};

} // namespace xi::data

namespace xi::data::datasets::stats::wire
{

struct Document;

}

namespace xi::data::datasets::stats
{

struct Dataset
{
    using Records      = xi::data::Stats;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "stats" };
    static constexpr std::string_view kTitle{ "Stats" };
    static constexpr std::string_view kDescription{ "What a grade is worth per level, for HP, MP and the base attributes." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::stats
