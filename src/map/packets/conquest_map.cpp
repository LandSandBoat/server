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

#include "besieged_system.h"
#include "conquest_data.h"
#include "conquest_system.h"
#include "entities/charentity.h"

#include "utils/charutils.h"

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

    // Overview Map Data [0xA0 - 0xA3]
    packBitsBE(buffer_.data() + 0xA0, besieged::GetAstralCandescence(), 0, 2);
    packBitsBE(buffer_.data() + 0xA0, besieged::GetAlZahbiOrders(), 2, 2);

    packBitsBE(buffer_.data() + 0xA0, besieged::GetMamookLevel(), 4, 4);
    packBitsBE(buffer_.data() + 0xA1, besieged::GetHalvungLevel(), 0, 4);
    packBitsBE(buffer_.data() + 0xA1, besieged::GetArrapagoLevel(), 4, 4);

    packBitsBE(buffer_.data() + 0xA2, besieged::GetMamookOrders(), 0, 3);
    packBitsBE(buffer_.data() + 0xA2, besieged::GetHalvungOrders(), 3, 3);
    packBitsBE(buffer_.data() + 0xA2, besieged::GetArrapagoOrders(), 6, 3);
    packBitsBE(buffer_.data() + 0xA2, 1, 9, 1); // TODO: Unknown constant

    // Mamook Stronghold - Mamool Ja Data
    packBitsBE(buffer_.data() + 0xA4, besieged::GetMamookOrders(), 0, 3);
    packBitsBE(buffer_.data() + 0xA4, besieged::GetMamookForces(), 3, 8);
    packBitsBE(buffer_.data() + 0xA4, besieged::GetMamookLevel(), 11, 4);
    packBitsBE(buffer_.data() + 0xA4, besieged::GetMamookMirrorDestroyed(), 15, 1);
    packBitsBE(buffer_.data() + 0xA6, (besieged::GetMamookMirrors() / 2), 0, 4);
    packBitsBE(buffer_.data() + 0xA6, besieged::GetMamookPrisoners(), 4, 4);
    ref<uint8>(0xA7) = 0x00; // Mamook

    // Halvung Stronghold - Trolls Data
    packBitsBE(buffer_.data() + 0xA8, besieged::GetHalvungOrders(), 0, 3);
    packBitsBE(buffer_.data() + 0xA8, besieged::GetHalvungForces(), 3, 8);
    packBitsBE(buffer_.data() + 0xA8, besieged::GetHalvungLevel(), 11, 4);
    packBitsBE(buffer_.data() + 0xA8, besieged::GetHalvungMirrorDestroyed(), 15, 1);
    packBitsBE(buffer_.data() + 0xAA, (besieged::GetHalvungMirrors() / 2), 0, 4);
    packBitsBE(buffer_.data() + 0xAA, besieged::GetHalvungPrisoners(), 4, 4);
    ref<uint8>(0xAB) = 0x00; // Halvung

    // Arrapago Stronghold - Undead Data
    packBitsBE(buffer_.data() + 0xAC, besieged::GetArrapagoOrders(), 0, 3);
    packBitsBE(buffer_.data() + 0xAC, besieged::GetArrapagoForces(), 3, 8);
    packBitsBE(buffer_.data() + 0xAC, besieged::GetArrapagoLevel(), 11, 4);
    packBitsBE(buffer_.data() + 0xAC, besieged::GetArrapagoMirrorDestroyed(), 15, 1);
    packBitsBE(buffer_.data() + 0xAE, (besieged::GetArrapagoMirrors() / 2), 0, 4);
    packBitsBE(buffer_.data() + 0xAE, besieged::GetArrapagoPrisoners(), 4, 4);
    ref<uint8>(0xAF) = 0x00; // Arrapago

    ref<uint32>(0xB0) = charutils::GetPoints(PChar, "imperial_standing");
}
