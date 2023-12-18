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

#include <tuple>

#include "campaign_system.h"
#include "map.h"
#include "map/utils/zoneutils.h"
#include "packets/campaign_map.h"
#include "utils/charutils.h"

CampaignState CState;

namespace campaign
{
    void LoadNations()
    {
        std::string query = "SELECT id, reconnaissance, morale, prosperity FROM campaign_nation ORDER BY id ASC;";
        int         ret   = _sql->Query(query.c_str());
        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                CampaignNation nation;
                nation.reconnaissance = (uint8)_sql->GetUIntData(1);
                nation.morale         = (uint8)_sql->GetUIntData(2);
                nation.prosperity     = (uint8)_sql->GetUIntData(3);
                CState.nations.emplace_back(nation);
            }
        }
    }

    void LoadState()
    {
        CampaignState state;

        if (CState.regions.empty() == false)
        {
            CState.regions.clear();
            CState.controlSandoria = 0;
            CState.controlBastok   = 0;
            CState.controlBeastman = 0;
            CState.controlWindurst = 0;
            state                  = CState;
        }

        // clang-format off
        zoneutils::ForEachZone([&state](CZone* PZone)
        {
            if (PZone->m_CampaignHandler != nullptr)
            {
                uint8 nation = (uint8)(PZone->m_CampaignHandler->GetZoneControl() + 1) * 2;
                switch (nation)
                {
                    case CampaignControl::SandoriaMask:
                        state.controlSandoria += 1;
                        break;
                    case CampaignControl::BastokMask:
                        state.controlBastok += 1;
                        break;
                    case CampaignControl::WindurstMask:
                        state.controlWindurst += 1;
                        break;
                    case CampaignControl::BeastmanMask:
                    default:
                        state.controlBeastman += 1;
                        break;
                }

                CampaignRegion region;
                region.campaignId            = PZone->m_CampaignHandler->GetCampaignId();
                region.status                = PZone->m_CampaignHandler->GetBattleStatus();
                region.heroism               = PZone->m_CampaignHandler->GetHeroism();
                region.influenceSandoria     = PZone->m_CampaignHandler->GetInfluence(CampaignArmy::Sandoria);
                region.influenceBastok       = PZone->m_CampaignHandler->GetInfluence(CampaignArmy::Bastok);
                region.influenceWindurst     = PZone->m_CampaignHandler->GetInfluence(CampaignArmy::Windurst);
                region.influenceBeastman     = PZone->m_CampaignHandler->GetInfluence(CampaignArmy::Orcish);
                region.currentFortifications = PZone->m_CampaignHandler->GetFortification();
                region.currentResources      = PZone->m_CampaignHandler->GetResource();
                region.maxFortifications     = PZone->m_CampaignHandler->GetMaxFortification();
                region.maxResources          = PZone->m_CampaignHandler->GetMaxResource();
                region.nationControl         = nation;
                state.regions.emplace_back(region);
            }
        });

        std::sort(state.regions.begin(), state.regions.end(), [](const CampaignRegion& a, const CampaignRegion& b) -> bool
        {
            if (a.campaignId < b.campaignId)
                return true;
            if (a.campaignId > b.campaignId)
                return false;
            return false;
        });
        // clang-format on

        CState = state;
    }

    CampaignState GetCampaignState()
    {
        LoadState();
        return CState;
    }

    uint8 GetReconnaissance(CampaignArmy army)
    {
        return CState.nations[army].reconnaissance;
    }

    uint8 GetMorale(CampaignArmy army)
    {
        return CState.nations[army].morale;
    }

    uint8 GetProsperity(CampaignArmy army)
    {
        return CState.nations[army].prosperity;
    }

    int32 GetAlliedNotes(CCharEntity* chr)
    {
        return charutils::GetPoints(chr, "allied_notes");
    }

    void SetReconnaissance(CampaignArmy army, int8 amount)
    {
        auto current = std::min(std::max((int32)amount, 0), 10);

        std::string query = "UPDATE `campaign_nation` SET `reconnaissance` = %d WHERE `id` = %d;";
        int         ret   = _sql->Query(query.c_str(), current, (int32)army);
        if (ret == SQL_ERROR)
        {
            ShowError("Unable to update nation reconnaissance.\n");
            return;
        }
        CState.nations[army].reconnaissance = current;
    }

    void SetMorale(CampaignArmy army, int8 amount)
    {
        auto current = std::min(std::max((int32)amount, 0), 100);

        std::string query = "UPDATE `campaign_nation` SET `morale` = %d WHERE `id` = %d;";
        int         ret   = _sql->Query(query.c_str(), current, (int32)army);
        if (ret == SQL_ERROR)
        {
            ShowError("Unable to update nation morale.\n");
            return;
        }
        CState.nations[army].morale = current;
    }

    void SetProsperity(CampaignArmy army, int8 amount)
    {
        auto current = std::min(std::max((int32)amount, 0), 100);

        std::string query = "UPDATE `campaign_nation` SET `prosperity` = %d WHERE `id` = %d;";
        int         ret   = _sql->Query(query.c_str(), current, (int32)army);
        if (ret == SQL_ERROR)
        {
            ShowError("Unable to update nation prosperity.\n");
            return;
        }
        CState.nations[army].prosperity = current;
    }

    void SetAlliedNotes(CCharEntity* chr, int32 amount)
    {
        charutils::SetPoints(chr, "allied_notes", amount);
    }

    void SendUpdate(CCharEntity* PChar)
    {
        PChar->pushPacket(new CCampaignPacket(PChar, CState, 0));
        PChar->pushPacket(new CCampaignPacket(PChar, CState, 1));
    }
}; // namespace campaign
