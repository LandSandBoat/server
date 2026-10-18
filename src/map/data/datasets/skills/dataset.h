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
#include "data/datasets/stats/dataset.h"
#include "data/enums/skill_rank.h"

#include <array>
#include <cstddef>
#include <string_view>

namespace xi::data
{

inline constexpr std::size_t kSkillRanks = EnumTraits<xi::SkillRank>::kEntries.size();

// Matches MAX_SKILLTYPE.
inline constexpr std::size_t kSkillTypes = 64;

struct Skills
{
    // Cap per level, indexed by rank. Rank none caps at 0.
    std::array<std::array<uint16, kSkillRanks>, kGrowthLevels> Caps{};

    // Rank per skill, indexed by job.
    std::array<std::array<uint8, kGrowthJobs>, kSkillTypes> Ranks{};

    auto size() const -> std::size_t
    {
        return Caps.size() - 1;
    }
};

} // namespace xi::data

namespace xi::data::datasets::skills::wire
{

struct Document;

}

namespace xi::data::datasets::skills
{

struct Dataset
{
    using Records      = xi::data::Skills;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "skills" };
    static constexpr std::string_view kTitle{ "Skills" };
    static constexpr std::string_view kDescription{ "The rank every job holds in each skill, and the cap each rank reaches per level." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::skills
