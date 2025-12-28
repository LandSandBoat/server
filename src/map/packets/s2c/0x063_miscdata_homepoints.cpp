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

#include "0x063_miscdata_homepoints.h"

#include "entities/charentity.h"

GP_SERV_COMMAND_MISCDATA::HOMEPOINTS::HOMEPOINTS(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::Homepoints;
    packet.unknown06 = sizeof(PacketData);

    // Copy teleport masks directly
    std::memcpy(packet.homePoint, PChar->teleport.homepoint.access, sizeof(packet.homePoint));
    std::memcpy(packet.survivalGuide, PChar->teleport.survival.access, sizeof(packet.survivalGuide));
    std::memcpy(packet.waypoint, PChar->teleport.waypoints.access, sizeof(packet.waypoint));

    // Everything below is untested/unimplemented
    // packet.atmos        = PChar->teleport.pastMaw;
    // packet.eschanPortal = PChar->teleport.eschanPortal;
    // packet.telepoint = PChar->teleport.telepoint;
    // packet.unknown00 = PChar->teleport.unknown00;
}
