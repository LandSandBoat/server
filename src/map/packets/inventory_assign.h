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

#ifndef _CINVENTORYASSIGHPACKET_H
#define _CINVENTORYASSIGHPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

#define INV_NORMAL    0x00
#define INV_NODROP    0x05
#define INV_NOSELECT  0x0F
#define INV_LINKSHELL 0x13
#define INV_MANNEQUIN 0x1B // Equipped to the mannequin

class CItem;

class CInventoryAssignPacket : public CBasicPacket
{
public:
    CInventoryAssignPacket(CItem* PItem, uint8 Flag);
};

#endif
