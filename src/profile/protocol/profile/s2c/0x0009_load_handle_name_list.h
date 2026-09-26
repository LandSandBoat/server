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

namespace profile
{

#pragma pack(push, 1)

// LoadHandleNameList entry
// Used by sqPlayOnlineGetHandleNameInfo()
struct HandleNameInfo
{
    uint8  Num;
    uint8  Order;
    uint8  OpenLevel; // 2 bits
    uint8  padding03;
    uint32 unknown04;
    uint64 Id; // low 44 bits
    char   Name[16];
    uint8  unused20[0x68];
};

#pragma pack(pop)

} // namespace profile
