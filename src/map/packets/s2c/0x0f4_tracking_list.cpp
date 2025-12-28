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

#include "0x0f4_tracking_list.h"

#include "entities/charentity.h"

GP_SERV_COMMAND_TRACKING_LIST::GP_SERV_COMMAND_TRACKING_LIST(const CCharEntity* PChar, CBaseEntity* PEntity)
{
    auto& packet = this->data();

    packet.ActIndex = PEntity->targid;
    if (PEntity->objtype == TYPE_MOB)
    {
        packet.Level = static_cast<CBattleEntity*>(PEntity)->GetMLevel();
    }

    // 0 - Black dot (Char??)
    // 1 - Green dot (NPC)
    // 2 - Red dot (Mob)
    packet.Type = PEntity->objtype / 2;

    packet.x = static_cast<int16_t>(PEntity->loc.p.x - PChar->loc.p.x); // Difference in x-value between character and object coordinates
    // TODO: Shouldn't this be Y?
    packet.z = static_cast<int16_t>(PEntity->loc.p.z - PChar->loc.p.z); // Difference in z-value between character and object coordinates

    // TODO: sName
    // std::memcpy(packet.sName, PEntity->GetName(), (PEntity->name.size() > 14 ? 14 : PEntity->name.size()));
}
