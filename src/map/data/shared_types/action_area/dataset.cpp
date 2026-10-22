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

#include "data/shared_types/action_area/yaml.h"

#include <fmt/format.h>

#include <stdexcept>
#include <utility>

namespace xi::data::shared
{

auto toTargets(const ActionTargets& tokens, const std::string_view field) -> xi::ActionTarget
{
    const auto targets = yaml::resolveFlags(std::optional{ tokens });
    if (targets == xi::ActionTarget::None)
    {
        throw std::runtime_error(fmt::format("{} needs at least one target", field));
    }

    return targets;
}

auto toAoe(const Aoe& source) -> AoeData
{
    AoeData aoe{ .Affects = toTargets(source.affects, "aoe.affects") };

    if (source.sphere.has_value() == source.cone.has_value())
    {
        throw std::runtime_error("aoe needs exactly one of sphere or cone");
    }

    if (source.sphere)
    {
        aoe.Shape = AoeSphereData{ .Origin = yaml::resolveEnum(source.sphere->origin), .Radius = source.sphere->radius };
    }
    else
    {
        aoe.Shape = AoeConeData{ .Origin = yaml::resolveEnum(source.cone->origin), .Distance = source.cone->distance };
    }

    return aoe;
}

} // namespace xi::data::shared
