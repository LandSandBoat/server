/*
===========================================================================
  Copyright (c) 2021 Ixion Dev Teams
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

#ifndef _CCHAREMOTIONJUMPPACKET_H
#define _CCHAREMOTIONJUMPPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

class CCharEntity;
class CCharEmotionJumpPacket : public CBasicPacket
{
public:
    CCharEmotionJumpPacket(CCharEntity* PChar, uint16 targetIndex, uint16 extra);
};

#endif
