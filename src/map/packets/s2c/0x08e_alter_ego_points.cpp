/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "0x08e_alter_ego_points.h"

#include "utils/charutils.h"

GP_SERV_PACKET_ALTER_EGO_POINTS::GP_SERV_PACKET_ALTER_EGO_POINTS(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.Points = charutils::GetPoints(PChar, "alter_ego_points");
    // TODO: Populate actual upgrade levels per category - see AlterEgoCategory
    for (auto& upgrade : packet.Upgrades)
    {
        upgrade = 0;
    }

    // TODO: Populate actual upgrade costs per category - see AlterEgoCategory
    for (auto& cost : packet.Costs)
    {
        cost = 0;
    }
}
