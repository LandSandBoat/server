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
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

namespace xi::data::datasets::animation_locks::wire
{

struct Document
{
    struct Tables
    {
        HashMap<uint16, uint16> weapon_skill;
        HashMap<uint16, uint16> dancer;
        HashMap<uint16, uint16> rune_fencer;
        HashMap<uint16, uint16> magic;
        HashMap<uint16, uint16> ability;
        HashMap<uint16, uint16> item;
        HashMap<uint16, uint16> mob_skill;
        HashMap<uint16, uint16> pet;
    };

    Tables animation_locks;

    using YamlRoot = yaml::DatasetRoot<&Document::animation_locks>;
};

} // namespace xi::data::datasets::animation_locks::wire

template <>
struct glz::json_schema<xi::data::datasets::animation_locks::wire::Document::Tables>
{
    glz::schema weapon_skill{ .description = "Animation locks for ActionCategory 3." };
    glz::schema dancer{ .description = "Animation locks for ActionCategory 14." };
    glz::schema rune_fencer{ .description = "Animation locks for ActionCategory 15." };
    glz::schema magic{ .description = "Animation locks for ActionCategory 4/8." };
    glz::schema ability{ .description = "Animation locks for ActionCategory 6/10." };
    glz::schema item{ .description = "Animation locks for ActionCategory 5/9." };
    glz::schema mob_skill{ .description = "Animation locks for ActionCategory 7/11." };
    glz::schema pet{ .description = "Animation locks for ActionCategory 13." };
};

template <>
struct glz::json_schema<xi::data::datasets::animation_locks::wire::Document>
{
    glz::schema animation_locks{ .description = "Caster action lock in milliseconds, keyed by animation id." };
};
