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

#include "0x0d3_trophy_solution.h"

#include "common/utils.h"
#include "entities/baseentity.h"

#include <cstring>

GP_SERV_COMMAND_TROPHY_SOLUTION::GP_SERV_COMMAND_TROPHY_SOLUTION(const uint8_t slotId, GP_TROPHY_SOLUTION_STATE messageType)
{
    auto& packet = this->data();

    packet.TrophyItemIndex = slotId;
    packet.JudgeFlg        = static_cast<uint8_t>(messageType);
}

GP_SERV_COMMAND_TROPHY_SOLUTION::GP_SERV_COMMAND_TROPHY_SOLUTION(const CBaseEntity* PWinner, const uint8_t slotId, const uint16_t lot, GP_TROPHY_SOLUTION_STATE messageType)
{
    auto& packet = this->data();

    packet.LootUniqueNo    = PWinner->id;
    packet.LootActIndex    = PWinner->targid;
    packet.LootPoint       = lot;
    packet.TrophyItemIndex = slotId;
    packet.JudgeFlg        = static_cast<uint8_t>(messageType);

    std::memcpy(packet.sLootName, PWinner->getName().c_str(), std::min(PWinner->getName().size(), sizeof(packet.sLootName)));
}

GP_SERV_COMMAND_TROPHY_SOLUTION::GP_SERV_COMMAND_TROPHY_SOLUTION(const CBaseEntity* PHighestLotter, const uint16_t highestLot, const CBaseEntity* PLotter, const uint8_t slotId, const uint16_t lot)
{
    auto& packet = this->data();

    if (PHighestLotter)
    {
        packet.LootUniqueNo = PHighestLotter->id;
        packet.LootActIndex = PHighestLotter->targid;
        packet.LootPoint    = highestLot;
        std::memcpy(packet.sLootName, PHighestLotter->getName().c_str(), std::min(PHighestLotter->getName().size(), sizeof(packet.sLootName)));
    }

    packet.EntryUniqueNo   = PLotter->id;
    packet.EntryActIndex   = PLotter->targid;
    packet.TrophyItemIndex = slotId;

    // Use packBitsBE to handle lot number - this fixes an offset problem with lot numbers
    packBitsBE(reinterpret_cast<uint8_t*>(&packet), lot, 144, 16);

    std::memcpy(packet.sLootName2, PLotter->getName().c_str(), std::min(PLotter->getName().size(), sizeof(packet.sLootName2)));
}
