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

#ifndef _CMERITPOINTSCATEGORIESPACKET_H_
#define _CMERITPOINTSCATEGORIESPACKET_H_

#include "common/cbasetypes.h"

#include "merit.h"

#include "basic.h"

class CCharEntity;

class CMeritPointsCategoriesPacket : public CBasicPacket
{
public:
    CMeritPointsCategoriesPacket(CCharEntity* PChar);
    CMeritPointsCategoriesPacket(CCharEntity* PChar, MERIT_TYPE merit);

private:
    // offset should be a uint16!!! Why assert fail?!
    void MeritPointsCategoriesPacket(CCharEntity* PChar, uint8 offset);
};

#endif
