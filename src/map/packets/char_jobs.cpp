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

#include "common/socket.h"

#include <cstring>

#include "../entities/charentity.h"
#include "char_jobs.h"

CCharJobsPacket::CCharJobsPacket(CCharEntity* PChar)
{
    this->setType(0x1B);
    this->setSize(0x84);

    ref<uint8>(0x04) = PChar->look.race;

    ref<uint8>(0x08) = PChar->GetMJob(); // Highlight the main job in Yellow
    ref<uint8>(0x0B) = PChar->GetSJob(); // Highlight the sub job in Blue

    memcpy(data + (0x0C), &PChar->jobs, 22);

    memcpy(data + (0x20), &PChar->stats, 14);
    memcpy(data + (0x44), &PChar->jobs, 27);

    ref<uint32>(0x3C) = PChar->health.maxhp;
    ref<uint32>(0x40) = PChar->health.maxmp;

    ref<uint32>(0x44) = PChar->jobs.unlocked & 1; // первый бит в unlocked отвечает за дополнительную профессию

    ref<uint16>(0x60) = PChar->m_EquipBlock; // Locked equipment slots
    ref<uint16>(0x62) =
        PChar->m_StatsDebilitation; // Bit field. Underestimation of physical characteristics, the characteristic turns red and a red arrlow appears next to it.

    ref<uint8>(0x64) = 0x01; // Unknown, set due to Retail reference; suspicion around mentor unlock
    ref<uint8>(0x65) = 0;    // Mentor Icon
    ref<uint8>(0x66) = 0x01; // Mastery Rank (In Profile Menu)

    ref<uint8>(0x68) = 0; // Is job mastered, and has Master Breaker KI
    ref<uint8>(0x6D) = 0; // Master Level
}
