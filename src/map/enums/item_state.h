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

enum class ItemState : uint8
{
    Free            = 0,
    Equipped        = 1, // Item is currently equipped
    Bazaar          = 2, // Item is currently being sold in Bazaar
    PlacedFurniture = 3, // Item has been placed in the Mog House
    InTransaction   = 4, // Item is being used as part of a transaction subsystem
};
