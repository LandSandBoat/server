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

#include "common/socket.h"

#include "campaign_map.h"
#include "campaign_system.h"

/*
Both Packets:
0x0C - 0x0F: Allied Notes
0x10 - 0x12: Controlled Areas [20 bits]: Sand, Bast, Wind, Beast
0x12 - 0x13: Unknown [12 bits]
0x14 - 0x17: San d'Oria Nation Structure
0x18 - 0x1B: Bastok Nation Structure
0x1C - 0x1F: Windurst Nation Structure
0x20 - 0x23: Orc Nation Structure
0x24 - 0x27: Quadav Nation Structure
0x28 - 0x2B: Yagudo Nation Structure
0x2C - 0x2F: Kindred Nation Structure
0x30 - 0xCB: 13 Region Structure blocks
Nation Structure:
 4 bits - Reconnaissance [10 cap]
14 bits - Unknown
 7 bits - Morale [~100 is max bar, larger overflows it]
 7 bits - Prosperity [~100 is max bar, larger overflows it]
Region Structure:
 4 bits - Status/Control [1=battleFlag, 2=Sandy, 3=Bastok, 2+3=Windy, 4=Beastman]
10 bits - Current Fortifications [max of 1023]
10 bits - Current Resources [max of 1023]
 4 bits - Unknown
 4 bits - Heroism Gauge [max of ~12]
 8 bits - San d'Oria Influence [max 250 before gauge overfills]
 8 bits - Bastok Influence [max 250 before gauge overfills]
 8 bits - Windurst Influence [max 250 before gauge overfills]
 8 bits - Beastman Influence [max 250 before gauge overfills]
10 bits - Max Fortifications [max of 1023]
10 bits - Max Resources [max of 1023]
12 bits - Unknown
Region Order:
0 - Southern San d'Oria [S]
1 - East Ronfaure [S]
2 - Jugner Forest [S]
3 - Vunkerl Inlet [S]
4 - Batallia Downs [S]
5 - La Vaule [S]
6 - The Eldieme Necropolis [S]
7 - Bastok Markets [S]
8 - North Gustaberg [S]
9 - Grauberg [S]
10 - Pashhow Marshlands [S]
11 - Rolanberry Fields [S]
12 - Beadeaux [S]
13 - Crawlers Nest [S]
14 - Windurst Waters [S]
15 - West Sarutabaruta [S]
16 - Fort Karugo-Narugo [S]
17 - Meriphataud Mountains [S]
18 - Sauromugue Champaign [S]
19 - Castle Oztroja [S]
20 - Garlaige Citadel [S]
21 - Beaucedine Glacier [S]
22 - Xarcabard [S]
23 - Castle Zvahl Baileys [S]
24 - Castle Zvahl Keep [S]
25 - Throne Room [S]
*/
CCampaignPacket::CCampaignPacket(CCharEntity* PChar, CampaignState const& state, uint8 number)
{
    this->setType(0x71);
    this->setSize(0xCC);

    ref<uint8>(0x04)  = 0x02;
    ref<uint8>(0x06)  = 0xC4;
    ref<uint8>(0x08)  = 0x01;
    ref<uint32>(0x0C) = campaign::GetAlliedNotes(PChar);
    ref<uint32>(0x10) = state.controlBeastman << 15 | state.controlWindurst << 10 | state.controlBastok << 5 | state.controlSandoria;

    SetNations(state.nations);

    switch (number)
    {
        case 0:
            ref<uint8>(0x09) = 0x00;
            SetRegions(state.regions);
            break;
        case 1:
            ref<uint8>(0x09) = 0x0D;
            SetRegions(state.regions, 13);
            break;
    }
}

void CCampaignPacket::SetRegions(std::vector<CampaignRegion> regions, int start)
{
    for (int i = start; i < start + 13; i++)
    {
        CampaignRegion a      = regions[i];
        int            offset = (i - start) * 0xC;

        ref<uint32>(0x30 + offset) = a.heroism << 24 | a.currentResources << 14 | a.currentFortifications << 4 | (a.status | a.nationControl);
        ref<uint8>(0x34 + offset)  = a.influenceSandoria;
        ref<uint8>(0x35 + offset)  = a.influenceBastok;
        ref<uint8>(0x36 + offset)  = a.influenceWindurst;
        ref<uint8>(0x37 + offset)  = a.influenceBeastman;
        ref<uint32>(0x38 + offset) = a.maxResources << 10 | a.maxFortifications;
    }
}

void CCampaignPacket::SetNations(std::vector<CampaignNation> nations)
{
    for (int i = 0; i < 7; i++)
    {
        CampaignNation n      = nations[i];
        int            offset = i * 0x4;

        ref<uint8>(0x14 + offset)  = n.reconnaissance;
        ref<uint16>(0x16 + offset) = n.prosperity << 9 | n.morale << 2;
    }
}
