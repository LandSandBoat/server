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

class CCharEntity;
class CBattleEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0058
// This packet is sent by the server to respond to a client assist request. (/assist)
class GP_SERV_COMMAND_ASSIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_ASSIST, GP_SERV_COMMAND_ASSIST>
{
public:
    struct PacketData
    {
        uint32_t UniqueNo;
        uint32_t AssistNo;
        uint16_t ActIndex;
        uint16_t padding00;
    };

    GP_SERV_COMMAND_ASSIST(const CCharEntity* PChar, const CBattleEntity* PTarget);
};
