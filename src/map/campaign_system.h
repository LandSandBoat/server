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

#ifndef _CAMPAIGNSYSTEM_H
#define _CAMPAIGNSYSTEM_H

#include "campaign_handler.h"
#include "common/cbasetypes.h"
#include <vector>

class CCharEntity;
class CZoneCampaign;

namespace campaign
{
    void LoadNations();
    void LoadState(); // Loads nation and region status as well as allied notes for character.

    void SetReconnaissance(CampaignArmy army, int8 amount); // Change the reconnaissance level for the army by the amount.
    void SetMorale(CampaignArmy army, int8 amount);         // Change the morale level for the army by the amount.
    void SetProsperity(CampaignArmy army, int8 amount);     // Change the prosperity level for the army by the amount.
    void SetAlliedNotes(CCharEntity* chr, int32 amount);    // Each week, certain aspects of the campaign are set back to defaults.

    CampaignState GetCampaignState();
    uint8         GetReconnaissance(CampaignArmy army); // Change the reconnaissance level for the army by the amount.
    uint8         GetMorale(CampaignArmy army);         // Change the morale level for the army by the amount.
    uint8         GetProsperity(CampaignArmy army);     // Change the prosperity level for the army by the amount.
    int32         GetAlliedNotes(CCharEntity* chr);     // Change the prosperity level for the army by the amount.

    void SendUpdate(CCharEntity* PChar);

    // CampaignState state;
}; // namespace campaign
#endif
