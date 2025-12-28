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
#include "common/mmo.h"

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00B4
// This packet is sent by the server to update the clients configuration settings.
class GP_SERV_COMMAND_CONFIG final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CONFIG, GP_SERV_COMMAND_CONFIG>
{
public:
#pragma pack(push, 1)
    struct PacketData
    {
        SAVE_CONF   ConfData;       // PS2: ConfData
        uint8_t     unknown00;      // PS2: GmLevel
        languages_t PartyLanguages; // PS2: (New; did not exist.)
        uint8_t     unknown01[3];   // PS2: (New; did not exist.)
    };
#pragma pack(pop)

    GP_SERV_COMMAND_CONFIG(const CCharEntity* PChar);
};
