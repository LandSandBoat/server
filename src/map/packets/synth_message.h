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

#ifndef _CSYNTHMESSAGEPACKET_H
#define _CSYNTHMESSAGEPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

enum SYNTH_MESSAGE
{
    SYNTH_SUCCESS         = 0,
    SYNTH_FAIL            = 1,
    SYNTH_INTERRUPT       = 2,
    SYNTH_BADRECIPE       = 3,
    SYNTH_CANCEL          = 4,
    SYNTH_FAILCRYSTAL     = 5,
    SYNTH_NOSKILL         = 6,
    SYNTH_CANCELRARE      = 7,
    SYNTH_SUCCESS_DESYNTH = 12,
    SYNTH_FAIL_CRITICAL   = 14, // 0x0E
};

class CCharEntity;

class CSynthMessagePacket : public CBasicPacket
{
public:
    CSynthMessagePacket(CCharEntity* PChar, SYNTH_MESSAGE messageID, uint16 itemID = 0, uint8 quantity = 0);
};

#endif
