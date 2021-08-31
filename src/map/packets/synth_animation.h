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

#ifndef _CSYNTHANIMATIONPACKET_H
#define _CSYNTHANIMATIONPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

#define RESULT_SUCCESS 0x00
#define RESULT_FAIL    0x01
#define RESULT_HQ      0x02
#define RESULT_HQ2     0x03
#define RESULT_HQ3     0x04

#define EFFECT_WATERSYNTH     0x0010
#define EFFECT_WINDSYNTH      0x0011
#define EFFECT_FIRESYNTH      0x0012
#define EFFECT_EARTHSYNTH     0x0013
#define EFFECT_LIGHTNINGSYNTH 0x0014
#define EFFECT_ICESYNTH       0x0015
#define EFFECT_LIGHTSYNTH     0x0016
#define EFFECT_DARKSYNTH      0x0017

/************************************************************************
 *																		*
 *  																		*
 *																		*
 ************************************************************************/

class CCharEntity;

class CSynthAnimationPacket : public CBasicPacket
{
public:
    CSynthAnimationPacket(CCharEntity* PChar, uint16 effect, uint8 param);
};

#endif
