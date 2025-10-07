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

#include "common/cbasetypes.h"

// Synthesis Result codes to be used in packets.
enum class SynthesisResult : uint8_t
{
    Success             = 0x00, // Successful synthesis; displays the item information sub-window.
    Failed              = 0x01, // Synthesis failed. You lost the crystal you were using.
    Interrupted         = 0x02, // Synthesis interrupted. You lost the crystal and materials you were using.
    CancelBadRecipe     = 0x03, // Synthesis canceled. That combination of materials cannot be synthesized.
    Cancel              = 0x04, // Synthesis canceled.
    CancelSkillTooLow   = 0x06, // Synthesis canceled. That formula is beyond your current craft skill level.
    CancelRareItem      = 0x07, // Synthesis canceled. You cannot hold more than one item of that type.
    SuccessDesynth      = 0x0C, // Successful synthesis; displays the item information sub-window.
    MustWaitLonger      = 0x0D, // You must wait longer before repeating that action.
    InterruptedCritical = 0x0E, // Synthesis interrupted. You lost the crystal and materials you were using.
};
