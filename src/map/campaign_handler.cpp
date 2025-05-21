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

#include <tuple>

#include "campaign_handler.h"
#include "map_server.h"
#include "zone.h"

#include "common/database.h"
#include "common/sql.h"

CCampaignHandler::CCampaignHandler(CZone* PZone)
{
    m_PZone = nullptr;
    LoadCampaignZone(PZone);
}

void CCampaignHandler::LoadCampaignZone(CZone* PZone)
{
    const auto rset = db::preparedStmt("SELECT id, zoneid, isbattle, nation, heroism, influence_sandoria, influence_bastok, influence_windurst, influence_beastman, "
                                       "current_fortifications, current_resources, max_fortifications, max_resources FROM campaign_map WHERE zoneid = ?",
                                       PZone->GetID());

    if (rset && rset->rowsCount() && rset->next())
    {
        m_zoneCampaignId        = rset->get<uint8>("id");
        m_zoneId                = rset->get<uint8>("zoneid");
        m_status                = rset->get<uint8>("isbattle");
        m_controllingNation     = rset->get<uint8>("nation");
        m_heroism               = rset->get<uint8>("heroism");
        m_influenceSandoria     = rset->get<uint8>("influence_sandoria");
        m_influenceBastok       = rset->get<uint8>("influence_bastok");
        m_influenceWindurst     = rset->get<uint8>("influence_windurst");
        m_influenceBeastman     = rset->get<uint8>("influence_beastman");
        m_currentFortifications = rset->get<uint16>("current_fortifications");
        m_currentResources      = rset->get<uint16>("current_resources");
        m_maxFortifications     = rset->get<uint16>("max_fortifications");
        m_maxResources          = rset->get<uint16>("max_resources");
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
    if (!db::preparedStmt("UPDATE campaign_map SET isbattle = ? WHERE zoneid = ?", status, m_PZone->GetID()))
    {
        ShowError("Unable to set campaign battle status.");
        return;
    }

    m_status = status;
}

void CCampaignHandler::SetZoneControl(uint8 nation)
{
    if (!db::preparedStmt("UPDATE campaign_map SET nation = ? WHERE zoneid = ?", nation, m_PZone->GetID()))
    {
        ShowError("Unable to set campaign zone control.");
        return;
    }

    m_controllingNation = nation;
}

void CCampaignHandler::SetHeroism(int16 amount)
{
    const auto current = std::clamp<int16>(amount, 0, 200);

    if (!db::preparedStmt("UPDATE campaign_map SET heroism = ? WHERE zoneid = ?", current, m_PZone->GetID()))
    {
        ShowError("Unable to set campaign region control.");
        return;
    }

    m_heroism = current;
}

void CCampaignHandler::SetFortification(int16 amount)
{
    const auto current = std::clamp<int16>(amount, 0, m_maxFortifications);

    if (!db::preparedStmt("UPDATE campaign_map SET current_fortifications = ? WHERE zoneid = ?", current, m_PZone->GetID()))
    {
        ShowError("Unable to update campaign fortifications.");
        return;
    }

    m_currentFortifications = current;
}

void CCampaignHandler::SetResource(int16 amount)
{
    const auto current = std::clamp<int16>(amount, 0, m_maxResources);

    if (!db::preparedStmt("UPDATE campaign_map SET current_resources = ? WHERE zoneid = ?", current, m_PZone->GetID()))
    {
        ShowError("Unable to update campaign resources.");
        return;
    }

    m_currentResources = current;
}

void CCampaignHandler::SetMaxFortification(int16 amount)
{
    const auto max = std::clamp<int16>(amount, 0, 1023);

    if (!db::preparedStmt("UPDATE campaign_map SET max_fortifications = ? WHERE zoneid = ?", max, m_PZone->GetID()))
    {
        ShowError("Unable to update max campaign fortifications.");
        return;
    }

    m_maxFortifications = max;
}

void CCampaignHandler::SetMaxResource(int16 amount)
{
    const auto max = std::clamp<int16>(amount, 0, 1023);

    if (!db::preparedStmt("UPDATE campaign_map SET max_resources = ? WHERE zoneid = ?", max, m_PZone->GetID()))
    {
        ShowError("Unable to update max campaign resources.");
        return;
    }

    m_maxResources = max;
}

void CCampaignHandler::SetInfluence(CampaignArmy army, int16 amount)
{
    const auto current = std::clamp<int16>(amount, 0, 250);

    std::unique_ptr<db::detail::ResultSetWrapper> rset = nullptr;
    switch (army)
    {
        case CampaignArmy::Sandoria:
            rset = db::preparedStmt("UPDATE campaign_map SET influence_sandoria = ? WHERE zoneid = %d", current, m_PZone->GetID());
            break;
        case CampaignArmy::Bastok:
            rset = db::preparedStmt("UPDATE campaign_map SET influence_bastok = ? WHERE zoneid = ?", current, m_PZone->GetID());
            break;
        case CampaignArmy::Windurst:
            rset = db::preparedStmt("UPDATE campaign_map SET influence_windurst = ? WHERE zoneid = ?", current, m_PZone->GetID());
            break;
        case CampaignArmy::Orcish:
        case CampaignArmy::Quadav:
        case CampaignArmy::Yagudo:
        case CampaignArmy::Kindred:
            rset = db::preparedStmt("UPDATE campaign_map SET influence_beastman = ? WHERE zoneid = ?", current, m_PZone->GetID());
            break;
    }

    if (!rset)
    {
        ShowError("Unable to update influence.");
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
