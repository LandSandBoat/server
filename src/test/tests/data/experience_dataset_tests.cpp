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

#include "map/data/datasets/experience/dataset.h"

#include <catch2/catch_test_macros.hpp>

#include <fstream>
#include <iterator>
#include <string>

namespace
{

using ExperienceDataset = xi::data::datasets::experience::Dataset;

auto slurp(const std::string& path) -> std::string
{
    std::ifstream input(path, std::ios::binary);
    return { std::istreambuf_iterator<char>(input), std::istreambuf_iterator<char>() };
}

} // namespace

TEST_CASE("experience: exp to next level read from data/experience.yaml", "[data][experience]")
{
    const auto experience = ExperienceDataset::decode(slurp("data/experience.yaml"));

    CHECK(experience.NextLevel[0] == 0);
    CHECK(experience.NextLevel[1] == 500);
    CHECK(experience.NextLevel[75] == 44000);
    CHECK(experience.NextLevel[99] == 56000);
}

TEST_CASE("experience: every level from 1 to 99 needs an entry", "[data][experience]")
{
    auto       text = slurp("data/experience.yaml");
    const auto row  = text.find("\n    50: ");
    text.erase(row, text.find('\n', row + 1) - row);

    CHECK_THROWS(ExperienceDataset::decode(text));
}
