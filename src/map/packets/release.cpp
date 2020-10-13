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

#include "../../common/socket.h"

#include "release.h"
#include "../entities/charentity.h"


CReleasePacket::CReleasePacket(CCharEntity * PChar, RELEASE_TYPE releaseType)
{
	this->type = 0x52;
	this->size = 0x04;

	ref<uint8>(0x04) = releaseType;

	if (releaseType == RELEASE_SKIPPING)
	{
		ref<uint16>(0x05) = PChar->m_event.EventID;
	}

    PChar->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
}

// типы release
// 0 - разговор с npc без старта события
// 2 - событие (с указание id события)
// 4 - рыбалка
