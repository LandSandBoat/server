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

#include "enums/content.h"

#include "common/cbasetypes.h"

namespace profile
{

#pragma pack(push, 1)

// SearchPolId request
// Used by sqPlayOnlineSearchPolId()
struct SearchPolId
{
    uint64  key;
    uint32  worldAndId; // FFXI: world << 16 | search id
    Content ContentsClass;
    uint8   handleNumber; // the searcher's active handle
    uint8   padding0F;
    uint32  unused10;
    uint32  checksum;
};

#pragma pack(pop)

} // namespace profile
