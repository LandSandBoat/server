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

// PS2: sqPolMessageHeader
// Friend status notice
// Used by __sqProfCopyFriendStat()
struct FriendStatNotice
{
    uint64  SenderPolId;   // the friend, masked
    uint64  ReceiverPolId; // masked; 0 for a friend's status
    uint8   connected;     // 2 connected, 1 polpro available, 0 closed
    uint8   Status;        // status + 1: 1 offline, 2 online, 3 away
    uint8   active;        // bit0 playing, bits 1-3 character slot
    uint8   Purpose;       // low 4 bits
    Content ContentsClass;
    uint16  unused16;
    uint8   handleNumber;
    uint8   hasExtended; // a FriendStatExtended block follows
    uint8   unused1A;
    uint8   legacyBlock;
    uint8   listIndex; // index in the recipient's FriendList
    uint8   unused1D[0x13];
    uint64  __SystemAgeOfData; // the client applies only newer ones
    uint32  Length;            // payload characters + 1
    uint8   SenderHandleNumber;
    uint8   ReceiverHandleNumber;
    uint16  DataType : 7;
    uint16  Type : 5; // MessageType
    uint16  Code : 2;
    uint16  bIsOnline : 1;
    uint16  bValid : 1;
    uint16  ContentsId;
    uint16  bPolproRequest : 1;
    uint16  __bSystemReserved : 15;
    uint32  __SystemReserved;
};

// Friend status notice payload, followed by a sqPolCharacterPrimitive when 0x08 is set
// Used by __sqProfCopyFriendStat()
struct FriendStatExtended
{
    uint8 flags; // 0x01 status fields apply, 0x08 a character slot follows
    uint8 padding01[7];
};

#pragma pack(pop)

} // namespace profile
