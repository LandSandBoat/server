/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/socket.h"

#include <cstring>

#include "conquest_data.h"
#include "conquest_system.h"
#include "entities/charentity.h"

#include "../utils/charutils.h"

#include "conquest_map.h"

CConquestPacket::CConquestPacket(CCharEntity* PChar)
{
    this->setType(0x5E);
    this->setSize(0xB4);

    auto  conquestData     = conquest::GetConquestData();
    uint8 sandoria_regions = conquestData->getRegionControlCount(NATION_SANDORIA);
    uint8 bastok_regions   = conquestData->getRegionControlCount(NATION_BASTOK);
    uint8 windurst_regions = conquestData->getRegionControlCount(NATION_WINDURST);
    uint8 sandoria_prev    = conquestData->getPrevRegionControlCount(NATION_SANDORIA);
    uint8 bastok_prev      = conquestData->getPrevRegionControlCount(NATION_BASTOK);
    uint8 windurst_prev    = conquestData->getPrevRegionControlCount(NATION_WINDURST);

    for (uint8 regionId = (uint8)REGION_TYPE::RONFAURE; regionId <= (uint8)REGION_TYPE::TAVNAZIA; regionId++)
    {
        uint8 region_owner              = conquestData->getRegionOwner((REGION_TYPE)regionId);
        int32 san_inf                   = conquestData->getInfluence((REGION_TYPE)regionId, NATION_SANDORIA);
        int32 bas_inf                   = conquestData->getInfluence((REGION_TYPE)regionId, NATION_BASTOK);
        int32 win_inf                   = conquestData->getInfluence((REGION_TYPE)regionId, NATION_WINDURST);
        int32 bst_inf                   = conquestData->getInfluence((REGION_TYPE)regionId, NATION_BEASTMEN);
        ref<uint8>(0x1A + regionId * 4) = conquest::GetInfluenceRanking(san_inf, bas_inf, win_inf, bst_inf);
        ref<uint8>(0x1B + regionId * 4) = conquest::GetInfluenceRanking(san_inf, bas_inf, win_inf);
        ref<uint8>(0x1C + regionId * 4) = conquest::GetInfluenceGraphics(san_inf, bas_inf, win_inf, bst_inf);
        ref<uint8>(0x1D + regionId * 4) = region_owner + 1;

        int64 total         = san_inf + bas_inf + win_inf;
        int64 totalBeastmen = total + bst_inf;

        if (PChar->loc.zone->GetRegionID() == static_cast<REGION_TYPE>(regionId))
        {
            ref<uint8>(0x86) = (uint8)((san_inf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            ref<uint8>(0x87) = (uint8)((bas_inf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            ref<uint8>(0x88) = (uint8)((win_inf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            ref<uint8>(0x89) = (uint8)((san_inf * 100) / (total == 0 ? 1 : total));
            ref<uint8>(0x8A) = (uint8)((bas_inf * 100) / (total == 0 ? 1 : total));
            ref<uint8>(0x8B) = (uint8)((win_inf * 100) / (total == 0 ? 1 : total));
            ref<uint8>(0x94) = (uint8)((bst_inf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
        }
    }

    ref<uint8>(0x04) = conquest::GetBalance(sandoria_regions, bastok_regions, windurst_regions, sandoria_prev, bastok_prev, windurst_prev);
    ref<uint8>(0x05) = conquest::GetAlliance(sandoria_regions, bastok_regions, windurst_regions, sandoria_prev, bastok_prev, windurst_prev);

    ref<uint8>(0x8C)  = conquest::GetNexTally();
    ref<uint32>(0x90) = charutils::GetPoints(PChar, charutils::GetConquestPointsName(PChar).c_str());
    ref<uint8>(0x9C)  = 0x01;

    // uint8 packet[] =
    //{
    //    0x80, 0x78, 0x52, 0x03, 0x1a, 0x46, 0x04, 0x00, 0x42, 0x46, 0x04, 0x00, 0x65, 0x3d, 0x04, 0x00
    //};
    // memcpy(data+(0xA0), &packet, 16);

    ref<uint8>(0xA0) = 16; // Situation: mamool ja level -> (1) 16 (2) 32 (3) 48 (4) 64 (5) 80 (6) 96 (7) 112 (8) 128
    ref<uint8>(0xA1) = 17; // Situation: troll mercenaries level -> 1~12 next with another
    ref<uint8>(0xA2) = 0;  // Situation: mamool ja siege status -> (0) training > (1) advancing > (2) attacking > (3) retreat | (4) defense (5) preparing
    ref<uint8>(0xA3) = 4;  // Situation: undead siege status? (3) defense (4) training(5) defense

    ref<uint8>(0xA4) = 0; // mamool ja: (13) preparing (26) attacking (32) training
    ref<uint8>(0xA5) = 0; // mamool ja: enemies forces (1=32)
    ref<uint8>(0xA6) = 0; // mamool ja: archaic mirror (1=2)
    ref<uint8>(0xA7) = 0;

    ref<uint8>(0xA8) = 0; // trolls: enemies forces (66=8)
    ref<uint8>(0xA9) = 0; // trolls: (70) attacking
    ref<uint8>(0xAA) = 0; // trolls: archaic mirror (4=8)
    ref<uint8>(0xAB) = 0;
    ref<uint8>(0xAC) = 0; // undead: enemies forces (101=12)
    ref<uint8>(0xAD) = 0; // undead: (61) preparing
    ref<uint8>(0xAE) = 0; // undead: archaic mirror (4=8)
    ref<uint8>(0xAF) = 0;

    ref<uint32>(0xB0) = charutils::GetPoints(PChar, "imperial_standing");
}
