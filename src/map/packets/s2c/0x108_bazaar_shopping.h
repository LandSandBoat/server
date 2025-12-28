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

enum class GP_SERV_COMMAND_BAZAAR_SHOPPING_STATE : uint32_t
{
    Enter = 0,
    Exit  = 1,
    End   = 2,
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0108
// This packet is sent by the server when another player has entered or left the local clients bazaar.
class GP_SERV_COMMAND_BAZAAR_SHOPPING final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_BAZAAR_SHOPPING, GP_SERV_COMMAND_BAZAAR_SHOPPING>
{
public:
    struct PacketData
    {
        uint32_t                              UniqueNo;  // PS2: UniqueNo
        GP_SERV_COMMAND_BAZAAR_SHOPPING_STATE State;     // PS2: State
        uint8_t                               HideLevel; // PS2: HideLevel
        uint8_t                               padding00; // PS2: padding00
        uint16_t                              ActIndex;  // PS2: ActIndex
        uint8_t                               sName[16]; // PS2: sName
    };

    GP_SERV_COMMAND_BAZAAR_SHOPPING(const CCharEntity* PChar, GP_SERV_COMMAND_BAZAAR_SHOPPING_STATE state);
};
