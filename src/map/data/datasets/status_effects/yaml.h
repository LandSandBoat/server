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
#include "data/enums/effect_overwrite.h"
#include "data/enums/element.h"
#include "data/enums/status_effect.h"
#include "data/enums/status_effect_flag.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <optional>
#include <string>
#include <vector>

namespace xi::data::datasets::status_effects::wire
{

struct StatusEffect
{
    uint16                                                            id{};
    std::optional<std::string>                                        name;
    std::optional<std::vector<yaml::EnumToken<xi::StatusEffectFlag>>> flags;
    std::optional<yaml::EnumToken<xi::StatusEffect>>                  exclusion_group;
    std::optional<yaml::EnumToken<xi::StatusEffect>>                  negative;
    std::optional<yaml::EnumToken<xi::EffectOverwrite>>               overwrite;
    std::optional<yaml::EnumToken<xi::StatusEffect>>                  block;
    std::optional<yaml::EnumToken<xi::StatusEffect>>                  remove;
    std::optional<yaml::EnumToken<xi::Element>>                       element;
    std::optional<uint16>                                             min_duration;
    std::optional<uint16>                                             sort_key;
    std::optional<uint16>                                             wear_off_message_id;
};

struct Document
{
    std::map<std::string, StatusEffect> status_effects;

    using YamlRoot = yaml::DatasetRoot<&Document::status_effects>;
};

} // namespace xi::data::datasets::status_effects::wire

template <>
struct glz::json_schema<xi::data::datasets::status_effects::wire::StatusEffect>
{
    glz::schema id{ .description = "Client-facing status effect ID.", .minimum = 0L, .maximum = 65535L };
    glz::schema name{ .description = "Override for the Lua script lookup name. Defaults to the YAML key." };
    glz::schema flags{ .description = "Behaviour flags. Defaults to an empty list; redefine the entire list when overriding.", .uniqueItems = true };
    glz::schema exclusion_group{ .description = "Applying this effect removes all other effects sharing the same group (the group's representative effect). For example, all spikes share blaze_spikes." };
    glz::schema negative{ .description = "This effect only lands if the named effect is weaker." };
    glz::schema overwrite{ .description = "When this effect may replace another instance of itself." };
    glz::schema block{ .description = "This effect will not land while the named effect is active." };
    glz::schema remove{ .description = "The named effect is always removed when this one lands." };
    glz::schema element{ .description = "Element used for resistance checks." };
    glz::schema min_duration{ .description = "Floor on the effect duration, in seconds.", .defaultValue = 0, .minimum = 0L, .maximum = 65535L };
    glz::schema sort_key{ .description = "Order in which the effect is displayed.", .defaultValue = 0, .minimum = 0L, .maximum = 65535L };
    glz::schema wear_off_message_id{ .description = "Message shown when the effect wears off.", .defaultValue = 0, .minimum = 0L, .maximum = 65535L };
};

template <>
struct glz::json_schema<xi::data::datasets::status_effects::wire::Document>
{
    glz::schema status_effects{ .description = "Status effects keyed by their canonical name." };
};
