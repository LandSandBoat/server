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

enum class SynthesisResult : uint8_t;
class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0070
// This packet is sent by the server to inform other players of a synthesis result.
class GP_SERV_COMMAND_COMBINE_INF final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_COMBINE_INF, GP_SERV_COMMAND_COMBINE_INF>
{
public:
    struct PacketData
    {
        SynthesisResult Result;       // PS2: Result
        int8_t          Grade;        // PS2: Grade
        uint8_t         Count;        // PS2: Count
        uint8_t         padding00;    // PS2: (New; did not exist.)
        uint16_t        ItemNo;       // PS2: ItemNo
        uint16_t        BreakNo[8];   // PS2: BreakNo
        uint16_t        UniqueNo;     // PS2: UniqueNo
        uint16_t        ActIndex;     // PS2: ActIndex
        uint8_t         name[16];     // PS2: Name
        uint8_t         padding01[2]; // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_COMBINE_INF(const CCharEntity* PChar, SynthesisResult result, uint16 itemId = 0, uint8 quantity = 0);
};
