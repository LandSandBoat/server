/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "0x02a_talknumwork.h"

#include "common/utils.h"
#include "entities/baseentity.h"

GP_SERV_COMMAND_TALKNUMWORK::GP_SERV_COMMAND_TALKNUMWORK(const CBaseEntity* PEntity, uint16 messageID, const uint32 param0,
                                                         const uint32 param1, const uint32 param2, const uint32 param3,
                                                         const bool ShowName)
{
    auto& packet = this->data();

    packet.UniqueNo = PEntity->id;
    packet.num[0]   = param0;
    packet.num[1]   = param1;
    packet.num[2]   = param2;
    packet.num[3]   = param3;
    packet.ActIndex = PEntity->targid;
    packet.Type     = 0;
    packet.Flag     = 0;

    if (ShowName)
    {
        std::memcpy(packet.String, PEntity->getName().c_str(), std::min<size_t>(PEntity->getName().size(), sizeof(packet.String) - 1));
    }
    else if (PEntity->objtype == TYPE_PC)
    {
        messageID += 0x8000;
    }

    packet.MesNum = messageID;
}
