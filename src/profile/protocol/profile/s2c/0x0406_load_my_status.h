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

// LoadMyStatus answer
// Used by sqPlayOnlineLoadMyStatusCheck()
struct MyStatus
{
    uint8   ActiveHandleNameNum;
    uint8   bCharacterActive;
    uint8   ActiveCharacterSlot; // slot in the handle's character table
    uint8   bReceiveOnlineMessage;
    Content ContentsClass;
    uint8   OpenStat; // OpenStatus + 1; 0 = offline
    uint8   FriendAuthMode;
    uint32  LastLoginTime;
    uint32  LastLogoutTime;
    uint8   unused10[0x6C]; // PS2: (New; did not exist.)
    uint32  checksum;
};

#pragma pack(pop)

} // namespace profile
