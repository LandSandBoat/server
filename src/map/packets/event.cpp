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

#include <cstring>

#include "../entities/charentity.h"
#include "event.h"

CEventPacket::CEventPacket(CCharEntity* PChar, EventInfo* eventInfo)
{
    this->type = 0x32;
    this->size = 0x0A;

    uint32 npcID = 0;
    auto*  PNpc  = eventInfo->targetEntity;
    if (PNpc)
    {
        npcID = PNpc->id;
    }
    else
    {
        // Fallback to our own CharID because giving a value
        // of zero makes the game hang.
        npcID = PChar->id;
    }
    ref<uint32>(0x04) = npcID;

    if (eventInfo->params.size() > 0)
    {
        this->type = 0x34;
        this->size = 0x1A;

        for (auto paramPair : eventInfo->params)
        {
            // Only params 0 through 7 are valid
            if (paramPair.first >= 0 && paramPair.first <= 7)
            {
                ref<uint32>(0x0008 + paramPair.first * 4) = paramPair.second;
            }
        }

        ref<uint16>(0x28) = PChar->m_TargID;

        ref<uint16>(0x2A) = PChar->getZone();
        if (eventInfo->textTable != -1)
        {
            ref<uint16>(0x30) = eventInfo->textTable;
        }
        else
        {
            ref<uint16>(0x30) = PChar->getZone();
        }

        ref<uint16>(0x2C) = eventInfo->eventId;
        ref<uint8>(0x2E)  = 8; // если патаметров меньше, чем 8, то после завершения события камера "прыгнет" за спину персонажу
    }
    else
    {
        ref<uint16>(0x08) = PChar->targid;
        ref<uint16>(0x0C) = eventInfo->eventId;

        ref<uint16>(0x0A) = PChar->getZone();
        ref<uint16>(0x10) = PChar->getZone();
    }
}
