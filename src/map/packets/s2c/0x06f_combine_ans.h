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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x006F
// This packet is sent by the server to inform the client of personal synthesis results.
class GP_SERV_COMMAND_COMBINE_ANS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_COMBINE_ANS, GP_SERV_COMMAND_COMBINE_ANS>
{
public:
    struct PacketData
    {
        SynthesisResult Result;        // PS2: Result
        int8_t          Grade;         // PS2: Grade
        uint8_t         Count;         // PS2: Count
        uint8_t         padding00;     // PS2: (New; did not exist.)
        uint16_t        ItemNo;        // PS2: ItemNo
        uint16_t        BreakNo[8];    // PS2: BreakNo
        int8_t          UpKind[4];     // PS2: UpKind
        int8_t          UpLevel[4];    // PS2: UpLevel
        uint16_t        CrystalNo;     // PS2: (New; did not exist.)
        uint16_t        MaterialNo[8]; // PS2: (New; did not exist.)
        uint32_t        padding01;     // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_COMBINE_ANS(const CCharEntity* PChar, SynthesisResult result, uint16 itemId = 0, uint8 quantity = 0);
};
