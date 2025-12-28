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

#include "common/cbasetypes.h"

#include "base.h"

enum class FourCC : uint32_t;
class CBaseEntity;

class GP_SERV_COMMAND_SCHEDULOR final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_SCHEDULOR, GP_SERV_COMMAND_SCHEDULOR>
{
public:
    struct PacketData
    {
        uint32_t UniqueNoCas;  // PS2: UniqueNoCas
        uint32_t UniqueNoTar;  // PS2: UniqueNoTar
        FourCC   id;           // PS2: id (FourCC code tag for scheduler)
        uint16_t ActIndexCast; // PS2: ActIndexCast
        uint16_t ActIndexTar;  // PS2: ActIndexTar
    };

    GP_SERV_COMMAND_SCHEDULOR(const CBaseEntity* PEntity, const CBaseEntity* PTarget, FourCC anim);
    GP_SERV_COMMAND_SCHEDULOR(const CBaseEntity* PEntity, const CBaseEntity* PTarget, const char anim[4]);
};
