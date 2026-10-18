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

#include "data/datasets/skills/dataset.h"

#include "data/datasets/skills/yaml.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <algorithm>
#include <cstddef>
#include <stdexcept>
#include <string_view>

namespace xi::data::datasets::skills
{

static_assert(std::ranges::all_of(EnumTraits<xi::SkillType>::kEntries, [](const auto& entry)
                                  {
                                      return static_cast<std::size_t>(entry.second) < kSkillTypes;
                                  }));

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto source = yaml::read<YamlDocument>(text).skills;

    Skills skills{};

    for (const auto& [skill, jobs] : yaml::resolveKeys<xi::SkillType, wire::JobRanks>(source.ranks))
    {
        for (const auto& [job, rank] : yaml::resolveKeys<xi::Job, wire::Rank>(jobs))
        {
            skills.Ranks[static_cast<std::size_t>(skill)][static_cast<std::size_t>(job)] = static_cast<uint8>(yaml::resolveEnum(rank));
        }
    }

    for (const auto& [level, cap] : source.caps)
    {
        if (level == 0 || level >= kGrowthLevels)
        {
            throw std::runtime_error(fmt::format("caps level {} is outside 1 to {}", level, kGrowthLevels - 1));
        }

        skills.Caps[level] = { 0, cap.a_plus, cap.a, cap.b_plus, cap.b, cap.b_minus, cap.c_plus, cap.c, cap.c_minus, cap.d, cap.e, cap.f, cap.g };
    }

    if (source.caps.size() != kGrowthLevels - 1)
    {
        throw std::runtime_error(fmt::format("caps has to cover every level from 1 to {}", kGrowthLevels - 1));
    }

    return skills;
}

} // namespace xi::data::datasets::skills
