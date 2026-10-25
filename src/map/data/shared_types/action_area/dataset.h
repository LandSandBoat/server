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

#include <variant>

namespace xi::data
{

// Who an action can be used on, and the area it reaches from there. Shared by every kind of action.

struct AoeSphereData
{
    xi::SphereOrigin Origin{};
    float            Radius{};
};

struct AoeConeData
{
    xi::ConeOrigin Origin{};
    float          Distance{};
};

struct AoeData
{
    xi::ActionTarget                         Affects{};
    std::variant<AoeSphereData, AoeConeData> Shape{};
};

} // namespace xi::data
