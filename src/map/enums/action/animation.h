/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include <cstdint>

enum class ActionAnimation : uint16_t
{
    None           = 0,
    PetSkillStart  = 94,
    SkillStart     = 121,
    Teleport       = 122,
    Raise3         = 496,
    SkillInterrupt = 508,
    Raise          = 511,
    Raise2         = 512,
    RegainHP       = 772,
    RegainMP       = 773,
    Arise          = 847,
    RedTrigger     = 1806,
    YellowTrigger  = 1807,
    BlueTrigger    = 1808,
    WhiteTrigger   = 1946,
};
