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

enum class AutomatonFrame : uint8
{
    Harlequin  = 0x20,
    Valoredge  = 0x21,
    Sharpshot  = 0x22,
    Stormwaker = 0x23,
};

enum class AutomatonHead : uint8
{
    Harlequin    = 0x01,
    Valoredge    = 0x02,
    Sharpshot    = 0x03,
    Stormwaker   = 0x04,
    Soulsoother  = 0x05,
    Spiritreaver = 0x06,
};

enum class AutomatonAttachment : uint8
{
    OpticFiber   = 198,
    OpticFiberII = 206,
};
