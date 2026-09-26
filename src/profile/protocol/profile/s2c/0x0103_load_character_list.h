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

// LoadCharacterList entry, converted into a sqPolCharacter
// Used by sqPlayOnlineGetCharacterInfo()
struct CharacterInfo
{
    uint8   index;
    uint8   Order;
    uint8   world; // PS2: (New; did not exist.) the character's world
    uint8   padding03;
    uint8   bAttached; // bit0
    uint8   HandleNumber;
    uint8   CharacterIndexOfHandleNameList; // 0-7
    uint8   padding07;
    Content ContentsClass;
    char    code[2]; // PS2: (New; did not exist.) retail sends "00"
    uint32  ContentsUserSubId;
    uint64  ContentsUserId;
    char    Name[16];
    char    Info[64];
};

#pragma pack(pop)

} // namespace profile
