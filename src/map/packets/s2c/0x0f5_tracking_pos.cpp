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

#include "0x0f5_tracking_pos.h"

#include "entities/baseentity.h"

GP_SERV_COMMAND_TRACKING_POS::GP_SERV_COMMAND_TRACKING_POS(const CBaseEntity* PEntity)
{
    auto& packet = this->data();

    packet.x = PEntity->loc.p.x;
    packet.y = PEntity->loc.p.y; // TODO: Shouldn't Y and Z be swapped?
    packet.z = PEntity->loc.p.z;

    packet.Level    = 1;
    packet.ActIndex = PEntity->targid;
    packet.State    = PEntity->status == STATUS_TYPE::DISAPPEAR ? GP_TRACKING_POS_STATE::Lose : GP_TRACKING_POS_STATE::Start;
}
