/*
===========================================================================

Copyright (c) 2010-2018 Darkstar Dev Teams

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

#ifndef _CMESSAGENAMEPACKET_H_
#define _CMESSAGENAMEPACKET_H_

#include "basic.h"

/************************************************************************
 *                                                                       *
 * Message packet that contains a name that the client inserts into      *
 * the message.                                                          *
 * Takes in a chat type (default 4)                                      *
 *                                                                       *
 ************************************************************************/

class CBaseEntity;

class CMessageNamePacket : public CBasicPacket
{
public:
    CMessageNamePacket(CBaseEntity* PActor, uint16 messageID, CBaseEntity* PNameActor = nullptr, int32 param0 = 0, int32 param1 = 0, int32 param2 = 0,
                       int32 param3 = 0, int32 chatType = 4, bool showSender = false);
};

#endif // _CMESSAGENAMEPACKET_H_
