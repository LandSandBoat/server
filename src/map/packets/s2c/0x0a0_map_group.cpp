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

#include "0x0a0_map_group.h"

#include "common/logging.h"
#include "entities/charentity.h"

GP_SERV_COMMAND_MAP_GROUP::GP_SERV_COMMAND_MAP_GROUP(const CCharEntity* PChar)
{
    if (PChar == nullptr)
    {
        ShowError("GP_SERV_COMMAND_MAP_GROUP::GP_SERV_COMMAND_MAP_GROUP() - PChar was null.");
        return;
    }

    auto& packet = this->data();

    packet.UniqueID = PChar->id;
    packet.zone     = PChar->getZone();
    packet.x        = PChar->loc.p.x;
    packet.y        = PChar->loc.p.y;
    packet.z        = PChar->loc.p.z;
}
