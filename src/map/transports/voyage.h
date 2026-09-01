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

class CZone;

// One leg's passenger window in the zone it crosses, telling the handler when to put its riders ashore.
struct Voyage
{
    CZone* zone{};          // zone where the crossing is occuring
    uint32 offset{};        // seconds the cycle is shifted by, so legs sharing a ship take their turn
    uint32 every{};         // cycle length in seconds
    uint32 disembarkFrom{}; // seconds into the cycle when riders are put ashore
    uint32 boardingEnds{};  // seconds into the cycle when the ship stops taking passengers
};
