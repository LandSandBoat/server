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

#ifndef _CAMPAIGNSYSTEM_H
#define _CAMPAIGNSYSTEM_H

#include <vector>
#include "../common/cbasetypes.h"

enum CampaignControl : uint8
{
    SandoriaMask = 0x02,
    BastokMask = 0x04,
    WindurstMask = 0x06,
    BeastmanMask = 0x08
};

enum CampaignZone : uint8
{
    SouthernSandOria = 0,
    EastRonfaure = 1,
    JugnerForest = 2,
    VunkerlInlet = 3,
    BatalliaDowns = 4,
    LaVaule = 5,
    TheEldiemeNecropolis = 6,
    BastokMarkets = 7,
    NorthGustaberg = 8,
    Grauberg = 9,
    PashhowMarshlands = 10,
    RolanberryFields = 11,
    Beadeaux = 12,
    CrawlersNest = 13,
    WindurstWaters = 14,
    WestSarutabaruta = 15,
    FortKarugoNarugo = 16,
    MeriphataudMountains = 17,
    SauromugueChampaign = 18,
    CastleOztroja = 19,
    GarlaigeCitadel = 20,
    BeaucedineGlacier = 21,
    Xarcabard = 22,
    CastleZvahlBaileys = 23,
    CastleZvahlKeep = 24,
    ThroneRoom = 25
};

enum CampaignArmy : uint8
{
    Sandoria = 0,
    Bastok = 1,
    Windurst = 2,
    Orcish = 3,
    Quadav = 4,
    Yagudo = 5,
    Kindred = 6
};

struct CampaignRegion
{
    // Battle bit | Control [CampaignControl]
    uint8 status = 0;

    // 1023 max
    uint16 currentFortifications = 0;

    // 1023 max
    uint16 currentResources = 0;

    // 12 max
    uint8 heroism = 0;

    // 250 max
    uint8 influenceSandoria = 0;

    // 250 max
    uint8 influenceBastok = 0;

    // 250 max
    uint8 influenceWindurst = 0;

    // 250 max
    uint8 influenceBeastman = 0;

    // 1023 max
    uint16 maxFortifications = 0;

    // 1023 max
    uint16 maxResources = 0;
};

struct CampaignNation
{
    // 10 max
    uint8 reconnaissance = 0;

    // ~100 max
    uint8 morale = 0;

    // ~100 max
    uint8 prosperity = 0;
};

struct CampaignState
{
    uint8 controlSandoria = 0;
    uint8 controlBastok = 0;
    uint8 controlWindurst = 0;
    uint8 controlBeastman = 0;
    uint32 alliedNotes = 0;
    std::vector<CampaignRegion> regions;
    std::vector<CampaignNation> nations;
};

namespace campaign
{
    // Loads nation and region status as well as allied notes for character.
    CampaignState LoadState(uint32 charId);

    // Each week, regional influences are tallied to determine control of areas.
    void Tally();

    // Each week, certain aspects of the campaign are set back to defaults.
    void Reset();

    // Checks if zone has an active battle.
    bool HasBattle(CampaignZone zone);

    // Sets the status of battle in a zone.
    void SetBattle(CampaignZone zone, bool status);

    // Gets the current controller of the zone.
    CampaignControl GetRegionControl(CampaignZone zone);

    // Sets the control of a zone.
    void SetRegionControl(CampaignZone zone, uint8 nation);

    // Change the current number of fortifications for a zone.
    void ModifyFortification(CampaignZone zone, int16 amount);

    // Change the current number of resources for a zone.
    void ModifyResource(CampaignZone zone, int16 amount);

    // Change the maximum number of fortifications for a zone.
    void ModifyMaxFortification(CampaignZone zone, int16 amount);

    // Change the maximum number of resources for a zone.
    void ModifyMaxResource(CampaignZone zone, int16 amount);

    // Change the current number of fortifications for a zone.
    void ModifyInfluence(CampaignArmy army, CampaignZone zone, int16 amount);

    // Change the reconnaissance level for the army by the amount.
    void ModifyReconnaissance(CampaignArmy army, int8 amount);

    // Change the morale level for the army by the amount.
    void ModifyMorale(CampaignArmy army, int8 amount);

    // Change the prosperity level for the army by the amount.
    void ModifyProsperity(CampaignArmy army, int8 amount);
};

#endif
