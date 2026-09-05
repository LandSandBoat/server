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
#include "common/enum_traits.h"
#include "data/enums/job.h"

#include <array>
#include <cstddef>
#include <string_view>

namespace xi::data
{

// The grades one job or race holds:
// hp, mp, str, dex, vit, agi, int, mnd, chr.
using AttributeGrades = std::array<uint8, 9>;

// Growth collapses the gendered CharRace values.
inline constexpr std::size_t kGrowthRaces = 5;

inline constexpr std::size_t kGrowthJobs = EnumTraits<xi::Job>::kEntries.size();

struct Grades
{
    std::array<AttributeGrades, kGrowthJobs>  Jobs{};
    std::array<AttributeGrades, kGrowthRaces> Races{};

    auto size() const -> std::size_t
    {
        return Jobs.size() + Races.size();
    }
};

} // namespace xi::data

namespace xi::data::datasets::grades::wire
{

struct Document;

}

namespace xi::data::datasets::grades
{

struct Dataset
{
    using Records      = xi::data::Grades;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "grades" };
    static constexpr std::string_view kTitle{ "Grades" };
    static constexpr std::string_view kDescription{ "The grade every job and race holds in each attribute." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::grades
