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

#include "besieged_system.h"

namespace besieged
{

auto GetAstralCandescence() -> xi::BesiegedStronghold
{
    return xi::BesiegedStronghold::AlZahbi;
}

auto GetAlZahbiOrders() -> xi::AlZahbiOrders
{
    return xi::AlZahbiOrders::Infiltrate;
}

auto GetMamookOrders() -> xi::BeastmanOrders
{
    return xi::BeastmanOrders::Train;
}

auto GetMamookLevel() -> uint8
{
    return 0;
}

auto GetMamookForces() -> uint8
{
    return 95;
}

auto GetMamookMirrors() -> uint8
{
    return 8;
}

auto GetMamookPrisoners() -> uint8
{
    return 0;
}

auto GetHalvungOrders() -> xi::BeastmanOrders
{
    return xi::BeastmanOrders::Train;
}

auto GetHalvungLevel() -> uint8
{
    return 0;
}

auto GetHalvungForces() -> uint8
{
    return 95;
}

auto GetHalvungMirrors() -> uint8
{
    return 8;
}

auto GetHalvungPrisoners() -> uint8
{
    return 0;
}

auto GetArrapagoOrders() -> xi::BeastmanOrders
{
    return xi::BeastmanOrders::Train;
}

auto GetArrapagoLevel() -> uint8
{
    return 0;
}

auto GetArrapagoForces() -> uint8
{
    return 95;
}

auto GetArrapagoMirrors() -> uint8
{
    return 8;
}

auto GetArrapagoPrisoners() -> uint8
{
    return 0;
}

}; // namespace besieged
