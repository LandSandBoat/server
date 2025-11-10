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

#include "0x036_talknum.h"

#include "entities/baseentity.h"

GP_SERV_COMMAND_TALKNUM::GP_SERV_COMMAND_TALKNUM(CBaseEntity* PEntity, const uint16 messageID, const bool showName, const uint8 mode)
{
    auto& packet = this->data();

    packet.UniqueNo = PEntity->id;
    packet.ActIndex = PEntity->targid;
    packet.MesNum   = (PEntity->objtype == TYPE_PC || !showName) ? (messageID + 0x8000) : messageID;
    packet.Type     = mode;
}
