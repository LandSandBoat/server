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

#include "0x05e_conquest.h"

#include "besieged_system.h"
#include "conquest_data.h"
#include "conquest_system.h"
#include "entities/charentity.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_CONQUEST::GP_SERV_COMMAND_CONQUEST(CCharEntity* PChar)
{
    auto& packet = this->data();

    const auto& conquestData = conquest::GetConquestData();

    const uint8 sandoria_regions = conquestData.getRegionControlCount(NATION_SANDORIA);
    const uint8 bastok_regions   = conquestData.getRegionControlCount(NATION_BASTOK);
    const uint8 windurst_regions = conquestData.getRegionControlCount(NATION_WINDURST);
    const uint8 sandoria_prev    = conquestData.getPrevRegionControlCount(NATION_SANDORIA);
    const uint8 bastok_prev      = conquestData.getPrevRegionControlCount(NATION_BASTOK);
    const uint8 windurst_prev    = conquestData.getPrevRegionControlCount(NATION_WINDURST);

    for (auto regionId = static_cast<uint8>(REGION_TYPE::RONFAURE); regionId <= static_cast<uint8>(REGION_TYPE::TAVNAZIA); regionId++)
    {
        const uint8 regionOwner = conquestData.getRegionOwner(static_cast<REGION_TYPE>(regionId));
        const int32 sandoriaInf = conquestData.getInfluence(static_cast<REGION_TYPE>(regionId), NATION_SANDORIA);
        const int32 bastokInf   = conquestData.getInfluence(static_cast<REGION_TYPE>(regionId), NATION_BASTOK);
        const int32 windurstInf = conquestData.getInfluence(static_cast<REGION_TYPE>(regionId), NATION_WINDURST);
        const int32 beastmenInf = conquestData.getInfluence(static_cast<REGION_TYPE>(regionId), NATION_BEASTMEN);

        packet.Conquest.Regions[regionId].InfluenceRankingWithBeastmen = conquest::GetInfluenceRanking(sandoriaInf, bastokInf, windurstInf, beastmenInf);
        packet.Conquest.Regions[regionId].InfluenceRankingNoBeastmen   = conquest::GetInfluenceRanking(sandoriaInf, bastokInf, windurstInf);
        packet.Conquest.Regions[regionId].InfluenceGraphics            = conquest::GetInfluenceGraphics(sandoriaInf, bastokInf, windurstInf, beastmenInf);
        packet.Conquest.Regions[regionId].Owner                        = regionOwner + 1;

        const int64 total         = sandoriaInf + bastokInf + windurstInf;
        const int64 totalBeastmen = total + beastmenInf;

        if (PChar->loc.zone->GetRegionID() == static_cast<REGION_TYPE>(regionId))
        {
            packet.Conquest.CurrentRegionSandoria    = static_cast<uint8>((sandoriaInf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            packet.Conquest.CurrentRegionBastok      = static_cast<uint8>((bastokInf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            packet.Conquest.CurrentRegionWindurst    = static_cast<uint8>((windurstInf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            packet.Conquest.CurrentRegionSandoriaPct = static_cast<uint8>((sandoriaInf * 100) / (total == 0 ? 1 : total));
            packet.Conquest.CurrentRegionBastokPct   = static_cast<uint8>((bastokInf * 100) / (total == 0 ? 1 : total));
            packet.Conquest.CurrentRegionWindurstPct = static_cast<uint8>((windurstInf * 100) / (total == 0 ? 1 : total));
            packet.Conquest.CurrentRegionBeastmen    = static_cast<uint8>((beastmenInf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
        }
    }

    packet.Conquest.Balance        = conquest::GetBalance(sandoria_regions, bastok_regions, windurst_regions, sandoria_prev, bastok_prev, windurst_prev);
    packet.Conquest.Alliance       = conquest::GetAlliance(sandoria_regions, bastok_regions, windurst_regions, sandoria_prev, bastok_prev, windurst_prev);
    packet.Conquest.NextTally      = conquest::GetNextTally();
    packet.Conquest.ConquestPoints = charutils::GetPoints(PChar, charutils::GetConquestPointsName(PChar).c_str());
    packet.Conquest.Unknown9C      = 0x01;

    packet.Besieged.Overview.AstralCandescence = besieged::GetAstralCandescence();
    packet.Besieged.Overview.AlZahbiOrders     = besieged::GetAlZahbiOrders();
    packet.Besieged.Overview.MamookLevel       = besieged::GetMamookLevel();
    packet.Besieged.Overview.HalvungLevel      = besieged::GetHalvungLevel();
    packet.Besieged.Overview.ArrapagoLevel     = besieged::GetArrapagoLevel();
    packet.Besieged.Overview.MamookOrders      = besieged::GetMamookOrders();
    packet.Besieged.Overview.HalvungOrders     = besieged::GetHalvungOrders();
    packet.Besieged.Overview.ArrapagoOrders    = besieged::GetArrapagoOrders();
    packet.Besieged.Overview.Unknown           = 1;

    packet.Besieged.MamookStronghold.Orders          = besieged::GetMamookOrders();
    packet.Besieged.MamookStronghold.Forces          = besieged::GetMamookForces();
    packet.Besieged.MamookStronghold.Level           = besieged::GetMamookLevel();
    packet.Besieged.MamookStronghold.MirrorDestroyed = besieged::GetMamookMirrorDestroyed();
    packet.Besieged.MamookStronghold.Mirrors         = besieged::GetMamookMirrors() / 2;
    packet.Besieged.MamookStronghold.Prisoners       = besieged::GetMamookPrisoners();

    packet.Besieged.HalvungStronghold.Orders          = besieged::GetHalvungOrders();
    packet.Besieged.HalvungStronghold.Forces          = besieged::GetHalvungForces();
    packet.Besieged.HalvungStronghold.Level           = besieged::GetHalvungLevel();
    packet.Besieged.HalvungStronghold.MirrorDestroyed = besieged::GetHalvungMirrorDestroyed();
    packet.Besieged.HalvungStronghold.Mirrors         = besieged::GetHalvungMirrors() / 2;
    packet.Besieged.HalvungStronghold.Prisoners       = besieged::GetHalvungPrisoners();

    packet.Besieged.ArrapagoStronghold.Orders          = besieged::GetArrapagoOrders();
    packet.Besieged.ArrapagoStronghold.Forces          = besieged::GetArrapagoForces();
    packet.Besieged.ArrapagoStronghold.Level           = besieged::GetArrapagoLevel();
    packet.Besieged.ArrapagoStronghold.MirrorDestroyed = besieged::GetArrapagoMirrorDestroyed();
    packet.Besieged.ArrapagoStronghold.Mirrors         = besieged::GetArrapagoMirrors() / 2;
    packet.Besieged.ArrapagoStronghold.Prisoners       = besieged::GetArrapagoPrisoners();

    packet.Besieged.ImperialStanding = charutils::GetPoints(PChar, "imperial_standing");
}
