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

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0044
// This packet is sent by the server to populate the clients extended job information.
namespace GP_SERV_COMMAND_EXTENDED_JOB
{

class BLU final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EXTENDED_JOB, BLU>
{
public:
    struct PacketData
    {
        uint8_t Job;      // PS2: Job
        uint8_t IsSubJob; // PS2: IsSubJob
        uint8_t padding[2];
        uint8_t SetSpells[20];
        uint8_t unknown01[132];
    };

    BLU(const CCharEntity* PChar, bool mjob);
};

} // namespace GP_SERV_COMMAND_EXTENDED_JOB
