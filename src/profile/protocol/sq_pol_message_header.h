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

// PS2: sqPolMessageHeader
// Message header; a stored message's file name is O/m/ followed by its base64
// Used by sqPlayOnlineMessageCreateHeader()
struct sqPolMessageHeader
{
    uint64 SenderPolId;
    uint64 ReceiverPolId;
    char   SenderName[16];
    char   SummaryOfTitle[16];

    union
    {
        struct
        {
            uint32 Seq;
            uint32 Date; // sqGetCalendarTime
        } Info;

        uint64 Code;
    } MessageId;

    uint32 Length;
    uint8  SenderHandleNumber;
    uint8  ReceiverHandleNumber;
    uint16 DataType : 7;
    uint16 Type : 5; // MessageType
    uint16 Code : 2;
    uint16 bIsOnline : 1;
    uint16 bValid : 1;
    uint16 ContentsId;
    uint16 bPolproRequest : 1; // an online notice, not a stored message
    uint16 Language : 7;
    uint16 bNavigatorLock : 1;
    uint16 bDoNotReply : 1;
    uint16 SRStatus : 2;
    uint16 bTitleSummaryOverFlow : 1;
    uint16 bNonUnicastMessage : 1;
    uint16 __bSystemReserved : 2;
    uint32 __SystemReserved;
};

#pragma pack(pop)

} // namespace profile
