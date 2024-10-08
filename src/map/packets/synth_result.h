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

#ifndef _CSYNTHRESULTMESSAGEPACKET_H
#define _CSYNTHRESULTMESSAGEPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

class CBaseEntity;

class CSynthResultMessagePacket : public CBasicPacket
{
public:
    CSynthResultMessagePacket(CCharEntity* PChar, SYNTH_MESSAGE messageID, uint16 itemID = 0, uint8 quantity = 0);
};

#endif
