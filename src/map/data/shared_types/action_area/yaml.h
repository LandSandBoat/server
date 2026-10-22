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

#include "data/enums/action_target.h"
#include "data/enums/cone_origin.h"
#include "data/enums/sphere_origin.h"
#include "data/shared_types/action_area/dataset.h"
#include "data/yaml/enum_token.h"

#include <glaze/glaze.hpp>

#include <optional>
#include <string_view>
#include <vector>

namespace xi::data::shared
{

using ActionTargets = std::vector<yaml::EnumToken<xi::ActionTarget>>;

struct AoeSphere
{
    yaml::EnumToken<xi::SphereOrigin> origin;
    float                             radius{};
};

struct AoeCone
{
    yaml::EnumToken<xi::ConeOrigin> origin;
    float                           distance{};
};

struct Aoe
{
    ActionTargets            affects;
    std::optional<AoeSphere> sphere;
    std::optional<AoeCone>   cone;
};

auto toTargets(const ActionTargets& tokens, std::string_view field) -> xi::ActionTarget;
auto toAoe(const Aoe& source) -> AoeData;

} // namespace xi::data::shared

template <>
struct glz::json_schema<xi::data::shared::AoeSphere>
{
    glz::schema origin{ .description = "Where the sphere is centred." };
    glz::schema radius{ .description = "Radius in yalms.", .minimum = 0L };
};

template <>
struct glz::json_schema<xi::data::shared::AoeCone>
{
    glz::schema origin{ .description = "Which way the cone opens from the caster." };
    glz::schema distance{ .description = "How far the cone reaches, in yalms.", .minimum = 0L };
};

template <>
struct glz::json_schema<xi::data::shared::Aoe>
{
    glz::schema affects{ .description = "Who the area affects.", .minItems = 1UL, .uniqueItems = true };
    glz::schema sphere{ .description = "Sphere area. Set this or cone, not both." };
    glz::schema cone{ .description = "Cone area. Set this or sphere, not both." };
};
