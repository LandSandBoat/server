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

#pragma once

#include "base.h"

class CBaseEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0039
// This packet is sent by the server to inform the client of a map scheduler animation/event that should play.
// This is used to play additional environment/map animations.
class GP_SERV_COMMAND_MAPSCHEDULOR final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MAPSCHEDULOR, GP_SERV_COMMAND_MAPSCHEDULOR>
{
public:
    struct PacketData
    {
        uint32_t UniqueNoCas;  // PS2: UniqueNoCas
        uint32_t UniqueNoTar;  // PS2: UniqueNoTar
        uint32_t id;           // PS2: id (visual/animation id)
        uint16_t ActIndexCast; // PS2: ActIndexCast
        uint16_t ActIndexTar;  // PS2: ActIndexTar
    };

    GP_SERV_COMMAND_MAPSCHEDULOR(const CBaseEntity* PEntity, const char type[4]);
};
