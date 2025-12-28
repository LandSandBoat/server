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
struct conquestregion_t
{
    uint8_t InfluenceRankingWithBeastmen;
    uint8_t InfluenceRankingNoBeastmen;
    uint8_t InfluenceGraphics;
    uint8_t Owner;
};

struct conquestdata_t
{
    uint8_t          Balance;
    uint8_t          Alliance;
    uint8_t          padding06[20];
    conquestregion_t Regions[27];
    uint8_t          CurrentRegionSandoria;
    uint8_t          CurrentRegionBastok;
    uint8_t          CurrentRegionWindurst;
    uint8_t          CurrentRegionSandoriaPct;
    uint8_t          CurrentRegionBastokPct;
    uint8_t          CurrentRegionWindurstPct;
    uint8_t          NextTally;
    uint8_t          padding8D[3];
    uint32_t         ConquestPoints;
    uint8_t          CurrentRegionBeastmen;
    uint8_t          padding95[7];
    uint8_t          Unknown9C;
    uint8_t          padding9D[3];
};

struct besiegedoverview_t
{
    uint32_t AstralCandescence : 2;
    uint32_t AlZahbiOrders : 2;
    uint32_t MamookLevel : 4;
    uint32_t HalvungLevel : 4;
    uint32_t ArrapagoLevel : 4;
    uint32_t MamookOrders : 3;
    uint32_t HalvungOrders : 3;
    uint32_t ArrapagoOrders : 3;
    uint32_t Unknown : 1;
    uint32_t unused : 6;
};

struct besiegedstronghold_t
{
    uint32_t Orders : 3;
    uint32_t Forces : 8;
    uint32_t Level : 4;
    uint32_t MirrorDestroyed : 1;
    uint32_t Mirrors : 4;
    uint32_t Prisoners : 4;
    uint32_t unused : 8;
};

struct besiegeddata_t
{
    besiegedoverview_t   Overview;
    besiegedstronghold_t MamookStronghold;
    besiegedstronghold_t HalvungStronghold;
    besiegedstronghold_t ArrapagoStronghold;
    uint32_t             ImperialStanding;
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x005E
// This packet is sent by the server to update conquest and besieged map information
class GP_SERV_COMMAND_CONQUEST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CONQUEST, GP_SERV_COMMAND_CONQUEST>
{
public:
    struct PacketData
    {
        conquestdata_t Conquest;
        besiegeddata_t Besieged;
    };

    GP_SERV_COMMAND_CONQUEST(CCharEntity* PChar);
};
