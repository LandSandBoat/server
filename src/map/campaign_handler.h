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

#ifndef _CAMPAIGNHANDLER_H
#define _CAMPAIGNHANDLER_H

#include "common/cbasetypes.h"
#include <vector>

class CZone;

enum CampaignArmy : uint8
{
    Sandoria = 0,
    Bastok   = 1,
    Windurst = 2,
    Orcish   = 3,
    Quadav   = 4,
    Yagudo   = 5,
    Kindred  = 6,
};

enum CampaignControl : uint8
{
    SandoriaMask = 2,
    BastokMask   = 4,
    WindurstMask = 6,
    BeastmanMask = 8,
};

enum CampaignUnion : uint8
{
    Adder  = 1,
    Bison  = 2,
    Coyote = 3,
    Dhole  = 4,
    Eland  = 5,
};

struct CampaignNation
{
    uint8 reconnaissance = 0; // 10 max
    uint8 morale         = 0; // ~100 max
    uint8 prosperity     = 0; // ~100 max
};

struct CampaignRegion
{
    uint8  campaignId            = 0;
    uint8  status                = 0;
    uint8  nationControl         = 0;
    uint16 currentFortifications = 0;
    uint16 currentResources      = 0;
    uint8  heroism               = 0;
    uint8  influenceSandoria     = 0;
    uint8  influenceBastok       = 0;
    uint8  influenceWindurst     = 0;
    uint8  influenceBeastman     = 0;
    uint16 maxFortifications     = 0;
    uint16 maxResources          = 0;
};

struct CampaignState
{
    uint8 controlSandoria = 0;
    uint8 controlBastok   = 0;
    uint8 controlWindurst = 0;
    uint8 controlBeastman = 0;

    std::vector<CampaignRegion> regions;
    std::vector<CampaignNation> nations;
};

class CCampaignHandler
{
public:
    CCampaignHandler(CZone* PZone);

    void LoadCampaignZone(CZone* PZone); // Loads nation and region status.

    uint8  GetCampaignId();                     // Change the current number of fortifications for a zone.
    uint8  GetBattleStatus();                   // Checks if zone has an active battle.
    uint8  GetZoneControl();                    // Gets the current controller of the zone.
    uint16 GetFortification();                  // Change the current number of fortifications for a zone.
    uint16 GetResource();                       // Change the current number of resources for a zone.
    uint16 GetMaxFortification();               // Change the maximum number of fortifications for a zone.
    uint16 GetMaxResource();                    // Change the maximum number of resources for a zone.
    uint8  GetInfluence(CampaignArmy army);     // Change the current number of fortifications for a zone.
    uint8  GetHeroism();                        // Change the current number of fortifications for a zone.
    uint8  GetUnionCount(CampaignUnion CUnion); // Change the maximum number of resources for a zone.

    void SetBattleStatus(uint8 status);                     // Sets the status of battle in a zone.
    void SetZoneControl(uint8 nation);                      // Sets the control of a zone.
    void SetFortification(int16 amount);                    // Change the current number of fortifications for a zone.
    void SetResource(int16 amount);                         // Change the current number of resources for a zone.
    void SetMaxFortification(int16 amount);                 // Change the maximum number of fortifications for a zone.
    void SetMaxResource(int16 amount);                      // Change the maximum number of resources for a zone.
    void SetInfluence(CampaignArmy army, int16 amount);     // Change the current number of fortifications for a zone.
    void SetHeroism(int16 amount);                          // Change the maximum number of resources for a zone.
    void SetUnionCount(CampaignUnion CUnion, uint8 amount); // Change the maximum number of resources for a zone.

    CZone* m_PZone;

private:
    uint8 m_zoneCampaignId    = 0;
    uint8 m_zoneId            = 0;
    uint8 m_controllingNation = 0;

    uint8  m_status                = 0; // if in battle
    uint16 m_currentFortifications = 0; // 1023 max
    uint16 m_currentResources      = 0; // 1023 max
    uint8  m_heroism               = 0; // 200 max
    uint8  m_influenceSandoria     = 0; // 250 max
    uint8  m_influenceBastok       = 0; // 250 max
    uint8  m_influenceWindurst     = 0; // 250 max
    uint8  m_influenceBeastman     = 0; // 250 max
    uint16 m_maxFortifications     = 0; // 1023 max
    uint16 m_maxResources          = 0; // 1023 max

    uint8 m_adderUnion  = 0; // number of players in the Adder Union for this zone
    uint8 m_bisonUnion  = 0; // number of players in the Bison Union for this zone
    uint8 m_coyoteUnion = 0; // number of players in the Coyote Union for this zone
    uint8 m_dholeUnion  = 0; // number of players in the Dhole Union for this zone
    uint8 m_elandUnion  = 0; // number of players in the Eland Union for this zone
};

#endif
