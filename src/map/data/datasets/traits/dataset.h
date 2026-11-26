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
#include "data/enums/content.h"
#include "data/enums/job.h"
#include "data/enums/merit.h"
#include "data/enums/mod.h"
#include "data/enums/trait.h"

#include <string_view>
#include <vector>

namespace xi::data
{

// one modifier of one job's trait rank; a rank with several modifiers has an entry for each
struct TraitData
{
    xi::Trait   Id{};
    xi::Job     Job{};
    uint8       Level{};
    uint8       Rank{};
    xi::Mod     Mod{};
    int16       Value{};
    xi::Merit   Merit{}; // granted only while this merit has upgrades
    xi::Content Content{};
};

using Traits = std::vector<TraitData>; // by job, then trait id, then rank descending

} // namespace xi::data

namespace xi::data::datasets::traits::wire
{

struct Document;

}

namespace xi::data::datasets::traits
{

struct Dataset
{
    using Records      = xi::data::Traits;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "traits" };
    static constexpr std::string_view kTitle{ "Traits" };
    static constexpr std::string_view kDescription{ "Job traits by job and level." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::traits
