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
#include "../../common/timer.h"

#include <cstring>

#include "../entities/charentity.h"

#include "../recast_container.h"
#include "char_recast.h"

CCharRecastPacket::CCharRecastPacket(CCharEntity* PChar)
{
    this->type = 0x19;
    this->size = 0x83;

    uint8 count = 0;

    RecastList_t* RecastList = PChar->PRecastContainer->GetRecastList(RECAST_ABILITY);

    for (auto&& recast : *RecastList)
    {
        uint32 recasttime = (recast.RecastTime == 0 ? 0 : ((recast.RecastTime - (uint32)(time(nullptr) - recast.TimeStamp))));

        if (recast.ID == 256) // borrowing this id for mount recast
        {
            ref<uint32>(0xFC) = recasttime;
            ref<uint16>(0xFE) = recast.ID;
        }
        else if (recast.ID != 0)
        {
            ref<uint32>(0x0C + count * 8) = recasttime;
            ref<uint8>(0x0F + count * 8)  = (uint8)recast.ID;
            count++;
        }
        else
        {
            ref<uint32>(0x04) = recasttime; // 2h ability (recast id is 0)
        }
    }
}
