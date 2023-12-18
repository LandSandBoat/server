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

#include "campaign_handler.h"
#include "map.h"

CCampaignHandler::CCampaignHandler(CZone* PZone)
{
    m_PZone = nullptr;
    LoadCampaignZone(PZone);
}

void CCampaignHandler::LoadCampaignZone(CZone* PZone)
{
    static const char* query = "SELECT id, zoneid, isbattle, nation, heroism, influence_sandoria, influence_bastok, influence_windurst, influence_beastman, "
                               "current_fortifications, current_resources, max_fortifications, max_resources FROM campaign_map WHERE zoneid = %u";

    if (_sql->Query(query, PZone->GetID()) != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        m_zoneCampaignId        = (uint8)_sql->GetUIntData(0);
        m_zoneId                = (uint8)_sql->GetUIntData(1);
        m_status                = (uint8)_sql->GetUIntData(2);
        m_controllingNation     = (uint8)_sql->GetUIntData(3);
        m_heroism               = (uint8)_sql->GetUIntData(4);
        m_influenceSandoria     = (uint8)_sql->GetUIntData(5);
        m_influenceBastok       = (uint8)_sql->GetUIntData(6);
        m_influenceWindurst     = (uint8)_sql->GetUIntData(7);
        m_influenceBeastman     = (uint8)_sql->GetUIntData(8);
        m_currentFortifications = (uint16)_sql->GetUIntData(9);
        m_currentResources      = (uint16)_sql->GetUIntData(10);
        m_maxFortifications     = (uint16)_sql->GetUIntData(11);
        m_maxResources          = (uint16)_sql->GetUIntData(12);
        m_PZone                 = PZone;
    }
}

uint8 CCampaignHandler::GetCampaignId()
{
    return m_zoneCampaignId;
}

uint8 CCampaignHandler::GetBattleStatus()
{
    return m_status;
}

uint8 CCampaignHandler::GetZoneControl()
{
    return m_controllingNation;
}

uint16 CCampaignHandler::GetFortification()
{
    return m_currentFortifications;
}

uint16 CCampaignHandler::GetResource()
{
    return m_currentResources;
}

uint16 CCampaignHandler::GetMaxFortification()
{
    return m_maxFortifications;
}

uint16 CCampaignHandler::GetMaxResource()
{
    return m_maxResources;
}

uint8 CCampaignHandler::GetHeroism()
{
    return m_heroism;
}

uint8 CCampaignHandler::GetUnionCount(CampaignUnion CUnion)
{
    switch (CUnion)
    {
        case CampaignUnion::Adder:
            return m_adderUnion;
        case CampaignUnion::Bison:
            return m_bisonUnion;
        case CampaignUnion::Coyote:
            return m_coyoteUnion;
        case CampaignUnion::Dhole:
            return m_dholeUnion;
        case CampaignUnion::Eland:
            return m_elandUnion;
        default:
            return 0;
    }
}

uint8 CCampaignHandler::GetInfluence(CampaignArmy army)
{
    switch (army)
    {
        case CampaignArmy::Sandoria:
            return m_influenceSandoria;
        case CampaignArmy::Bastok:
            return m_influenceBastok;
        case CampaignArmy::Windurst:
            return m_influenceWindurst;
        case CampaignArmy::Orcish:
        case CampaignArmy::Quadav:
        case CampaignArmy::Yagudo:
        case CampaignArmy::Kindred:
            return m_influenceBeastman;
        default:
            return 0;
    }
}

void CCampaignHandler::SetBattleStatus(uint8 status)
{
    auto current = std::min(std::max((int32)status, 0), 1);

    std::string query = "UPDATE `campaign_map` SET `isbattle` = %d WHERE `zoneid` = %d;";
    int         ret   = _sql->Query(query.c_str(), current, m_PZone->GetID());
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to set campaign battle status.\n");
        return;
    }
    m_status = current;
}

void CCampaignHandler::SetZoneControl(uint8 nation)
{
    uint8       nationid = nation;
    std::string query    = "UPDATE `campaign_map` SET `nation` = %d WHERE `zoneid` = %d;";
    int         ret      = _sql->Query(query.c_str(), nationid, m_PZone->GetID());
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to set campaign zone control.\n");
        return;
    }
    m_controllingNation = nationid;
}

void CCampaignHandler::SetHeroism(int16 amount)
{
    auto current = std::min(std::max((int32)amount, 0), 200);

    std::string query = "UPDATE `campaign_map` SET `heroism` = %d WHERE `zoneid` = %d;";
    int         ret   = _sql->Query(query.c_str(), current, m_PZone->GetID());
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to set campaign region control.\n");
        return;
    }
    m_heroism = current;
}

void CCampaignHandler::SetFortification(int16 amount)
{
    auto current = std::min(std::max((int32)amount, 0), (int32)m_maxFortifications);

    std::string query = "UPDATE `campaign_map` SET `current_fortifications` = %d WHERE `zoneid` = %d;";
    int         ret   = _sql->Query(query.c_str(), current, m_PZone->GetID());
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update campaign fortifications.\n");
        return;
    }
    m_currentFortifications = current;
}

void CCampaignHandler::SetResource(int16 amount)
{
    auto current = std::min(std::max((int32)amount, 0), (int32)m_maxResources);

    std::string query = "UPDATE `campaign_map` SET `current_resources` = %d WHERE `zoneid` = %d;";
    int         ret   = _sql->Query(query.c_str(), current, m_PZone->GetID());
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update campaign resources.\n");
        return;
    }
    m_currentResources = current;
}

void CCampaignHandler::SetMaxFortification(int16 amount)
{
    auto max = std::min(std::max((int32)amount, 0), 1023);

    std::string query = "UPDATE `campaign_map` SET `max_fortifications` = %d WHERE `zoneid` = %d;";
    int         ret   = _sql->Query(query.c_str(), max, m_PZone->GetID());
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update max campaign fortifications.\n");
        return;
    }
    m_maxFortifications = max;
}

void CCampaignHandler::SetMaxResource(int16 amount)
{
    auto max = std::min(std::max((int32)amount, 0), 1023);

    std::string query = "UPDATE `campaign_map` SET `max_resources` = %d WHERE `zoneid` = %d;";
    int         ret   = _sql->Query(query.c_str(), max, m_PZone->GetID());
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update max campaign resources.\n");
        return;
    }
    m_maxResources = max;
}

void CCampaignHandler::SetInfluence(CampaignArmy army, int16 amount)
{
    auto current = std::min(std::max((int32)amount, 0), 250);

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

    std::string query = "UPDATE `campaign_map` SET influence_%s = %d WHERE `zoneid` = %d;";
    int         ret   = _sql->Query(query.c_str(), type, current, m_PZone->GetID());
    if (ret == SQL_ERROR)
    {
        ShowError("Unable to update influence.\n");
        return;
    }

    switch (army)
    {
        case CampaignArmy::Sandoria:
            m_influenceSandoria = current;
            break;
        case CampaignArmy::Bastok:
            m_influenceBastok = current;
            break;
        case CampaignArmy::Windurst:
            m_influenceWindurst = current;
            break;
        case CampaignArmy::Orcish:
        case CampaignArmy::Quadav:
        case CampaignArmy::Yagudo:
        case CampaignArmy::Kindred:
            m_influenceBeastman = current;
            break;
    }
}

void CCampaignHandler::SetUnionCount(CampaignUnion CUnion, uint8 amount)
{
    switch (CUnion)
    {
        case CampaignUnion::Adder:
            m_adderUnion = amount;
            break;
        case CampaignUnion::Bison:
            m_bisonUnion = amount;
            break;
        case CampaignUnion::Coyote:
            m_coyoteUnion = amount;
            break;
        case CampaignUnion::Dhole:
            m_dholeUnion = amount;
            break;
        case CampaignUnion::Eland:
            m_elandUnion = amount;
            break;
    }
}
