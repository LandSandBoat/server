/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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
#include "data/enums/al_zahbi_orders.h"
#include "data/enums/beastman_orders.h"
#include "data/enums/besieged_stronghold.h"

namespace besieged
{

// Holder of the Astral Candescence.
auto GetAstralCandescence() -> xi::BesiegedStronghold;
auto GetAlZahbiOrders() -> xi::AlZahbiOrders;

auto GetMamookOrders() -> xi::BeastmanOrders;
auto GetMamookLevel() -> uint8;
auto GetMamookForces() -> uint8;
auto GetMamookMirrors() -> uint8;
auto GetMamookPrisoners() -> uint8;
auto GetMamookMirrorDestroyed() -> bool;

auto GetHalvungOrders() -> xi::BeastmanOrders;
auto GetHalvungLevel() -> uint8;
auto GetHalvungForces() -> uint8;
auto GetHalvungMirrors() -> uint8;
auto GetHalvungPrisoners() -> uint8;
auto GetHalvungMirrorDestroyed() -> bool;

auto GetArrapagoOrders() -> xi::BeastmanOrders;
auto GetArrapagoLevel() -> uint8;
auto GetArrapagoForces() -> uint8;
auto GetArrapagoMirrors() -> uint8;
auto GetArrapagoPrisoners() -> uint8;
auto GetArrapagoMirrorDestroyed() -> bool;

}; // namespace besieged
