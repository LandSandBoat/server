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

#include "data/datasets/animation_locks/dataset.h"

#include "data/datasets/animation_locks/yaml.h"
#include "data/yaml/read.h"

#include <utility>

namespace xi::data::datasets::animation_locks
{

auto Dataset::decode(const std::string_view text) -> Records
{
    auto source = yaml::read<YamlDocument>(text).animation_locks;

    return AnimationLocks{
        .WeaponSkill = std::move(source.weapon_skill),
        .Dancer      = std::move(source.dancer),
        .RuneFencer  = std::move(source.rune_fencer),
        .Magic       = std::move(source.magic),
        .Ability     = std::move(source.ability),
        .Item        = std::move(source.item),
        .MobSkill    = std::move(source.mob_skill),
        .Pet         = std::move(source.pet),
    };
}

} // namespace xi::data::datasets::animation_locks
