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
#include "data/enums/animation.h"
#include "data/enums/behavior.h"
#include "data/enums/detects.h"
#include "data/enums/ecosystem.h"
#include "data/enums/element.h"
#include "data/enums/family.h"
#include "data/enums/immunity.h"
#include "data/enums/job.h"
#include "data/enums/mob_mod.h"
#include "data/enums/mod.h"
#include "data/enums/skill_type.h"
#include "data/enums/spawn_type.h"
#include "data/enums/species.h"
#include "data/enums/stat_rank.h"
#include "data/shared_types/mob_attributes/dataset.h"

#include <array>
#include <optional>
#include <string_view>
#include <utility>

namespace xi::data
{

struct SpeciesData
{
    xi::Species            Id{};
    MobAttributesOverrides MobAttributes{};
};

struct FamilyData
{
    xi::Family                                      Id{};
    MobAttributesOverrides                          MobAttributes{};
    HashMap<decltype(SpeciesData::Id), SpeciesData> Species{};
};

struct EcosystemData
{
    xi::Ecosystem                                 Id{};
    MobAttributesOverrides                        MobAttributes{};
    HashMap<decltype(FamilyData::Id), FamilyData> Families{};
};

using Ecosystems = HashMap<xi::Ecosystem, EcosystemData>;

} // namespace xi::data

namespace xi::data::shared
{

struct MobAttributes;

} // namespace xi::data::shared

namespace xi::data::datasets::ecosystems::wire
{

struct Document;

} // namespace xi::data::datasets::ecosystems::wire

namespace xi::data::datasets::ecosystems
{

struct Dataset
{
    using Records      = Ecosystems;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "ecosystems" };
    static constexpr std::string_view kTitle{ "Ecosystems" };
    static constexpr std::string_view kDescription{ "The ecosystem, family, and species tree with inherited mob attributes at every level." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::ecosystems
