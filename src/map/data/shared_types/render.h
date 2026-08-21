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
#include "data/enums/animation.h"
#include "data/shared_types/look.h"
#include "data/yaml/enum_token.h"

#include <glaze/glaze.hpp>

#include <optional>

namespace xi::data::shared
{

// How an entity is rendered through packets.
// TODO: Slated for deprecation/rework to expose the actual packet fields meaning.
struct Render
{
    std::optional<Look>                           look;
    std::optional<uint32>                         door_id;
    std::optional<uint16>                         moving;
    std::optional<uint32>                         entity_flags;
    std::optional<yaml::EnumToken<xi::Animation>> animation;
    std::optional<uint8>                          animation_sub;
    std::optional<uint8>                          name_vis;
    std::optional<uint8>                          name_prefix;
    std::optional<uint8>                          model_size;
    std::optional<uint8>                          hitbox;
};

} // namespace xi::data::shared

template <>
struct glz::json_schema<xi::data::shared::Render>
{
    glz::schema look{ .description = "Appearance. On a mob it inherits through the species chain; on an npc, omitted means an empty look." };
    glz::schema door_id{ .description = "Identity the client reads for a door, elevator or ship. Elevators and ships send it with a timestamp appended. Nothing reads it on a mob." };
    glz::schema moving{ .description = "Movement flag word sent alongside the position. Defaults to 0." };
    glz::schema entity_flags{ .description = "Entity behaviour bitmask sent to the client. Defaults to 0 on a mob and 3 on an npc.", .minimum = 0L, .maximum = 4294967295L };
    glz::schema animation{ .description = "Idle animation. Defaults to none." };
    glz::schema animation_sub{ .description = "Sub-animation selector. Defaults to 0.", .minimum = 0L, .maximum = 255L };
    glz::schema name_vis{ .description = "Name display bitmask. Defaults to 0.", .minimum = 0L, .maximum = 255L };
    glz::schema name_prefix{ .description = "Byte 0x27 of the entity update: gender, plus the article the client shows before the name. Defaults to 0.", .minimum = 0L, .maximum = 255L };
    glz::schema model_size{ .description = "Graphic size the client draws the entity at, 0 to 3. Defaults to 0.", .minimum = 0L, .maximum = 3L };
    glz::schema hitbox{ .description = "Hitbox radius in tenths of a yalm. Defaults to 0.", .minimum = 0L, .maximum = 255L };
};
