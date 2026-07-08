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

enum class GP_TROPHY_SOLUTION_STATE : uint8_t
{
    Win      = 0x01,
    WinError = 0x02,
    Lost     = 0x03,
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00D3
// This packet is sent by the server when an item in the treasure pool has had an action taken against it. (Lot, Pass, Distribution)
class GP_SERV_COMMAND_TROPHY_SOLUTION final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TROPHY_SOLUTION, GP_SERV_COMMAND_TROPHY_SOLUTION>
{
public:
    struct PacketData
    {
        uint32_t LootUniqueNo;       // PS2: LootUniqueNo
        uint32_t EntryUniqueNo;      // PS2: EntryUniqueNo
        uint16_t LootActIndex;       // PS2: LootActIndex
        int16_t  LootPoint;          // PS2: LootPoint
        uint16_t EntryActIndex : 15; // PS2: EntryActIndex
        uint16_t EntryFlg : 1;       // PS2: EntryFlg
        int16_t  EntryPoint;         // PS2: EntryPoint
        uint8_t  TrophyItemIndex;    // PS2: TrophyItemIndex
        uint8_t  JudgeFlg;           // PS2: JudgeFlg
        uint8_t  sLootName[16];      // PS2: sLootName
        uint8_t  sLootName2[16];     // XiPackets states 24. This is 16 on purpose.
        uint8_t  padding00[6];       // Undocumented padding
    };

    GP_SERV_COMMAND_TROPHY_SOLUTION(uint8_t slotId, GP_TROPHY_SOLUTION_STATE messageType);
    GP_SERV_COMMAND_TROPHY_SOLUTION(const CBaseEntity* PWinner, uint8_t slotId, uint16_t lot, GP_TROPHY_SOLUTION_STATE messageType);
    GP_SERV_COMMAND_TROPHY_SOLUTION(const CBaseEntity* PHighestLotter, uint16_t highestLot, const CBaseEntity* PLotter, uint8_t slotId, uint16_t lot);
};
