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

#include "data/datasets/grades/dataset.h"

#include "common/enum_traits.h"
#include "data/datasets/grades/yaml.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <array>
#include <cstddef>
#include <stdexcept>
#include <string_view>

namespace xi::data::datasets::grades
{

namespace
{

auto toGrades(const wire::Attributes& source) -> AttributeGrades
{
    const auto rank = [](const wire::Rank& token)
    {
        return static_cast<uint8>(yaml::resolveEnum(token));
    };

    return { rank(source.hp), rank(source.mp), rank(source.str), rank(source.dex), rank(source.vit), rank(source.agi), rank(source.intelligence), rank(source.mnd), rank(source.chr) };
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto source = yaml::read<YamlDocument>(text).grades;

    Grades grades{};

    const auto held = yaml::resolveKeys<xi::Job, wire::Attributes>(source.jobs);
    for (auto id = static_cast<uint8>(xi::Job::WAR); id <= static_cast<uint8>(xi::Job::RUN); ++id)
    {
        const auto job   = static_cast<xi::Job>(id);
        const auto name  = EnumTraits<xi::Job>::toName(job);
        const auto entry = held.find(job);
        if (entry == held.end())
        {
            throw std::runtime_error(fmt::format("jobs is missing {}", name));
        }

        grades.Jobs[id] = toGrades(entry->second);
    }

    const auto races = std::array{ &source.races.hume, &source.races.elvaan, &source.races.tarutaru, &source.races.mithra, &source.races.galka };
    for (std::size_t race = 0; race < kGrowthRaces; ++race)
    {
        grades.Races[race] = toGrades(*races[race]);
    }

    return grades;
}

} // namespace xi::data::datasets::grades
