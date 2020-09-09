/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#ifndef _CMESSAGECOMBATPACKET_H
#define _CMESSAGECOMBATPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

/************************************************************************
*																		*
*  																		*
*																		*
************************************************************************/

class CBaseEntity;

class CMessageCombatPacket : public CBasicPacket
{
public:

    CMessageCombatPacket(CBaseEntity* PSender, CBaseEntity* PTarget, int32 param0, int32 param1, uint16 messageID);
};

#endif
