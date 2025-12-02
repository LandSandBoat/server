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

#include "0x065_wpos2.h"

#include "entities/baseentity.h"
#include "entities/charentity.h"

GP_SERV_COMMAND_WPOS2::GP_SERV_COMMAND_WPOS2(CBaseEntity* PEntity, const position_t position, POSMODE mode)
{
    auto& packet = this->data();

    // Doing this here prevents conflicts when the client receives the packet.
    auto* PChar = dynamic_cast<CCharEntity*>(PEntity);
    if (mode == POSMODE::NORMAL ||
        mode == POSMODE::EVENT ||
        mode == POSMODE::POP ||
        mode == POSMODE::RESET ||
        mode == POSMODE::MATERIALIZE)
    {
        PEntity->loc.p.x        = position.x;
        PEntity->loc.p.y        = position.y;
        PEntity->loc.p.z        = position.z;
        PEntity->loc.p.rotation = position.rotation;
        if (PChar && mode == POSMODE::RESET)
        {
            PChar->setLocked(false);
        }
    }
    else if (mode == POSMODE::ROTATE)
    {
        PEntity->loc.p.rotation = position.rotation;
    }
    else if (PChar && (mode == POSMODE::LOCK || mode == POSMODE::UNLOCK))
    {
        PChar->setLocked(mode == POSMODE::LOCK);
    }

    packet.x        = PEntity->loc.p.x;
    packet.y        = PEntity->loc.p.y;
    packet.z        = PEntity->loc.p.z;
    packet.dir      = PEntity->loc.p.rotation;
    packet.UniqueNo = PEntity->id;
    packet.ActIndex = PEntity->targid;
    packet.Mode     = static_cast<uint8_t>(mode);
}
