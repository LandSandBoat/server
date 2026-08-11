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
#include "common/types/hash_map.h"
#include "data/enums/job.h"
#include "data/enums/merit.h"
#include "data/enums/merit_category.h"
#include "data/enums/skill_type.h"

#include <array>
#include <cstddef>
#include <string>
#include <string_view>
#include <vector>

namespace xi::data
{

// indexed by the merit's current upgrade count
using MeritUpgradeCosts = std::vector<uint8>;

struct MeritData
{
    xi::Merit                  Id{};
    xi::MeritCategory          Category{};
    uint16                     Value{};
    uint8                      MaxUpgrades{}; // 0 leaves the merit visible but unbuyable
    std::vector<xi::Job>       Jobs{};
    std::vector<xi::SkillType> Skills{};
    MeritUpgradeCosts          UpgradeCosts{};
    std::string                Spell{};       // name in spell_list
    std::string                WeaponSkill{}; // name in weapon_skills
};

struct MeritCategoryData
{
    xi::MeritCategory Id{};
    uint8             MaxUpgrades{}; // cap on upgrades across the category
    uint8             Count{};       // merits in this category
    uint16            Offset{};      // index of its first merit in Merits::Entries
};

struct Merits
{
    std::vector<MeritData>         Entries{};    // ordered by merit id
    std::vector<MeritCategoryData> Categories{}; // ordered by category id

    // upgrades that count toward a merit's effect, indexed by character level
    std::array<uint8, 256> LevelCaps{};

    HashMap<xi::SkillType, xi::Merit> MeritBySkill{};

    auto size() const -> std::size_t
    {
        return Entries.size();
    }
};

} // namespace xi::data

namespace xi::data::datasets::merits::wire
{

struct Document;

}

namespace xi::data::datasets::merits
{

struct Dataset
{
    using Records      = xi::data::Merits;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "merits" };
    static constexpr std::string_view kTitle{ "Merits" };
    static constexpr std::string_view kDescription{ "Merit categories, their merits, and the point cost of each upgrade." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::merits
