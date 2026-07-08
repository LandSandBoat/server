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

// Used in GP_SERV_COMMAND_ITEM_* packets LockFlg
// TODO: This needs to be checked and compared with client.
enum class ItemLockFlg : uint8_t
{
    Normal    = 0x00,
    NoDrop    = 0x05,
    NoSelect  = 0x0F,
    Linkshell = 0x13,
    Unknown0  = 0x19,
    Mannequin = 0x1B,
};
