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

#ifndef _CENTITYUPDATEPACKET_H
#define _CENTITYUPDATEPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

enum MODELTYPE
{
    MODEL_STANDARD  = 0,
    MODEL_EQUIPPED  = 1,
    MODEL_DOOR      = 2,
    MODEL_ELEVATOR  = 3,
    MODEL_SHIP      = 4,
    MODEL_UNK_5     = 5,
    MODEL_AUTOMATON = 6,
    MODEL_CHOCOBO   = 7,
};

class CBaseEntity;

class CEntityUpdatePacket : public CBasicPacket
{
public:
    CEntityUpdatePacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask);
    void updateWith(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask);
};

#endif
