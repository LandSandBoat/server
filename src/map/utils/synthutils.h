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

#ifndef _SYNTHUTILS_H
#define _SYNTHUTILS_H

#include "../../common/cbasetypes.h"

/************************************************************************
*																		*
*  Все методы, необходимые для работы синтеза							*
*																		*
************************************************************************/

class CCharEntity;

namespace synthutils
{
    enum SYNTHESIS_ELEMENT
    {
        ELEMENT_FIRE        = 0,
        ELEMENT_ICE         = 1,
        ELEMENT_WIND        = 2,
        ELEMENT_EARTH       = 3,
        ELEMENT_LIGHTNING   = 4,
        ELEMENT_WATER       = 5,
        ELEMENT_LIGHT       = 6,
        ELEMENT_DARK        = 7
    };

    enum SYNTHESIS_RESULT
    {
        SYNTHESIS_FAIL		= 0,
        SYNTHESIS_SUCCESS	= 1,
        SYNTHESIS_HQ		= 2,
        SYNTHESIS_HQ2		= 3,
        SYNTHESIS_HQ3		= 4
    };

	int32 startSynth(CCharEntity* PChar);
	int32 sendSynthDone(CCharEntity* PChar);
    int32 doSynthFail(CCharEntity* PChar);
};

#endif
