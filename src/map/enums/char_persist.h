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

#include <magic_enum/magic_enum.hpp>

// What a character still owes the database, drained by MapEngine::persistSweep.
enum class CharPersist : uint8
{
    None     = 0x00,
    Equip    = 0x01, // char_equip
    Position = 0x02,
    Effects  = 0x04,
    Look     = 0x08, // char_look, char_style, chars.isstylelocked
};

using namespace magic_enum::bitwise_operators;
