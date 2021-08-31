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

#include "../../common/socket.h"

#include <cstring>

#include "../conquest_system.h"
#include "../entities/charentity.h"

#include "../utils/charutils.h"

#include "conquest_map.h"

CConquestPacket::CConquestPacket(CCharEntity* PChar)
{
    this->type = 0x5E;
    this->size = 0x5A;

    const char* Query = "SELECT region_id, region_control, region_control_prev, \
                         sandoria_influence, bastok_influence, windurst_influence, \
                         beastmen_influence FROM conquest_system;";

    int32 ret = Sql_Query(SqlHandle, Query);

    uint8 sandoria_regions = 0;
    uint8 bastok_regions   = 0;
    uint8 windurst_regions = 0;
    uint8 sandoria_prev    = 0;
    uint8 bastok_prev      = 0;
    uint8 windurst_prev    = 0;

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            int regionid            = Sql_GetIntData(SqlHandle, 0);
            int region_control      = Sql_GetIntData(SqlHandle, 1);
            int region_control_prev = Sql_GetIntData(SqlHandle, 2);

            if (region_control == 0)
            {
                sandoria_regions++;
            }
            else if (region_control == 1)
            {
                bastok_regions++;
            }
            else if (region_control == 2)
            {
                windurst_regions++;
            }

            if (region_control_prev == 0)
            {
                sandoria_prev++;
            }
            else if (region_control_prev == 1)
            {
                bastok_prev++;
            }
            else if (region_control_prev == 2)
            {
                windurst_prev++;
            }

            int32 san_inf                   = Sql_GetIntData(SqlHandle, 3);
            int32 bas_inf                   = Sql_GetIntData(SqlHandle, 4);
            int32 win_inf                   = Sql_GetIntData(SqlHandle, 5);
            int32 bst_inf                   = Sql_GetIntData(SqlHandle, 6);
            ref<uint8>(0x1A + regionid * 4) = conquest::GetInfluenceRanking(san_inf, bas_inf, win_inf, bst_inf);
            ref<uint8>(0x1B + regionid * 4) = conquest::GetInfluenceRanking(san_inf, bas_inf, win_inf);
            ref<uint8>(0x1C + regionid * 4) = conquest::GetInfluenceGraphics(san_inf, bas_inf, win_inf, bst_inf);
            ref<uint8>(0x1D + regionid * 4) = region_control + 1;

            int64 total         = san_inf + bas_inf + win_inf;
            int64 totalBeastmen = total + bst_inf;

            if (PChar->loc.zone->GetRegionID() == static_cast<REGION_TYPE>(regionid))
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

    ref<uint8>(0xA0) = 16; // Situation: mamool ja niveau -> (1) 16 (2) 32 (3) 48 (4) 64 (5) 80 (6) 96 (7) 112 (8) 128
    ref<uint8>(0xA1) = 17; // Situation: mercenaire trolls niveau -> 1~12 la suite avec un autre
    ref<uint8>(0xA2) = 0; // Situation: mamool ja status du siege -> (0) entrainement > (1) en marche > (2) attaque > (3) retraite | (4) defense (5) preparation
    ref<uint8>(0xA3) = 4; // Situation: undead status du siege ? (3) defense (4) entrainement (5) defense

    ref<uint8>(0xA4) = 0; // mamool ja: (13) preparation (26) attaque (32) entrainement
    ref<uint8>(0xA5) = 0; // mamool ja: forces ennemies (1=32)
    ref<uint8>(0xA6) = 0; // mamool ja: miroir archaique (1=2)
    ref<uint8>(0xA7) = 0;

    ref<uint8>(0xA8) = 0; // trolls: forces ennemies (66=8)
    ref<uint8>(0xA9) = 0; // trolls: (70) attaque
    ref<uint8>(0xAA) = 0; // trolls: miroir archaique (4=8)
    ref<uint8>(0xAB) = 0;
    ref<uint8>(0xAC) = 0; // undead: forces ennemies (101=12)
    ref<uint8>(0xAD) = 0; // undead: (61) preparation
    ref<uint8>(0xAE) = 0; // undead: miroir archaique (4=8)
    ref<uint8>(0xAF) = 0;

    ref<uint32>(0xB0) = charutils::GetPoints(PChar, "imperial_standing");
}
