/*
===========================================================================

  Copyright (c) 2018 Darkstar Dev Teams

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

#ifndef _CENTITYSETNAMEPACKET_H
#define _CENTITYSETNAMEPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

class CBaseEntity;

class CEntitySetNamePacket : public CBasicPacket
{
public:
    CEntitySetNamePacket(CBaseEntity* PEntity);
};

#endif // _CENTITYSETNAMEPACKET_H
