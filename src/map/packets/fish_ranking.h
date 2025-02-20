/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#ifndef _CFISHRANKINGPACKET_H
#define _CFISHRANKINGPACKET_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include "basic.h"

struct FishingContestEntry;

class CFishRankingPacket : public CBasicPacket
{
public:
    CFishRankingPacket(const std::vector<FishingContestEntry>& entries, int8 language, int32 timestamp, int32 message_offset, uint32 numEntries, uint8 msg_chunk);
};

#endif
