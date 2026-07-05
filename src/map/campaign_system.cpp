/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTItem or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "campaign_system.h"
#include "map/utils/zoneutils.h"
#include "packets/s2c/0x071_influence_campaign.h"
#include "utils/charutils.h"

CampaignState CState;

namespace campaign
{

void LoadNations()
{
    const auto rset = db::preparedStmt("SELECT id, reconnaissance, morale, prosperity FROM campaign_nation ORDER BY id ASC");
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            CampaignNation nation;
            nation.reconnaissance = rset->get<uint8>("reconnaissance");
            nation.morale         = rset->get<uint8>("morale");
            nation.prosperity     = rset->get<uint8>("prosperity");
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

    zoneutils::ForEachZone(
        [&state](CZone* PZone)
        {
            if (PZone->campaignHandler() != nullptr)
            {
                auto* handler = PZone->campaignHandler();

                uint8 nation = (uint8)(handler->GetZoneControl() + 1) * 2;
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
                region.campaignId            = handler->GetCampaignId();
                region.status                = handler->GetBattleStatus();
                region.heroism               = handler->GetHeroism();
                region.influenceSandoria     = handler->GetInfluence(CampaignArmy::Sandoria);
                region.influenceBastok       = handler->GetInfluence(CampaignArmy::Bastok);
                region.influenceWindurst     = handler->GetInfluence(CampaignArmy::Windurst);
                region.influenceBeastman     = handler->GetInfluence(CampaignArmy::Orcish);
                region.currentFortifications = handler->GetFortification();
                region.currentResources      = handler->GetResource();
                region.maxFortifications     = handler->GetMaxFortification();
                region.maxResources          = handler->GetMaxResource();
                region.nationControl         = nation;
                state.regions.emplace_back(region);
            }
        });

    std::sort(
        state.regions.begin(),
        state.regions.end(),
        [](const CampaignRegion& a, const CampaignRegion& b) -> bool
        {
            if (a.campaignId < b.campaignId)
            {
                return true;
            }
            if (a.campaignId > b.campaignId)
            {
                return false;
            }
            return false;
        });

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
    const auto current = std::min(std::max((int32)amount, 0), 10);

    const auto rset = db::preparedStmt("UPDATE `campaign_nation` SET `reconnaissance` = ? WHERE `id` = ?", current, (int32)army);
    if (!rset)
    {
        ShowError("Unable to update nation reconnaissance.");
        return;
    }
    CState.nations[army].reconnaissance = current;
}

void SetMorale(CampaignArmy army, int8 amount)
{
    const auto current = std::min(std::max((int32)amount, 0), 100);

    const auto rset = db::preparedStmt("UPDATE `campaign_nation` SET `morale` = ? WHERE `id` = ?", current, (int32)army);
    if (!rset)
    {
        ShowError("Unable to update nation morale.");
        return;
    }
    CState.nations[army].morale = current;
}

void SetProsperity(CampaignArmy army, int8 amount)
{
    const auto current = std::min(std::max((int32)amount, 0), 100);

    const auto rset = db::preparedStmt("UPDATE `campaign_nation` SET `prosperity` = ? WHERE `id` = ?", current, (int32)army);
    if (!rset)
    {
        ShowError("Unable to update nation prosperity.");
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
    PChar->pushPacket<GP_SERV_COMMAND_INFLUENCE::CAMPAIGN>(PChar, CState, 0);
    PChar->pushPacket<GP_SERV_COMMAND_INFLUENCE::CAMPAIGN>(PChar, CState, 1);
}

}; // namespace campaign
