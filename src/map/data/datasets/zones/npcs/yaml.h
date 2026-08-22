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
#include "data/enums/status.h"
#include "data/shared_types/look.h"
#include "data/shared_types/render.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <optional>
#include <string>
#include <vector>

namespace xi::data::datasets::zones::npcs::wire
{

struct Npc
{
    std::optional<std::string>                  script;
    std::optional<std::string>                  display_name;
    std::optional<std::vector<float>>           at;
    shared::Render                              render;
    std::optional<uint16>                       look_at;
    std::optional<yaml::EnumToken<xi::Status>>  status;
    std::optional<uint8>                        speed;
    std::optional<uint8>                        animation_speed;
    std::optional<bool>                         widescan;
    std::optional<yaml::EnumToken<xi::Content>> content;
};

struct Document
{
    std::map<uint32, Npc> npcs;

    using YamlRoot = yaml::DatasetRoot<&Document::npcs>;
};

} // namespace xi::data::datasets::zones::npcs::wire

template <>
struct glz::json_schema<xi::data::datasets::zones::npcs::wire::Npc>
{
    glz::schema script{ .description = "Script identity, resolving to scripts/zones/<zone>/npcs/<script>.lua." };
    glz::schema display_name{ .description = "Name sent to the client." };
    glz::schema at{ .description = "Position as x, y, z and optionally a facing of 0-255. Defaults to 0, 0, 0 facing 0." };
    glz::schema render{ .description = "How it is drawn and named." };
    glz::schema look_at{ .description = "ActIndex this NPC faces. Omitted means none." };
    glz::schema status{ .description = "Spawn status. Defaults to disappear." };
    glz::schema speed{ .description = "Movement speed. Defaults to 50.", .minimum = 0L, .maximum = 255L };
    glz::schema animation_speed{ .description = "Animation speed sent to the client. Defaults to 50.", .minimum = 0L, .maximum = 255L };
    glz::schema widescan{ .description = "Whether the NPC appears on widescan. Defaults to false." };
    glz::schema content{ .description = "Content tag gating this NPC. Omitted means always enabled." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::npcs::wire::Document>
{
    glz::schema npcs{ .description = "NPCs keyed by their fully qualified entity id." };
};
