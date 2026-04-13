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

// Furnishing placement kind.
// How a piece of furniture is placed in the mog house.
// Exactly one per item; these are not flags.
enum class FurnishingPlacement : uint8
{
    Floor   = 0, // Sits on the floor
    Surface = 1, // Sits on the floor and other items can be placed on top (tables, desks)
    Wall    = 2, // Hung on a wall slot
    OnTable = 3, // Placed on top of a Surface item (vases, statues, flowerpots)
};
