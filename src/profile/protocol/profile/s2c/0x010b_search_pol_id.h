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

// SearchPolId answer
// Used by sqPlayOnlineSearchPolIdCheck2()
struct SearchPolIdAns
{
    uint64 polId;    // polpro POL id
    uint32 handleId; // PS2: (New; did not exist.)
    uint32 unused0C;
    char   handleName[16];
    uint8  found; // 0 = not found
    uint8  handleNumber;
    uint8  unused22[10];
    uint32 checksum;
};

#pragma pack(pop)

} // namespace profile
