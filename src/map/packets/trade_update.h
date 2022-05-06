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

#ifndef _CTRADEUPDATEPACKET_H
#define _CTRADEUPDATEPACKET_H

#include "common/cbasetypes.h"
#include <string.h>

#include "basic.h"

class CItem;

class CTradeUpdatePacket : public CBasicPacket
{
public:
    CTradeUpdatePacket(CItem* PItem, uint8 slot);
};

#endif
