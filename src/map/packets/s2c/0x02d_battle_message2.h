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

enum MESSAGE_COMBAT : uint16
{
    USE_OBTAIN_ESCHA_SILT = 765, // <name> uses <item>. <name> obtains <n> escha silt.
    USE_OBTAIN_ESCHA_BEAD = 766, // <name> uses <item>. <name> obtains <n> escha beads.
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x002D
// This packet is sent by the server to display combat related messages to the client.
// This packet is generally used for end-of-combat related messages such as chains, experience/limit points gains, merit points/job points gains, etc.
class GP_SERV_COMMAND_BATTLE_MESSAGE2 final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_BATTLE_MESSAGE2, GP_SERV_COMMAND_BATTLE_MESSAGE2>
{
public:
    struct PacketData
    {
        uint32_t UniqueNoCas; // PS2: UniqueNoCas
        uint32_t UniqueNoTar; // PS2: UniqueNoTar
        uint16_t ActIndexCas; // PS2: ActIndexCas
        uint16_t ActIndexTar; // PS2: ActIndexTar
        uint32_t Data;        // PS2: Data
        uint32_t Data2;       // PS2: Data2
        uint16_t MessageNum;  // PS2: MessageNum
        uint8_t  Type;        // PS2: Type
        uint8_t  padding1B;   // PS2: dummy
    };

    GP_SERV_COMMAND_BATTLE_MESSAGE2(CBaseEntity* PSender, CBaseEntity* PTarget, int32 param0, int32 param1, uint16 messageID);
};
