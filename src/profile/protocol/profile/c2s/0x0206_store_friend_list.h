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

// StoreFriendList request, followed by FriendInfo entries
// Used by __sqPlayOnlineStoreFriendListCheck()
struct StoreFriendListHead
{
    uint8  friendOrder[200]; // FriendList display order
    uint8  blackOrder[100];  // BlackList display order
    uint16 count;            // FriendInfo entries that follow
    uint16 unused12E;
};

#pragma pack(pop)

} // namespace profile
