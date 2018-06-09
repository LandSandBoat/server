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

This file is part of DarkStar-server source code.

===========================================================================
*/

#include <tuple>

#include "map.h"
#include "campaign_system.h"

CampaignState campaign::LoadState(uint32 charId)
{
    CampaignState state;
    std::string query = "SELECT id, isbattle, nation, heroism, influence_sandoria, influence_bastok, influence_windurst, influence_beastman, current_fortifications, current_resources, max_fortifications, max_resources FROM campaign_map ORDER BY id ASC;";
    int ret = Sql_Query(SqlHandle, query.c_str());
    if (ret == SQL_ERROR || Sql_NumRows(SqlHandle) == 0)
    {
        return state;
    }

    while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        uint8 nation = (uint8)Sql_GetUIntData(SqlHandle, 2);
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
        region.status = (uint8)Sql_GetUIntData(SqlHandle, 1) | nation;
        region.heroism = (uint8)Sql_GetUIntData(SqlHandle, 3);
        region.influenceSandoria = (uint8)Sql_GetUIntData(SqlHandle, 4);
        region.influenceBastok = (uint8)Sql_GetUIntData(SqlHandle, 5);
        region.influenceWindurst = (uint8)Sql_GetUIntData(SqlHandle, 6);
        region.influenceBeastman = (uint8)Sql_GetUIntData(SqlHandle, 7);
        region.currentFortifications = (uint16)Sql_GetUIntData(SqlHandle, 8);
        region.currentResources = (uint16)Sql_GetUIntData(SqlHandle, 9);
        region.maxFortifications = (uint16)Sql_GetUIntData(SqlHandle, 10);
        region.maxResources = (uint16)Sql_GetUIntData(SqlHandle, 11);
        state.regions.push_back(region);
    }

    query = "SELECT id, reconnaissance, morale, prosperity FROM campaign_nation ORDER BY id ASC;";
    ret = Sql_Query(SqlHandle, query.c_str());
    if (ret == SQL_ERROR || Sql_NumRows(SqlHandle) == 0)
    {
        return state;
    }

    while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        CampaignNation nation;
        nation.reconnaissance = (uint8)Sql_GetUIntData(SqlHandle, 1);
        nation.morale = (uint8)Sql_GetUIntData(SqlHandle, 2);
        nation.prosperity= (uint8)Sql_GetUIntData(SqlHandle, 3);
        state.nations.push_back(nation);
    }

    query = "SELECT allied_notes FROM char_points WHERE charid = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), charId);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        return state;
    }

    state.alliedNotes = (uint32)Sql_GetUIntData(SqlHandle, 0);
    return state;
}

void campaign::Tally()
{
    // TODO: How does a tally work
}

void campaign::Reset()
{
    std::string query = "UPDATE `campaign_map` SET `heroism` = 0;";
    int ret = Sql_Query(SqlHandle, query.c_str());
    if (ret == SQL_ERROR)
    {
        ShowWarning("Unable to reset campaign heroism.");
    }

    // TODO: Figure out reset values for other campaign statistics
}

bool campaign::HasBattle(CampaignZone zone)
{
    std::string query = "SELECT `isbattle` FROM `campaign_map` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), zone);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to get campaign battle status.\n");
        return false;
    }
    return Sql_GetIntData(SqlHandle, 0);
}

void campaign::SetBattle(CampaignZone zone, bool status)
{
    std::string query = "UPDATE `campaign_map` SET `isbattle` = %d WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), status, zone);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to set campaign battle status.\n");
    }
}

CampaignControl campaign::GetRegionControl(CampaignZone zone)
{
    std::string query = "SELECT `nation` FROM `campaign_map` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), zone);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to get campaign control status.\n");
        return CampaignControl::BeastmanMask;
    }
    return (CampaignControl)Sql_GetIntData(SqlHandle, 0);
}

void campaign::SetRegionControl(CampaignZone zone, uint8 nation)
{
    std::string query = "UPDATE `campaign_map` SET `nation` = %d WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), nation, zone);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to set campaign region control.\n");
    }
}

void campaign::ModifyFortification(CampaignZone zone, int16 amount)
{
    std::string query = "SELECT `current_fortifications`, `max_fortifications` FROM `campaign_map` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), zone);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to query campaign fortifications.\n");
        return;
    }

    auto current = Sql_GetIntData(SqlHandle, 0);
    auto max = Sql_GetIntData(SqlHandle, 1);
    current = std::min(std::max(current + amount, 0), max);

    query = "UPDATE `campaign_map` SET `current_fortifications` = %d WHERE `id` = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), current, zone);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update campaign fortifications.\n");
        return;
    }
}

void campaign::ModifyResource(CampaignZone zone, int16 amount)
{
    std::string query = "SELECT `current_resources`, `max_resources` FROM `campaign_map` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), zone);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to query campaign resources.\n");
        return;
    }

    auto current = Sql_GetIntData(SqlHandle, 0);
    auto max = Sql_GetIntData(SqlHandle, 1);
    current = std::min(std::max(current + amount, 0), max);

    query = "UPDATE `campaign_map` SET `current_resources` = %d WHERE `id` = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), current, zone);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update campaign resources.\n");
        return;
    }
}

void campaign::ModifyMaxFortification(CampaignZone zone, int16 amount)
{
    std::string query = "SELECT `current_fortifications`, `max_fortifications` FROM `campaign_map` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), zone);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to query campaign fortifications.\n");
        return;
    }

    auto max = Sql_GetIntData(SqlHandle, 1);
    max = std::min(std::max(max + amount, 0), 1000);

    auto current = Sql_GetIntData(SqlHandle, 0);
    current = std::min(current, max);

    query = "UPDATE `campaign_map` SET `current_fortifications` = %d, `max_fortifications` = %d WHERE `id` = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), current, max, zone);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update max campaign fortifications.\n");
        return;
    }
}

void campaign::ModifyMaxResource(CampaignZone zone, int16 amount)
{
    std::string query = "SELECT `current_resources`, `max_resources` FROM `campaign_map` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), zone);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to query campaign resources.\n");
        return;
    }

    auto max = Sql_GetIntData(SqlHandle, 1);
    max = std::min(std::max(max + amount, 0), 1000);

    auto current = Sql_GetIntData(SqlHandle, 0);
    current = std::min(current, max);

    query = "UPDATE `campaign_map` SET `current_resources` = %d, `max_resources` = %d WHERE `id` = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), current, max, zone);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update max campaign resources.\n");
        return;
    }
}

void campaign::ModifyInfluence(CampaignArmy army, CampaignZone zone, int16 amount)
{
    amount = std::min(std::max(amount, (int16)-250), (int16)250);

    std::string type = "unknown";
    switch (army)
    {
    case CampaignArmy::Sandoria:
        type = "sandoria";
        break;
    case CampaignArmy::Bastok:
        type = "bastok";
        break;
    case CampaignArmy::Windurst:
        type = "windurst";
        break;
    case CampaignArmy::Orcish:
    case CampaignArmy::Quadav:
    case CampaignArmy::Yagudo:
    case CampaignArmy::Kindred:
        type = "beastman";
        break;
    }

    std::string query = "SELECT influence_%s FROM `campaign_map` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), type, zone);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to query influence.\n");
        return;
    }

    auto current = (int16)Sql_GetIntData(SqlHandle, 0);
    current = std::min(std::max(current + amount, 0), 250);
    query = "UPDATE `campaign_map` SET influence_%s = %d WHERE `id` = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), type, current, zone);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update influence.\n");
        return;
    }
}

void campaign::ModifyReconnaissance(CampaignArmy army, int8 amount)
{
    std::string query = "SELECT `reconnaissance` FROM `campaign_nation` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), army);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to query nation reconnaissance.\n");
        return;
    }

    auto current = Sql_GetIntData(SqlHandle, 0);
    current = std::min(std::max(current + amount, 0), 10);

    query = "UPDATE `campaign_nation` SET `reconnaissance` = %d WHERE `id` = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), current, army);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update nation reconnaissance.\n");
        return;
    }
}

void campaign::ModifyMorale(CampaignArmy army, int8 amount)
{
    std::string query = "SELECT `morale` FROM `campaign_nation` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), army);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to query nation morale.\n");
        return;
    }

    auto current = Sql_GetIntData(SqlHandle, 0);
    current = std::min(std::max(current + amount, 0), 100);

    query = "UPDATE `campaign_nation` SET `morale` = %d WHERE `id` = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), current, army);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update nation morale.\n");
        return;
    }
}

void campaign::ModifyProsperity(CampaignArmy army, int8 amount)
{
    std::string query = "SELECT `prosperity` FROM `campaign_nation` WHERE `id` = %d;";
    int ret = Sql_Query(SqlHandle, query.c_str(), army);
    if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        ShowError("Unable to query nation prosperity.\n");
        return;
    }

    auto current = Sql_GetIntData(SqlHandle, 0);
    current = std::min(std::max(current + amount, 0), 100);

    query = "UPDATE `campaign_nation` SET `prosperity` = %d WHERE `id` = %d;";
    ret = Sql_Query(SqlHandle, query.c_str(), current, army);
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update nation prosperity.\n");
        return;
    }
}
