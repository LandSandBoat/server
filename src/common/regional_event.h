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

#include "cbasetypes.h"

#include "map/conquest_data.h"

//
// Conquest
//

enum ConquestMessage : uint8
{
    // World map broadcasts weekly update started to all zones
    W2M_WeeklyUpdateStart,

    // World map broadcasts that update is done, with the respective tally
    W2M_WeeklyUpdateEnd,

    // World map broadcasts influence point updates to all zones.
    // Used for periodic updates or initialization.
    W2M_BroadcastInfluencePoints,

    // World map broadcasts region control data to all zones.
    // Used for initialization.
    W2M_BroadcastRegionControls,

    // A GM Triggers a weekly update.
    // World should send W2M_WeeklyUpdateStart and
    // W2M_WeeklyUpdateEnd to all zones when done.
    M2W_GM_WeeklyUpdate,

    // A GM requests hourly conquest data (just influence points).
    // World server should send W2M_BroadcastInfluencePoints to all zones.
    M2W_GM_ConquestUpdate,

    // Influence point update from any zone to world.
    M2W_AddInfluencePoints,
};
DECLARE_FORMAT_AS_UNDERLYING(ConquestMessage);

// W2M_BroadcastInfluencePoints
struct ConquestInfluenceUpdate
{
    bool                     shouldUpdateZones;
    std::vector<influence_t> influences;
};

// W2M_BroadcastRegionControls
struct ConquestRegionControlUpdate
{
    std::vector<region_control_t> regionControls;
};

// M2W_AddInfluencePoints
struct ConquestAddInfluencePoints
{
    int32  points;
    uint32 nation;
    uint8  region;
};

//
// Besieged
//

enum BesiegedMessage : uint8
{
};
DECLARE_FORMAT_AS_UNDERLYING(BesiegedMessage);

//
// Campaign
//

enum CampaignMessage : uint8
{
};
DECLARE_FORMAT_AS_UNDERLYING(CampaignMessage);

//
// Colonization
//

enum ColonizationMessage : uint8
{
};
DECLARE_FORMAT_AS_UNDERLYING(ColonizationMessage);
