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
#include "data/enums/effect_overwrite.h"
#include "data/enums/element.h"
#include "data/enums/status_effect.h"
#include "data/enums/status_effect_flag.h"

#include <string>
#include <string_view>

namespace xi::data
{

struct StatusEffectData
{
    uint16               Id{};
    std::string          Name{};
    xi::StatusEffectFlag Flags{};
    xi::StatusEffect     ExclusionGroup{};
    xi::StatusEffect     Negative{};
    xi::EffectOverwrite  Overwrite{};
    xi::StatusEffect     Block{};
    xi::StatusEffect     Remove{};
    xi::Element          Element{};
    uint16               MinDuration{};
    uint16               SortKey{};
    uint16               WearOffMessageId{};
};

using StatusEffects = HashMap<uint16, StatusEffectData>;

} // namespace xi::data

namespace xi::data::datasets::status_effects::wire
{

struct Document;

}

namespace xi::data::datasets::status_effects
{

struct Dataset
{
    using Records      = StatusEffects;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "status_effects" };
    static constexpr std::string_view kTitle{ "Status Effects" };
    static constexpr std::string_view kDescription{ "Status effects and their overwrite, block, and removal rules." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::status_effects
