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

#include "menu_merit.h"

#include "../entities/charentity.h"
#include "../utils/charutils.h"


CMenuMeritPacket::CMenuMeritPacket(CCharEntity* PChar)
{
	this->type = 0x63;
	this->size = 0x08;

	ref<uint8>(0x04) = 0x02;
	ref<uint8>(0x06) = 0x0C;

    ref<uint16>(0x08) = PChar->PMeritPoints->GetLimitPoints();

    uint16 bits = 0;
    bits += PChar->PMeritPoints->GetMeritPoints() & 0b0000000001111111; // first seven bits are merit points
    if (PChar->GetMJob() == JOB_BLU && PChar->GetMLevel() > 74)
        bits += (PChar->PMeritPoints->GetMeritValue(MERIT_ASSIMILATION, PChar) << 7) & 0b0001111110000000; // next six bits are assimilation points. the last three bits are the three flags below:
    bits += (PChar->jobs.job[PChar->GetMJob()] >= 75 && charutils::hasKeyItem(PChar, 606)) << 13;          // is 75 and has limit breaker KI
    bits += ((PChar->jobs.job[PChar->GetMJob()] >= PChar->jobs.genkai &&
              PChar->jobs.exp[PChar->GetMJob()] == charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1) || PChar->MeritMode) << 14; // my exp is capped
    bits += (bits & (1 << 13) && PChar->MeritMode) << 15; // flag 13 is set and merit mode is on

    ref<uint16>(0x0A) = bits;

    ref<uint8>(0x0C) = map_config.max_merit_points + PChar->PMeritPoints->GetMeritValue(MERIT_MAX_MERIT, PChar);

    PChar->pushPacket(new CBasicPacket(*this));

    // ver 30121205_4 second packet

    this->size = 0x6E;

	memset(data + 4, 0, sizeof(PACKET_SIZE -4));

    uint8 packet[] =
    {
		0x03, 0x00, 0xD8
    };

	memcpy(data+(0x04), &packet, sizeof(packet));
	PChar->pushPacket(new CBasicPacket(*this));

	// ver 30130319_5 third packet

	this->size = 0x44;

	memset(data + 4, 0, sizeof(PACKET_SIZE -4));

	uint8 packet2[] =
	{
		0x04, 0x00, 0x84
	};
	memcpy(data+(0x04), &packet2, sizeof(packet2));
}




//0x63, 0x06, 0x88, 0x41, 0x02, 0x00, 0x08, 0x00, 0xD3, 0x03, 0x03, 0x60
