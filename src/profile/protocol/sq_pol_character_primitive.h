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

// PS2: sqPolCharacterPrimitive
// Character identity, also a slot of FriendInfo and friend status notices
struct sqPolCharacterPrimitive
{
    uint16  bValid : 1;
    uint16  __SystemReserved : 15;
    Content ContentsClass;
    uint32  ContentsUserSubId;
    uint64  ContentsUserId; // FFXI: character id
};

#pragma pack(pop)

} // namespace profile
