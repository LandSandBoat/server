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

#ifndef _CEVENTUPDATEPACKET_H
#define _CEVENTUPDATEPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

/************************************************************************
 *																		*
 *  																		*
 *																		*
 ************************************************************************/

class CEventUpdatePacket : public CBasicPacket
{
public:
    CEventUpdatePacket(uint32 param0 = 0, uint32 param1 = 0, uint32 param2 = 0, uint32 param3 = 0, uint32 param4 = 0, uint32 param5 = 0, uint32 param6 = 0,
                       uint32 param7 = 0);
};

#endif
