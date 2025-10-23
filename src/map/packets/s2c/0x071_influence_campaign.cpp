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

#include "0x071_influence_campaign.h"

#include "0x071_influence.h"
#include "campaign_system.h"
#include "entities/charentity.h"

GP_SERV_COMMAND_INFLUENCE::CAMPAIGN::CAMPAIGN(CCharEntity* PChar, CampaignState const& state, const uint8 number)
{
    auto& packet = this->data();

    packet.Mode        = GP_SERV_COMMAND_INFLUENCE_MODE::Campaign;
    packet.Length      = 0xC4; // This is the size of the rest of the packet after Length but without the padding.
    packet.AlliedNotes = campaign::GetAlliedNotes(PChar);

    packet.ControlledAreas.Sandoria        = state.controlSandoria;
    packet.Nations.Sandoria.Reconnaissance = state.nations[0].reconnaissance;
    packet.Nations.Sandoria.Morale         = state.nations[0].morale;
    packet.Nations.Sandoria.Prosperity     = state.nations[0].prosperity;

    packet.ControlledAreas.Bastok        = state.controlBastok;
    packet.Nations.Bastok.Reconnaissance = state.nations[1].reconnaissance;
    packet.Nations.Bastok.Morale         = state.nations[1].morale;
    packet.Nations.Bastok.Prosperity     = state.nations[1].prosperity;

    packet.ControlledAreas.Windurst        = state.controlWindurst;
    packet.Nations.Windurst.Reconnaissance = state.nations[2].reconnaissance;
    packet.Nations.Windurst.Morale         = state.nations[2].morale;
    packet.Nations.Windurst.Prosperity     = state.nations[2].prosperity;

    packet.ControlledAreas.Beastman                   = state.controlBeastman;
    packet.Nations.BeastmanOrc.Reconnaissance         = state.nations[3].reconnaissance;
    packet.Nations.BeastmanOrc.Morale                 = state.nations[3].morale;
    packet.Nations.BeastmanOrc.Prosperity             = state.nations[3].prosperity;
    packet.Nations.BeastmanQuadav.Reconnaissance      = state.nations[4].reconnaissance;
    packet.Nations.BeastmanQuadav.Morale              = state.nations[4].morale;
    packet.Nations.BeastmanQuadav.Prosperity          = state.nations[4].prosperity;
    packet.Nations.BeastmanYagudo.Reconnaissance      = state.nations[5].reconnaissance;
    packet.Nations.BeastmanYagudo.Morale              = state.nations[5].morale;
    packet.Nations.BeastmanYagudo.Prosperity          = state.nations[5].prosperity;
    packet.Nations.BeastmanDarkKindred.Reconnaissance = state.nations[6].reconnaissance;
    packet.Nations.BeastmanDarkKindred.Morale         = state.nations[6].morale;
    packet.Nations.BeastmanDarkKindred.Prosperity     = state.nations[6].prosperity;

    const int start   = number == 0 ? 0 : 13;
    packet.ZoneOffset = start;

    for (int i = start; i < start + 13; i++)
    {
        const CampaignRegion region = state.regions[i];
        const int            idx    = i - start;

        packet.Zones[idx].Owner                 = region.nationControl;
        packet.Zones[idx].CurrentFortifications = region.currentFortifications;
        packet.Zones[idx].CurrentResources      = region.currentResources;
        packet.Zones[idx].Heroism               = region.heroism;
        packet.Zones[idx].InfluenceSandoria     = region.influenceSandoria;
        packet.Zones[idx].InfluenceBastok       = region.influenceBastok;
        packet.Zones[idx].InfluenceWindurst     = region.influenceWindurst;
        packet.Zones[idx].InfluenceBeastman     = region.influenceBeastman;
        packet.Zones[idx].MaxFortifications     = region.maxFortifications;
        packet.Zones[idx].MaxResources          = region.maxResources;
    }
}
