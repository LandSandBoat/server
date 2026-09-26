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

#include "protocol/sq_pol_character_primitive.h"

#include "common/cbasetypes.h"

namespace profile
{

// FriendInfo store op
constexpr uint8 friendOpSet    = 1;
constexpr uint8 friendOpDelete = 2;

#pragma pack(push, 1)

// Friend or block list entry, converted into a sqPolFriend
// Used by sqPlayOnlineGetFriendInfo(), sqPlayOnlineGetBlackInfo(), __sqProfCopyFriendMember()
struct FriendInfo
{
    uint64                  op : 4;           // friendOpSet or friendOpDelete; ignored on load
    uint64                  isBlack : 1;      // BlackList instead of FriendList
    uint64                  kind : 2;         // PS2: Level + 1; 0 marks an invalid entry
    uint64                  handleNumber : 6; // PS2: HandleNamePrimitive.Num
    uint64                  handleId : 44;    // PS2: HandleNamePrimitive.Id
    uint64                  Group : 4;
    uint64                  unknown61 : 1;
    uint64                  bTemporary : 1; // a friend request still pending
    uint64                  unknown63 : 1;
    uint8                   Num; // index in FriendList (0-199) or BlackList (0-99)
    uint8                   Order;
    uint8                   result; // store answer: 0 = applied
    uint8                   padding0B;
    uint32                  padding0C;
    uint64                  PolId;          // polpro POL id (common id XOR _BaseKey)
    char                    handleName[16]; // PS2: HandleNamePrimitive.Name
    sqPolCharacterPrimitive CharacterPrimitive[8];
};

#pragma pack(pop)

} // namespace profile
