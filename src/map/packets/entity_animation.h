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

#ifndef _CENTITYANIMATIONPACKET_H
#define _CENTITYANIMATIONPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

/************************************************************************
 *																		*
 *  	Animates an entity in some fashion.  The parameter is a 4 byte      *
 *   ASCII word that the client will parse (and change to a proper anim) *
 *																		*
 ************************************************************************/

class CBaseEntity;

class CEntityAnimationPacket : public CBasicPacket
{
public:
    static const char* Fade_Out;
    CEntityAnimationPacket(CBaseEntity* PEntity, const char type[4]);
};

#endif
