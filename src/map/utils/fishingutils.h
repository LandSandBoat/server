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

#ifndef _FISHINGUTILS_H
#define _FISHINGUTILS_H

#include "../../common/cbasetypes.h"

enum FISHACTION
{
    FISHACTION_CHECK   = 2, // This is always the first 0x110 packet. //
    FISHACTION_FINISH  = 3, // This is the next 0x110 after 0x115. //
    FISHACTION_END     = 4,
    FISHACTION_WARNING = 5 // This is the 0x110 packet if the time is going on too long. //
};

/************************************************************************
 *																		*
 *  Все методы, необходимые для реализации рыбалки						*
 *																		*
 ************************************************************************/

class CCharEntity;

namespace fishingutils
{
    void LoadFishingMessages();

    void StartFishing(CCharEntity* PChar);
    void FishingAction(CCharEntity* PChar, FISHACTION action, uint16 stamina, uint32 special);
}; // namespace fishingutils

#endif
