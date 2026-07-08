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

enum class SynthesisEffect : int16_t;
class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0030
// This packet is sent by the server to inform the client to of an entity status change.
// This handler is specifically used for setting an entities crafting animation.
class GP_SERV_COMMAND_EFFECT final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EFFECT, GP_SERV_COMMAND_EFFECT>
{
public:
    struct PacketData
    {
        uint32_t        UniqueNo;  // PS2: UniqueNo
        uint16_t        ActIndex;  // PS2: ActIndex
        SynthesisEffect EffectNum; // PS2: effectnum
        int8_t          Type;      // PS2: type
        int8_t          Status;    // PS2: status
        uint16_t        Timer;     // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_EFFECT(const CCharEntity* PChar, SynthesisEffect effect, uint8 param);
};
